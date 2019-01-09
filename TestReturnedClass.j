.class public static TestReturnedClass
.super Object
.field public expect LExpect;
.field public returnedClass LReturnClass;
.field public child LChild;
.method public <init>()V
.limit stack 32
	;
	; set default value for int, boolean and string fields:
	;
	aload_0
	invokespecial Object/<init>()V
	return
.end method
.method public test()Z
.limit stack 32
.limit locals 32
.var 1 is intResult I from begin_test to end_test
.var 2 is boolResult Z from begin_test to end_test
begin_test:
	;
	; set default value for int, boolean and string localVars:
	;
	iconst_0
	istore 1
	iconst_0
	istore 2
	;
	; variable initialation end.
	;
	aload_0
	new Expect
	dup
	invokespecial Expect/<init>()V
	putfield TestReturnedClass/expect LExpect;
	aload_0
	new ReturnClass
	dup
	invokespecial ReturnClass/<init>()V
	putfield TestReturnedClass/returnedClass LReturnClass;
	aload_0
	getfield TestReturnedClass/returnedClass LReturnClass;
	invokevirtual ReturnClass/returnClass()LChild;
	invokevirtual Child/childMethod()I
	istore 1
	aload_0
	getfield TestReturnedClass/expect LExpect;
	iload 1
	bipush 127
	ldc "Returned class (Field) called its method"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	istore 2
	aload_0
	getfield TestReturnedClass/returnedClass LReturnClass;
	invokevirtual ReturnClass/returnClass()LChild;
	invokevirtual Child/parentMethod()I
	istore 1
	iload 2
	aload_0
	getfield TestReturnedClass/expect LExpect;
	iload 1
	bipush 127
	ldc "Returned class (Field) called parent's method"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 2
	aload_0
	getfield TestReturnedClass/returnedClass LReturnClass;
	invokevirtual ReturnClass/returnNewClass()LChild;
	invokevirtual Child/childMethod()I
	istore 1
	iload 2
	aload_0
	getfield TestReturnedClass/expect LExpect;
	iload 1
	bipush 127
	ldc "Returned class (new class()) called its method"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 2
	aload_0
	getfield TestReturnedClass/returnedClass LReturnClass;
	invokevirtual ReturnClass/returnNewClass()LChild;
	invokevirtual Child/parentMethod()I
	istore 1
	iload 2
	aload_0
	getfield TestReturnedClass/expect LExpect;
	iload 1
	bipush 127
	ldc "Returned class (new class()) called parent's method"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 2
	aload_0
	aload_0
	getfield TestReturnedClass/returnedClass LReturnClass;
	invokevirtual ReturnClass/returnLocalClass()LChild;
	putfield TestReturnedClass/child LChild;
	aload_0
	getfield TestReturnedClass/child LChild;
	invokevirtual Child/childMethod()I
	istore 1
	iload 2
	aload_0
	getfield TestReturnedClass/expect LExpect;
	iload 1
	bipush 127
	ldc "Returned class (Local variable) called its method"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 2
	aload_0
	getfield TestReturnedClass/child LChild;
	invokevirtual Child/parentMethod()I
	istore 1
	iload 2
	aload_0
	getfield TestReturnedClass/expect LExpect;
	iload 1
	bipush 127
	ldc "Returned class (Local variable) called parent's method"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 2
	aload_0
	getfield TestReturnedClass/child LChild;
	invokevirtual Child/returnItsField()I
	istore 1
	iload 2
	aload_0
	getfield TestReturnedClass/expect LExpect;
	iload 1
	bipush 126
	ldc "Returned class (Local variable) returns its field"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 2
	aload_0
	getfield TestReturnedClass/child LChild;
	invokevirtual Child/returnParentsField()I
	istore 1
	iload 2
	aload_0
	getfield TestReturnedClass/expect LExpect;
	iload 1
	bipush 127
	ldc "Returned class (Local variable) returns parent's field"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	iand
	istore 2
	iload 2
	ireturn
end_test:
.end method
