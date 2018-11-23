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

    // @todo: BinaryExpression or Expression
    expressionAddTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        operator=('+' | '-')
        expressionMult
        {
            BinaryExpression currentRes = new BinaryExpression(
                $inhCurrentResult, $expressionMult.synFinalResult,
                ($operator.text.equals('+')) ? BinaryOperator.add : BinaryOperator.sub
            );
        }
        expressionAddTemp[currentRes]
        | { $synFinalResult = $inhCurrentResult; }
    ;

    expressionMult [Expression inhCurrentResult] returns [Expression synFinalResult]:
        expressionUnary[inhCurrentResult]
        expressionMultTemp[expressionUnary.synResult]
        { $synFinalResult = $expressionMultTemp.synFinalResult; }
    ;

    expressionMultTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        operator=('*' | '/')
        expressionUnary
        {
            BinaryExpression currentRes = new BinaryExpression(
                $inhCurrentResult, $expressionUnary.synResult,
                ($operator.text.equals('*')) ? BinaryOperator.mult : BinaryOperator.div
            );
            // TODO : check this later:
            $inhCurrentResult = currentRes;
        }
        expressionMultTemp[inhCurrentResult]
        | { $synFinalResult = $inhCurrentResult; }
    ;

    expressionUnary [Expression inhCurrentResult] returns [Expression synFinalResult]:
        operator=('!' | '-')
        expressionUnary
        {
            $synFinalResult = new UnaryExpression(
                ($operator.text.equals('!')) ? UnaryOperator.not : UnaryOperator.minus,
                $expressionUnary.synFinalResult
            );
        }
        | expressionMem { $synFinalResult = $expressionMem.synFinalResult; }
    ;

    expressionMem returns [Expression synFinalResult]:
        expressionMethods expressionMemTemp
    ;

    expressionMemTemp:
        '[' expression ']'
        |
    ;
    expressionMethods returns [Expression synFinalResult]:
        expressionOther
        expressionMethodsTemp[expressionOther.synFinalResult]
        { $synFinalResult = $expressionMethodsTemp.synFinalResult; }
    ;
    expressionMethodsTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        '.' 
        (
            id=ID '(' ')' 
                {   
                    Expression instance = $inhCurrentResult;
                    Identifier id = new Identifier($id.text);
                    $inhCurrentResult = new MethodCall(instance, id);
                }
            |   id=ID
                    {
                        Expression instance = $inhCurrentResult;
                        Identifier id = new Identifier($id.text);
                        $inhCurrentResult = new MethodCall(instance, id);
                    }
                '(' (expression { $inhCurrentResult.addArg($expression.synFinalResult); }
                    (',' expression { $inhCurrentResult.addArg($expression.synFinalResult); } )*) ')' 
            |   'length' 
                    {
                        Expression instance = $inhCurrentResult;
                        $inhCurrentResult = new Lenghth(instance);
                    }
        )
        expressionMethodsTemp[]
        | { $synFinalResult = $inhCurrentResult; }
    ;
    expressionOther return [Expression synFinalResult]:
        num=CONST_NUM { $synFinalResult = new IntValue(Integer.parseInt(num.text), new IntType()); }
        |   str=CONST_STR 
            { 
                $synFinalResult = new StringValue($str.text, new StringType());
            }
        |   'new ' 'int' '[' num=CONST_NUM ']'
            {
                $synFinalResult = new NewArray(
                    new IntValue(Integer.parseInt(num.text), new IntType())
                );
            }
        |   'new ' newClassId=ID '(' ')' 
            {
                Identifier id = new Identifier($newClassId.text);
                $synFinalResult = new NewClass(id);
            }
        |   'this'  { $synFinalResult = new This();}
        |   'true'  { $synFinalResult = new BooleanValue(true, new BooleanType());}
        |   'false' { $synFinalResult = new BooleanValue(false, new BooleanType());}
        |   id=ID   { $synFinalResult = new Identifier($id.text); }
        |   id=ID '[' expression ']'
            {
                Identifier instance = new Identifier($id.text);
                Expression exp = $expression.synFinalResult; 
                $synFinalResult = new ArrayCall(instance, exp);
            }
        |   '(' expression ')' { $synFinalResult = $expression.synFinalResult; }
    ;

    type returns [Type synVarType]:
        'int' { $synVarType = new IntType(); } |
        'boolean' { $synVarType = new BooleanType(); } |
        'string' { $synVarType = new StringType(); } |
        'int' '[' ']'  { $synVarType = new ArrayType(); } |
        id=ID 
            { 
                $synVarType = new UserDefinedType();
                $synVarType.setName(new Identifier($id.text));
            } // TODO : generate compatible statment
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
