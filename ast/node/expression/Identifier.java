package ast.node.expression;

import ast.Visitor;

public class Identifier extends Expression {
    private String name;
    private int index;
    public boolean isField;
    private String className;

    public Identifier(String name) {
        this.name = name;
        this.islValue = true;
        this.isField = false;
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

    public String getClassName() {
        return className;
    }

    public void setClassName(String name) {
        this.className = name;
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
