package ast.Type.PrimitiveType;

import ast.Type.Type;
import ast.Type.TypeName;

public class StringType extends Type {

    @Override
    public String toString() {
        return "string";
    }

    @Override
    public String getByteCodeRep() {
        return this.toString();
    }
    
    @Override
    public TypeName getType() {
        return TypeName.stringType;
    }
}
