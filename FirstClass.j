.class public static FirstClass
.super Object
.field public intField I
.field public stringField Ljava/lang/String;
.field public boolField Z
.field public arrayField [I
.field public dummyField LDummy;
.method public <init>()V
.limit stack 32
	;
	; set default value for int, boolean and string fields:
	;
	aload_0
	invokespecial Object/<init>()V
	aload_0
	iconst_0
	putfield FirstClass/intField I
	aload_0
	ldc ""
	putfield FirstClass/stringField Ljava/lang/String;
	aload_0
	iconst_0
	putfield FirstClass/boolField Z
	return
.end method
.method public setFirstInt(I)Z
.limit stack 32
.limit locals 32
.var 1 is value I from begin_setFirstInt to end_setFirstInt
begin_setFirstInt:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	aload_0
	iload 1
	putfield FirstClass/intField I
	iconst_1
	ireturn
end_setFirstInt:
.end method
.method public setFirstBoolean(Z)Z
.limit stack 32
.limit locals 32
.var 1 is value Z from begin_setFirstBoolean to end_setFirstBoolean
begin_setFirstBoolean:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	aload_0
	iload 1
	putfield FirstClass/boolField Z
	iconst_1
	ireturn
end_setFirstBoolean:
.end method
.method public setFirstString(Ljava/lang/String;)Z
.limit stack 32
.limit locals 32
.var 1 is value Ljava/lang/String; from begin_setFirstString to end_setFirstString
begin_setFirstString:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	aload_0
	aload 1
	putfield FirstClass/stringField Ljava/lang/String;
	iconst_1
	ireturn
end_setFirstString:
.end method
.method public setFirstArray([I)Z
.limit stack 32
.limit locals 32
.var 1 is value [I from begin_setFirstArray to end_setFirstArray
begin_setFirstArray:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	aload_0
	aload 1
	putfield FirstClass/arrayField [I
	iconst_1
	ireturn
end_setFirstArray:
.end method
.method public setFirstDummy(LDummy;)Z
.limit stack 32
.limit locals 32
.var 1 is value LDummy; from begin_setFirstDummy to end_setFirstDummy
begin_setFirstDummy:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	aload_0
	aload 1
	putfield FirstClass/dummyField LDummy;
	iconst_1
	ireturn
end_setFirstDummy:
.end method
.method public getFirstInt()I
.limit stack 32
.limit locals 32
begin_getFirstInt:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	aload_0
	getfield FirstClass/intField I
	ireturn
end_getFirstInt:
.end method
.method public getFirstBoolean()Z
.limit stack 32
.limit locals 32
begin_getFirstBoolean:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	aload_0
	getfield FirstClass/boolField Z
	ireturn
end_getFirstBoolean:
.end method
.method public getFirstString()Ljava/lang/String;
.limit stack 32
.limit locals 32
begin_getFirstString:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	aload_0
	getfield FirstClass/stringField Ljava/lang/String;
	areturn
end_getFirstString:
.end method
.method public getFirstArray()[I
.limit stack 32
.limit locals 32
begin_getFirstArray:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	aload_0
	getfield FirstClass/arrayField [I
	areturn
end_getFirstArray:
.end method
.method public getFirstDummy()LDummy;
.limit stack 32
.limit locals 32
begin_getFirstDummy:
	;
	; set default value for int, boolean and string localVars:
	;
	;
	; variable initialation end.
	;
	aload_0
	getfield FirstClass/dummyField LDummy;
	areturn
end_getFirstDummy:
.end method
