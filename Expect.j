.class public static Expect
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
.method public equalInt(IILjava/lang/String;)Z
.limit stack 32
.limit locals 32
.var 1 is output I from begin_equalInt to end_equalInt
.var 2 is expected I from begin_equalInt to end_equalInt
.var 3 is message Ljava/lang/String; from begin_equalInt to end_equalInt
.var 4 is result Z from begin_equalInt to end_equalInt
begin_equalInt:
	;
	; set default value for int, boolean and string localVars:
	;
	iconst_0
	istore 4
	;
	; variable initialation end.
	;
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
	;
	; set default value for int, boolean and string localVars:
	;
	iconst_0
	istore 4
	;
	; variable initialation end.
	;
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
.method public equalString(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
.limit stack 32
.limit locals 32
.var 1 is expected Ljava/lang/String; from begin_equalString to end_equalString
.var 2 is output Ljava/lang/String; from begin_equalString to end_equalString
.var 3 is message Ljava/lang/String; from begin_equalString to end_equalString
.var 4 is result Z from begin_equalString to end_equalString
begin_equalString:
	;
	; set default value for int, boolean and string localVars:
	;
	iconst_0
	istore 4
	;
	; variable initialation end.
	;
	aload 3
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	aload 1
	aload 2
	invokevirtual java/lang/String/equals(Ljava/lang/Object;)Z
	ifeq fi_4
if_4:
	ldc "\t###### Passed ######"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iconst_1
	istore 4
	goto else_4
fi_4:
	ldc "\t$$$$$$ Failed $$$$$$"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	ldc "\n\tOutput:"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	aload 2
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	ldc "\n\tExpceted:"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	aload 1
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iconst_0
	istore 4
else_4:
	ldc ""
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iload 4
	ireturn
end_equalString:
.end method
.method public equalUserdefined(LDummy;LDummy;Ljava/lang/String;)Z
.limit stack 32
.limit locals 32
.var 1 is expected LDummy; from begin_equalUserdefined to end_equalUserdefined
.var 2 is output LDummy; from begin_equalUserdefined to end_equalUserdefined
.var 3 is message Ljava/lang/String; from begin_equalUserdefined to end_equalUserdefined
.var 4 is result Z from begin_equalUserdefined to end_equalUserdefined
begin_equalUserdefined:
	;
	; set default value for int, boolean and string localVars:
	;
	iconst_0
	istore 4
	;
	; variable initialation end.
	;
	aload 3
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	aload 1
	aload 2
	invokevirtual java/lang/Object/equals(Ljava/lang/Object;)Z
	ifeq fi_5
if_5:
	ldc "\t###### Passed ######"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iconst_1
	istore 4
	goto else_5
fi_5:
	ldc "\t$$$$$$ Failed $$$$$$"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iconst_0
	istore 4
else_5:
	ldc ""
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iload 4
	ireturn
end_equalUserdefined:
.end method
.method public equalIntArray([I[ILjava/lang/String;)Z
.limit stack 32
.limit locals 32
.var 1 is expected [I from begin_equalIntArray to end_equalIntArray
.var 2 is output [I from begin_equalIntArray to end_equalIntArray
.var 3 is message Ljava/lang/String; from begin_equalIntArray to end_equalIntArray
.var 4 is result Z from begin_equalIntArray to end_equalIntArray
begin_equalIntArray:
	;
	; set default value for int, boolean and string localVars:
	;
	iconst_0
	istore 4
	;
	; variable initialation end.
	;
	aload 3
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	aload 1
	aload 2
	invokevirtual java/lang/Object/equals(Ljava/lang/Object;)Z
	ifeq fi_6
if_6:
	ldc "\t###### Passed ######"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iconst_1
	istore 4
	goto else_6
fi_6:
	ldc "\t$$$$$$ Failed $$$$$$"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iconst_0
	istore 4
else_6:
	ldc ""
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iload 4
	ireturn
end_equalIntArray:
.end method
