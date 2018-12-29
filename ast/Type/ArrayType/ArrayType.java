package ast.Type.ArrayType;

import ast.Type.Type;
import ast.Type.TypeName;

public class ArrayType extends Type {
    private int size;
    @Override
    public String toString() {
        return "int[]";
    }

    @Override
    public String getByteCodeRep() {
        return "int[" + this.size + "]";
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    @Override
    public TypeName getType() {
        return TypeName.arrayType;
    }
}
