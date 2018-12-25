package ast.node.declaration;

import ast.Type.Type;
import ast.Visitor;
import ast.node.declaration.MethodDeclaration;
import ast.node.expression.Expression;
import ast.node.expression.Identifier;
import ast.node.statement.Statement;

import java.util.ArrayList;

public class MainMethodDeclaration extends MethodDeclaration {
    public MainMethodDeclaration(Identifier name, int lineNumber) {
        super(name, lineNumber);
    }

    @Override
    public void accept(Visitor visitor) {
        visitor.visit(this);
    }
}
