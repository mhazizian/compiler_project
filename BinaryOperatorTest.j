.class public static BinaryOperatorTest
.super Object
.field public expect LExpect;
.field public resultBool Z
.field public resultInt I
.method public <init>()V
	aload_0
	invokespecial Object/<init>()V
	return
.end method

.method public test(IZ)Z
.limit stack 32
.limit locals 32
.var 1 is tempInt I from begin_test to end_test
.var 2 is tempBool Z from begin_test to end_test
.var 3 is result Z from begin_test to end_test
begin_test:
	aload_0
	new Expect
	dup
	invokespecial Expect/<init>()V
	putfield BinaryOperatorTest/expect LExpect;
	bipush 13
	istore 1
	iconst_1
	istore 2
	ldc "Binary Operator Test :\n"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	aload_0
	aload 0
	bipush -1
	bipush 1
	invokevirtual BinaryOperatorTest/addTest(II)I
	putfield BinaryOperatorTest/resultInt I
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 0
	ldc "\tAddTest :"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	istore 3
	aload_0
	aload 0
	iload 1
	iload 1
	invokevirtual BinaryOperatorTest/addTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 26
	ldc "\tAddTest : Variable"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iload 1
	bipush 23
	invokevirtual BinaryOperatorTest/addTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 36
	ldc "\tAddTest : var + const"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	bipush 3
	bipush 0
	invokevirtual BinaryOperatorTest/subTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 3
	ldc "\tSubTest : Constant"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iload 1
	iload 1
	invokevirtual BinaryOperatorTest/subTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 0
	ldc "\tSubTest : Variable"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iload 1
	bipush 23
	invokevirtual BinaryOperatorTest/subTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush -10
	ldc "\tSubTest : var + const"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	bipush 3
	bipush 0
	invokevirtual BinaryOperatorTest/multTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 0
	ldc "\tmultTest : Constant"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 3
	bipush 2
	istore 1
	aload_0
	aload 0
	iload 1
	iload 1
	invokevirtual BinaryOperatorTest/multTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 4
	ldc "\tmultTest : Variable"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iload 1
	bipush -2
	invokevirtual BinaryOperatorTest/multTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush -4
	ldc "\tmultTest : var + const"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	bipush 3
	bipush 1
	invokevirtual BinaryOperatorTest/divTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 3
	ldc "\tdivTest : Constant"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iload 1
	iload 1
	invokevirtual BinaryOperatorTest/divTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 1
	ldc "\tdivTest : Variable"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	bipush 0
	iload 1
	invokevirtual BinaryOperatorTest/divTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 0
	ldc "\tdivTest : var + const"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iconst_1
	iconst_1
	invokevirtual BinaryOperatorTest/andTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\tandTest : Constant"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iload 2
	iload 2
	invokevirtual BinaryOperatorTest/andTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\tandTest : Variable"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iconst_0
	iload 2
	invokevirtual BinaryOperatorTest/andTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_0
	ldc "\tandTest : var + const"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iload 2
	iconst_0
	invokevirtual BinaryOperatorTest/orTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\torTest : Constant"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iload 2
	iload 2
	ifeq begin_notUnary_5
	iconst_0
	goto end_notUnary_5
begin_notUnary_5:
	iconst_1
end_notUnary_5:
	invokevirtual BinaryOperatorTest/orTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\torTest : Variable"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iconst_0
	iload 2
	ifeq begin_notUnary_6
	iconst_0
	goto end_notUnary_6
begin_notUnary_6:
	iconst_1
end_notUnary_6:
	invokevirtual BinaryOperatorTest/orTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_0
	ldc "\torTest : var + const"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iload 2
	iconst_1
	invokevirtual BinaryOperatorTest/eqTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\teqTest : Constant"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iload 2
	iload 2
	ifeq begin_notUnary_7
	iconst_0
	goto end_notUnary_7
begin_notUnary_7:
	iconst_1
end_notUnary_7:
	invokevirtual BinaryOperatorTest/eqTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_0
	ldc "\teqTest : Variable"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iconst_0
	iload 2
	invokevirtual BinaryOperatorTest/eqTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_0
	ldc "\teqTest : var + const"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iload 2
	iconst_1
	invokevirtual BinaryOperatorTest/neqTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_0
	ldc "\tneqTest : Constant"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iload 2
	iload 2
	ifeq begin_notUnary_8
	iconst_0
	goto end_notUnary_8
begin_notUnary_8:
	iconst_1
end_notUnary_8:
	invokevirtual BinaryOperatorTest/neqTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\tneqTest : Variable"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iconst_0
	iload 2
	invokevirtual BinaryOperatorTest/neqTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\tneqTest : var + const"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	bipush -1
	bipush 1
	invokevirtual BinaryOperatorTest/ltTest(II)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\tltTest : Constant"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iload 1
	bipush 1
	isub
	iload 1
	invokevirtual BinaryOperatorTest/ltTest(II)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\tltTest : Variable"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	bipush 20
	iload 1
	invokevirtual BinaryOperatorTest/ltTest(II)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_0
	ldc "\tltTest : var + const"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	bipush -1
	bipush 1
	invokevirtual BinaryOperatorTest/gtTest(II)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_0
	ldc "\tgtTest : Constant"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	iload 1
	bipush 1
	isub
	iload 1
	invokevirtual BinaryOperatorTest/gtTest(II)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_0
	ldc "\tgtTest : Variable"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	aload_0
	aload 0
	bipush 20
	iload 1
	invokevirtual BinaryOperatorTest/gtTest(II)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 3
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\tgtTest : var + const"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	iload 3
	ireturn
end_test:
.end method
.method public addTest(II)I
.limit stack 32
.limit locals 32
.var 1 is firstOp I from begin_addTest to end_addTest
.var 2 is secondOp I from begin_addTest to end_addTest
begin_addTest:
	iload 1
	iload 2
	iadd
	ireturn
end_addTest:
.end method
.method public subTest(II)I
.limit stack 32
.limit locals 32
.var 1 is firstOp I from begin_subTest to end_subTest
.var 2 is secondOp I from begin_subTest to end_subTest
begin_subTest:
	iload 1
	iload 2
	isub
	ireturn
end_subTest:
.end method
.method public multTest(II)I
.limit stack 32
.limit locals 32
.var 1 is firstOp I from begin_multTest to end_multTest
.var 2 is secondOp I from begin_multTest to end_multTest
begin_multTest:
	iload 1
	iload 2
	imul
	ireturn
end_multTest:
.end method
.method public divTest(II)I
.limit stack 32
.limit locals 32
.var 1 is firstOp I from begin_divTest to end_divTest
.var 2 is secondOp I from begin_divTest to end_divTest
begin_divTest:
	iload 1
	iload 2
	idiv
	ireturn
end_divTest:
.end method
.method public andTest(ZZ)Z
.limit stack 32
.limit locals 32
.var 1 is firstOp Z from begin_andTest to end_andTest
.var 2 is secondOp Z from begin_andTest to end_andTest
begin_andTest:
	iload 1
	iload 2
	iand
	ireturn
end_andTest:
.end method
.method public orTest(ZZ)Z
.limit stack 32
.limit locals 32
.var 1 is firstOp Z from begin_orTest to end_orTest
.var 2 is secondOp Z from begin_orTest to end_orTest
begin_orTest:
	iload 1
	iload 2
	ior
	ireturn
end_orTest:
.end method
.method public eqTest(ZZ)Z
.limit stack 32
.limit locals 32
.var 1 is firstOp Z from begin_eqTest to end_eqTest
.var 2 is secondOp Z from begin_eqTest to end_eqTest
begin_eqTest:
	iload 1
	iload 2
	if_icmpeq qe_9
eq_9:
	iconst_0
	goto end_9
qe_9:
	iconst_1
end_9:
	ireturn
end_eqTest:
.end method
.method public neqTest(ZZ)Z
.limit stack 32
.limit locals 32
.var 1 is firstOp Z from begin_neqTest to end_neqTest
.var 2 is secondOp Z from begin_neqTest to end_neqTest
begin_neqTest:
	iload 1
	iload 2
	if_icmpne qen_10
neq_10:
	iconst_0
	goto end_10
qen_10:
	iconst_1
end_10:
	ireturn
end_neqTest:
.end method
.method public ltTest(II)Z
.limit stack 32
.limit locals 32
.var 1 is firstOp I from begin_ltTest to end_ltTest
.var 2 is secondOp I from begin_ltTest to end_ltTest
begin_ltTest:
	iload 1
	iload 2
	if_icmplt tl_11
lt_11:
	iconst_0
	goto end_11
tl_11:
	iconst_1
end_11:
	ireturn
end_ltTest:
.end method
.method public gtTest(II)Z
.limit stack 32
.limit locals 32
.var 1 is firstOp I from begin_gtTest to end_gtTest
.var 2 is secondOp I from begin_gtTest to end_gtTest
begin_gtTest:
	iload 1
	iload 2
	if_icmpgt tg_12
gt_12:
	iconst_0
	goto end_12
tg_12:
	iconst_1
end_12:
	ireturn
end_gtTest:
.end method
