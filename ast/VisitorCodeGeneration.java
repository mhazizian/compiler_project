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
public class VisitorCodeGeneration implements Visitor {

// ##############################################################################
// ##############################################################################
// #############################                     ############################
// #############################  VISITOR FUNCTIONS  ############################
// #############################                     ############################
// ##############################################################################
// ##############################################################################

    @Override
    public void visit(Program program) {
        ArrayList<ClassDeclaration> classes =
            ((ArrayList<ClassDeclaration>)program.getClasses());
        ClassDeclaration mainClass = program.getMainClass();

        for (int j = 0; j < classes.size(); j++)
            classes.get(j).accept(new VisitorCodeGeneration());

        mainClass.accept(new VisitorCodeGeneration());
    }

    @Override
    public void visit(ClassDeclaration classDeclaration) {
        ArrayList<VarDeclaration> vars =
            ((ArrayList<VarDeclaration>)classDeclaration.getVarDeclarations());
        ArrayList<MethodDeclaration> methods =
            ((ArrayList<MethodDeclaration>)classDeclaration.getMethodDeclarations());

        // visit subItems:
        for (int i = 0; i < vars.size(); i++)
            vars.get(i).accept(new VisitorCodeGeneration());

        for (int i = 0; i < methods.size(); i++)
            methods.get(i).accept(new VisitorCodeGeneration());
    }

    @Override
    public void visit(MethodDeclaration methodDeclaration) {
        Expression returnValue = methodDeclaration.getReturnValue();
        Identifier name = methodDeclaration.getName();
        ArrayList<VarDeclaration> args = methodDeclaration.getArgs();
        ArrayList<VarDeclaration> localVars =
            methodDeclaration.getLocalVars();
        ArrayList<Statement> body = methodDeclaration.getBody();

        name.accept(new VisitorCodeGeneration());

        for (int i = 0; i < args.size(); i++)
            args.get(i).accept(new VisitorCodeGeneration());

        // visit method members
        for (int i = 0; i < localVars.size(); i++)
            localVars.get(i).accept(new VisitorCodeGeneration());

        for (int i = 0; i < body.size(); i++)
            body.get(i).accept(new VisitorCodeGeneration());

        returnValue.accept(new VisitorCodeGeneration());
    }

    @Override
    public void visit(VarDeclaration varDeclaration) {
        Identifier identifier = varDeclaration.getIdentifier();
        identifier.accept(new VisitorCodeGeneration());
    }

     @Override
    public void visit(ArrayCall arrayCall) {
        // Nothing to type check in 'ArrayCall'

        Expression instance = arrayCall.getInstance();
        Expression index = arrayCall.getIndex();

        instance.accept(new VisitorCodeGeneration());
        index.accept(new VisitorCodeGeneration());
    }

    @Override
    public void visit(BinaryExpression binaryExpression) {
        Expression left = binaryExpression.getLeft();
        Expression right = binaryExpression.getRight();

        left.accept(new VisitorCodeGeneration());
        right.accept(new VisitorCodeGeneration());
    }

    @Override
    public void visit(Identifier identifier) {
    }

    @Override
    public void visit(MethodCallIdentifier identifier) {
    }

    @Override
    public void visit(Length length) {
        Expression expression = length.getExpression();
        expression.accept(new VisitorCodeGeneration());
    }

    @Override
    public void visit(MethodCall methodCall) {
        Expression instance = methodCall.getInstance();
        MethodCallIdentifier methodName = methodCall.getMethodName();
        ArrayList<Expression> args = methodCall.getArgs();

        instance.accept(new VisitorCodeGeneration());
        methodName.accept(new VisitorCodeGeneration());
        for (int i = 0; i < args.size(); i++)
            args.get(i).accept(new VisitorCodeGeneration());
    }

    @Override
    public void visit(NewArray newArray) {
        Expression expression = newArray.getExpression();
        IntValue arraySize = ((IntValue) newArray.getExpression());
        
        expression.accept(new VisitorCodeGeneration());
    }

    @Override
    public void visit(NewClass newClass) {
        Identifier className = newClass.getClassName();
        className.accept(new VisitorCodeGeneration());
    }

    @Override
    public void visit(This instance) {
    }

    @Override
    public void visit(UnaryExpression unaryExpression) {
        Expression value = unaryExpression.getValue();
        value.accept(new VisitorCodeGeneration());
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
        lValue.accept(new VisitorCodeGeneration());
        rValue.accept(new VisitorCodeGeneration());
    }

    @Override
    public void visit(Block block) {
        ArrayList<Statement> body = block.getBody();

        for (int i = 0; i < body.size(); ++i)
            body.get(i).accept(new VisitorCodeGeneration());
    }

    @Override
    public void visit(Conditional conditional) {
        Expression expression = conditional.getExpression();
        Statement consequenceBody = conditional.getConsequenceBody();
        Statement alternativeBody = conditional.getAlternativeBody();

        expression.accept(new VisitorCodeGeneration());
        consequenceBody.accept(new VisitorCodeGeneration());

        if (alternativeBody != null) {
            alternativeBody.accept(new VisitorCodeGeneration());
        }

    }

    @Override
    public void visit(While loop) {
        Expression condition = loop.getCondition();
        Statement body = loop.getBody();

        condition.accept(new VisitorCodeGeneration());
        body.accept(new VisitorCodeGeneration());
    }

    @Override
    public void visit(Write write) {
        Expression arg = write.getArg();
        arg.accept(new VisitorCodeGeneration());
    }
}