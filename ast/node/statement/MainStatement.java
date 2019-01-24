package ast.node.statement;

import ast.Visitor;
import ast.Type.Type;
import ast.node.expression.Expression;

public class MainStatement extends Statement {
    private Expression value;
    private Type type;

    public MainStatement(Expression value) {
        this.value = value;
    }

    public Expression getValue() {
        return value;
    }

    public void setValue(Expression value) {
        this.value = value;
    }

    public Type getType() {
        return this.value.getType();
    }

    @Override
    public String toString() {
        return "NewClass";
    }
    
    @Override
    public void accept(Visitor visitor) {
        visitor.visit(this);
    }
}
