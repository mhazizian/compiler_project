parser grammar SmoolaParser;

options { tokenVocab=SmoolaLexer; }

@members{
   void print(Object obj){
        System.out.print(obj);
   }

   void printEmptyLine(){
        System.out.println("");
   }

   void printLine(Object obj){
        System.out.println(obj);
   }
}

smoolaParser
  : mainClassDeclaration
    (classDeclaration
    | COMMENT)*
    EOF;

classDeclaration
  : CLASS className = IDENTIFIER
        { print("ClassDec:" + $className.text); }
        extendsDeclaration?
    {printEmptyLine();}
    classBlock
  ;

extendsDeclaration
  : EXTENDS extendedClass = IDENTIFIER
  { print("," + $extendedClass.text); }
  ;

classBlock
  : (COMMENT)* LBRACE
      (variableDeclaration | COMMENT)*
      (methodDeclaration COMMENT*)*
    RBRACE
  ;

mainClassDeclaration
  : CLASS className = IDENTIFIER
        { printLine("ClassDec:" + $className.text); }
    mainClassBlock
  ;

mainClassBlock
	: (COMMENT)* LBRACE (COMMENT)*
      (mainMethodDeclaration COMMENT*)
    RBRACE
	;

methodDeclaration
  : DEF methodName = IDENTIFIER { print("MethodDec:" + $methodName.text); }
  arguments COLON type
  {printEmptyLine();}
  bodyBlock
  ;

mainMethodDeclaration
  : DEF MAIN { printLine("MethodDec:main"); }
        LPAREN RPAREN COLON INT
    mainBodyBlock
  ;

mainBodyBlock
	: (COMMENT)* LBRACE
      (variableDeclaration | COMMENT)*
      (expression
      | statement
      | arithmeticBlock SEMI)*
      returnBlock
    RBRACE
	;

arguments
  : LPAREN
      ((arg = IDENTIFIER { print("," + $arg.text); } COLON type COMMA)*
      (arg = IDENTIFIER { print("," + $arg.text); } COLON type))?
    RPAREN
  ;

bodyBlock
	: (COMMENT)* LBRACE
      (variableDeclaration
      | COMMENT)*
      ( expression
      | statement)*
      returnBlock
    RBRACE
	;

returnBlock
  : RETURN arithmeticBlock SEMI
  ;

expression
	: COMMENT
  | newAssign
  | primitiveAssign
  | arrayInitializer
  | arrayAssign
  | arithmeticAssign
	;

arrayAssign
  : IDENTIFIER LBRACK arithmeticBlock RBRACK
    operator = ASSIGN
        { printLine("Operator:" + $operator.text); }
    arithmeticBlock SEMI
  ;

arrayInitializer
  : IDENTIFIER operator = ASSIGN
        { printLine("Operator:" + $operator.text); }
    NEW INT LBRACK
    arithmeticBlock
    RBRACK SEMI
  ;

arithmeticAssign
  : IDENTIFIER operator = ASSIGN
        { printLine("Operator:" + $operator.text); }
    (arithmeticBlock)+
    SEMI
  ;

arithmeticBlock
  : additiveExpression (
      (operator = equalityOperator
          { printLine("Operator:" + $operator.text); }
      | comparisonOperator)
        additiveExpression)*
  ;

equalityOperator
  : EQUAL | NOTEQUAL| ASSIGN
  ;

comparisonOperator
  : GT | LT
  ;

additiveExpression
  : multiplicativeExpression (
      operator = additiveOperator
          { printLine("Operator:" + $operator.text); }
      multiplicativeExpression)*
  ;

additiveOperator
  : ADD | SUB | OR
  ;

multiplicativeExpression
  : primary (operator = multiplicativeOperator
        { printLine("Operator:" + $operator.text); }
      primary)*
  ;

multiplicativeOperator
  : MUL | DIV | AND
  ;

primary
  : LPAREN arithmeticBlock RPAREN
    | literal
    | operator = BANG
          { printLine("Operator:" + $operator.text); }
      primary
    | operator = SUB
          { printLine("Operator:" + $operator.text); }
      primary
  ;

literal:
  IDENTIFIER | INTEGER_LITERAL | BOOL_LITERAL | STRING_LITERAL | methodCall
  ;

primitiveAssign
  : IDENTIFIER operator = ASSIGN
        { printLine("Operator:" + $operator.text); }
    (arithmeticBlock | STRING_LITERAL)
    SEMI
  ;

newAssign
  : IDENTIFIER operator = ASSIGN
        { printLine("Operator:" + $operator.text); }
        NEW IDENTIFIER LPAREN RPAREN SEMI
  ;

statement
  : COMMENT
  | writeln
  | ifStatement (elseStatement)?
  | whileStatement
  ;

whileStatement
  : WHILE { printLine("Loop:While‬‬"); }
    LPAREN arithmeticBlock RPAREN
    conditionalBlock
  ;

elseStatement
  : ELSE { printLine("Conditional:else"); }
    conditionalBlock
  ;

ifStatement
  : IF { printLine("Conditional:if‬‬"); }
    LPAREN arithmeticBlock RPAREN THEN
    conditionalBlock
  ;

conditionalBlock
	: LBRACE
    (expression
    | statement
    )* RBRACE
  | (COMMENT)*
    (expression
    | statement
    )
	;

writeln
  : WRITELN LPAREN arithmeticBlock RPAREN SEMI
  ;

methodCall
  : NEW IDENTIFIER
    LPAREN RPAREN (DOT method)+
  | IDENTIFIER (DOT method)+
  ;

method
  : IDENTIFIER LPAREN (methodCallArguments) RPAREN
  | LENGTH
  ;

methodCallArguments
  : (arithmeticBlock) (COMMA methodCallArguments)? |
  ;

variableDeclaration
  : VAR varName = IDENTIFIER COLON varType = type SEMI
      	{ printLine("VarDec:" + $varName.text + "," + $varType.text); }
  ;

type
	: primitiveType
	| nonPrimitiveType
	;

nonPrimitiveType
  : INT_ARRAY
	| IDENTIFIER
  ;

primitiveType
	: INT
	| STRING
	| BOOLEAN
	;
