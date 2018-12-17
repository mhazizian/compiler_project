package ast;

import java.util.*;
// import java.util.ArrayList;
// import java.util.Arrays;
// import java.util.Collection;

import javax.sound.midi.SysexMessage;

// import com.sun.org.apache.xpath.internal.operations.Bool;

import ast.node.Program;
import ast.node.declaration.ClassDeclaration;
import ast.node.declaration.MethodDeclaration;
import ast.node.declaration.VarDeclaration;
import ast.node.expression.*;
import ast.node.expression.Value.BooleanValue;
import ast.node.expression.Value.IntValue;
import ast.node.expression.Value.StringValue;
import ast.node.statement.*;

import ast.Type.*;
import ast.Type.PrimitiveType.BooleanType;
import ast.Type.PrimitiveType.IntType;
import ast.Type.UserDefinedType.UserDefinedType;
import ast.Type.NoType.NoType;
import symbolTable.*;
public class VisitorImpl implements Visitor {
    private static int ItemDecIndex = 0;
    public static String objectClassName = "Object";

    public static void createNewSymbolTable() {
        SymbolTable.push(new SymbolTable(SymbolTable.top));
    }

    public SymbolTableItem createVarDecSymbolItem(VarDeclaration varDecleration) {
        SymbolTableVariableItem varDec = new SymbolTableVariableItem(
            varDecleration.getIdentifier().getName(),
            varDecleration.getType(),
            VisitorImpl.ItemDecIndex
        );
        VisitorImpl.ItemDecIndex += 1;

        return ((SymbolTableItem) varDec);
    }

    public SymbolTableItem createMethodDecSymbolTableItem(
            MethodDeclaration methodDecleration, SymbolTableClassItem currentClass) {
        ArrayList<VarDeclaration> varsDec = methodDecleration.getArgs();
        ArrayList<Type> varsType = new ArrayList<Type> ();
        for (int i = 0; i < varsDec.size(); i++)
            varsType.add(varsDec.get(i).getType());

        SymbolTableMethodItem methodDec = new SymbolTableMethodItem(
            methodDecleration.getName().getName(),
            varsType, methodDecleration.getReturnType()
        );
        methodDec.setThisObject(currentClass);

        return ((SymbolTableItem) methodDec);
    }

    public SymbolTableItem createClassDecSymbolTableItem(ClassDeclaration classDeclaration) {
        SymbolTableClassItem classDec = new SymbolTableClassItem(
            classDeclaration.getName().getName());
        return ((SymbolTableItem) classDec);
    }

    public void completeClassSymbolTableBody(ClassDeclaration classDeclaration) {
        try {
            SymbolTableClassItem currentClass =
                    ((SymbolTableClassItem) SymbolTable.top.get(
                    "c_" + classDeclaration.getName().getName()));

            ArrayList<VarDeclaration> vars =
                ((ArrayList<VarDeclaration>)classDeclaration.getVarDeclarations());
            ArrayList<MethodDeclaration> methods =
                ((ArrayList<MethodDeclaration>)classDeclaration.getMethodDeclarations());

            // add subItems to SymbolTableItem and ClassSymbolTable:
            for (int i = 0; i < vars.size(); i++) {
                SymbolTableItem item = this.createVarDecSymbolItem(vars.get(i));
                try {
                    // SymbolTable.top.put(item);
                    currentClass.put(item);
                } catch (ItemAlreadyExistsException error) {
                    System.out.println("Line:" + vars.get(i).getLineNumber() +
                        ":Redefinition of variable " +
                        vars.get(i).getIdentifier().getName());
                    SymbolTable.isValidAst = false;
                }
            }

            for (int i = 0; i < methods.size(); i++) {
                SymbolTableItem item = this.createMethodDecSymbolTableItem(
                    methods.get(i), currentClass);
                try {
                    // SymbolTable.top.put(item);
                    currentClass.put(item);
                } catch (ItemAlreadyExistsException error) {
                    System.out.println("Line:" + methods.get(i).getLineNumber() +
                        ":Redefinition of method " +
                        methods.get(i).getName().getName());
                    SymbolTable.isValidAst = false;
                }
            }
        } catch (ItemNotFoundException e) {
            // do nothing
        }
    }

    void putToSymbolTable(SymbolTableItem item) {
        try {
            SymbolTable.top.put(item);
        } catch (ItemAlreadyExistsException error) {
            System.out.println("____ ItemAlreadyExistsException.");
        }
    }

    void putToClass(SymbolTableClassItem c, SymbolTableItem item) {
        try {
            c.put(item);
        } catch (ItemAlreadyExistsException error) {
            System.out.println("____ ItemAlreadyExistsException.");
        }
    }

    String getType(Expression condition) {   
        String type = condition.getType().toString();
        
        try {
            SymbolTableItem item = SymbolTable.top.getItem(type);
            if (item.getItemType() == SymbolTableItemType.variableType) {
                Type varType = ((SymbolTableVariableItem)item).getType();
                type = varType.toString();
            }
        } catch (ItemNotFoundException error) {
            // do nothing
        }
        return type;
    }

    boolean isValidType(String type, String base) {
        // @TODO Is it correct to check the NoType here?
        if (!type.equals(base) && !type.equals("NoType")) {
            SymbolTable.isValidAst = false;
            return false;
        }
        return true;
    }

    boolean isArithmetic(BinaryOperator operator) {
        switch (operator) {
            case add:
            case sub:
            case mult:
            case div:
                return true;

            default:
                return false;
        }
    }

    boolean isWritable(String type) {
        // @TODO Is it correct to check the NoType here?
        return (type.equals("int[]") || type.equals("int") 
                || type.equals("string") || type.equals("NoType"));
    }

    void checkOperandsValidity(String leftType, String rightType,
            BinaryExpression binaryExpression, String base)
    {
        BinaryOperator operator = binaryExpression.getBinaryOperator();
     
        if (!(isValidType(leftType, base) && isValidType(rightType, base))) {
            System.out.println("Line:" + binaryExpression.getLineNumber() + ":unsupported operand type for " + operator);
            
            // NoType class has been used for invalid types
            binaryExpression.setType(new NoType());
        }
        else
            if (base.equals("int"))
                binaryExpression.setType(new IntType());
            else
                binaryExpression.setType(new BooleanType());
    }

    void findTheMethodInClass(MethodCall methodCall, SymbolTableItem instanceItem,
            String methodName, String className) {

        ArrayList<Expression> args = methodCall.getArgs();

        try {
            SymbolTableMethodItem methodItem = (SymbolTableMethodItem)(
                    (SymbolTableClassItem)instanceItem).get("m_" + methodName);
            
            if (args.size() != methodItem.getArgs().size()) {
                System.out.println("Line:" + methodCall.getLineNumber() + ": invalid number of args passed to method " +
                methodName + " in class " + className);

                SymbolTable.isValidAst = false;
                methodCall.setType(new NoType());
                return;
            }

            for (int i = 0; i < args.size(); i++) {
                if (!canAssign(methodItem.getArgs().get(i), methodCall.getArgs().get(i).getType())) {
                    System.out.println("Line:" + methodCall.getLineNumber()
                        + ":in methodCall: "+ methodName + ":argument " + (i + 1)
                        + "th has invalid type from refrence method.");
    
                    SymbolTable.isValidAst = false;
                }
            }

            methodCall.setType(methodItem.getReturnType());

        } catch (ItemNotFoundException error) {
            System.out.println("Line:" + methodCall.getLineNumber() + ": there is no method named " +
                methodName + " in class " + className);

            SymbolTable.isValidAst = false;
            // NoType class has been used for invalid types
            methodCall.setType(new NoType());
        }
    }

    void findTheClass(MethodCall methodCall, String methodName, String className) {
        try {
        SymbolTableItem instanceClassItem = SymbolTable.top.get("c_" + className);
        findTheMethodInClass(methodCall, instanceClassItem, methodName, className);
        } catch (ItemNotFoundException error) {
            System.out.println("Line:" + methodCall.getLineNumber() + ":class " + className + " is not declared");
            
            SymbolTable.isValidAst = false;
            // NoType class has been used for invalid types
            methodCall.setType(new NoType());
        }
    }

    boolean isCastAble(String baseClassName, String subClassName) {
        try {
            if (baseClassName == subClassName)
                return true;

            SymbolTableClassItem baseClassItem = (SymbolTableClassItem)SymbolTable.top.get("c_" + baseClassName);
            SymbolTableClassItem subClassItem = (SymbolTableClassItem)SymbolTable.top.get("c_" + subClassName);

            return subClassItem.hasParent(baseClassName);

        } catch(ItemNotFoundException error) {
            return false;
        }
    }

    boolean canAssign(Type lValue, Type rValue) {
        if (lValue.getType() == rValue.getType()) {
            if (!this.isCastAble(lValue.toString(), rValue.toString())) {
                return false;
            }

        } else {            
            return false;
        }
        return true;
    }

// ##############################################################################
// ##############################################################################
// #############################                     ############################
// #############################  VISITOR FUNCTIONS  ############################
// #############################                     ############################
// ##############################################################################
// ##############################################################################

    @Override
    public void visit(Program program) {
        createNewSymbolTable();
        SymbolTableClassItem objectClass = new SymbolTableClassItem(objectClassName);
        putToSymbolTable(objectClass);

        ArrayList<ClassDeclaration> classes =
            ((ArrayList<ClassDeclaration>)program.getClasses());
        ClassDeclaration mainClass = program.getMainClass();

        if (classes.size() == 0 && mainClass == null) {
            System.out.println("Line:" + 0 +
                ":No class exists in the program");
            SymbolTable.isValidAst = false;
            return;
        }

        // create SymbolTableItem for each classDec
        putToSymbolTable(this.createClassDecSymbolTableItem(mainClass));

        ArrayList<Boolean> classDecIsValid = new ArrayList<Boolean>();
        for (int i = 0; i < classes.size(); i++) {
            try {
                SymbolTable.top.put(this.createClassDecSymbolTableItem(
                    classes.get(i))
                );
                classDecIsValid.add(true);
            } catch (ItemAlreadyExistsException error) {
                System.out.println("Line:" + classes.get(i).getLineNumber() +
                    ":Redefinition of class " +
                    classes.get(i).getName().getName()
                );
                classDecIsValid.add(false);
            }
        }
        // add parentClass for each ClassDecSymbolTableItem
        for (int i = 0; i < classes.size(); i++) {
            String parentClassName = classes.get(i).getParentName().getName();
            if (parentClassName.equals(""))
                parentClassName = objectClassName;

            if (parentClassName.equals(classes.get(i).getName().getName())) {
                System.out.println("Line:" + classes.get(i).getLineNumber() +
                    ":self-inheritance is not valid, class name: " +
                    parentClassName);
                SymbolTable.isValidAst = false;
                continue;
            }

            try {
                SymbolTableClassItem parentClass = ((SymbolTableClassItem)
                        SymbolTable.top.get("c_" + parentClassName));
                SymbolTableClassItem curretClass = ((SymbolTableClassItem)
                        SymbolTable.top.get("c_" + classes.get(i).getName().getName()));

                if (!classDecIsValid.get(i))
                        continue;

                curretClass.setParent(parentClass);

            } catch (ItemNotFoundException error) {
                System.out.println("Line:" + classes.get(i).getLineNumber() +
                    ":inherited class not found: " + parentClassName);
                SymbolTable.isValidAst = false;
            }
        }

        // Complete classSymbolTableItem body with proper order:
        int i = 0;
        HashMap<String, Boolean> visitedClasses = new HashMap<>(); 
        visitedClasses.put(objectClassName, true);
        visitedClasses.put("", true);

        while(visitedClasses.size() < classes.size() + 2) {
            if (visitedClasses.getOrDefault(classes.get(i).getName().getName(), false))
                continue;
            
            if (visitedClasses.getOrDefault(classes.get(i).getParentName().getName(), false)
                || !(SymbolTable.top.hasItem(classes.get(i).getParentName().getName()))
            ) {
                this.completeClassSymbolTableBody(classes.get(i));
                visitedClasses.put(classes.get(i).getName().getName(), true);
            }
            i = (i + 1) % classes.size();
        }

        for (int j = 0; j < classes.size(); j++)
            classes.get(j).accept(new VisitorImpl());

        mainClass.accept(new VisitorImpl());
        SymbolTable.pop();
    }

    @Override
    public void visit(ClassDeclaration classDeclaration) {
        createNewSymbolTable();
        try {
            SymbolTableClassItem currentClass =
                ((SymbolTableClassItem) SymbolTable.top.get(
                "c_" + classDeclaration.getName().getName()));

            ArrayList<VarDeclaration> vars =
                ((ArrayList<VarDeclaration>)classDeclaration.getVarDeclarations());
            ArrayList<MethodDeclaration> methods =
                ((ArrayList<MethodDeclaration>)classDeclaration.getMethodDeclarations());
    
            // add subItems to SymbolTableItem and ClassSymbolTable:
            for (int i = 0; i < vars.size(); i++) {
                SymbolTableItem item = currentClass.get("v_" + vars.get(i).getIdentifier().getName());
                try {
                    SymbolTable.top.put(item);
                    // currentClass.put(item);
                } catch (ItemAlreadyExistsException error) {}
            }
    
            for (int i = 0; i < methods.size(); i++) {
                SymbolTableItem item = currentClass.get("m_" + methods.get(i).getName().getName());
                try {
                    SymbolTable.top.put(item);
                    // currentClass.put(item);
                } catch (ItemAlreadyExistsException error) {}
            }

            // visit subItems:
            for (int i = 0; i < vars.size(); i++)
                vars.get(i).accept(new VisitorImpl());

            for (int i = 0; i < methods.size(); i++)
                methods.get(i).accept(new VisitorImpl());

        } catch (ItemNotFoundException error) {
            // System.out.println("____ ItemNotFoundException.");
        }
        SymbolTable.pop();
    }

    @Override
    public void visit(MethodDeclaration methodDeclaration) {
        createNewSymbolTable();
        Expression returnValue = methodDeclaration.getReturnValue();
        Identifier name = methodDeclaration.getName();
        ArrayList<VarDeclaration> args = methodDeclaration.getArgs();
        ArrayList<VarDeclaration> localVars =
            methodDeclaration.getLocalVars();
        ArrayList<Statement> body = methodDeclaration.getBody();

        for (int i = 0; i < args.size(); i++) {
            try {
                SymbolTable.top.put(this.createVarDecSymbolItem(args.get(i)));
            } catch (ItemAlreadyExistsException error) {
               System.out.println("Line:" + args.get(i).getLineNumber()
                  + ":Redefinition of variable " +
                  args.get(i).getIdentifier().getName());
              SymbolTable.isValidAst = false;
            }
        }

        for (int i = 0; i < localVars.size(); i++) {
            try {
                SymbolTable.top.put(this.createVarDecSymbolItem(localVars.get(i)));
            } catch (ItemAlreadyExistsException error) {
               System.out.println("Line:" + localVars.get(i).getLineNumber()
                  + ":Redefinition of variable " +
                  localVars.get(i).getIdentifier().getName());
              SymbolTable.isValidAst = false;
            }
        }


        name.accept(new VisitorImpl());

        for (int i = 0; i < args.size(); i++)
            args.get(i).accept(new VisitorImpl());

        // visit method members
        for (int i = 0; i < localVars.size(); i++)
            localVars.get(i).accept(new VisitorImpl());

        for (int i = 0; i < body.size(); i++)
            body.get(i).accept(new VisitorImpl());

        returnValue.accept(new VisitorImpl());

        if (!canAssign(methodDeclaration.getReturnType(), returnValue.getType()))
        {
            System.out.println("Line:" + returnValue.getLineNumber() + ":"
                + methodDeclaration.getName().getName() + " return type must be "
                + methodDeclaration.getReturnType()
            );
            SymbolTable.isValidAst = false;
        }

        SymbolTable.pop();
    }

    @Override
    public void visit(VarDeclaration varDeclaration) {
        Identifier identifier = varDeclaration.getIdentifier();
        identifier.accept(new VisitorImpl());

        if (varDeclaration.getType().getType() == TypeName.userDefinedType) {
            String className = ((UserDefinedType)varDeclaration.getType()).getName().getName();
            try {
                SymbolTableItem item = SymbolTable.top.get("c_" + className);
            } catch (ItemNotFoundException e) {
                System.out.println("Line:" + varDeclaration.getLineNumber() + ":class "
                    + className + " is not declared"
                );
                SymbolTable.isValidAst = false;
            }
        }
    }

     @Override
    public void visit(ArrayCall arrayCall) {
        // Nothing to type check in 'ArrayCall'

        Expression instance = arrayCall.getInstance();
        Expression index = arrayCall.getIndex();

        instance.accept(new VisitorImpl());
        index.accept(new VisitorImpl());

        // only array of int is valid:
        arrayCall.setType(new IntType());

        if (index.getType().getType() != TypeName.intType) {
            System.out.println("Line:" + arrayCall.getLineNumber() + ":array index must be int");
            SymbolTable.isValidAst = false;
        }
    }

    @Override
    public void visit(BinaryExpression binaryExpression) {
        Expression left = binaryExpression.getLeft();
        Expression right = binaryExpression.getRight();

        left.accept(new VisitorImpl());
        right.accept(new VisitorImpl());

        String leftType = getType(left);
        String rightType = getType(right);

        BinaryOperator operator = binaryExpression.getBinaryOperator();

        // Both the operands should be valid
        if (isArithmetic(operator))
            checkOperandsValidity(leftType, rightType, binaryExpression, "int");
        else 
            checkOperandsValidity(leftType, rightType, binaryExpression, "bool");
    }

    @Override
    public void visit(Identifier identifier) {
        try {
            SymbolTableItem item = SymbolTable.top.getItem(identifier.getName());

            if (item.getItemType() == SymbolTableItemType.variableType) 
                identifier.setType(((SymbolTableVariableItem)item).getType());
                // identifier.setType(new UserDefinedType(new Identifier(item.getName())));
            
        } catch (ItemNotFoundException error) {
            if (!identifier.getName().equals("")) {
                System.out.println("Line:" + identifier.getLineNumber() + ":variable "
                    + identifier.getName() + " is not declared"
                );
                SymbolTable.isValidAst = false;
                identifier.setType(new NoType());
            }
        }
    }

    @Override
    public void visit(MethodCallIdentifier identifier) {
        try {
            SymbolTableItem item = SymbolTable.top.getItem(identifier.getName());

            if (item.getItemType() == SymbolTableItemType.variableType) 
                identifier.setType(new UserDefinedType(new Identifier(item.getName())));
            
        } catch (ItemNotFoundException error) {
            // :thinking:
        }
    }

    @Override
    public void visit(Length length) {
        Expression expression = length.getExpression();
        expression.accept(new VisitorImpl());

        String type = getType(expression);
        if (isValidType(type, "int[]"))
            length.setType(new IntType());
        else {
            // This error message doesn't exist in project description
            System.out.println("Line:" + length.getLineNumber() + ": unsupported type for length");
            length.setType(new NoType());
        }
    }

    @Override
    public void visit(MethodCall methodCall) {
        Expression instance = methodCall.getInstance();
        MethodCallIdentifier methodName = methodCall.getMethodName();
        ArrayList<Expression> args = methodCall.getArgs();

        instance.accept(new VisitorImpl());
        methodName.accept(new VisitorImpl());
        for (int i = 0; i < args.size(); i++)
            args.get(i).accept(new VisitorImpl());

        if (methodCall.getLineNumber() == -1)
            methodCall.setLineNumber(instance.getLineNumber());


        try {
            SymbolTableItem instanceItem = SymbolTable.top.getItem(instance.getType().toString());
            
            if (instanceItem.getItemType() == SymbolTableItemType.classType)
                findTheMethodInClass(methodCall, instanceItem,
                        methodName.getName(), instance.getType().toString());

            else if (instanceItem.getItemType() == SymbolTableItemType.variableType) {
                Type varType = ((SymbolTableVariableItem)instanceItem).getType();

                if (varType.getType() == TypeName.userDefinedType)
                    findTheClass(methodCall, methodName.getName(), varType.toString());
                else {
                    // @TODO : Which kind of error?
                }
            }
        } catch (ItemNotFoundException error) {
            // @TODO : Which kind of error?
            System.out.println("Line:" + methodName.getLineNumber() + ":primitive types are not callable.");
            SymbolTable.isValidAst = false;
        }
    }

    @Override
    public void visit(NewArray newArray) {
        Expression expression = newArray.getExpression();
        IntValue arraySize = ((IntValue) newArray.getExpression());
        if (arraySize.getConstant() <= 0) {
            System.out.println("Line:" + newArray.getLineNumber()
                    + ":Array length should not be zero or negative");
            SymbolTable.isValidAst = false;
        }
        expression.accept(new VisitorImpl());
    }

    @Override
    public void visit(NewClass newClass) {
        Identifier className = newClass.getClassName();
        className.accept(new VisitorImpl());
        // className is an Identifier not a primitive type (It's been checked in parser)
        newClass.setType(new UserDefinedType(className));
    }

    @Override
    public void visit(This instance) {
    }

    @Override
    public void visit(UnaryExpression unaryExpression) {
        Expression value = unaryExpression.getValue();
        value.accept(new VisitorImpl());
        
        String type = getType(value);
        if (isValidType(type, "bool"))
            unaryExpression.setType(new BooleanType());
        else {
            System.out.println("Line:" + unaryExpression.getLineNumber() + ":unsupported operand type for " +
                    unaryExpression.getUnaryOperator());

            // NoType class has been used for invalid types
            unaryExpression.setType(new NoType());
        }
    }

    @Override
    public void visit(BooleanValue value) {
        // Type checked in Parser
    }

    @Override
    public void visit(IntValue value) {
        // Type checked in Parser
    }

    @Override
    public void visit(StringValue value) {
        // Type checked in Parser
    }

    @Override
    public void visit(Assign assign) {
        Expression lValue = assign.getlValue();
        Expression rValue = assign.getrValue();
        lValue.accept(new VisitorImpl());
        rValue.accept(new VisitorImpl());

        if (!canAssign(lValue.getType(), rValue.getType())) {
            System.out.println("Line:" + assign.getLineNumber() + ":unsupported operand type for assign");
            SymbolTable.isValidAst = false;
        }

        // @TODO Is it the only case of right-hand-side value?
        if (!lValue.islValue) {
            System.out.println("Line:" + assign.getLineNumber() + ":left side of assignment must be a valid lvalue");
            
            // It should be ignored to continue the process
            lValue.islValue = true;
            SymbolTable.isValidAst = false;
        }
    }

    @Override
    public void visit(Block block) {
        // Nothing to type check in 'block'
        createNewSymbolTable();

        ArrayList<Statement> body = block.getBody();

        for (int i = 0; i < body.size(); ++i)
            body.get(i).accept(new VisitorImpl());

        SymbolTable.pop();
    }

    @Override
    public void visit(Conditional conditional) {
        Expression expression = conditional.getExpression();
        Statement consequenceBody = conditional.getConsequenceBody();
        Statement alternativeBody = conditional.getAlternativeBody();

        expression.accept(new VisitorImpl());
        
        createNewSymbolTable();
        consequenceBody.accept(new VisitorImpl());
        SymbolTable.pop();

        if (alternativeBody != null) {
            createNewSymbolTable();
            alternativeBody.accept(new VisitorImpl());
            SymbolTable.pop();
        }


        String type = getType(expression);
        if (!isValidType(type, "bool"))
            System.out.println("Line:" + conditional.getLineNumber() + ":condition type must be boolean");
        // Nothing to do in the else statement
    }

    @Override
    public void visit(While loop) {
        Expression condition = loop.getCondition();
        Statement body = loop.getBody();

        condition.accept(new VisitorImpl());
        body.accept(new VisitorImpl());

        String type = getType(condition);
        if (!isValidType(type, "bool"))
            System.out.println("Line:" + loop.getLineNumber() + ":condition type must be boolean");
        // Nothing to do in the else statement
    }

    @Override
    public void visit(Write write) {
        Expression arg = write.getArg();
        arg.accept(new VisitorImpl());

        String type = getType(arg);

        if (!isWritable(type)) {
            System.out.println("Line:" + write.getLineNumber() + ":unsupported type for writeln");
            SymbolTable.isValidAst = false;
        }
        // Nothing to do in the else statement
    }
}
