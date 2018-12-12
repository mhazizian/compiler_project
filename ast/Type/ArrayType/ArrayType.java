package ast.Type.ArrayType;

import ast.Type.Type;
import ast.Type.TypeName;

public class ArrayType extends Type {
    private int size;
    @Override
    public String toString() {
        return "int[]";
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
