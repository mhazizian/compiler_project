parser grammar SmoolaParser;

// import SmoolaLexer;
options { tokenVocab=SmoolaLexer; }

@members{
   void print(Object obj){
        System.out.println(obj);
   }
}

program
    : (variableDeclarator | LINE_COMMENT )+ EOF 
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