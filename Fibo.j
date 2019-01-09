.class public static Fibo
.super Object
.field public expect LExpect;
.field public dp [I
.method public <init>()V
.limit stack 32
	;
	; set default value for int, boolean and string fields:
	;
	aload_0
	invokespecial Object/<init>()V
	return
.end method
.method public normalFibo(I)I
.limit stack 32
.limit locals 32
.var 1 is n I from begin_normalFibo to end_normalFibo
.var 2 is first I from begin_normalFibo to end_normalFibo
.var 3 is second I from begin_normalFibo to end_normalFibo
.var 4 is index I from begin_normalFibo to end_normalFibo
.var 5 is temp I from begin_normalFibo to end_normalFibo
begin_normalFibo:
	;
	; set default value for int, boolean and string localVars:
	;
	iconst_0
	istore 2
	iconst_0
	istore 3
	iconst_0
	istore 4
	iconst_0
	istore 5
	;
	; variable initialation end.
	;
	bipush 0
	istore 2
	bipush 1
	istore 3
loop_17:
	iload 4
	iload 1
	if_icmplt tl_18
lt_18:
	iconst_0
	goto end_18
tl_18:
	iconst_1
end_18:
	ifeq pool_17
	iload 3
	istore 5
	iload 2
	iload 3
	iadd
	istore 3
	iload 5
	istore 2
	iload 4
	bipush 1
	iadd
	istore 4
	goto loop_17
pool_17:
	iload 2
	ireturn
end_normalFibo:
.end method
.method public initializeArray()I
.limit stack 32
.limit locals 32
.var 1 is index I from begin_initializeArray to end_initializeArray
.var 2 is localArray [I from begin_initializeArray to end_initializeArray
begin_initializeArray:
	;
	; set default value for int, boolean and string localVars:
	;
	iconst_0
	istore 1
	;
	; variable initialation end.
	;
	bipush 2
	istore 1
	bipush 127
	newarray int
	astore 2
	aload_0
	bipush 127
	newarray int
	putfield Fibo/dp [I
	aload_0
	getfield Fibo/dp [I
	bipush 0
	bipush 0
	iastore
	aload_0
	getfield Fibo/dp [I
	bipush 1
	bipush 1
	iastore
loop_19:
	iload 1
	bipush 127
	if_icmplt tl_20
lt_20:
	iconst_0
	goto end_20
tl_20:
	iconst_1
end_20:
	ifeq pool_19
	aload_0
	getfield Fibo/dp [I
	iload 1
	bipush -1
	iastore
	iload 1
	bipush 1
	iadd
	istore 1
	goto loop_19
pool_19:
	aload_0
	getfield Fibo/dp [I
	astore 2
	bipush 2
	ireturn
end_initializeArray:
.end method
.method public dynamicFibo(I)I
.limit stack 32
.limit locals 32
.var 1 is n I from begin_dynamicFibo to end_dynamicFibo
.var 2 is index I from begin_dynamicFibo to end_dynamicFibo
begin_dynamicFibo:
	;
	; set default value for int, boolean and string localVars:
	;
	iconst_0
	istore 2
	;
	; variable initialation end.
	;
	iload 1
	bipush 127
	if_icmpgt tg_22
gt_22:
	iconst_0
	goto end_22
tg_22:
	iconst_1
end_22:
	iload 1
	bipush 0
	if_icmplt tl_23
lt_23:
	iconst_0
	goto end_23
tl_23:
	iconst_1
end_23:
	ior
	ifeq fi_21
if_21:
	ldc "Out of range"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	goto else_21
fi_21:
	aload 0
	invokevirtual Fibo/initializeArray()I
	istore 2
	bipush 2
	istore 2
loop_24:
	iload 2
	iload 1
	bipush 1
	iadd
	if_icmplt tl_25
lt_25:
	iconst_0
	goto end_25
tl_25:
	iconst_1
end_25:
	ifeq pool_24
	aload_0
	getfield Fibo/dp [I
	iload 2
	aload_0
	getfield Fibo/dp [I
	iload 2
	bipush 1
	isub
iaload
	aload_0
	getfield Fibo/dp [I
	iload 2
	bipush 2
	isub
iaload
	iadd
	iastore
	iload 2
	bipush 1
	iadd
	istore 2
	goto loop_24
pool_24:
else_21:
	aload_0
	getfield Fibo/dp [I
	iload 1
iaload
	ireturn
end_dynamicFibo:
.end method
.method public recursiveFibo(I)I
.limit stack 32
.limit locals 32
.var 1 is n I from begin_recursiveFibo to end_recursiveFibo
.var 2 is result I from begin_recursiveFibo to end_recursiveFibo
begin_recursiveFibo:
	;
	; set default value for int, boolean and string localVars:
	;
	iconst_0
	istore 2
	;
	; variable initialation end.
	;
	iload 1
	bipush 0
	if_icmplt tl_27
lt_27:
	iconst_0
	goto end_27
tl_27:
	iconst_1
end_27:
	ifeq fi_26
if_26:
	ldc "n < 0 occured in the fibo function!"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	bipush -1
	istore 2
	goto else_26
fi_26:
	iload 1
	bipush 0
	if_icmpeq qe_29
eq_29:
	iconst_0
	goto end_29
qe_29:
	iconst_1
end_29:
	ifeq fi_28
if_28:
	bipush 0
	istore 2
	goto else_28
fi_28:
	iload 1
	bipush 1
	if_icmpeq qe_31
eq_31:
	iconst_0
	goto end_31
qe_31:
	iconst_1
end_31:
	ifeq fi_30
if_30:
	bipush 1
	istore 2
	goto else_30
fi_30:
	aload 0
	iload 1
	bipush 1
	isub
	invokevirtual Fibo/recursiveFibo(I)I
	aload 0
	iload 1
	bipush 2
	isub
	invokevirtual Fibo/recursiveFibo(I)I
	iadd
	istore 2
else_30:
else_28:
else_26:
	iload 2
	ireturn
end_recursiveFibo:
.end method
