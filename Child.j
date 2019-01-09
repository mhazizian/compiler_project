.class public static Child
.super Parent
.field public childField I
.method public <init>()V
.limit stack 32
	;
	; set default value for int, boolean and string fields:
	;
	aload_0
	invokespecial Parent/<init>()V
	aload_0
	iconst_0
	putfield Child/childField I
	return
.end method
.method public childMethod()I
.limit stack 32
.limit locals 32
begin_childMethod:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	aload 0
	invokevirtual Child/parentMethod()I
	ireturn
end_childMethod:
.end method
.method public returnItsField()I
.limit stack 32
.limit locals 32
begin_returnItsField:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
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
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	aload_0
	getfield Parent/parentField I
	ireturn
end_returnParentsField:
.end method
