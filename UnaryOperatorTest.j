.class public static UnaryOperatorTest
.super Object
.field public expect LExpect;
.field public tempBool Z
.field public tempInt I
.method public <init>()V
	aload_0
	invokespecial Object/<init>()V
	return
.end method

.method public test()Z
.limit stack 32
.limit locals 32
.var 1 is result Z from begin_test to end_test
.var 2 is resultBool Z from begin_test to end_test
.var 3 is resultInt I from begin_test to end_test
begin_test:
	aload_0
	iconst_0
	putfield UnaryOperatorTest/tempBool Z
	aload_0
	bipush 1
	putfield UnaryOperatorTest/tempInt I
	aload_0
	new Expect
	dup
	invokespecial Expect/<init>()V
	putfield UnaryOperatorTest/expect LExpect;
	ldc "Unary Operator Test :\n"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	aload 0
	iconst_1
	invokevirtual UnaryOperatorTest/notTest(Z)Z
	istore 2
	aload_0
	getfield UnaryOperatorTest/expect LExpect;
	iload 2
	iconst_0
	ldc "\tNotTest : True"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	istore 1
	aload 0
	iconst_0
	invokevirtual UnaryOperatorTest/notTest(Z)Z
	istore 2
	iload 1
	aload_0
	getfield UnaryOperatorTest/expect LExpect;
	iload 2
	iconst_1
	ldc "\tNotTest : False"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 1
	aload 0
	aload_0
	getfield UnaryOperatorTest/tempBool Z
	invokevirtual UnaryOperatorTest/notTest(Z)Z
	istore 2
	aload_0
	getfield UnaryOperatorTest/expect LExpect;
	iload 2
	iconst_1
	ldc "\tNotTest : variable"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	istore 1
	aload 0
	bipush 1
	invokevirtual UnaryOperatorTest/minusTest(I)I
	istore 3
	iload 1
	aload_0
	getfield UnaryOperatorTest/expect LExpect;
	iload 3
	bipush -1
	ldc "\tMinusTest : True"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 1
	aload 0
	bipush 0
	invokevirtual UnaryOperatorTest/minusTest(I)I
	istore 3
	iload 1
	aload_0
	getfield UnaryOperatorTest/expect LExpect;
	iload 3
	bipush 0
	ldc "\tMinusTest : False"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 1
	aload 0
	aload_0
	getfield UnaryOperatorTest/tempInt I
	invokevirtual UnaryOperatorTest/minusTest(I)I
	istore 3
	iload 1
	aload_0
	getfield UnaryOperatorTest/expect LExpect;
	iload 3
	bipush -1
	ldc "\tMinusTest : variable"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 1
	iload 1
	ireturn
end_test:
.end method
.method public minusTest(I)I
.limit stack 32
.limit locals 32
.var 1 is value I from begin_minusTest to end_minusTest
begin_minusTest:
	iload 1
	ineg
	ireturn
end_minusTest:
.end method
.method public notTest(Z)Z
.limit stack 32
.limit locals 32
.var 1 is value Z from begin_notTest to end_notTest
begin_notTest:
	iload 1
	ifeq begin_notUnary_4
	iconst_0
	goto end_notUnary_4
begin_notUnary_4:
	iconst_1
end_notUnary_4:
	ireturn
end_notTest:
.end method
