package ast.node.statement;

import ast.Visitor;
import ast.node.Node;

public class Statement extends Node {

    @Override
    public String toString() {
        return "Statement";
    }

    @Override
    public void accept(Visitor visitor) {}
}
