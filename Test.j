.class public static Test
.super java/lang/Object
.method public <init>()V
	aload_0
	invokespecial java/lang/Object/<init>()V
	return
.end method

.method public static main([Ljava/lang/String;)V
.limit stack 32
.limit locals 32
.var 10 is expect LExpect; from begin_main to end_main
.var 11 is result Z from begin_main to end_main
.var 12 is babyTest LBabyTest; from begin_main to end_main
.var 13 is babyTestOut I from begin_main to end_main
begin_main:
	new Expect
	dup
	invokespecial Expect/<init>()V
	astore 10
	new BabyTest
	dup
	invokespecial BabyTest/<init>()V
	astore 12
	aload 12
	invokevirtual BabyTest/test()I
	istore 13
	ldc "BabyTest (variable) :"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	aload 10
	bipush 0
	iload 13
	invokevirtual Expect/equalInt(II)Z
	istore 11
	bipush 0
return
end_main:
.end method
