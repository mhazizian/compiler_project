grammar Smoola;

    @header {
        import javafx.util.Pair; 
        import java.util.ArrayList; 

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
        SymbolTableItem addVariableDecleration(String name, Type type) {
            SymbolTableVariableItemBase varDec = new SymbolTableVariableItemBase(name, type, SymbolTable.itemIndex);

            // print("# logging: ");

            // for (String name: SymbolTable.top.items.keySet()) {
            //     print("# Log: " + name + ", " + ((SymbolTableVariableItemBase)SymbolTable.top.items.get(name)).getIndex());
            // }

            try {
                print("## Putting Var: " + varDec.getName() +", "+ varDec.getIndex());
                SymbolTable.top.put(varDec);
                SymbolTable.itemIndex += 1;
            } catch (ItemAlreadyExistsException error) {
                print("## put failed: ItemAlreadyExistsException");
            }
            return ((SymbolTableItem) varDec);
        }

        SymbolTableItem addMethodDecleration(String name, ArrayList<Type> args) {
            SymbolTableMethodItem methodDec = new SymbolTableMethodItem(name, args);
            try {
                String s = new String();
                for (int i = 0; i < args.size(); i++)
                    s = s + " " + args.get(i);
                print("## Putting Method: " + name + " ,Args:" + s);

                SymbolTable.top.put(methodDec);
                
            } catch (ItemAlreadyExistsException error) {
                print("## put failed: ItemAlreadyExistsException");
            }
            return ((SymbolTableItem) methodDec);
        }

        SymbolTableItem addClassDecleration(String name) {
            SymbolTableClassItem classDec = new SymbolTableClassItem(name);

            try {
                print("## Putting: Class: " + classDec.getKey());
                SymbolTable.top.put(classDec);
            } catch (ItemAlreadyExistsException error) {
                print("Item Already Exists Exception!");
            }
            return ((SymbolTableItem) classDec);
        }
    }

    program:
      { createNewSymbolTable(); }
        mainClass
        (
          classDeclaration
          {
          }
        )* 
        { SymbolTable.pop(); }
        EOF
    ;

    mainClass:
    // name should be checked later
    'class' name=ID
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
        print("ItemAlreadyExistsException!");
      }
    }

    '{' 'def' ID '(' ')' ':' 'int' '{'  varDeclaration* statements 'return' expression ';' '}' '}'
    { SymbolTable.pop(); }
    ;
    classDeclaration returns [ClassDeclaration synClassDeclaration]:
        'class' name=ID
        {
            addClassDecleration($name.text);
            createNewSymbolTable();
        }

        ('extends' ID)? '{' (varDeclaration)* (methodDeclaration)* '}'
        {
          Identifier id = new Identifier($name.text);
          $synClassDeclaration = new ClassDeclaration(id, null);
        }

        { SymbolTable.pop(); }
    ;
    varDeclaration returns [SymbolTableItem synVarDec]:
        'var' name=ID ':' type ';'
        { $synVarDec = addVariableDecleration($name.text, $type.synVarType); }
    ;
    methodDeclaration returns [SymbolTableItem synMethodDec]:
        'def' methodName=ID
        {
            ArrayList<Pair<String, Type> > inArgs = new ArrayList<Pair<String, Type> >();
        }
        (
            '(' ')'
            |   ('(' arg0=ID ':' arg0Type=type { inArgs.add(new Pair <String, Type> ($arg0.text, $arg0Type.synVarType)); }
                    (',' arg=ID ':' argType=type 
                        {
                            inArgs.add(new Pair <String, Type> ($arg.text, $argType.synVarType));
                        }
                    )* 
                ')')
        )
        ':' retValue=type
        {
            // create funcDec object in SymbolTable
            ArrayList<Type> inArgsType = new ArrayList<Type>();
            for(int i = 0; i < inArgs.size(); i++)
                inArgsType.add(inArgs.get(i).getValue());

            $synMethodDec = addMethodDecleration($methodName.text, inArgsType);
            createNewSymbolTable();

            // create VarDecleration for each input arg
            for(int i = 0; i < inArgs.size(); i++) 
                addVariableDecleration(inArgs.get(i).getKey(), inArgs.get(i).getValue());
            
        }
        '{'
            varDeclaration* statements
            'return' expression ';'
        '}'

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
