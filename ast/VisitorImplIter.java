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
            variables.get(i).accept(new VisitorImplIter()); // DONE

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
            args.get(i).accept(new VisitorImplIter()); // DONE

        for (int i = 0; i < localVars.size(); i++)
            localVars.get(i).accept(new VisitorImplIter()); // DONE

        for (int i = 0; i < body.size(); i++)
            body.get(i).accept(new VisitorImplIter());

        returnValue.accept(new VisitorImplIter()); // DONE
    }

    @Override
    public void visit(VarDeclaration varDeclaration) { // DONE
        System.out.println(varDeclaration.toString());

        Identifier identifier = varDeclaration.getIdentifier();
        identifier.accept(new VisitorImplIter()); // DONE
    }

    @Override
    public void visit(ArrayCall arrayCall) { // DONE
        System.out.println(arrayCall.toString());

        Expression instance = arrayCall.getInstance();
        Expression index = arrayCall.getIndex();

        instance.accept(new VisitorImplIter());
        index.accept(new VisitorImplIter());
    }

    @Override
    public void visit(BinaryExpression binaryExpression) { // DONE
        System.out.println(binaryExpression.toString());

        Expression left = binaryExpression.getLeft();
        Expression right = binaryExpression.getRight();

        left.accept(new VisitorImplIter());
        right.accept(new VisitorImplIter());
    }

    @Override
    public void visit(Identifier identifier) { // DONE
        System.out.println(identifier.toString());
    }

    @Override
    public void visit(Length length) { // DONE
        System.out.println(length.toString());

        Expression expression = length.getExpression();
        expression.accept(new VisitorImplIter());
    }

    @Override
    public void visit(MethodCall methodCall) { // DONE
        System.out.println(methodCall.toString());

        Expression instance = methodCall.getInstance();
        Identifier methodName = methodCall.getMethodName();

        instance.accept(new VisitorImplIter());
        methodName.accept(new VisitorImplIter()); // DONE
    }

    @Override
    public void visit(NewArray newArray) { // DONE
        System.out.println(newArray.toString());

        Expression expression = newArray.getExpression();
        expression.accept(new VisitorImplIter());
    }

    @Override
    public void visit(NewClass newClass) { // DONE
        System.out.println(newClass.toString());

        Identifier className = newClass.getClassName();
        className.accept(new VisitorImplIter());
    }

    @Override
    public void visit(This instance) { // DONE
        System.out.println(instance.toString());
    }

    @Override
    public void visit(UnaryExpression unaryExpression) { // DONE
        System.out.println(unaryExpression.toString());

        Expression value = unaryExpression.getValue();
        value.accept(new VisitorImplIter());
    }

    @Override
    public void visit(BooleanValue value) { // DONE
        System.out.println(value.toString());
    }

    @Override
    public void visit(IntValue value) { // DONE
        System.out.println(value.toString());
    }

    @Override
    public void visit(StringValue value) { // DONE
        System.out.println(value.toString());
    }

    @Override
    public void visit(Assign assign) { // DONE
        System.out.println(assign.toString());

        Expression lValue = assign.getlValue();
        Expression rValue = assign.getrValue();
        lValue.accept(new VisitorImplIter()); // DONE
        // rValue.accept(new VisitorImplIter());
    }

    @Override
    public void visit(Block block) { // DONE
        System.out.println(block.toString());

        ArrayList<Statement> body = block.getBody();

        for (int i = 0; i < body.size(); ++i)
            body.get(i).accept(new VisitorImplIter());
    }

    @Override
    public void visit(Conditional conditional) {
        System.out.println(conditional.toString());

        Expression expression = conditional.getExpression();
        Statement consequenceBody = conditional.getConsequenceBody();
        Statement alternativeBody = conditional.getAlternativeBody();

        expression.accept(new VisitorImplIter());
        consequenceBody.accept(new VisitorImplIter());

        if (alternativeBody != null)
            alternativeBody.accept(new VisitorImplIter());
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