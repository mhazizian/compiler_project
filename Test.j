.class public static Test
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
.method public test()I
.limit stack 32
.limit locals 32
.var 1 is expect LExpect; from begin_test to end_test
.var 2 is result Z from begin_test to end_test
.var 3 is tempResult Z from begin_test to end_test
.var 4 is babyTest LBabyTest; from begin_test to end_test
.var 5 is babyTestOut I from begin_test to end_test
.var 6 is unaryOperatorTest LUnaryOperatorTest; from begin_test to end_test
.var 7 is binaryOperatorTest LBinaryOperatorTest; from begin_test to end_test
.var 8 is arrayTest LArrayTest; from begin_test to end_test
.var 9 is returnedClass LTestReturnedClass; from begin_test to end_test
.var 10 is testInheritedClasses LTestInheritedClasses; from begin_test to end_test
.var 11 is fibo LFibo; from begin_test to end_test
begin_test:
	;
	; set default value for int, boolean and string localVars:
	;
	iconst_0
	istore 2
	iconst_0
	istore 3
	iconst_0
	istore 5
	;
	; variable initialation end.
	;
	new Expect
	dup
	invokespecial Expect/<init>()V
	astore 1
	new BabyTest
	dup
	invokespecial BabyTest/<init>()V
	astore 4
	aload 4
	invokevirtual BabyTest/test()I
	istore 5
	aload 1
	iload 5
	bipush 0
	ldc "BabyTest (variable):"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	istore 2
	iload 2
	aload 1
	new BabyTest
	dup
	invokespecial BabyTest/<init>()V
	invokevirtual BabyTest/test()I
	bipush 0
	ldc "BabyTest (new class):"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 2
	new UnaryOperatorTest
	dup
	invokespecial UnaryOperatorTest/<init>()V
	astore 6
	aload 6
	invokevirtual UnaryOperatorTest/test()Z
	istore 3
	iload 3
	aload 1
	iload 3
	iconst_1
	ldc "Unary Opeartors Test :"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	iload 3
	iload 2
	iand
	istore 2
	new BinaryOperatorTest
	dup
	invokespecial BinaryOperatorTest/<init>()V
	astore 7
	aload 7
	bipush 13
	iconst_1
	ldc "Hello"
	invokevirtual BinaryOperatorTest/test(IZLjava/lang/String;)Z
	istore 3
	iload 3
	aload 1
	iload 3
	iconst_1
	ldc "Binary Opeartors Test :"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	iload 3
	iload 2
	iand
	istore 2
	new ArrayTest
	dup
	invokespecial ArrayTest/<init>()V
	astore 8
	aload 8
	invokevirtual ArrayTest/test()Z
	istore 3
	iload 3
	aload 1
	iload 3
	iconst_1
	ldc "Array Test :"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	iload 3
	iload 2
	iand
	istore 2
	new TestReturnedClass
	dup
	invokespecial TestReturnedClass/<init>()V
	astore 9
	aload 9
	invokevirtual TestReturnedClass/test()Z
	istore 3
	iload 3
	aload 1
	iload 3
	iconst_1
	ldc "Class returning Test :"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	iload 3
	iload 2
	iand
	istore 2
	new TestInheritedClasses
	dup
	invokespecial TestInheritedClasses/<init>()V
	astore 10
	aload 10
	invokevirtual TestInheritedClasses/test()Z
	istore 3
	iload 3
	aload 1
	iload 3
	iconst_1
	ldc "Inherited Classes Test :"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	iand
	istore 3
	iload 3
	iload 2
	iand
	istore 2
	new Fibo
	dup
	invokespecial Fibo/<init>()V
	astore 11
	iload 2
	aload 1
	aload 11
	bipush 6
	invokevirtual Fibo/normalFibo(I)I
	bipush 8
	ldc "Normal Fibo Test:"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 2
	iload 2
	aload 1
	aload 11
	bipush 6
	invokevirtual Fibo/recursiveFibo(I)I
	bipush 8
	ldc "Recursive Fibo Test:"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 2
	iload 2
	aload 1
	aload 11
	bipush 6
	invokevirtual Fibo/dynamicFibo(I)I
	bipush 8
	ldc "Dynamic Fibo Test:"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 2
	aload 1
	iload 2
	iconst_1
	ldc "Test :"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	istore 2
	bipush 0
	ireturn
end_test:
.end method
