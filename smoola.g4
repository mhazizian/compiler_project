grammar smoola;

@members{
   void print(Object obj){
        System.out.println(obj);
   }
}

program :
    ( ReservedWords | Identifier | Delimiter | OpenPar | ClosePar | Integer )+;
    // IF | ELSE | ReservedWords | Identifier | Delimiter | OpenPar | ClosePar | Integer;


// IF: 
//     'if';


// ELSE:
//     'else';


ReservedWords :
    'boolean' | 'string' | 'int' | 'class' | 'def' | 'then' | 'if'
    | 'writeln' | 'extends' | 'var' | 'this' | 'false' | 'true' | 'while'
    | 'else' | 'return' | 'new';


Identifier :   
    ALPHABET (ALPHABET | NUMBER)*;


Delimiter :
    ';';


OpenPar :
    '(';


ClosePar :
    ')';


Integer :
    NUMBER+;


ALPHABET :
    [A-Za-z_];


NUMBER :
    [0-9];


WS :
    [\n\t\r ] -> skip;

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