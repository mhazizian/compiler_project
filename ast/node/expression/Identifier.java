package ast.node.expression;

import ast.Visitor;

public class Identifier extends Expression {
    private String name;

    public Identifier(String name) {
        this.name = name;
        this.islValue = true;
    }

    public Identifier(String name, int lineNumber) {
        this.name = name;
        this.lineNumber = lineNumber;
        this.islValue = true;
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
