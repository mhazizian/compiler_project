package ast.Type.PrimitiveType;

import ast.Type.Type;
import ast.Type.TypeName;

public class IntType extends Type {
    @Override
    public String toString() {
        return "int";
    }

    @Override
    public TypeName getType() {
        return TypeName.intType;
    }
}
