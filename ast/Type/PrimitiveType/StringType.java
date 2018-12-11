package ast.Type.PrimitiveType;

import ast.Type.Type;

public class StringType extends Type {

    @Override
    public String toString() {
        return "string";
    }
    @Override
    public String getType() {
        return "String";
    }
}
