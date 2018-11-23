package ast.node.expression.Value;

import ast.Type.Type;
import ast.Visitor;
import ast.node.expression.Expression;

public abstract class Value extends Expression {
    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    protected Type type;

    @Override
    public void accept(Visitor visitor) {}
}