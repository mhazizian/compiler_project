.class public static Expect
.super Object
.method public <init>()V
	aload_0
	invokespecial Object/<init>()V
	return
.end method

.method public equalInt(IILjava/lang/String;)Z
.limit stack 32
.limit locals 32
.var 1 is output I from begin_equalInt to end_equalInt
.var 2 is expected I from begin_equalInt to end_equalInt
.var 3 is message Ljava/lang/String; from begin_equalInt to end_equalInt
.var 4 is result Z from begin_equalInt to end_equalInt
begin_equalInt:
	aload 3
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
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
	ldc "\t###### Passed ######"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iconst_1
	istore 4
	goto else_0
fi_0:
	ldc "\t$$$$$$ Failed $$$$$$"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	ldc "\n\tOutput:"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iload 1
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(I)V
	ldc "\n\tExpceted:"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iload 2
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(I)V
	iconst_0
	istore 4
else_0:
	ldc ""
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iload 4
	ireturn
end_equalInt:
.end method
.method public equalBool(ZZLjava/lang/String;)Z
.limit stack 32
.limit locals 32
.var 1 is expected Z from begin_equalBool to end_equalBool
.var 2 is output Z from begin_equalBool to end_equalBool
.var 3 is message Ljava/lang/String; from begin_equalBool to end_equalBool
.var 4 is result Z from begin_equalBool to end_equalBool
begin_equalBool:
	aload 3
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iload 1
	iload 2
	if_icmpeq qe_3
eq_3:
	iconst_0
	goto end_3
qe_3:
	iconst_1
end_3:
	ifeq fi_2
if_2:
	ldc "\t###### Passed ######"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iconst_1
	istore 4
	goto else_2
fi_2:
	ldc "\t$$$$$$ Failed $$$$$$"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	ldc "\n\tOutput:"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iload 2
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Z)V
	ldc "\n\tExpceted:"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iload 1
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Z)V
	iconst_0
	istore 4
else_2:
	ldc ""
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iload 4
	ireturn
end_equalBool:
.end method
