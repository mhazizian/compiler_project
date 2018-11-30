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
    @Override
    public void visit(Program program) { // DONE
        System.out.println(program.toString());

        ClassDeclaration mainClass = program.getMainClass();
        ArrayList<ClassDeclaration> classes = ((ArrayList<ClassDeclaration>)
            program.getClasses());

        mainClass.accept(new VisitorImplIter());

        for (int i = 0; i < classes.size(); i++) {
            classes.get(i).accept(new VisitorImplIter());
        }
    }

    @Override
    public void visit(ClassDeclaration classDeclaration) { // DONE
        System.out.println(classDeclaration.toString());

        Identifier name = classDeclaration.getName();
        Identifier parentName = classDeclaration.getParentName();
        ArrayList<VarDeclaration> variables = classDeclaration.getVarDeclarations();
        ArrayList<MethodDeclaration> methods = classDeclaration.getMethodDeclarations();

        name.accept(new VisitorImplIter()); // DONE

        if (!parentName.getName().equals(""))
            parentName.accept(new VisitorImplIter()); // DONE

        for (int i = 0; i < variables.size(); i++)
            variables.get(i).accept(new VisitorImplIter());

        for (int i = 0; i < methods.size(); i++)
            methods.get(i).accept(new VisitorImplIter());
    }

    @Override
    public void visit(MethodDeclaration methodDeclaration) { // DONE
        System.out.println(methodDeclaration.toString());

        Expression returnValue = methodDeclaration.getReturnValue();
        Identifier name = methodDeclaration.getName();
        ArrayList<VarDeclaration> args = methodDeclaration.getArgs();
        ArrayList<VarDeclaration> localVars = methodDeclaration.getLocalVars();
        ArrayList<Statement> body = methodDeclaration.getBody();

        name.accept(new VisitorImplIter()); // DONE

        for (int i = 0; i < args.size(); i++)
            args.get(i).accept(new VisitorImplIter());

        for (int i = 0; i < localVars.size(); i++)
            localVars.get(i).accept(new VisitorImplIter());

        for (int i = 0; i < body.size(); i++)
            body.get(i).accept(new VisitorImplIter());

        returnValue.accept(new VisitorImplIter()); // DONE
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
    public void visit(Identifier identifier) { // DONE
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
