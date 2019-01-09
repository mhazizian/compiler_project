.class public static ArrayTest
.super Object
.field public classArray [I
.field public expect LExpect;
.field public result Z
.method public <init>()V
.limit stack 32
	;
	; set default value for int, boolean and string fields:
	;
	aload_0
	invokespecial Object/<init>()V
	aload_0
	iconst_0
	putfield ArrayTest/result Z
	return
.end method
.method public test()Z
.limit stack 32
.limit locals 32
.var 1 is localArray [I from begin_test to end_test
.var 2 is binaryOperatorTest LBinaryOperatorTest; from begin_test to end_test
begin_test:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	new BinaryOperatorTest
	dup
	invokespecial BinaryOperatorTest/<init>()V
	astore 2
	bipush 2
	newarray int
	astore 1
	aload_0
	bipush 3
	newarray int
	putfield ArrayTest/classArray [I
	aload_0
	new Expect
	dup
	invokespecial Expect/<init>()V
	putfield ArrayTest/expect LExpect;
	aload_0
	getfield ArrayTest/classArray [I
	bipush 0
	bipush 13
	iastore
	aload_0
	getfield ArrayTest/classArray [I
	bipush 1
	bipush 26
	iastore
	aload_0
	getfield ArrayTest/classArray [I
	bipush 2
	bipush 39
	iastore
	aload 1
	bipush 0
	bipush -26
	iastore
	aload 1
	bipush 1
	bipush -13
	iastore
	aload_0
	getfield ArrayTest/classArray [I
	bipush 0
	aload 1
	bipush 1
iaload
	iastore
	ldc "Array Test:"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	aload_0
	aload 2
	aload 1
	bipush 1
iaload
	ineg
	iconst_1
	ldc "Hello"
	invokevirtual BinaryOperatorTest/test(IZLjava/lang/String;)Z
	putfield ArrayTest/result Z
	aload_0
	aload_0
	getfield ArrayTest/expect LExpect;
	aload_0
	getfield ArrayTest/result Z
	iconst_1
	ldc "Array element in binary operators :"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	putfield ArrayTest/result Z
	aload_0
	aload_0
	getfield ArrayTest/result Z
	aload_0
	getfield ArrayTest/expect LExpect;
	bipush 5
	aload 1
arraylength
	aload_0
	getfield ArrayTest/classArray [I
arraylength
	iadd
	ldc "Array length :"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	putfield ArrayTest/result Z
	ldc "Array elements:"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	aload 1
	bipush 0
iaload
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(I)V
	aload 1
	bipush 1
iaload
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(I)V
	ldc "Printed array:"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	aload 1
	pop
	ldc "["
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
	ldc "]
"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
	aload_0
	getfield ArrayTest/result Z
	ireturn
end_test:
.end method
