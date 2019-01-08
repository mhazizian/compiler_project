.class public static UnaryOperatorTest
.super java/lang/Object
.method public <init>()V
	aload_0
	invokespecial java/lang/Object/<init>()V
	return
.end method

.method public test()Z
.limit stack 32
.limit locals 32
.var 4 is expect LExpect; from begin_test to end_test
.var 5 is result Z from begin_test to end_test
.var 6 is resultBool Z from begin_test to end_test
.var 7 is resultInt I from begin_test to end_test
begin_test:
	new Expect
	dup
	invokespecial Expect/<init>()V
	astore 4
	aload 0
	iconst_0
	invokevirtual UnaryOperatorTest/notTest(Z)Z
	istore 6
	aload 0
	bipush 1
	invokevirtual UnaryOperatorTest/minusTest(I)I
	istore 7
	aload 0
	bipush 0
	invokevirtual UnaryOperatorTest/minusTest(I)I
	istore 7
	iload 5
	ireturn
end_test:
.end method
.method public minusTest(I)I
.limit stack 32
.limit locals 32
.var 8 is value I from begin_minusTest to end_minusTest
begin_minusTest:
	iload 8
	ineg
	ireturn
end_minusTest:
.end method
.method public notTest(Z)Z
.limit stack 32
.limit locals 32
.var 9 is value Z from begin_notTest to end_notTest
begin_notTest:
	iload 9
	ineg
	ireturn
end_notTest:
.end method
