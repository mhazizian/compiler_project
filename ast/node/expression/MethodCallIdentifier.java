package ast.node.expression;

import ast.Visitor;

public class MethodCallIdentifier extends Expression {
    private String name;

    public MethodCallIdentifier(String name) {
        this.name = name;
    }

    public MethodCallIdentifier(String name, int lineNumber) {
        this.name = name;
        this.lineNumber = lineNumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Identifier " + name;
    }
    @Override
    public void accept(Visitor visitor) {
        visitor.visit(this);
    }
}
