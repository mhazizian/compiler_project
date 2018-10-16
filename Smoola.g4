grammar Smoola;

@members{
   void print(Object obj){
        System.out.println(obj);
   }
}

program :
    (if_token | else_token | reservedWords | identifier | delimiter | openPar | closePar | integer)+;

if_token: 
    'if';


else_token:
    'else';


reservedWords :
    'boolean' | 'string' | 'int' | 'class' | 'def' | 'then' | 'writeln' 
    | 'extends' | 'var' | 'this' | 'false' | 'true' | 'while'
    | 'return' | 'new';


identifier :   
    IDENTIFIER;


integer :
    NUMBER;


delimiter :
    ';';


openPar :
    '(';


closePar :
    ')';


IDENTIFIER :   
    ALPHABET (ALPHABET | NUMBER)*;


ALPHABET :
    [A-Za-z_]+;


NUMBER :
    [0-9]+;


WS :
    [ \n\t\r]+ -> skip;

// additionExp
//     :    multiplyExp
//          ( '+' multiplyExp
//          | '-' multiplyExp
//          )*
//     ;
// 
// 
// multiplyExp
//     :    atomExp
//          ( '*' atomExp
//          | '/' atomExp
//          )*
//     ;
// 
// atomExp
//     :    num = NUMBER {print($num.text);}
//     |    '(' additionExp ')'
//     ;