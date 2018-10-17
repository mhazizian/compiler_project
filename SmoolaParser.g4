parser grammar SmoolaParser;

// import SmoolaLexer;

options { tokenVocab=SmoolaLexer; }

// @members{
//    void print(Object obj){
//         System.out.println(obj);
//    }
// }

program
    : STRING_LITERAL+ EOF
    ;

// expression
// 	: 