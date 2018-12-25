package ast.node.declaration;

import ast.Visitor;
import ast.node.Node;

public abstract class Declaration extends Node {
    @Override
    public void accept(Visitor visitor) {}

    // @Override
    public void accept_parent(Visitor visitor) {}
}