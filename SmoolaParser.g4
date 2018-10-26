parser grammar SmoolaParser;

// Class return value can be Class
// main method is variable less
// other logic operators in nested arithmetic structures

options { tokenVocab=SmoolaLexer; }

@members{
   void print(Object obj){
        System.out.print(obj);
   }

   void println(Object obj2){
        System.out.println(obj2);
   }
}

program
  : mainClassDeclaration
    (classDeclaration
    | COMMENT
    )*
    EOF;

classDeclaration
  : CLASS methodName = IDENTIFIER
        { print("MethodDes: " + $methodName.text + " ,");}
        extendsDeclaration?
    classBlock
  ;

classBlock
  : (COMMENT)* LBRACE
      (variableDeclaration | COMMENT)*
      (methodDeclaration COMMENT*)*
    RBRACE
  ;

mainClassDeclaration
  : CLASS methodName = IDENTIFIER
        { print("MethodDes: " + $methodName.text + " ,");}
    mainClassBlock
  ;

mainClassBlock
	: (COMMENT)* LBRACE
      (mainMethodDeclaration COMMENT*)
    RBRACE
	;

mainMethodDeclaration
  : DEF MAIN { print("MethodDes: main ,");}
        LPAREN RPAREN COLON INT
    mainBodyBlock
  ;

mainBodyBlock
	: (COMMENT)* LBRACE
      (variableDeclaration | COMMENT)*
      (mainBodyBlock expression*)*
      returnBlock
    RBRACE
	;

methodDeclaration
  : DEF methodName = IDENTIFIER arguments COLON  type
    bodyBlock
  ;

arguments
  : LPAREN
      ((arg=IDENTIFIER COLON type COMMA {print($arg.text + ", ");} )*
      (IDENTIFIER COLON type) {print($arg.text);} )?
    RPAREN { println("");}
  ;

extendsDeclaration
  : (EXTENDS IDENTIFIER)
  ;

bodyBlock
	: (COMMENT)* LBRACE
      (variableDeclaration
      | COMMENT
      )*
      (bodyBlock
      | expression
      | statement
      )*
      returnBlock
    RBRACE
	;

returnBlock
  : RETURN IDENTIFIER SEMI
  ;

logicalOperators
  : (BOOL_LITERAL | IDENTIFIER)
    ( AND
    | OR
    )
    (BOOL_LITERAL | IDENTIFIER)
    | BANG (BOOL_LITERAL | IDENTIFIER)
  ;

comparativeOperators
  : (INTEGER_LITERAL | IDENTIFIER)
    ( NOTEQUAL
    | GT
    | LT
    | EQUAL
    )
    (INTEGER_LITERAL | IDENTIFIER)
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
    ASSIGN arithmeticBlock SEMI
  ;

arrayInitializer
  : IDENTIFIER ASSIGN NEW INT LBRACK
    arithmeticBlock
    RBRACK SEMI
  ;

arithmeticAssign
  : IDENTIFIER ASSIGN
    (arithmeticBlock)+
    SEMI
  ;

arithmeticBlock
  : LPAREN
    (IDENTIFIER | INTEGER_LITERAL | BOOL_LITERAL)
    (ADD | SUB | MUL | DIV | AND | OR)
    arithmeticBlock
    RPAREN
  | (IDENTIFIER | INTEGER_LITERAL | BOOL_LITERAL)
    (ADD | SUB | MUL | DIV | AND | OR)
    arithmeticBlock
  | (IDENTIFIER | INTEGER_LITERAL | BOOL_LITERAL)
  ;

primitiveAssign
  : IDENTIFIER ASSIGN
    (arithmeticBlock | STRING_LITERAL)
    SEMI
  ;

newAssign
  : IDENTIFIER ASSIGN NEW IDENTIFIER
        LPAREN RPAREN SEMI
  ;

statement
  : COMMENT
  | writeln
  | ifStatement (elseStatement)?
  | whileStatement
  ;

whileStatement
  : WHILE LPAREN comparativeOperators RPAREN
    conditionBlock
  ;

elseStatement
  : ELSE
    conditionBlock
  ;

ifStatement
  : IF LPAREN comparativeOperators RPAREN THEN
    conditionBlock
  ;

conditionBlock
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
  : WRITELN LPAREN STRING_LITERAL RPAREN SEMI
  ;

variableDeclaration
  : VAR varName=IDENTIFIER COLON varType=type SEMI
      	{ println("varDec: " + $varName.text + ", " + $varType.text); }
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
