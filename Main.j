.class public static Main
.super Object
.method public <init>()V
.limit stack 32
	;
	; set default value for int, boolean and string fields:
	;
	aload_0
	invokespecial Object/<init>()V
	return
.end method
.method public main()I
.limit stack 32
.limit locals 32
begin_main:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	new Test
	dup
	invokespecial Test/<init>()V
	invokevirtual Test/test()I
	ireturn
end_main:
.end method
