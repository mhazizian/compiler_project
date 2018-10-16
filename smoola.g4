grammar smoola;

@members{
   void print(Object obj){
        System.out.println(obj);
   }
}

program
    :    additionExp
    ;

additionExp
    :    multiplyExp
         ( '+' multiplyExp
         | '-' multiplyExp
         )*
    ;


multiplyExp
    :    atomExp
         ( '*' atomExp
         | '/' atomExp
         )*
    ;

atomExp
    :    num = NUMBER {print($num.text);}
    |    '(' additionExp ')'
    ;


NUMBER
    :    [0-9]+
    ;