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
import ast.Type.UserDefinedType.UserDefinedType;
import symbolTable.*;
public class VisitorImpl implements Visitor {
    private static int ItemDecIndex = 0;
    public static String objectClassName = "Object";

    public static void createNewSymbolTable() {
        SymbolTable.push(new SymbolTable(SymbolTable.top));
    }

    public SymbolTableItem createVarDecSymbolItem(VarDeclaration varDecleration) {
        SymbolTableVariableItemBase varDec = new SymbolTableVariableItemBase(
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
        System.out.println(methodDeclaration);
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

        // @TODO type check expression
    }

    @Override
    public void visit(Identifier identifier) {
        // @TODO : type check with SymbolTable
        // @TODO : must distinguish between Class, Method, Variable
    }

    @Override
    public void visit(Length length) {
        Expression expression = length.getExpression();
        expression.accept(new VisitorImpl());
    }

    @Override
    public void visit(MethodCall methodCall) {
        System.out.println(methodCall);
        Expression instance = methodCall.getInstance();
        Identifier methodName = methodCall.getMethodName();

        instance.accept(new VisitorImpl());
        methodName.accept(new VisitorImpl());

        try {
            System.out.println("MethodCall: :D : " + "c_" + instance.getType());
            SymbolTableClassItem instanceItem = (SymbolTableClassItem)SymbolTable.top.get("c_" + instance.getType());
            System.out.println("MethodCall: " + "c_" + instanceItem.getKey());
            SymbolTableMethodItem methodItem =  (SymbolTableMethodItem)instanceItem.get("m_" + methodName.getName());
            System.out.println("MethodCall: " + "m_" + methodItem.getReturnType());
            methodCall.setType(methodItem.getReturnType());
            // System.out.println("MethodCall: " + "c_" + instance.getType());
            // SymbolTableMethodItem methodItem = (SymbolTableMethodItem)SymbolTable.top.get("m_" + methodName.getName());
        } catch (ItemNotFoundException error) {
            System.out.println("here :DDD");
            // @TODO : complete this section. :))
        }
        // methodCall.setType(type);
        // @TODO : find return type of methodName in SymbolTable
    }

    @Override
    public void visit(NewArray newArray) {
        Expression expression = newArray.getExpression();
        // Here.
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
        System.out.println(newClass);
        Identifier className = newClass.getClassName();
        className.accept(new VisitorImpl());
        System.out.println("NewClass: " + new UserDefinedType(className));
        newClass.setType(new UserDefinedType(new Identifier(className.getName())));
    }

    @Override
    public void visit(This instance) {
    }

    @Override
    public void visit(UnaryExpression unaryExpression) {
        Expression value = unaryExpression.getValue();
        value.accept(new VisitorImpl());
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

        // @TODO : check booleanity.
    }

    @Override
    public void visit(While loop) {
        Expression condition = loop.getCondition();
        Statement body = loop.getBody();

        condition.accept(new VisitorImpl());
        body.accept(new VisitorImpl());

        // @TODO : check booleanity.

    }

    @Override
    public void visit(Write write) {
        Expression arg = write.getArg();
        arg.accept(new VisitorImpl());

        // @TODO : type check arg, must be int or string
    }
}
