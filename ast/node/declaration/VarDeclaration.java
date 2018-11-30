package ast.node.declaration;

import ast.Type.Type;
import ast.Visitor;
import ast.node.expression.Identifier;

public class VarDeclaration extends Declaration {
    private Identifier identifier;
    private Type type;
    private int lineNum;

    public VarDeclaration(Identifier identifier, Type type, int lineNum) {
        this.identifier = identifier;
        this.type = type;
        this.lineNum = lineNum;
    }

    
    public int getLineNumber() {
        return lineNum;
    }


    public Identifier getIdentifier() {
        return identifier;
    }

    public void setIdentifier(Identifier identifier) {
        this.identifier = identifier;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "VarDeclaration";
    }
    @Override
    public void accept(Visitor visitor) {
        visitor.visit(this);
    }
}
