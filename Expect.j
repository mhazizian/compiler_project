.class public static Expect
.super java/lang/Object
.method public <init>()V
	aload_0
	invokespecial java/lang/Object/<init>()V
	return
.end method

.method public equalInt(II)Z
.limit stack 32
.limit locals 32
.var 1 is output I from begin_equalInt to end_equalInt
.var 2 is expected I from begin_equalInt to end_equalInt
.var 3 is result Z from begin_equalInt to end_equalInt
begin_equalInt:
	iload 2
	iload 1
	if_icmpeq qe_1
eq_1:
	iconst_0
	goto end_1
qe_1:
	iconst_1
end_1:
	ifeq fi_0
if_0:
	ldc "       ###### Passed. ######"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iconst_1
	istore 3
	goto else_0
fi_0:
	ldc "       $$$$$$ Failed! $$$$$$"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iconst_0
	istore 3
else_0:
	ldc ""
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iload 3
	ireturn
end_equalInt:
.end method
