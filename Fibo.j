.class public static Fibo
.super Object
.field public expect LExpect;
.field public dp [I
.method public <init>()V
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
	bipush 0
	istore 4
	bipush 0
	istore 2
	bipush 1
	istore 3
loop_13:
	iload 4
	iload 1
	if_icmplt tl_14
lt_14:
	iconst_0
	goto end_14
tl_14:
	iconst_1
end_14:
	ifeq pool_13
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
	goto loop_13
pool_13:
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
loop_15:
	iload 1
	bipush 127
	if_icmplt tl_16
lt_16:
	iconst_0
	goto end_16
tl_16:
	iconst_1
end_16:
	ifeq pool_15
	aload_0
	getfield Fibo/dp [I
	iload 1
	bipush -1
	iastore
	iload 1
	bipush 1
	iadd
	istore 1
	goto loop_15
pool_15:
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
	bipush 0
	istore 2
	iload 1
	bipush 127
	if_icmpgt tg_18
gt_18:
	iconst_0
	goto end_18
tg_18:
	iconst_1
end_18:
	iload 1
	bipush 0
	if_icmplt tl_19
lt_19:
	iconst_0
	goto end_19
tl_19:
	iconst_1
end_19:
	ior
	ifeq fi_17
if_17:
	ldc "Out of range"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	goto else_17
fi_17:
	aload 0
	invokevirtual Fibo/initializeArray()I
	istore 2
	bipush 2
	istore 2
loop_20:
	iload 2
	iload 1
	bipush 1
	iadd
	if_icmplt tl_21
lt_21:
	iconst_0
	goto end_21
tl_21:
	iconst_1
end_21:
	ifeq pool_20
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
	goto loop_20
pool_20:
else_17:
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
	bipush 0
	istore 2
	iload 1
	bipush 0
	if_icmplt tl_23
lt_23:
	iconst_0
	goto end_23
tl_23:
	iconst_1
end_23:
	ifeq fi_22
if_22:
	ldc "n < 0 occured in the fibo function!"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	bipush -1
	istore 2
	goto else_22
fi_22:
	iload 1
	bipush 0
	if_icmpeq qe_25
eq_25:
	iconst_0
	goto end_25
qe_25:
	iconst_1
end_25:
	ifeq fi_24
if_24:
	bipush 0
	istore 2
	goto else_24
fi_24:
	iload 1
	bipush 1
	if_icmpeq qe_27
eq_27:
	iconst_0
	goto end_27
qe_27:
	iconst_1
end_27:
	ifeq fi_26
if_26:
	bipush 1
	istore 2
	goto else_26
fi_26:
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
else_26:
else_24:
else_22:
	iload 2
	ireturn
end_recursiveFibo:
.end method
