package ast.node;

import ast.Visitor;

public abstract class Node {
    public void accept(Visitor visitor) {}
    public int lineNumber = -1;

    public int getLineNumber() {
        return lineNumber;
    }

    public void setLineNumber(int lineNumber) {
        this.lineNumber = lineNumber;
    }

}
