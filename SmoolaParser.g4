parser grammar SmoolaParser;

// import SmoolaLexer;

options { tokenVocab=SmoolaLexer; }

// @members{
//    void print(Object obj){
//         System.out.println(obj);
//    }
// }

program
    : IDENTIFIER+ EOF
    ;
