.class public static Main
.super java/lang/Object
.method public static main([Ljava/lang/String;)V
.limit stack 32
.limit locals 32
.var 4 is i I from begin_main to end_main
.var 5 is stringT Ljava/lang/String; from begin_main to end_main
.var 6 is arrayT [I from begin_main to end_main
.var 7 is intT I from begin_main to end_main
.var 8 is boolT Z from begin_main to end_main
begin_main:
	ldc "#### Equality Test ####"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iconst_1
	iconst_1
	if_icmpeq qe_1
eq_1:
	iconst_0
	goto end_1
qe_1:
	iconst_1
end_1:
	ifeq fi_0
if_0:
	ldc "if: eqtest: eq"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	goto else_0
fi_0:
	ldc "Nothing!"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
else_0:
	ldc "#### Non-equality Test ####"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iconst_1
	iconst_0
	if_icmpne qen_3
neq_3:
	iconst_0
	goto end_3
qen_3:
	iconst_1
end_3:
	ifeq fi_2
if_2:
	ldc "if: neqtest: neq"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	goto else_2
fi_2:
	ldc "Nothing!"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
else_2:
	ldc "#### Less than Test ####"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	bipush 0
	bipush 1
	if_icmplt tl_5
lt_5:
	iconst_0
	goto end_5
tl_5:
	iconst_1
end_5:
	ifeq fi_4
if_4:
	ldc "if: lttest: lt"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	goto else_4
fi_4:
	ldc "Nothing!"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
else_4:
	bipush 1
	bipush 0
	if_icmplt tl_7
lt_7:
	iconst_0
	goto end_7
tl_7:
	iconst_1
end_7:
	ifeq fi_6
if_6:
	ldc "Nothing!"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	goto else_6
fi_6:
	ldc "else: lttest: gt"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
else_6:
	ldc "#### Greater than Test ####"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	bipush 1
	bipush 0
	if_icmpgt tg_9
gt_9:
	iconst_0
	goto end_9
tg_9:
	iconst_1
end_9:
	ifeq fi_8
if_8:
	ldc "if: gttest: gt"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	goto else_8
fi_8:
	ldc "Nothing!"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
else_8:
	bipush 0
	bipush 1
	if_icmpgt tg_11
gt_11:
	iconst_0
	goto end_11
tg_11:
	iconst_1
end_11:
	ifeq fi_10
if_10:
	ldc "Nothing!"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	goto else_10
fi_10:
	ldc "else: gttest: lt"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
else_10:
	ldc "#### OR Test ####"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iconst_0
	iconst_1
	ior
	ifeq fi_12
if_12:
	ldc "if: ortest: true"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	goto else_12
fi_12:
	ldc "Nothing!"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
else_12:
	iconst_0
	iconst_0
	ior
	ifeq fi_13
if_13:
	ldc "Nothing!"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	goto else_13
fi_13:
	ldc "else: ortest: false"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
else_13:
	ldc "#### AND Test ####"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	iconst_0
	iconst_1
	iand
	ifeq fi_14
if_14:
	ldc "Nothing!"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	goto else_14
fi_14:
	ldc "else: andtest: false"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
else_14:
	iconst_1
	iconst_1
	iand
	ifeq fi_15
if_15:
	ldc "if: andtest: true"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	goto else_15
fi_15:
	ldc "Nothing!"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
else_15:
	ldc "#### Fake loop Test ####"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
loop_16:
	bipush 0
	bipush 1
	if_icmpeq qe_17
eq_17:
	iconst_0
	goto end_17
qe_17:
	iconst_1
end_17:
	ifeq pool_16
	ldc "Fake Loop!"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	goto loop_16
pool_16:
	ldc "### Mohammad Hosein is Here!"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	ldc "salam"
	astore 5
	aload 5
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	bipush 2
	istore 7
	iload 7
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(I)V
	ldc "### while  and ArrayCall test"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	bipush 0
	istore 4
	bipush 20
	newarray int
	astore 6
loop_18:
	iload 4
	bipush 20
	if_icmplt tl_19
lt_19:
	iconst_0
	goto end_19
tl_19:
	iconst_1
end_19:
	ifeq pool_18
	aload 6
	iload 4
	bipush 2
	iload 4
	imul
	iastore
	aload 6
	iload 4
iaload
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(I)V
	iload 4
	bipush 1
	iadd
	istore 4
	goto loop_18
pool_18:
	ldc "### Write array test"
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
	aload 6
	pop
	ldc 20
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(I)V
	bipush 0
return
end_main:
.end method
