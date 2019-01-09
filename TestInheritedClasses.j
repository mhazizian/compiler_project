.class public static TestInheritedClasses
.super Object
.field public secondClass LSecondClass;
.field public firstClass LFirstClass;
.field public expect LExpect;
.method public <init>()V
	aload_0
	invokespecial Object/<init>()V
	return
.end method

.method public test()Z
.limit stack 32
.limit locals 32
.var 1 is result Z from begin_test to end_test
.var 2 is tempBool Z from begin_test to end_test
.var 3 is intField I from begin_test to end_test
.var 4 is stringField Ljava/lang/String; from begin_test to end_test
.var 5 is boolField Z from begin_test to end_test
.var 6 is arrayField [I from begin_test to end_test
.var 7 is dummyField LDummy; from begin_test to end_test
begin_test:
	aload_0
	new Expect
	dup
	invokespecial Expect/<init>()V
	putfield TestInheritedClasses/expect LExpect;
	aload_0
	new SecondClass
	dup
	invokespecial SecondClass/<init>()V
	putfield TestInheritedClasses/firstClass LFirstClass;
	ldc "Inherited Classes:"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	aload_0
	getfield TestInheritedClasses/firstClass LFirstClass;
	bipush 13
	invokevirtual FirstClass/setFirstInt(I)Z
	istore 2
	aload_0
	getfield TestInheritedClasses/expect LExpect;
	aload_0
	getfield TestInheritedClasses/firstClass LFirstClass;
	invokevirtual FirstClass/getFirstInt()I
	bipush 13
	ldc "\tint field:"
	invokevirtual Expect/equalInt(IILjava/lang/String;)Z
	istore 1
	aload_0
	getfield TestInheritedClasses/firstClass LFirstClass;
	iconst_1
	invokevirtual FirstClass/setFirstBoolean(Z)Z
	istore 2
	aload_0
	getfield TestInheritedClasses/expect LExpect;
	aload_0
	getfield TestInheritedClasses/firstClass LFirstClass;
	invokevirtual FirstClass/getFirstBoolean()Z
	iconst_1
	ldc "\tboolean field:"
	invokevirtual Expect/equalBool(ZZLjava/lang/String;)Z
	istore 1
	iload 1
	ireturn
end_test:
.end method
