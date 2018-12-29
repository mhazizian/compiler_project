package ast.Type.PrimitiveType;

import ast.Type.Type;
import ast.Type.TypeName;

public class BooleanType extends Type {

    @Override
    public String toString() {
        return "bool";
    }


    @Override
    public String getByteCodeRep() {
        return this.toString();
    }

    @Override
    public TypeName getType() {
        return TypeName.booleanType;
    }
}
