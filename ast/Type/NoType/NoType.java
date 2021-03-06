package ast.Type.NoType;

import ast.Type.Type;
import ast.Type.TypeName;

public class NoType extends Type {

    @Override
    public String toString() {
        return "NoType";
    }


    @Override
    public String getByteCodeRep() {
        return this.toString();
    }

    @Override
    public TypeName getType() {
        return TypeName.noType;
    }
}
