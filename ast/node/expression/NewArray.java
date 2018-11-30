package ast.node.expression;

import ast.Visitor;

public class NewArray extends Expression {
    private Expression expression;
    private int lineNum;

    public Expression getExpression() {
        return expression;
    }

    public int getLineNumber() {
        return lineNum;
    }

    public void setLineNumber(int lineNum) {
        this.lineNum = lineNum;
    }
    
    public void setExpression(Expression expression) {
        this.expression = expression;
    }

    @Override
    public String toString() {
        return "NewArray";
    }
    @Override
    public void accept(Visitor visitor) {
        visitor.visit(this);
    }
}
