.class public static Child
.super Parent
.field public childField I
.method public <init>()V
	aload_0
	invokespecial Parent/<init>()V
	return
.end method

.method public childMethod()I
.limit stack 32
.limit locals 32
begin_childMethod:
	aload 0
	invokevirtual Child/parentMethod()I
	ireturn
end_childMethod:
.end method
.method public returnItsField()I
.limit stack 32
.limit locals 32
begin_returnItsField:
	aload_0
	bipush 126
	putfield Child/childField I
	aload_0
	getfield Child/childField I
	ireturn
end_returnItsField:
.end method
.method public returnParentsField()I
.limit stack 32
.limit locals 32
begin_returnParentsField:
	aload_0
	getfield Parent/parentField I
	ireturn
end_returnParentsField:
.end method
