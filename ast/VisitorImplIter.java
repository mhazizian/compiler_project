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

public class VisitorImplIter implements Visitor {
    private static int ItemDecIndex = 0;

    public static void createNewSymbolTable() {
            if (SymbolTable.top == null)
                SymbolTable.push(new SymbolTable());
            else
                SymbolTable.push(new SymbolTable(SymbolTable.top.getPreSymbolTable()));
    }

    public SymbolTableItem addVarToSymbolTable(VarDeclaration varDecleration) {
        SymbolTableVariableItemBase varDec = new SymbolTableVariableItemBase(
            varDecleration.getIdentifier().getName(),
            varDecleration.getType(),
            this.ItemDecIndex
        );

        try {
            SymbolTable.top.put(varDec);
            this.ItemDecIndex += 1;
        } catch (ItemAlreadyExistsException error) {
            System.out.println("## put failed: ItemAlreadyExistsException");
        }
        return ((SymbolTableItem) varDec);
    }

    public SymbolTableItem addMethodToSymbolTable(MethodDeclaration methodDecleration) {
        ArrayList<VarDeclaration> varsDec = methodDecleration.getArgs();
        ArrayList<Type> varsType = new ArrayList<Type> ();
        for (int i = 0; i < varsDec.size(); i++)
            varsType.add(varsDec.get(i).getType());

        SymbolTableMethodItem methodDec = new SymbolTableMethodItem(
            methodDecleration.getName().getName(),
            varsType
        );

        try {
            String s = new String();
            for (int i = 0; i < methodDec.getArgs().size(); i++)
                s = s + " " + methodDec.getArgs().get(i);

            System.out.println("## Putting Method: " + methodDec.getName() + " ,Args:" + s);

            SymbolTable.top.put(methodDec);

        } catch (ItemAlreadyExistsException error) {
            System.out.println("## put failed: ItemAlreadyExistsException");
        }

        return ((SymbolTableItem) methodDec);
    }

    public SymbolTableItem addClassToSymbolTable(ClassDeclaration classDeclaration) {
        SymbolTableClassItem classDec = new SymbolTableClassItem(classDeclaration.getName().getName());

        try {
            SymbolTable.top.put(classDec);
        } catch (ItemAlreadyExistsException error) {
            System.out.println("ItemAlreadyExistsException.");
        }

        return ((SymbolTableItem) classDec);
    }

    @Override
    public void visit(Program program) {
        System.out.println(program.toString());
        createNewSymbolTable();

        ArrayList<ClassDeclaration> classes = ((ArrayList<ClassDeclaration>)
            program.getClasses());

        for (int i = 0; i < classes.size(); i++) {
            classes.get(i).accept(new VisitorImplIter());
        }
        SymbolTable.pop();
    }

    @Override
    public void visit(ClassDeclaration classDeclaration) {
        System.out.println(classDeclaration.toString());
        this.addClassToSymbolTable(classDeclaration);
        createNewSymbolTable();

          ArrayList<VarDeclaration> vars = ((ArrayList<VarDeclaration>)
              classDeclaration.getVarDeclarations());
          ArrayList<MethodDeclaration> methods = ((ArrayList<MethodDeclaration>)
              classDeclaration.getMethodDeclarations());

          for (int i = 0; i < vars.size(); i++)
              vars.get(i).accept(new VisitorImplIter());

          for (int i = 0; i < methods.size(); i++)
              methods.get(i).accept(new VisitorImplIter());

        SymbolTable.pop();
    }

    @Override
    public void visit(MethodDeclaration methodDeclaration) {
        System.out.println(methodDeclaration.toString());
        this.addMethodToSymbolTable(methodDeclaration);
        createNewSymbolTable();

        ArrayList<VarDeclaration> localVars = ((ArrayList<VarDeclaration>)
            methodDeclaration.getLocalVars());

        ArrayList<Statement> body = ((ArrayList<Statement>)
            methodDeclaration.getBody());

        for (int i = 0; i < localVars.size(); i++)
            localVars.get(i).accept(new VisitorImplIter());

        for (int i = 0; i < body.size(); i++)
            body.get(i).accept(new VisitorImplIter());

        SymbolTable.pop();
    }

    @Override
    public void visit(VarDeclaration varDeclaration) {
        System.out.println(varDeclaration.toString());
    }

    @Override
    public void visit(ArrayCall arrayCall) {
        System.out.println(arrayCall.toString());
    }

    @Override
    public void visit(BinaryExpression binaryExpression) {
        System.out.println(binaryExpression.toString());
    }

    @Override
    public void visit(Identifier identifier) {
        System.out.println(identifier.toString());
    }

    @Override
    public void visit(Length length) {
        System.out.println(length.toString());
    }

    @Override
    public void visit(MethodCall methodCall) {
        System.out.println(methodCall.toString());
    }

    @Override
    public void visit(NewArray newArray) {
        System.out.println(newArray.toString());
    }

    @Override
    public void visit(NewClass newClass) {
        System.out.println(newClass.toString());
    }

    @Override
    public void visit(This instance) {
        System.out.println(instance.toString());
    }

    @Override
    public void visit(UnaryExpression unaryExpression) {
        System.out.println(unaryExpression.toString());
    }

    @Override
    public void visit(BooleanValue value) {
        System.out.println(value.toString());
    }

    @Override
    public void visit(IntValue value) {
        System.out.println(value.toString());
    }

    @Override
    public void visit(StringValue value) {
        System.out.println(value.toString());
    }

    @Override
    public void visit(Assign assign) {
        System.out.println(assign.toString());
    }

    @Override
    public void visit(Block block) {
        System.out.println(block.toString());
    }

    @Override
    public void visit(Conditional conditional) {
        System.out.println(conditional.toString());
    }

    @Override
    public void visit(While loop) {
        System.out.println(loop.toString());
    }

    @Override
    public void visit(Write write) {
        System.out.println(write.toString());
    }
}
