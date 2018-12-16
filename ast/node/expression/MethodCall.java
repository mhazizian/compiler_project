package ast.node.expression;

import ast.Type.Type;
import ast.Visitor;

import java.util.ArrayList;

public class MethodCall extends Expression {
    private Expression instance;
    private MethodCallIdentifier methodName;
    private ArrayList<Expression> args = new ArrayList<>();

    public MethodCall(Expression instance, MethodCallIdentifier methodName) {
        this.instance = instance;
        this.methodName = methodName;
    }

    public Expression getInstance() {
        return instance;
    }

    public void setInstance(Expression instance) {
        this.instance = instance;
    }

    public MethodCallIdentifier getMethodName() {
        return methodName;
    }

    public void setMethodName(MethodCallIdentifier methodName) {
        this.methodName = methodName;
    }

    public ArrayList<Expression> getArgs() {
        return args;
    }

    public void addArg(Expression arg) {
        this.args.add(arg);
    }

    @Override
    public String toString() {
        return "MethodCall";
    }
    @Override
    public void accept(Visitor visitor) {
        visitor.visit(this);
    }
}
