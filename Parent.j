.class public static Parent
.super Object
.field public expect LExpect;
.field public parentField I
.method public <init>()V
	aload_0
	invokespecial Object/<init>()V
	return
.end method

.method public parentMethod()I
.limit stack 32
.limit locals 32
begin_parentMethod:
	aload_0
	bipush 127
	putfield Parent/parentField I
	aload_0
	getfield Parent/parentField I
	ireturn
end_parentMethod:
.end method
