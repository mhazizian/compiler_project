grammar Smoola;
    @header {
        import javafx.util.Pair;
        import java.util.ArrayList;

        import ast.node.Program;
        import ast.node.declaration.*;
        import ast.node.expression.Identifier;
        // import symbolTable.*;
        import ast.Type.PrimitiveType.*;
        import ast.Type.ArrayType.*;
        import ast.Type.UserDefinedType.*;
        import ast.Type.*;
    }
    @members {
        void print(Object s) {
            System.out.println(s);
        }
    }

    program:
        { Program program = new Program(); }
        mainClass { program.setMainClass($mainClass.synClassDec); }
        (classDec=classDeclaration { program.addClass($classDec.synClassDec); } )*
        EOF
    ;
    mainClass returns [ClassDeclaration synClassDec]:
        // name should be checked later

        'class' self=ID '{' 'def' methodName=ID '(' ')' ':' 'int'
            {
                Identifier self = new Identifier($self.text);
                Identifier methodName = new Identifier($methodName.text);

                ClassDeclaration mainClass = new ClassDeclaration(self, new Identifier(""));
                MethodDeclaration mainMethod = new MethodDeclaration(methodName);

                mainMethod.setReturnType(new IntType());
                $synClassDec = mainClass;
            }
            '{'
                varDeclaration*
                statements
                'return' expression ';'
            '}'
        '}'
    ;
    classDeclaration returns [ClassDeclaration synClassDec]:
        'class' name=ID ('extends' parent=ID)?
            {
                Identifier self = new Identifier($name.text);
                Identifier parent = new Identifier("");
                if (!$parent.text.equals(""))
                    parent.setName($parent.text);

                ClassDeclaration classDec = new ClassDeclaration(self, parent);
                $synClassDec = classDec;
            }
            '{'
                (varDec=varDeclaration { classDec.addVarDeclaration($varDec.synVarDec); } )*
                (methodDec=methodDeclaration { classDec.addMethodDeclaration($methodDec.synMethodDec); } )*
            '}'
    ;
    varDeclaration returns [VarDeclaration synVarDec]:
        'var' name=ID ':' type ';'
        {
            Identifier id = new Identifier($name.text);
            VarDeclaration varDec = new VarDeclaration(id, $type.synVarType);
            $synVarDec = varDec;
        }
    ;
    methodDeclaration returns [MethodDeclaration synMethodDec]:
        'def' methodName=ID
        {
            Identifier methodName = new Identifier($methodName.text);
            $synMethodDec = new MethodDeclaration(methodName);
        }
        (
          '(' ')'
          | ('(' firstArgId=ID ':' firstArgType=type
          {
            Identifier firstArgIdentifier = new Identifier($firstArgId.text);
            VarDeclaration firstArg = new VarDeclaration(firstArgIdentifier, $firstArgType.synVarType);

            $synMethodDec.addArg(firstArg);
          }
              (',' argId=ID ':' argType=type
                  {
                    Identifier argIdentifier = new Identifier($argId.text);
                    VarDeclaration newArg = new VarDeclaration(argIdentifier, $argType.synVarType);
                    $synMethodDec.addArg(newArg);
                  }
              )*')'
            )
        )
        ':' type
        {
          $synMethodDec.setReturnType($type.synVarType);
        }

        '{'  varDeclaration* statements 'return' expression ';' '}'
    ;
    statements:
        (statement)*
    ;
    statement:
        statementBlock |
        statementCondition |
        statementLoop |
        statementWrite |
        statementAssignment
    ;
    statementBlock:
        '{'  statements '}'
    ;
    statementCondition:
        'if' '('expression')' 'then' statement ('else' statement)?
    ;
    statementLoop:
        'while' '(' expression ')' statement
    ;
    statementWrite:
        'writeln(' expression ')' ';'
    ;
    statementAssignment:
        expression ';'
    ;

    expression:
        expressionAssignment
    ;

    expressionAssignment:
        expressionOr '=' expressionAssignment
        |   expressionOr
    ;

    expressionOr:
        expressionAnd expressionOrTemp
    ;

    expressionOrTemp:
        '||' expressionAnd expressionOrTemp
        |
    ;

    expressionAnd:
        expressionEq expressionAndTemp
    ;

    expressionAndTemp:
        '&&' expressionEq expressionAndTemp
        |
    ;

    expressionEq:
        expressionCmp expressionEqTemp
    ;

    expressionEqTemp:
        ('==' | '<>') expressionCmp expressionEqTemp
        |
    ;

    expressionCmp:
        expressionAdd expressionCmpTemp
    ;

    expressionCmpTemp:
        ('<' | '>') expressionAdd expressionCmpTemp
        |
    ;

    expressionAdd:
        expressionMult expressionAddTemp
    ;

    expressionAddTemp [Expression inhLeft]:
        operator=('+' | '-') 
        expressionMult
        {
            BinaryExpression currectRes = new BinaryExpression(
                $inhLeft,
                $expressionMult.synResult,
                ($operator.text.equals('+')) ? BinaryOperator.add : BinaryOperator.sub
            );
        }
        expressionAddTemp
        |
    ;

    expressionMult:
        expressionUnary expressionMultTemp
    ;

    expressionMultTemp:
        ('*' | '/') expressionUnary expressionMultTemp
        |
    ;

    expressionUnary:
        ('!' | '-') expressionUnary
        |   expressionMem
    ;

    expressionMem:
        expressionMethods expressionMemTemp
    ;

    expressionMemTemp:
        '[' expression ']'
        |
    ;
    expressionMethods:
        expressionOther expressionMethodsTemp
    ;
    expressionMethodsTemp:
        '.' (ID '(' ')' | ID '(' (expression (',' expression)*) ')' | 'length') expressionMethodsTemp
        |
    ;
    expressionOther:
        CONST_NUM
        |   CONST_STR
        |   'new ' 'int' '[' CONST_NUM ']'
        |   'new ' ID '(' ')'
        |   'this'
        |   'true'
        |   'false'
        |   ID
        |   ID '[' expression ']'
        |   '(' expression ')'
    ;
    type returns [Type synVarType]:
        'int' { $synVarType = new IntType(); } |
        'boolean' { $synVarType = new BooleanType(); } |
        'string' { $synVarType = new StringType(); } |
        'int' '[' ']'  { $synVarType = new ArrayType(); } |
        ID { $synVarType = new UserDefinedType(); } // TODO : generate compatible statment
    ;
    CONST_NUM:
        [0-9]+
    ;

    CONST_STR:
        '"' ~('\r' | '\n' | '"')* '"'
    ;
    NL:
        '\r'? '\n' -> skip
    ;

    ID:
        [a-zA-Z_][a-zA-Z0-9_]*
    ;

    COMMENT:
        '#'(~[\r\n])* -> skip
    ;

    WS:
        [ \t] -> skip
    ;
