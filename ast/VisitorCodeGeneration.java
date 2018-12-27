package ast;

import java.io.PrintWriter;
import java.rmi.UnexpectedException;
import java.util.*;
import java.io.IOException;

import ast.node.Program;
import ast.node.declaration.*;
import ast.node.expression.*;
import ast.node.expression.Value.BooleanValue;
import ast.node.expression.Value.IntValue;
import ast.node.expression.Value.StringValue;
import ast.node.statement.*;
import ast.Type.ArrayType.*;

import ast.Type.*;
import ast.Type.UserDefinedType.UserDefinedType;
import ast.*;
public class VisitorCodeGeneration implements Visitor {
    public static PrintWriter currentWriter;

    public String getJasminType(Type type) {
        switch (type.getType()) {
            case intType:
                return "I";
            case booleanType:
                return "Z";
            case arrayType:
                return "[I";
            case stringType:
                return "Ljava/lang/String;";
            case userDefinedType:
                String className = ((UserDefinedType)type).getName().getName();
                return "L" + className + ";";
            default:
                System.out.println("Invalid given Type to convert to Jasmin.");
                return "";
        }
    }

    public void setReturnType(Type returnType)
    {    
        switch (returnType.getType()) {
            case intType:
                currentWriter.println("ireturn");
                break;

            case stringType:
            case userDefinedType:
            case arrayType:
                currentWriter.println("areturn");
                break;
        
            case booleanType:
                currentWriter.println("ireturn");
                break;
        }
    }


    void visitLocalVariables(ArrayList<VarDeclaration> localVars, String scopeBegin, String scopeEnd)
    {
        for (int i = 0; i < localVars.size(); i++) {
            localVars.get(i).accept(new VisitorCodeGeneration());
            // @TODO Is it correct to set the identifier index as a variable number
            currentWriter.println(".var " + localVars.get(i).getIdentifier().getIndex() +
                    " is " + localVars.get(i).getIdentifier().getName() + " " +
                    getJasminType(localVars.get(i).getType()) + " from " +
                    scopeBegin + " to " + scopeEnd);
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
        ArrayList<ClassDeclaration> classes =
            ((ArrayList<ClassDeclaration>)program.getClasses());
        ClassDeclaration mainClass = program.getMainClass();
        for (int j = 0; j < classes.size(); j++)
            classes.get(j).accept(new VisitorCodeGeneration());

        mainClass.accept(new VisitorCodeGeneration());
    }

    @Override
    public void visit(ClassDeclaration classDeclaration) {
        String className = classDeclaration.getName().getName();
        try {
            currentWriter = new PrintWriter(className + ".j", "UTF-8");
        } catch (IOException e) {}

        currentWriter.println(".class public static " + className);
        currentWriter.println(".super " + classDeclaration.getParentName().getName());

        ArrayList<VarDeclaration> vars =
            ((ArrayList<VarDeclaration>)classDeclaration.getVarDeclarations());
        ArrayList<MethodDeclaration> methods =
            ((ArrayList<MethodDeclaration>)classDeclaration.getMethodDeclarations());

        // visit subItems:
        for (int i = 0; i < vars.size(); i++) {
            // vars.get(i).accept(new VisitorCodeGeneration());
            currentWriter.println(".field public " +
                    vars.get(i).getIdentifier().getName() + " " +
                    getJasminType(vars.get(i).getType()));
        }

        for (int i = 0; i < methods.size(); i++)
            methods.get(i).accept(new VisitorCodeGeneration());

        currentWriter.close();
    }

    @Override
    public void visit(MethodDeclaration methodDeclaration) {
        Expression returnValue = methodDeclaration.getReturnValue();
        Type returnType = methodDeclaration.getReturnType();
        Identifier name = methodDeclaration.getName();
        ArrayList<VarDeclaration> args = methodDeclaration.getArgs();
        ArrayList<Statement> body = methodDeclaration.getBody();

        String scopeBegin = "begin_" + name.getName();
        String scopeEnd = "end_" + name.getName();

        String methodArgs = "";
        for(int i = 0; i < args.size(); i++)
            methodArgs += getJasminType(args.get(i).getType());
        String methodReturnType = getJasminType(returnType);

        currentWriter.println(".method public static " + name.getName() +
                "(" + methodArgs + ")" + methodReturnType);

        currentWriter.println(".limit stack 32");
        currentWriter.println(".limit locals 32");

        // Arguments
        visitLocalVariables(methodDeclaration.getArgs(), scopeBegin, scopeEnd);
        // Local Variables
        visitLocalVariables(methodDeclaration.getLocalVars(), scopeBegin, scopeEnd);

        currentWriter.println(scopeBegin + ":");

        for (int i = 0; i < body.size(); i++)
            body.get(i).accept(new VisitorCodeGeneration());

        returnValue.accept(new VisitorCodeGeneration());

        setReturnType(returnType);

        currentWriter.println(scopeEnd + ":");
        currentWriter.println(".end method");
    }

    @Override
    public void visit(MainMethodDeclaration methodDeclaration) {
        Expression returnValue = methodDeclaration.getReturnValue();
        Identifier name = methodDeclaration.getName();
        ArrayList<Statement> body = methodDeclaration.getBody();

        String scopeBegin = "begin_" + name.getName();
        String scopeEnd = "end_" + name.getName();

        currentWriter.println(".method public static main([Ljava/lang/String;)V");
        currentWriter.println(".limit stack 32");
        currentWriter.println(".limit locals 32");

        // Arguments
        visitLocalVariables(methodDeclaration.getArgs(), scopeBegin, scopeEnd);
        // Local Variables
        visitLocalVariables(methodDeclaration.getLocalVars(), scopeBegin, scopeEnd);

        currentWriter.println(scopeBegin + ":");

        for (int i = 0; i < body.size(); i++)
            body.get(i).accept(new VisitorCodeGeneration());

        returnValue.accept(new VisitorCodeGeneration());

        // currentWriter.println("pop");
        currentWriter.println("return");
        currentWriter.println(scopeEnd + ":");
        currentWriter.println(".end method");
    }

    @Override
    public void visit(VarDeclaration varDeclaration) {
        // @TODO Why these are comment?
        // Identifier identifier = varDeclaration.getIdentifier();
        // identifier.accept(new VisitorCodeGeneration());
    }

     @Override
    public void visit(ArrayCall arrayCall) {
        Expression instance = arrayCall.getInstance();
        Expression index = arrayCall.getIndex();

        instance.accept(new VisitorCodeGeneration()); // put arrayRef to stack
        index.accept(new VisitorCodeGeneration()); // put index value to stack
        currentWriter.println("iaload"); // put requested value to stack
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
        switch (identifier.getType().getType()) {
            case intType:
            case booleanType:
                currentWriter.println("iload " + identifier.getIndex());
                break;
            
            default:
                // currentWriter.println("aload " + identifier.getIndex());
                break;
        }
    }

    @Override
    public void visit(MethodCallIdentifier identifier) {
    }

    @Override
    public void visit(Length length) {
        Expression expression = length.getExpression();
        expression.accept(new VisitorCodeGeneration());

        currentWriter.println("pop");
        // should pop even more?
        currentWriter.println("bipush " + ((ArrayType)length.
                getExpression().getType()).getSize());
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
        currentWriter.println("anewarray java/lang/Integer");
    }

    @Override
    public void visit(NewClass newClass) {
        Identifier className = newClass.getClassName();
        
    }

    @Override
    public void visit(This instance) {
        // indexed as 0 in variables.
    }

    @Override
    public void visit(UnaryExpression unaryExpression) {
        Expression value = unaryExpression.getValue();
        value.accept(new VisitorCodeGeneration());
        switch (unaryExpression.getUnaryOperator()) {
            case not:
                // @TODO : find appropriate command for not.
                currentWriter.println("ineg");
                break;
        
            case minus:
                currentWriter.println("ineg");
                break;
        }
    }

    @Override
    public void visit(BooleanValue value) {
        // Assume boolean is integer (getConstant returns integer)
        currentWriter.println("iconst_" + value.getConstant());
    }

    @Override
    public void visit(IntValue value) {
        currentWriter.println("bipush " + value.getConstant());
    }

    @Override
    public void visit(StringValue value) {
        currentWriter.println("ldc " + value.getConstant());
    }

    @Override
    public void visit(Assign assign) {
        Expression lValue = assign.getlValue();
        Expression rValue = assign.getrValue();

        // lValue associated value shoul not be pushed to stack:
        // lValue.accept(new VisitorCodeGeneration());

        rValue.accept(new VisitorCodeGeneration());

        // @TODO : check given example:
        // var a : int[];
        // a[2] = 3
        // type of lValue in above example is setted to IntType.
        switch (lValue.getType().getType()) {
            case arrayType:
                // @TODO Check the appropriate function in VisitorImpl.java
                // currentWriter.println("astore " + ((Identifier)lValue).getIndex());
                break;

            case intType:
            case booleanType:
                currentWriter.println("istore " + ((Identifier)lValue).getIndex());
                break;

            case userDefinedType:
                currentWriter.println("astore " + ((Identifier)lValue).getIndex());
                break;

            default:
                break;
        }
        // currentWriter.println(";" + ((VarDeclaration)lValue).getIdentifier().getIndex());
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

        switch (arg.getType().getType()) {
            case intType:
            case stringType:
            case booleanType:
                currentWriter.println("getstatic java/lang/System/out Ljava/io/PrintStream;");
                currentWriter.println("swap");
                currentWriter.println("invokevirtual java/io/PrintStream/println(" + getJasminType(arg.getType()) + ")V");
                break;

            case arrayType:
                currentWriter.println("pop");
                currentWriter.println("pop");
            case userDefinedType:
                currentWriter.println("pop");
                currentWriter.println("ldc " + arg.toString());
                currentWriter.println("getstatic java/lang/System/out Ljava/io/PrintStream;");
                currentWriter.println("swap");
                currentWriter.println("invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V");
                break;
                
        
            default:
                break;
        }
    }
}
