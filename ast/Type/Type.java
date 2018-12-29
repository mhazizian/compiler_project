package ast.Type;

public abstract class Type {
    public abstract String toString();
    public abstract String getByteCodeRep();
    public abstract TypeName getType();
}
