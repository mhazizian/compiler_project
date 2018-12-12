package ast;

import java.util.ArrayList;

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
import ast.Type.UserDefinedType.UserDefinedType;
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
            this.ItemDecIndex
        );
        this.ItemDecIndex += 1;

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

    public SymbolTableItem createClassDecSymbolTableItem(
      ClassDeclaration classDeclaration) {
        SymbolTableClassItem classDec = new SymbolTableClassItem(
            classDeclaration.getName().getName());
        return ((SymbolTableItem) classDec);
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
            // @TODO Throw something!
        }
        return type;
    }

    boolean checkBooleanity(String type) {
        if (!type.equals("bool")) {
            SymbolTable.isValidAst = false;
            return false;
        }
        return true;
    }

    boolean checkIntegrity(String type) {
        if (!type.equals("int")) {
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
                SymbolTableClassItem parentClass =
                    ((SymbolTableClassItem) SymbolTable.top.get("c_" + parentClassName));
                SymbolTableClassItem curretClass =
                    ((SymbolTableClassItem) SymbolTable.top.get(
                        "c_" + classes.get(i).getName().getName()));

                if (!classDecIsValid.get(i))
                        continue;

                curretClass.setParent(parentClass);

            } catch (ItemNotFoundException error) {
                System.out.println("Line:" + classes.get(i).getLineNumber() +
                    ":inherited class not found: " +
                    parentClassName);
                SymbolTable.isValidAst = false;
            }
        }

        // visit classes
        // @TODO check order of visiting classes.
        for (int i = 0; i < classes.size(); i++)
            classes.get(i).accept(new VisitorImpl());

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
                SymbolTableItem item = this.createVarDecSymbolItem(vars.get(i));
                try {
                    SymbolTable.top.put(item);
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
                    SymbolTable.top.put(item);
                    currentClass.put(item);
                } catch (ItemAlreadyExistsException error) {
                    System.out.println("Line:" + methods.get(i).getLineNumber() +
                        ":Redefinition of method " +
                        methods.get(i).getName().getName());
                    SymbolTable.isValidAst = false;
                }
            }

            // visit subItems:
            for (int i = 0; i < vars.size(); i++)
                vars.get(i).accept(new VisitorImpl());

            for (int i = 0; i < methods.size(); i++)
                methods.get(i).accept(new VisitorImpl());

        } catch (ItemNotFoundException error) {
            System.out.println("____ ItemNotFoundException.");
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

        if (!returnValue.getType().toString().equals(methodDeclaration.getReturnType().toString()))
        {
            System.out.println("ErrorItemMessage: " + methodDeclaration.getName() +
                    " return type must be " + methodDeclaration.getReturnType());
            SymbolTable.isValidAst = false;
        }

        SymbolTable.pop();
    }

    @Override
    public void visit(VarDeclaration varDeclaration) {
        Identifier identifier = varDeclaration.getIdentifier();
        identifier.accept(new VisitorImpl());
    }

     @Override
    public void visit(ArrayCall arrayCall) {
        Expression instance = arrayCall.getInstance();
        Expression index = arrayCall.getIndex();

        instance.accept(new VisitorImpl());
        index.accept(new VisitorImpl());
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
        if (isArithmetic(operator)) {
            if (!(checkIntegrity(leftType) && checkIntegrity(rightType)))
                System.out.println("ErrorItemMessage: unsupported operand type for " + operator);
        } else {
            if (!(checkBooleanity(leftType) && checkBooleanity(rightType)))
                System.out.println("ErrorItemMessage: unsupported operand type for " + operator);
        }

        // @TODO type check expression
    }

    @Override
    public void visit(Identifier identifier) {
        try {
            SymbolTableItem item = SymbolTable.top.getItem(identifier.getName());

            if (item.getItemType() == SymbolTableItemType.variableType)
                identifier.setType(new UserDefinedType(new Identifier(item.getName())));
            
        } catch (ItemNotFoundException error) {

        }
    }

    @Override
    public void visit(Length length) {
        Expression expression = length.getExpression();
        expression.accept(new VisitorImpl());
    }

    @Override
    public void visit(MethodCall methodCall) {
        Expression instance = methodCall.getInstance();
        Identifier methodName = methodCall.getMethodName();
        instance.accept(new VisitorImpl());
        methodName.accept(new VisitorImpl());

        try {
            SymbolTableItem instanceItem = SymbolTable.top.getItem(instance.getType().toString());

            if (instanceItem.getItemType() == SymbolTableItemType.classType) {
                SymbolTableMethodItem methodItem = (SymbolTableMethodItem)(
                    (SymbolTableClassItem)instanceItem).get("m_" + methodName.getName());
                methodCall.setType(methodItem.getReturnType());

            } else if (instanceItem.getItemType() == SymbolTableItemType.variableType) {
                Type varType = ((SymbolTableVariableItem)instanceItem).getType();

                if (varType.getType() == TypeName.userDefinedType) {
                    SymbolTableItem instanceClassItem = SymbolTable.top.get("c_" + varType);
                    SymbolTableMethodItem methodItem = (SymbolTableMethodItem)(
                        (SymbolTableClassItem)instanceClassItem).get("m_" + methodName.getName());
                    methodCall.setType(methodItem.getReturnType());
                } else {
                    // @TODO : print error or throw.
                }
            }
        } catch (ItemNotFoundException error) {
            // @TODO : complete this section. :))
            System.out.println("Error on Method Call");
        }
    }

    @Override
    public void visit(NewArray newArray) {
        Expression expression = newArray.getExpression();
        IntValue arraySize = ((IntValue) newArray.getExpression());
        if (arraySize.getConstant() <= 0) {
            System.out.println("Line:" + newArray.getLineNumber() +
                ":Array length should not be zero or negative");
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
        if (checkBooleanity(type)) {
            unaryExpression.setType(new BooleanType());
        // else -> Error
        }
    }

    @Override
    public void visit(BooleanValue value) {
        // type checked in Parser
    }

    @Override
    public void visit(IntValue value) {
        // type checked in Parser
    }

    @Override
    public void visit(StringValue value) {
        // type checked in Parser
    }

    @Override
    public void visit(Assign assign) {
        Expression lValue = assign.getlValue();
        Expression rValue = assign.getrValue();
        lValue.accept(new VisitorImpl());
        rValue.accept(new VisitorImpl());
    }

    @Override
    public void visit(Block block) {
        ArrayList<Statement> body = block.getBody();

        for (int i = 0; i < body.size(); ++i)
            body.get(i).accept(new VisitorImpl());
    }

    @Override
    public void visit(Conditional conditional) {
        Expression expression = conditional.getExpression();
        Statement consequenceBody = conditional.getConsequenceBody();
        Statement alternativeBody = conditional.getAlternativeBody();

        expression.accept(new VisitorImpl());
        consequenceBody.accept(new VisitorImpl());

        if (alternativeBody != null)
            alternativeBody.accept(new VisitorImpl());

        String type = getType(expression);
        if (!checkBooleanity(type))
            System.out.println("ErrorItemMessage: condition type must be boolean");
    }

    @Override
    public void visit(While loop) {
        Expression condition = loop.getCondition();
        Statement body = loop.getBody();

        condition.accept(new VisitorImpl());
        body.accept(new VisitorImpl());

        String type = getType(condition);
        if (!checkBooleanity(type))
            System.out.println("ErrorItemMessage: condition type must be boolean");
    }

    @Override
    public void visit(Write write) {
        Expression arg = write.getArg();
        arg.accept(new VisitorImpl());

        String type = getType(arg);

        if (type != "int[]" && type != "int" && type != "string") {
            System.out.println("ErrorItemMessage: unsupported type for writeln");
            SymbolTable.isValidAst = false;
        }
    }
}
