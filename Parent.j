.class public static Parent
.super Object
.field public expect LExpect;
.field public parentField I
.method public <init>()V
.limit stack 32
	;
	; set default value for int, boolean and string fields:
	;
	aload_0
	invokespecial Object/<init>()V
	aload_0
	iconst_0
	putfield Parent/parentField I
	return
.end method
.method public parentMethod()I
.limit stack 32
.limit locals 32
begin_parentMethod:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	aload_0
	bipush 127
	putfield Parent/parentField I
	aload_0
	getfield Parent/parentField I
	ireturn
end_parentMethod:
.end method
