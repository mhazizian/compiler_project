lexer grammar SmoolaLexer;

// Keywords

DEF:                'def';
VAR:                'var';
ELSE:               'else';
NEW:                'new';
CLASS:              'class';
EXTENDS:            'extends';
WHILE:              'while';
RETURN:             'return';
INT:                'int';
WRITELN:            'writeln';
STRING:             'string';
IF:                 'if';
BOOLEAN:            'boolean';
THEN:               'then';
THIS:               'this';

// Operators

ADD:                '+';
SUB:                '-';
MUL:                '*';
DIV:                '/';
ASSIGN:             '=';
NOTEQUAL:           '<>';
GT:                 '>';
LT:                 '<';
BANG:               '!';
EQUAL:              '==';
LE:                 '<=';
GE:                 '>=';
AND:                '&&';
OR:                 '||';

// Separators

LPAREN:             '(';
RPAREN:             ')';
LBRACE:             '{';
RBRACE:             '}';
LBRACK:             '[';
RBRACK:             ']';
SEMI:               ';';
COMMA:              ',';
DOT:                '.';

// Literals
INTEGER_LITERAL:    Digits;
BOOL_LITERAL:       'true'
            |       'false'
            ;
STRING_LITERAL:     '"' (LetterOrDigit | [!@#$%^&*+()\-_?\\/,.<>~`{}\[\]])* '"';

// Identifiers

IDENTIFIER:         Letter LetterOrDigit*;

// Whitespace and comments

WS:                 [ \t\r\n]+ -> skip;
LINE_COMMENT:       '#' ~[\r\n]* -> skip;

// Fragment rules

fragment Digits
    : [0-9]+
    ;

fragment LetterOrDigit
    : Letter
    | [0-9]
    ;

fragment Letter
    : [a-zA-Z_]
    ;