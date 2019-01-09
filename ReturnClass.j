.class public static ReturnClass
.super Object
.field public child LChild;
.method public <init>()V
	aload_0
	invokespecial Object/<init>()V
	return
.end method

.method public returnClass()LChild;
.limit stack 32
.limit locals 32
begin_returnClass:
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
	new Child
	dup
	invokespecial Child/<init>()V
	astore 1
	aload 1
	areturn
end_returnLocalClass:
.end method
