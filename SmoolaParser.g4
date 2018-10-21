parser grammar SmoolaParser;

// import SmoolaLexer;
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
    : (funcGenerator | LINE_COMMENT )+ EOF 
    ;

funcGenerator
	: DEF methodName=IDENTIFIER { print("MethodDes: " + $methodName.text + " ,");}
		LPAREN
			((arg=IDENTIFIER COLON type COMMA {print($arg.text + ", ");} )* 
			(IDENTIFIER COLON type) {print($arg.text);} )?
		RPAREN { println("");}
		COLON type
		LBRACE blockBody RBRACE
	;

blockBody
	: (variableDeclarator | LINE_COMMENT )*
		statement* (LBRACE blockBody RBRACE statement*)?
	;

statement
	: LINE_COMMENT
	; 

variableDeclarator
    : VAR varName=IDENTIFIER COLON varType=type SEMI
    	{
    		println("varDec: " + $varName.text + ", " + $varType.text);
    	}
    ;

type
	: primitiveType
	| INT_ARRAY
	| IDENTIFIER
	;


primitiveType
	: INT 
	| STRING
	| BOOLEAN
	;


// expression
// 	: 