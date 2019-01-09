.class public static BinaryOperatorTest
.super Object
.field public expect LExpect;
.field public resultBool Z
.field public resultInt I
.field public fieldString Ljava/lang/String;
.method public <init>()V
.limit stack 32
	;
	; set default value for int, boolean and string fields:
	;
	aload_0
	invokespecial Object/<init>()V
	aload_0
	iconst_0
	putfield BinaryOperatorTest/resultBool Z
	aload_0
	iconst_0
	putfield BinaryOperatorTest/resultInt I
	aload_0
	ldc ""
	putfield BinaryOperatorTest/fieldString Ljava/lang/String;
	return
.end method
.method public test(IZLjava/lang/String;)Z
.limit stack 32
.limit locals 32
.var 1 is tempInt I from begin_test to end_test
.var 2 is tempBool Z from begin_test to end_test
.var 3 is tempString Ljava/lang/String; from begin_test to end_test
.var 4 is result Z from begin_test to end_test
.var 5 is firstDummy LDummy; from begin_test to end_test
.var 6 is secondDummy LDummy; from begin_test to end_test
begin_test:
	;
	; set default value for int, boolean and string localVars:
	;
	iconst_0
	istore 4
	;
	; variable initialation end.
	;
	aload_0
	ldc "Salam"
	putfield BinaryOperatorTest/fieldString Ljava/lang/String;
	aload_0
	new Expect
	dup
	invokespecial Expect/<init>()V
	putfield BinaryOperatorTest/expect LExpect;
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
	istore 4
	aload_0
	aload 0
	iload 1
	iload 1
	invokevirtual BinaryOperatorTest/addTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 26
	ldc "\tAddTest : Variable"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iload 1
	bipush 23
	invokevirtual BinaryOperatorTest/addTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 36
	ldc "\tAddTest : var + const"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	bipush 3
	bipush 0
	invokevirtual BinaryOperatorTest/subTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 3
	ldc "\tSubTest : Constant"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iload 1
	iload 1
	invokevirtual BinaryOperatorTest/subTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 0
	ldc "\tSubTest : Variable"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iload 1
	bipush 23
	invokevirtual BinaryOperatorTest/subTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush -10
	ldc "\tSubTest : var + const"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	bipush 3
	bipush 0
	invokevirtual BinaryOperatorTest/multTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 0
	ldc "\tmultTest : Constant"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 4
	bipush 2
	istore 1
	aload_0
	aload 0
	iload 1
	iload 1
	invokevirtual BinaryOperatorTest/multTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 4
	ldc "\tmultTest : Variable"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iload 1
	bipush -2
	invokevirtual BinaryOperatorTest/multTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush -4
	ldc "\tmultTest : var + const"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	bipush 3
	bipush 1
	invokevirtual BinaryOperatorTest/divTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 3
	ldc "\tdivTest : Constant"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iload 1
	iload 1
	invokevirtual BinaryOperatorTest/divTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 1
	ldc "\tdivTest : Variable"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	bipush 0
	iload 1
	invokevirtual BinaryOperatorTest/divTest(II)I
	putfield BinaryOperatorTest/resultInt I
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultInt I
	bipush 0
	ldc "\tdivTest : var + const"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iconst_1
	iconst_1
	invokevirtual BinaryOperatorTest/andTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\tandTest : Constant"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iload 2
	iload 2
	invokevirtual BinaryOperatorTest/andTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\tandTest : Variable"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iconst_0
	iload 2
	invokevirtual BinaryOperatorTest/andTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_0
	ldc "\tandTest : var + const"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iload 2
	iconst_0
	invokevirtual BinaryOperatorTest/orTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\torTest : Constant"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
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
	invokevirtual BinaryOperatorTest/orTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\torTest : Variable"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iconst_0
	iload 2
	ifeq begin_notUnary_9
	iconst_0
	goto end_notUnary_9
begin_notUnary_9:
	iconst_1
end_notUnary_9:
	invokevirtual BinaryOperatorTest/orTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_0
	ldc "\torTest : var + const"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iload 2
	iconst_1
	invokevirtual BinaryOperatorTest/eqBoolTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\teqTest : Constant"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iload 2
	iload 2
	ifeq begin_notUnary_10
	iconst_0
	goto end_notUnary_10
begin_notUnary_10:
	iconst_1
end_notUnary_10:
	invokevirtual BinaryOperatorTest/eqBoolTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_0
	ldc "\teqTest : Variable"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iconst_0
	iload 2
	invokevirtual BinaryOperatorTest/eqBoolTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_0
	ldc "\teqTest : var + const"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload 3
	ldc "Hello"
	ldc "\teqStringTest : Constant"
	invokevirtual Expect/equalString(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
	iand
	istore 4
	new Dummy
	dup
	invokespecial Dummy/<init>()V
	astore 5
	new Dummy
	dup
	invokespecial Dummy/<init>()V
	astore 6
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload 5
	aload 5
	ldc "\teqUserDefinedTest"
	invokevirtual Expect/equalUserdefined(LDummy;LDummy;Ljava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 5
	aload 6
	invokevirtual java/lang/Object/equals(Ljava/lang/Object;)Z
	ifeq begin_notUnary_11
	iconst_0
	goto end_notUnary_11
begin_notUnary_11:
	iconst_1
end_notUnary_11:
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "eqUserDefinedTest: not equal"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iload 2
	iconst_1
	invokevirtual BinaryOperatorTest/neqBoolTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_0
	ldc "\tneqTest : Constant"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iload 2
	iload 2
	ifeq begin_notUnary_12
	iconst_0
	goto end_notUnary_12
begin_notUnary_12:
	iconst_1
end_notUnary_12:
	invokevirtual BinaryOperatorTest/neqBoolTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\tneqTest : Variable"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iconst_0
	iload 2
	invokevirtual BinaryOperatorTest/neqBoolTest(ZZ)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\tneqTest : var + const"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	bipush -1
	bipush 1
	invokevirtual BinaryOperatorTest/ltTest(II)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\tltTest : Constant"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iload 1
	bipush 1
	isub
	iload 1
	invokevirtual BinaryOperatorTest/ltTest(II)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\tltTest : Variable"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	bipush 20
	iload 1
	invokevirtual BinaryOperatorTest/ltTest(II)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_0
	ldc "\tltTest : var + const"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	bipush -1
	bipush 1
	invokevirtual BinaryOperatorTest/gtTest(II)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_0
	ldc "\tgtTest : Constant"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	iload 1
	bipush 1
	isub
	iload 1
	invokevirtual BinaryOperatorTest/gtTest(II)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_0
	ldc "\tgtTest : Variable"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	aload_0
	aload 0
	bipush 20
	iload 1
	invokevirtual BinaryOperatorTest/gtTest(II)Z
	putfield BinaryOperatorTest/resultBool Z
	iload 4
	aload_0
	getfield BinaryOperatorTest/expect LExpect;
	aload_0
	getfield BinaryOperatorTest/resultBool Z
	iconst_1
	ldc "\tgtTest : var + const"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 4
	iload 4
	ireturn
end_test:
.end method
.method public addTest(II)I
.limit stack 32
.limit locals 32
.var 1 is firstOp I from begin_addTest to end_addTest
.var 2 is secondOp I from begin_addTest to end_addTest
begin_addTest:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
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
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
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
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
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
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
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
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
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
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	iload 1
	iload 2
	ior
	ireturn
end_orTest:
.end method
.method public eqBoolTest(ZZ)Z
.limit stack 32
.limit locals 32
.var 1 is firstOp Z from begin_eqBoolTest to end_eqBoolTest
.var 2 is secondOp Z from begin_eqBoolTest to end_eqBoolTest
begin_eqBoolTest:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	iload 1
	iload 2
	if_icmpeq qe_13
eq_13:
	iconst_0
	goto end_13
qe_13:
	iconst_1
end_13:
	ireturn
end_eqBoolTest:
.end method
.method public neqBoolTest(ZZ)Z
.limit stack 32
.limit locals 32
.var 1 is firstOp Z from begin_neqBoolTest to end_neqBoolTest
.var 2 is secondOp Z from begin_neqBoolTest to end_neqBoolTest
begin_neqBoolTest:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	iload 1
	iload 2
	if_icmpne qen_14
neq_14:
	iconst_0
	goto end_14
qen_14:
	iconst_1
end_14:
	ireturn
end_neqBoolTest:
.end method
.method public ltTest(II)Z
.limit stack 32
.limit locals 32
.var 1 is firstOp I from begin_ltTest to end_ltTest
.var 2 is secondOp I from begin_ltTest to end_ltTest
begin_ltTest:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	iload 1
	iload 2
	if_icmplt tl_15
lt_15:
	iconst_0
	goto end_15
tl_15:
	iconst_1
end_15:
	ireturn
end_ltTest:
.end method
.method public gtTest(II)Z
.limit stack 32
.limit locals 32
.var 1 is firstOp I from begin_gtTest to end_gtTest
.var 2 is secondOp I from begin_gtTest to end_gtTest
begin_gtTest:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	iload 1
	iload 2
	if_icmpgt tg_16
gt_16:
	iconst_0
	goto end_16
tg_16:
	iconst_1
end_16:
	ireturn
end_gtTest:
.end method
