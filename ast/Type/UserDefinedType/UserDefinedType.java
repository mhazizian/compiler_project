package ast.Type.UserDefinedType;

import ast.Type.Type;
import ast.Type.TypeName;
import ast.node.declaration.ClassDeclaration;
import ast.node.expression.Identifier;

public class UserDefinedType extends Type {
    private ClassDeclaration classDeclaration;
    private Identifier name;

    public UserDefinedType(Identifier id) {
        this.name = id;
    }

    public UserDefinedType() {}


    public ClassDeclaration getClassDeclaration() {
        return classDeclaration;
    }

    public void setClassDeclaration(ClassDeclaration classDeclaration) {
        this.classDeclaration = classDeclaration;
    }

    public Identifier getName() {
        return name;
    }

    public void setName(Identifier name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return this.name.getName();
        // return classDeclaration.getName().getName();
    }

    @Override
    public TypeName getType() {
        return TypeName.userDefinedType;
    }
}
