.class public static Main
.super Object
.method public <init>()V
	aload_0
	invokespecial Object/<init>()V
	return
.end method

.method public main()I
.limit stack 32
.limit locals 32
begin_main:
	new Test
	dup
	invokespecial Test/<init>()V
	invokevirtual Test/test()I
	ireturn
end_main:
.end method
