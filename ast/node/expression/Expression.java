package ast.node.expression;

import ast.Type.Type;
import ast.Visitor;
import ast.node.Node;

public abstract class Expression extends Node{
    private Type type;
    public boolean isAbsoluteValue;

    public Type getType() {
        return this.type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    @Override
    public void accept(Visitor visitor) {}
}