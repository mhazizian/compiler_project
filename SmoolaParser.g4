parser grammar SmoolaParser;

// import SmoolaLexer;
options { tokenVocab=SmoolaLexer; }

@members{
   void print(Object obj){
        System.out.println(obj);
   }
}

program
    : (funcGenerator | LINE_COMMENT )+ EOF 
    ;

funcGenerator
	: DEF methodName=IDENTIFIER
		LPAREN ((IDENTIFIER COLON type COMMA)* (IDENTIFIER COLON type))? RPAREN
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
    		print("varDec: " + $varName.text + ", " + $varType.text);
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