.class public static ReturnClass
.super Object
.field public child LChild;
.method public <init>()V
.limit stack 32
	;
	; set default value for int, boolean and string fields:
	;
	aload_0
	invokespecial Object/<init>()V
	return
.end method
.method public returnClass()LChild;
.limit stack 32
.limit locals 32
begin_returnClass:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	aload_0
	new Child
	dup
	invokespecial Child/<init>()V
	putfield ReturnClass/child LChild;
	aload_0
	getfield ReturnClass/child LChild;
	areturn
end_returnClass:
.end method
.method public returnNewClass()LChild;
.limit stack 32
.limit locals 32
begin_returnNewClass:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	new Child
	dup
	invokespecial Child/<init>()V
	areturn
end_returnNewClass:
.end method
.method public returnLocalClass()LChild;
.limit stack 32
.limit locals 32
.var 1 is localClass LChild; from begin_returnLocalClass to end_returnLocalClass
begin_returnLocalClass:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	new Child
	dup
	invokespecial Child/<init>()V
	astore 1
	aload 1
	areturn
end_returnLocalClass:
.end method
