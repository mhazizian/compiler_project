grammar Smoola;

    @header {
        import ast.node.Program;
        import ast.node.declaration.*;
        import ast.node.expression.Identifier;
        import symbolTable.*;
        import ast.Type.PrimitiveType.*;
        import ast.Type.ArrayType.*;
        import ast.Type.UserDefinedType.*;
        import ast.Type.*;
    }
    @members {
        void createNewSymbolTable() {
            if (SymbolTable.top == null)
                SymbolTable.push(new SymbolTable());
            else
                SymbolTable.push(new SymbolTable(SymbolTable.top.getPreSymbolTable()));

            print("___ scope created ___");
        }
        void print(Object s) {
            System.out.println(s);
        }
    }

    program:
      { createNewSymbolTable(); }
        mainClass
        (
          classDeclaration
          {
          }
        )* EOF

    ;

    mainClass:
    // name should be checked later
    'class' name = ID
    {
      try
      {
        SymbolTableClassItem classDec = new SymbolTableClassItem($name.text);
        print("## Putting: Main Class: " + classDec.getKey());
        SymbolTable.top.put(classDec);
        createNewSymbolTable();
      }
      catch (ItemAlreadyExistsException error)
      {
        print("Item Already Exists Exception!");
      }
    }

    '{' 'def' ID '(' ')' ':' 'int' '{'  varDeclaration* statements 'return' expression ';' '}' '}'
    { SymbolTable.pop(); }
    ;
    classDeclaration returns [ClassDeclaration synClassDeclaration]:
        'class' name=ID
        {
          try
          {
            SymbolTableClassItem classDec = new SymbolTableClassItem($name.text);
            print("## Putting: Class: " + classDec.getKey());
            SymbolTable.top.put(classDec);
            createNewSymbolTable();
          }
          catch (ItemAlreadyExistsException error)
          {
            print("Item Already Exists Exception!");
          }
        }

        ('extends' ID)? '{' (varDeclaration)* (methodDeclaration)* '}'
        {
          Identifier id = new Identifier($name.text);
          $synClassDeclaration = new ClassDeclaration(id, null);
        }

        { SymbolTable.pop(); }
    ;
    varDeclaration:
        'var' name=ID ':' type ';'
        {
          try
          {
            SymbolTableVariableItemBase varDec = new SymbolTableVariableItemBase($name.text, $type.synVarType, SymbolTable.itemIndex);
            print("## Putting: Var: " + varDec.getName() +", "+ varDec.getIndex());
            SymbolTable.top.put(varDec);
            SymbolTable.itemIndex += 1;
          }
          catch (ItemAlreadyExistsException error)
          {
            print("Item Already Exists Exception!");
          }
        }
    ;
    methodDeclaration:
        { createNewSymbolTable(); }
        'def' ID ('(' ')' | ('(' ID ':' type (',' ID ':' type)* ')')) ':' type '{'  varDeclaration* statements 'return' expression ';' '}'
        { SymbolTable.pop(); }
    ;
    statements:
        (statement)*
    ;
    statement:
        statementBlock |
        statementCondition |
        statementLoop |
        statementWrite |
        statementAssignment
    ;
    statementBlock:
        { createNewSymbolTable(); }
        '{'  statements '}'
        { SymbolTable.pop(); }
    ;
    statementCondition:
        'if' '('expression')' 'then' statement ('else' statement)?
    ;
    statementLoop:
        'while' '(' expression ')' statement
    ;
    statementWrite:
        'writeln(' expression ')' ';'
    ;
    statementAssignment:
        expression ';'
    ;

    expression:
		expressionAssignment
	;

    expressionAssignment:
		expressionOr '=' expressionAssignment
	    |	expressionOr
	;

    expressionOr:
		expressionAnd expressionOrTemp
	;

    expressionOrTemp:
		'||' expressionAnd expressionOrTemp
	    |
	;

    expressionAnd:
		expressionEq expressionAndTemp
	;

    expressionAndTemp:
		'&&' expressionEq expressionAndTemp
	    |
	;

    expressionEq:
		expressionCmp expressionEqTemp
	;

    expressionEqTemp:
		('==' | '<>') expressionCmp expressionEqTemp
	    |
	;

    expressionCmp:
		expressionAdd expressionCmpTemp
	;

    expressionCmpTemp:
		('<' | '>') expressionAdd expressionCmpTemp
	    |
	;

    expressionAdd:
		expressionMult expressionAddTemp
	;

    expressionAddTemp:
		('+' | '-') expressionMult expressionAddTemp
	    |
	;

        expressionMult:
		expressionUnary expressionMultTemp
	;

    expressionMultTemp:
		('*' | '/') expressionUnary expressionMultTemp
	    |
	;

    expressionUnary:
		('!' | '-') expressionUnary
	    |	expressionMem
	;

    expressionMem:
		expressionMethods expressionMemTemp
	;

    expressionMemTemp:
		'[' expression ']'
	    |
	;
	expressionMethods:
	    expressionOther expressionMethodsTemp
	;
	expressionMethodsTemp:
	    '.' (ID '(' ')' | ID '(' (expression (',' expression)*) ')' | 'length') expressionMethodsTemp
	    |
	;
    expressionOther:
		CONST_NUM
        |	CONST_STR
        |   'new ' 'int' '[' CONST_NUM ']'
        |   'new ' ID '(' ')'
        |   'this'
        |   'true'
        |   'false'
        |	ID
        |   ID '[' expression ']'
        |	'(' expression ')'
	;
	type returns [Type synVarType]:
	    'int' { $synVarType = new IntType(); } |
	    'boolean' { $synVarType = new BooleanType(); } |
	    'string' { $synVarType = new StringType(); } |
	    'int' '[' ']'  { $synVarType = new ArrayType(); } |
	    ID { $synVarType = new UserDefinedType(); } // TODO : generate compatible statment
	;
    CONST_NUM:
		[0-9]+
	;

    CONST_STR:
		'"' ~('\r' | '\n' | '"')* '"'
	;
    NL:
		'\r'? '\n' -> skip
	;

    ID:
		[a-zA-Z_][a-zA-Z0-9_]*
	;

    COMMENT:
		'#'(~[\r\n])* -> skip
	;

    WS:
    	[ \t] -> skip
    ;
