package ast;

import java.io.PrintWriter;
import java.io.File;

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

public class VisitorImplCodeGeneration implements Visitor {
    public static PrintWriter currentWriter;
    public static int statementCounter = 0;

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
                currentWriter.println("\tireturn");
                break;

            case stringType:
            case userDefinedType:
            case arrayType:
                currentWriter.println("\tareturn");
                break;
        
            case booleanType:
                currentWriter.println("\tireturn");
                break;
            default:
                break;
        }
    }

    void visitLocalVariables(ArrayList<VarDeclaration> localVars, String scopeBegin, String scopeEnd)
    {
        for (int i = 0; i < localVars.size(); i++) {
            localVars.get(i).accept(new VisitorImplCodeGeneration());
            currentWriter.println(".var " + localVars.get(i).getIdentifier().getIndex() +
                    " is " + localVars.get(i).getIdentifier().getName() + " " +
                    getJasminType(localVars.get(i).getType()) + " from " +
                    scopeBegin + " to " + scopeEnd);
        }
    }

    void compareStatements(String operator, String condition)      
    {
        String operatorBegin = operator + "_" + Integer.toString(statementCounter);
        String operatorEnd = (new StringBuilder(operator).reverse().toString()) +
                "_" + Integer.toString(statementCounter);
        String scopeEnd = "end_" + Integer.toString(statementCounter++);

        currentWriter.println("\tif_icmp" + condition + " " + operatorEnd);
        currentWriter.println(operatorBegin + ":");
        currentWriter.println("\ticonst_0");
        currentWriter.println("\tgoto " + scopeEnd);
        currentWriter.println(operatorEnd + ":");
        currentWriter.println("\ticonst_1");
        currentWriter.println(scopeEnd + ":");
    }

    void print(String type) {
        currentWriter.println("\tgetstatic java/lang/System/out Ljava/io/PrintStream;");
        currentWriter.println("\tswap");
        currentWriter.println("\tinvokevirtual java/io/PrintStream/print(" + type + ")V");
    }

    void printArray(Identifier array) {
        int arraySize = ((ArrayType)(array.getType())).getSize();
        
        currentWriter.println("\tpop");

        currentWriter.println("\tldc \"[\"");
        print("Ljava/lang/String;");

        for (int i = 0; i < arraySize; ++i) {
            currentWriter.println("\taload " + array.getIndex());
            currentWriter.println("\tbipush " + Integer.toString(i));
            currentWriter.println("\tiaload");
            print("I");
            if (i != (arraySize - 1))
                currentWriter.println("\tldc \", \"");
            else
                break;

            print("Ljava/lang/String;");
        }
        currentWriter.println("\tldc \"]\n\"");

        print("Ljava/lang/String;");
    }

    void createDefaultConstructor(ClassDeclaration classDeclaration) {
        String parentName = classDeclaration.getParentName().getName();

        ArrayList<VarDeclaration> vars =
                ((ArrayList<VarDeclaration>)classDeclaration.getVarDeclarations());


        currentWriter.println(".method public <init>()V");
        currentWriter.println(".limit stack 32");
        currentWriter.println("\t;");
        currentWriter.println("\t; set default value for int, boolean and string fields:");
        currentWriter.println("\t;");
        currentWriter.println("\taload_0");
        currentWriter.println("\tinvokespecial " + parentName + "/<init>()V");
        for (int i = 0; i < vars.size(); i++) {
            switch (vars.get(i).getType().getType()) {
                case intType:
                case booleanType:
                    currentWriter.println("\taload_0");
                    currentWriter.println("\ticonst_0");
                    currentWriter.println("\tputfield " + vars.get(i).getIdentifier().getClassName() +
                            "/" + vars.get(i).getIdentifier().getName() + " "
                            + getJasminType(vars.get(i).getIdentifier().getType()));
                    break;
                case stringType:
                    currentWriter.println("\taload_0");
                    currentWriter.println("\tldc \"\"");
                    currentWriter.println("\tputfield " + vars.get(i).getIdentifier().getClassName() +
                            "/" + vars.get(i).getIdentifier().getName() + " "
                            + getJasminType(vars.get(i).getIdentifier().getType()));

                default:
                    break;
            }
        }
        currentWriter.println("\treturn");
        currentWriter.println(".end method");
    }

    public void wirteConstructor(String parentName) {
        currentWriter.println(".method public <init>()V\n" +
                "\taload_0\n" + 
                "\tinvokespecial " + parentName + "/<init>()V\n" + 
                "\treturn\n" + 
                ".end method\n");
    }

    public void createJavaMain(String mainClassName) {
        try {
            currentWriter = new PrintWriter("output/" + "JavaMain.j", "UTF-8");
        } catch (IOException e) {}

        currentWriter.println(".class public JavaMain\n" + 
                ".super java/lang/Object\n\n");
                
        wirteConstructor("java/lang/Object");

        currentWriter.println(".method public static main([Ljava/lang/String;)V\n" +
                ".limit stack 32\n" +
                ".limit locals 32\n" + 
                "new " + mainClassName + "\n" +
                "dup\n" +
                "invokespecial " + mainClassName + "/<init>()V\n" +
                "\tinvokevirtual " + mainClassName + "/main()I\n" +
                "\treturn\n" +
                ".end method\n");

        currentWriter.close();
    }

    public void createObjectClass() {
        try {
            currentWriter = new PrintWriter("output/" + "Object.j", "UTF-8");
        } catch (IOException e) {}

        currentWriter.println(".class public Object\n" + 
                ".super java/lang/Object\n");
                
                wirteConstructor("java/lang/Object");
        
                currentWriter.println(".method public toString()Ljava/lang/String;\n" + 
                        ".limit locals 32\n" + 
                        ".limit stack 32\n" + 
                        "\tldc \"Object\"\n" + 
                        "\tareturn\n" + 
                        ".end method\n");

        currentWriter.close();
    }

    void checkEquality(String operator, String condition, Expression value) {
        TypeName type = value.getType().getType();

        switch (type) {
            case booleanType:
            case intType:
                compareStatements(operator, condition);
                break;

            case stringType:
                currentWriter.println("\tinvokevirtual java/lang/String/equals(Ljava/lang/Object;)Z");
                break;

            case userDefinedType:
                currentWriter.println("\tinvokevirtual java/lang/Object/equals(Ljava/lang/Object;)Z");
                break;

            case arrayType:
                currentWriter.println("\tinvokevirtual java/lang/Object/equals(Ljava/lang/Object;)Z");
                break;
        }
    }

    void notStatement() {
        String scopeEnd = "begin_notUnary_" + Integer.toString(statementCounter);
        String statementEnd = "end_notUnary_" + Integer.toString(statementCounter++);

        currentWriter.println("\tifeq " + scopeEnd);
        currentWriter.println("\ticonst_0");
        currentWriter.println("\tgoto " + statementEnd);

        currentWriter.println(scopeEnd + ":");
        currentWriter.println("\ticonst_1");

        currentWriter.println(statementEnd + ":");
    }

    void checkNotEquality(String operator, String condition, Expression value) {
        TypeName type = value.getType().getType();

        switch (type) {
            case booleanType:
            case intType:
                compareStatements(operator, condition);
                break;

            case stringType:
                currentWriter.println("\tinvokevirtual java/lang/String/equals(Ljava/lang/Object;)Z");
                notStatement();
                break;

            case userDefinedType:
                currentWriter.println("\tinvokevirtual java/lang/Object/equals(Ljava/lang/Object;)Z");
                notStatement();                
                break;

            case arrayType:
                currentWriter.println("\tinvokevirtual java/lang/Object/equals(Ljava/lang/Object;)Z");
                notStatement();
                break;
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
        new File("./output").mkdirs();

        ArrayList<ClassDeclaration> classes = ((ArrayList<ClassDeclaration>)program.getClasses());
        ClassDeclaration mainClass = program.getMainClass();
        
        createObjectClass();
        
        for (int j = 0; j < classes.size(); j++)
            classes.get(j).accept(new VisitorImplCodeGeneration());

        mainClass.accept(new VisitorImplCodeGeneration());

        createJavaMain(mainClass.getName().getName());
    }

    @Override
    public void visit(ClassDeclaration classDeclaration) {
        String className = classDeclaration.getName().getName();
        String parentName = classDeclaration.getParentName().getName();

        try {
            currentWriter = new PrintWriter("output/" + className + ".j", "UTF-8");
        } catch (IOException e) {}

        currentWriter.println(".class public static " + className);
        currentWriter.println(".super " + parentName);

        ArrayList<VarDeclaration> vars =
            ((ArrayList<VarDeclaration>)classDeclaration.getVarDeclarations());

        ArrayList<MethodDeclaration> methods =
            ((ArrayList<MethodDeclaration>)classDeclaration.getMethodDeclarations());

        // Class Fields
        for (int i = 0; i < vars.size(); i++) {
            currentWriter.println(".field public " +
                    vars.get(i).getIdentifier().getName() + " " +
                    getJasminType(vars.get(i).getType()));
        }
        
        createDefaultConstructor(classDeclaration);

        for (int i = 0; i < methods.size(); i++)
            methods.get(i).accept(new VisitorImplCodeGeneration());

        currentWriter.close();
    }

    @Override
    public void visit(MethodDeclaration methodDeclaration) {
        Expression returnValue = methodDeclaration.getReturnValue();
        Type returnType = methodDeclaration.getReturnType();
        Identifier name = methodDeclaration.getName();
        ArrayList<VarDeclaration> args = methodDeclaration.getArgs();
        ArrayList<Statement> body = methodDeclaration.getBody();
        ArrayList<VarDeclaration> localVars = methodDeclaration.getLocalVars();

        String scopeBegin = "begin_" + name.getName();
        String scopeEnd = "end_" + name.getName();

        String methodArgs = "";
        for(int i = 0; i < args.size(); i++)
            methodArgs += getJasminType(args.get(i).getType());
        String methodReturnType = getJasminType(returnType);

        currentWriter.println(".method public " + name.getName() +
                "(" + methodArgs + ")" + methodReturnType);

        currentWriter.println(".limit stack 32");
        currentWriter.println(".limit locals 32");

        // Arguments
        visitLocalVariables(methodDeclaration.getArgs(), scopeBegin, scopeEnd);
        // Local Variables
        visitLocalVariables(methodDeclaration.getLocalVars(), scopeBegin, scopeEnd);

        currentWriter.println(scopeBegin + ":");

        currentWriter.println("\t;");
        currentWriter.println("\t; set default value for int, boolean and string localVars:");
        currentWriter.println("\t;");

        for (int i = 0; i < localVars.size(); i++) {
            switch (localVars.get(i).getType().getType()) {
                case intType:
                case booleanType:
                    currentWriter.println("\ticonst_0");
                    currentWriter.println("\tistore " + localVars.get(i).getIdentifier().getIndex());
                    break;
                case stringType:
                    currentWriter.println("\tldc \"\"");
                    currentWriter.println("\tastore " + localVars.get(i).getIdentifier().getIndex());

                default:
                    break;
            }
        }

        currentWriter.println("\t;");
        currentWriter.println("\t; variable initialation end.");
        currentWriter.println("\t;");

        for (int i = 0; i < body.size(); i++)
            body.get(i).accept(new VisitorImplCodeGeneration());

        returnValue.accept(new VisitorImplCodeGeneration());

        setReturnType(returnType);

        currentWriter.println(scopeEnd + ":");
        currentWriter.println(".end method");
    }

    @Override
    public void visit(VarDeclaration varDeclaration) {
    }

     @Override
    public void visit(ArrayCall arrayCall) {
        Expression instance = arrayCall.getInstance();
        Expression index = arrayCall.getIndex();

        // Put the arrayRef to the stack
        instance.accept(new VisitorImplCodeGeneration());
        // Put the index value to the stack
        index.accept(new VisitorImplCodeGeneration());
        // Put the requested value to the stack
        currentWriter.println("iaload");
    }

    public void visitArrayCallByRefrence(ArrayCall arrayCall) {
        Expression instance = arrayCall.getInstance();
        Expression index = arrayCall.getIndex();

        // Put the arrayRef to the stack
        instance.accept(new VisitorImplCodeGeneration());
        // Put the index value to the stack
        index.accept(new VisitorImplCodeGeneration());
    }

    @Override
    public void visit(BinaryExpression binaryExpression) {
        Expression left = binaryExpression.getLeft();
        Expression right = binaryExpression.getRight();

        if (binaryExpression.getBinaryOperator() != BinaryOperator.assign) {
            left.accept(new VisitorImplCodeGeneration());
            right.accept(new VisitorImplCodeGeneration());
        }

        switch (binaryExpression.getBinaryOperator()) {
            case add:
                currentWriter.println("\tiadd");
                break;

            case sub:
                currentWriter.println("\tisub");
                break;

            case mult:
                currentWriter.println("\timul");
                break;

            case div:
                currentWriter.println("\tidiv");
                break;

            case eq:
                checkEquality("eq", "eq", left);
                break;

            case neq:
                checkNotEquality("neq", "ne", left);
                break;

            case lt:
                compareStatements("lt", "lt");
                break;
            
            case gt:
                compareStatements("gt", "gt");
                break;

            case and:
                currentWriter.println("\tiand");
                break;
                
            case or:
                currentWriter.println("\tior");
                break;

            case assign:
                Assign tempAssign = new Assign(left, right);
                tempAssign.accept(new VisitorImplCodeGeneration());
                left.accept(new VisitorImplCodeGeneration());
                break;

            default:
                break;
        }
    }

    @Override
    public void visit(Identifier identifier) {
        if (identifier.isField) {
            currentWriter.println("\taload_0");
            currentWriter.println("\tgetfield " + identifier.getClassName() +
                    "/" + identifier.getName() + " "
                    + getJasminType(identifier.getType()));
        } else {
            switch (identifier.getType().getType()) {
                case intType:
                case booleanType:
                    currentWriter.println("\tiload " + identifier.getIndex());
                    break;
                
                case userDefinedType:
                case arrayType:
                case stringType:
                    currentWriter.println("\taload " + identifier.getIndex());
                    break;
                    
                default:
                    break;
            }
        }
    }

    @Override
    public void visit(MethodCallIdentifier identifier) {
    }

    @Override
    public void visit(Length length) {
        Expression expression = length.getExpression();

        // Put the arrayRef to the stack
        expression.accept(new VisitorImplCodeGeneration());

        currentWriter.println("arraylength");
    }

    @Override
    public void visit(MethodCall methodCall) {
        Expression instance = methodCall.getInstance();
        MethodCallIdentifier methodName = methodCall.getMethodName();
        ArrayList<Expression> args = methodCall.getArgs();
        
        instance.accept(new VisitorImplCodeGeneration());
        for (int i = 0; i < args.size(); i++)
            args.get(i).accept(new VisitorImplCodeGeneration());

        String methodArgs = "";
        for (int i = 0; i < args.size(); i++)
            methodArgs += getJasminType(args.get(i).getType());

        currentWriter.println("\tinvokevirtual " + instance.getType().toString() +
                "/" + methodName.getName() + "(" + methodArgs + ")" +
                getJasminType(methodCall.getType()));
    }

    @Override
    public void visit(NewArray newArray) {
        Expression expression = newArray.getExpression();
        
        expression.accept(new VisitorImplCodeGeneration());
        currentWriter.println("\tnewarray int");
    }

    @Override
    public void visit(NewClass newClass) {
        Identifier className = newClass.getClassName();
        currentWriter.println("\tnew " + className.getName());
        currentWriter.println("\tdup");
        currentWriter.println("\tinvokespecial " + className.getName() + "/<init>()V");
    }

    @Override
    public void visit(This instance) {
        currentWriter.println("\taload 0");    
    }

    @Override
    public void visit(UnaryExpression unaryExpression) {
        Expression value = unaryExpression.getValue();
        value.accept(new VisitorImplCodeGeneration());
        switch (unaryExpression.getUnaryOperator()) {
            case not:
                notStatement();
    
                // @TODO: find appropriate command for not.
                // currentWriter.println("\tineg");
                break;
        
            case minus:
                currentWriter.println("\tineg");
                break;
        }
    }

    @Override
    public void visit(BooleanValue value) {
        // Assume that boolean is an integer (getConstant returns integer)
        currentWriter.println("\ticonst_" + value.getConstant());
    }

    @Override
    public void visit(IntValue value) {
        currentWriter.println("\tbipush " + value.getConstant());
    }

    @Override
    public void visit(StringValue value) {
        currentWriter.println("\tldc " + value.getConstant());
    }

    @Override
    public void visit(Assign assign) {
        Expression lValue = assign.getlValue();
        Expression rValue = assign.getrValue();

        if (lValue instanceof ArrayCall) {

            visitArrayCallByRefrence((ArrayCall)lValue);
            rValue.accept(new VisitorImplCodeGeneration());
            currentWriter.println("\tiastore");

        } else if (lValue instanceof Identifier && ((Identifier)lValue).isField) {

            currentWriter.println("\taload_0");
            rValue.accept(new VisitorImplCodeGeneration());
            currentWriter.println("\tputfield " + ((Identifier)lValue).getClassName() +
                    "/" + ((Identifier)lValue).getName() + " "
                    + getJasminType(((Identifier)lValue).getType()));

        } else {
            switch (lValue.getType().getType()) {
                case intType:
                case booleanType:
                    rValue.accept(new VisitorImplCodeGeneration());
                    currentWriter.println("\tistore " + ((Identifier)lValue).getIndex());
                    break;
    
                case userDefinedType:
                case arrayType:
                case stringType:
                    rValue.accept(new VisitorImplCodeGeneration());
                    currentWriter.println("\tastore " + ((Identifier)lValue).getIndex());
                    break;
    
                default:
                    break;
            }
        }
    }

    @Override
    public void visit(Block block) {
        ArrayList<Statement> body = block.getBody();

        for (int i = 0; i < body.size(); ++i)
            body.get(i).accept(new VisitorImplCodeGeneration());
    }

    @Override
    public void visit(Conditional conditional) {
        Expression expression = conditional.getExpression();
        Statement consequenceBody = conditional.getConsequenceBody();
        Statement alternativeBody = conditional.getAlternativeBody();
        String scopeBegin = "if_" + Integer.toString(statementCounter);
        String scopeEnd = "fi_" + Integer.toString(statementCounter);
        String statementEnd = "else_" + Integer.toString(statementCounter++);

        expression.accept(new VisitorImplCodeGeneration());

        currentWriter.println("\tifeq " + scopeEnd);

        currentWriter.println(scopeBegin + ":");
        consequenceBody.accept(new VisitorImplCodeGeneration());
        currentWriter.println("\tgoto " + statementEnd);

        currentWriter.println(scopeEnd + ":");

        if (alternativeBody != null)
            alternativeBody.accept(new VisitorImplCodeGeneration());

        currentWriter.println(statementEnd + ":");

    }

    @Override
    public void visit(While loop) {
        Expression condition = loop.getCondition();
        Statement body = loop.getBody();
        String scopeBegin = "loop_" + Integer.toString(statementCounter);
        String scopeEnd = "pool_" + Integer.toString(statementCounter++);
        
        currentWriter.println(scopeBegin + ":");

        condition.accept(new VisitorImplCodeGeneration());

        currentWriter.println("\tifeq " + scopeEnd);

        body.accept(new VisitorImplCodeGeneration());

        currentWriter.println("\tgoto " + scopeBegin);        

        currentWriter.println(scopeEnd + ":");
    }

    @Override
    public void visit(Write write) {
        Expression arg = write.getArg();
        arg.accept(new VisitorImplCodeGeneration());

        switch (arg.getType().getType()) {
            case intType:
            case stringType:
            case booleanType:
                currentWriter.println("\tgetstatic java/lang/System/out Ljava/io/PrintStream;");
                currentWriter.println("\tswap");
                currentWriter.println("\tinvokevirtual java/io/PrintStream/println(" + getJasminType(arg.getType()) + ")V");
                break;

            case userDefinedType:
                currentWriter.println("\tpop");
                currentWriter.println("\tldc \"" + arg.getType().getByteCodeRep() + "\"");
                currentWriter.println("\tgetstatic java/lang/System/out Ljava/io/PrintStream;");
                currentWriter.println("\tswap");
                currentWriter.println("\tinvokevirtual java/io/PrintStream/println(Ljava/lang/String;)V");
                break;
                
            case arrayType:
                printArray((Identifier)arg);
                
            break;
        
            default:
                break;
        }
    }

    @Override
    public void visit(MainStatement statement) {
        Expression expression = statement.getValue();
        expression.accept(new VisitorImplCodeGeneration());
        currentWriter.println("\tpop");
    }

    @Override
    public void visit(NoOperation nop) {}
}
