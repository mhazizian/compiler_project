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

public class VisitorImpl implements Visitor {
    private static int ItemDecIndex = 0;

    public static void createNewSymbolTable() {
            if (SymbolTable.top == null)
                SymbolTable.push(new SymbolTable());
            else
                SymbolTable.push(new SymbolTable(SymbolTable.top.getPreSymbolTable()));

            System.out.println("___ scope created ___");
    }

    public SymbolTableItem addVarToSymbolTable(VarDeclaration varDecleration) {
        SymbolTableVariableItemBase varDec = new SymbolTableVariableItemBase(
            varDecleration.getIdentifier().getName(),
            varDecleration.getType(),
            this.ItemDecIndex
        );

        try {
            System.out.println("## Putting Var: " + varDec.getName() +", "+ varDec.getIndex());
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
            System.out.println("## Putting: Class: " + classDec.getKey());
            SymbolTable.top.put(classDec);
        } catch (ItemAlreadyExistsException error) {
            System.out.println("ItemAlreadyExistsException.");
        }
        
        return ((SymbolTableItem) classDec);
    }

    @Override
    public void visit(Program program) {
        System.out.println("Program.");
        createNewSymbolTable();

        ArrayList<ClassDeclaration> classes = ((ArrayList<ClassDeclaration>)program.getClasses());

        for (int i = 0; i < classes.size(); i++) {
            classes.get(i).accept(new VisitorImpl());
        }
        SymbolTable.pop();
    }       

    @Override
    public void visit(ClassDeclaration classDeclaration) {
        System.out.println("Class Decleration.");
        this.addClassToSymbolTable(classDeclaration);
        createNewSymbolTable();

        // visit class members
        {
            ArrayList<VarDeclaration> vars =
                ((ArrayList<VarDeclaration>)classDeclaration.getVarDeclarations());
            ArrayList<MethodDeclaration> methods = 
                ((ArrayList<MethodDeclaration>)classDeclaration.getMethodDeclarations());

            for (int i = 0; i < vars.size(); i++)
                vars.get(i).accept(new VisitorImpl());

            for (int i = 0; i < methods.size(); i++)
                methods.get(i).accept(new VisitorImpl());         
        }


        SymbolTable.pop();
    }

    @Override
    public void visit(MethodDeclaration methodDeclaration) {
        System.out.println("Method Decleration.");
        this.addMethodToSymbolTable(methodDeclaration);
        createNewSymbolTable();

        // visit method members

        SymbolTable.pop();
    }

    @Override
    public void visit(VarDeclaration varDeclaration) {
        System.out.println("Var Decleration.");
        this.addVarToSymbolTable(varDeclaration);
    }

    @Override
    public void visit(ArrayCall arrayCall) {
        //TODO: implement appropriate visit functionality
    }

    @Override
    public void visit(BinaryExpression binaryExpression) {
        //TODO: implement appropriate visit functionality
    }

    @Override
    public void visit(Identifier identifier) {
        //TODO: implement appropriate visit functionality
    }

    @Override
    public void visit(Length length) {
        //TODO: implement appropriate visit functionality
    }

    @Override
    public void visit(MethodCall methodCall) {
        //TODO: implement appropriate visit functionality
    }

    @Override
    public void visit(NewArray newArray) {
        //TODO: implement appropriate visit functionality
    }

    @Override
    public void visit(NewClass newClass) {
        //TODO: implement appropriate visit functionality
    }

    @Override
    public void visit(This instance) {
        //TODO: implement appropriate visit functionality
    }

    @Override
    public void visit(UnaryExpression unaryExpression) {
        //TODO: implement appropriate visit functionality
    }

    @Override
    public void visit(BooleanValue value) {
        //TODO: implement appropriate visit functionality
    }

    @Override
    public void visit(IntValue value) {
        //TODO: implement appropriate visit functionality
    }

    @Override
    public void visit(StringValue value) {
        //TODO: implement appropriate visit functionality
    }

    @Override
    public void visit(Assign assign) {
        //TODO: implement appropriate visit functionality
    }

    @Override
    public void visit(Block block) {
        //TODO: implement appropriate visit functionality
    }

    @Override
    public void visit(Conditional conditional) {
        //TODO: implement appropriate visit functionality
    }

    @Override
    public void visit(While loop) {
        //TODO: implement appropriate visit functionality
    }

    @Override
    public void visit(Write write) {
        //TODO: implement appropriate visit functionality
    }
}
