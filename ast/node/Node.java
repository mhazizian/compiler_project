package ast.node;

import ast.Visitor;

public abstract class Node {
    public void accept(Visitor visitor) {}
}
