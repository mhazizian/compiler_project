package ast.node.expression;

import ast.Visitor;

public class Identifier extends Expression {
    private String name;
    private int index;

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

    public void setIndex(int index) {
        this.index = index;
    }

    public int getIndex() {
        return this.index;
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
