parser grammar SmoolaParser;

// Class return value can be Class
// main method is variable less
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
    bodyBlock
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
      (variableDeclaration | COMMENT)*
      (bodyBlock statement*)*
    RBRACE
	;

statement
	: COMMENT
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
