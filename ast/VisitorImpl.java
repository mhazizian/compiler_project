package ast;

import java.util.ArrayList;

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

import symbolTable.*;
// TODO Same method and field names
public class VisitorImpl implements Visitor {
    private static int ItemDecIndex = 0;

    public static void createNewSymbolTable() {
        SymbolTable.push(new SymbolTable(SymbolTable.top));
        // System.out.println("___ scope created ___");
    }

    public SymbolTableItem createVarDecSymbolItem(VarDeclaration varDecleration) {
        SymbolTableVariableItemBase varDec = new SymbolTableVariableItemBase(
            varDecleration.getIdentifier().getName(),
            varDecleration.getType(),
            this.ItemDecIndex
        );
        this.ItemDecIndex += 1;

        // try {
            // System.out.println("## Putting Var: " + varDec.getName() +", "+ varDec.getIndex());
        //     SymbolTable.top.put(varDec);
        //     this.ItemDecIndex += 1;
        // } catch (ItemAlreadyExistsException error) {
        //     System.out.println("## put failed: ItemAlreadyExistsException");
        // }

        return ((SymbolTableItem) varDec);
    }

    public SymbolTableItem createMethodDecSymbolTableItem(MethodDeclaration methodDecleration) {
        ArrayList<VarDeclaration> varsDec = methodDecleration.getArgs();
        ArrayList<Type> varsType = new ArrayList<Type> ();
        for (int i = 0; i < varsDec.size(); i++)
            varsType.add(varsDec.get(i).getType());

        SymbolTableMethodItem methodDec = new SymbolTableMethodItem(
            methodDecleration.getName().getName(),
            varsType
        );

        // try {
            // String s = new String();
            // for (int i = 0; i < methodDec.getArgs().size(); i++)
            //     s = s + " " + methodDec.getArgs().get(i);

            // System.out.println("## Putting Method: " + methodDec.getName() + " ,Args:" + s);

        //     SymbolTable.top.put(methodDec);

        // } catch (ItemAlreadyExistsException error) {
        //     System.out.println("## put failed: ItemAlreadyExistsException");
        // }

        return ((SymbolTableItem) methodDec);
    }

    public SymbolTableItem createClassDecSymbolTableItem(ClassDeclaration classDeclaration) {
        SymbolTableClassItem classDec = new SymbolTableClassItem(classDeclaration.getName().getName());

        // try {
            // System.out.println("## Putting: Class: " + classDec.getKey());
        //     SymbolTable.top.put(classDec);
        // } catch (ItemAlreadyExistsException error) {
        //     System.out.println("ItemAlreadyExistsException.");
        // }

        return ((SymbolTableItem) classDec);
    }

    void putToSymbolTable(SymbolTableItem item) {
        try {
            // System.out.println("## Putting: Class: " + classDec.getKey());
            SymbolTable.top.put(item);
        } catch (ItemAlreadyExistsException error) {
            System.out.println("____ ItemAlreadyExistsException.");
        }
    }

    void putToClass(SymbolTableClassItem c, SymbolTableItem item) {
        try {
            // System.out.println("## Putting: Class: " + classDec.getKey());
            c.put(item);
            // SymbolTable.top.put(item);
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

        ArrayList<ClassDeclaration> classes = ((ArrayList<ClassDeclaration>)program.getClasses());
        ClassDeclaration mainClass = program.getMainClass();

        if (classes.size() == 0 && mainClass == null) {
            System.out.println("Line:" + 0 + ":ErrorItemMessage: No class exists in the program");
            return;
        }

        // create SymbolTableItem for each classDec
        putToSymbolTable(this.createClassDecSymbolTableItem(mainClass));
        // System.out.println("____ added class: " + mainClass.getName().getName());

        for (int i = 0; i < classes.size(); i++) {
            try {
                SymbolTable.top.put(this.createClassDecSymbolTableItem(classes.get(i)));
                // System.out.println("____ added class: " + classes.get(i).getName().getName());
            } catch (ItemAlreadyExistsException error) {
                System.out.println("Line:" + classes.get(i).getLineNumber() + ":ErrorItemMessage: Redefinition of class " + classes.get(i).getName().getName());
            }
        }


        // add parentClass for each ClassDecSymbolTableItem
        for (int i = 0; i < classes.size(); i++) {
            String parentClassName = classes.get(i).getParentName().getName();
            if (parentClassName.equals(""))
                continue;

            try {
                SymbolTableClassItem parentClass = ((SymbolTableClassItem) SymbolTable.top.get(parentClassName));
                SymbolTableClassItem curretClass = ((SymbolTableClassItem) SymbolTable.top.get(classes.get(i).getName().getName()));
                curretClass.setParent(parentClass);
            } catch (ItemNotFoundException error) {
                System.out.println("Line:" + classes.get(i).getLineNumber() + ":ErrorItemMessage: inherited class not found: " + parentClassName);
            }
        }

        // visit classes
        for (int i = 0; i < classes.size(); i++)
            classes.get(i).accept(new VisitorImpl());

        // SymbolTable.top.put(this.createClassDecSymbolTableItem(mainClass));
        mainClass.accept(new VisitorImpl());

        SymbolTable.pop();
    }

    @Override
    public void visit(ClassDeclaration classDeclaration) {
        createNewSymbolTable();
        // System.out.println("Class Decleration: " + classDeclaration.getName().getName());

        try {
            SymbolTableClassItem currentClass = ((SymbolTableClassItem) SymbolTable.top.get(classDeclaration.getName().getName()));

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
                   System.out.println("Line:" + vars.get(i).getLineNumber() + ":ErrorItemMessage: Redefinition of variable " + vars.get(i).getIdentifier().getName());
                }

            }

            for (int i = 0; i < methods.size(); i++) {
                SymbolTableItem item = this.createMethodDecSymbolTableItem(methods.get(i));
                try {
                    SymbolTable.top.put(item);
                    currentClass.put(item);
                } catch (ItemAlreadyExistsException error) {
                   System.out.println("Line:" + methods.get(i).getLineNumber() + ":ErrorItemMessage: Redefinition of method " + methods.get(i).getName().getName());
                }
                // currentClass.put(item);
                // SymbolTable.top.put(item);
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
        // System.out.println("Method Decleration: " + methodDeclaration.getName().getName());

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
               System.out.println("Line:" + localVars.get(i).getLineNumber() + ":ErrorItemMessage: Redefinition of variable " + localVars.get(i).getIdentifier().getName());
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
    }

    @Override
    public void visit(Identifier identifier) {
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
    }

    @Override
    public void visit(NewArray newArray) {
        Expression expression = newArray.getExpression();
        // Here.
        IntValue arraySize = ((IntValue) newArray.getExpression());
        if (arraySize.getConstant() <= 0)
            System.out.println("Line:" + newArray.getLineNumber() + ":ErrorItemMessage: Array length should not be zero or negative");
        expression.accept(new VisitorImpl());
    }

    @Override
    public void visit(NewClass newClass) {
        Identifier className = newClass.getClassName();
        className.accept(new VisitorImpl());
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
    }

    @Override
    public void visit(IntValue value) {
    }

    @Override
    public void visit(StringValue value) {
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
    }

    @Override
    public void visit(While loop) {
        Expression condition = loop.getCondition();
        Statement body = loop.getBody();

        condition.accept(new VisitorImpl());
        body.accept(new VisitorImpl());
    }

    @Override
    public void visit(Write write) {
        Expression arg = write.getArg();
        arg.accept(new VisitorImpl());
    }
}
