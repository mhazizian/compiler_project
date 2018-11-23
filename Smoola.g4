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

    // DONE
    expressionOr returns [Expression synFinalResult]::
        expressionAnd
        expressionOrTemp[expressionAnd.synFinalResult]
        { $synFinalResult = $expressionAndTemp.synFinalResult; }
    ;

    // DONE
    expressionOrTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        '||'
        expressionAnd
        {
          BinaryExpression currentRes = new BinaryExpression(
              $inhCurrentResult, $expressionAnd.synFinalResult, BinaryOperator.or
          );
          $inhCurrentResult = $currentRes;
        }
        expressionOrTemp[inhCurrentResult]
        | { $synFinalResult = $inhCurrentResult; }
    ;

    // DONE
    expressionAnd returns [Expression synFinalResult]::
        expressionEq
        expressionAndTemp[expressionEq.synFinalResult]
        { $synFinalResult = $expressionAndTemp.synFinalResult; }
    ;

    // DONE
    expressionAndTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        '&&'
        expressionEq
        {
          BinaryExpression currentRes = new BinaryExpression(
              $inhCurrentResult, $expressionEq.synFinalResult, BinaryOperator.and
          );
          $inhCurrentResult = $currentRes;
        }
        expressionAndTemp[inhCurrentResult]
        | { $synFinalResult = $inhCurrentResult; }
    ;

    // DONE
    expressionEq returns [Expression synFinalResult]::
        expressionCmp
        expressionEqTemp[expressionCmp.synFinalResult]
        { $synFinalResult = $expressionEqTemp.synFinalResult; }
    ;

    // DONE
    expressionEqTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        operator=('==' | '<>')
        expressionCmp
        {
          BinaryExpression currentRes = new BinaryExpression(
              $inhCurrentResult, $expressionCmp.synFinalResult,
              ($operator.text.equals('==')) ? BinaryOperator.eq : BinaryOperator.neq
          );
          $inhCurrentResult = currentRes;
        }
        expressionEqTemp[inhCurrentResult] // TODO a > b < c ??
        | { $synFinalResult = $inhCurrentResult; }
    ;

    // DONE
    expressionCmp returns [Expression synFinalResult]::
        expressionAdd
        expressionCmpTemp[expressionAdd.synFinalResult]
        { $synFinalResult = $expressionCmpTemp.synFinalResult; }
    ;

    // DONE
    expressionCmpTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        operator=('<' | '>')
        expressionAdd
        {
          BinaryExpression currentRes = new BinaryExpression(
              $inhCurrentResult, $expressionAdd.synFinalResult,
              ($operator.text.equals('>')) ? BinaryOperator.gt : BinaryOperator.lt
          );
          $inhCurrentResult = $currentRes;
        }
        expressionCmpTemp[inhCurrentResult] // TODO a > b < c ??
        | { $synFinalResult = $inhCurrentResult; }
    ;

    // DONE
    expressionAdd reutrns [Expression synFinalResult]:
        expressionMult
        expressionAddTemp[expressionMult.synFinalResult]
        { $synFinalResult = $expressionAddTemp.synFinalResult; }
    ;

    // DONE
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

    // DONE
    expressionMult returns [Expression synFinalResult]:
        expressionUnary
        expressionMultTemp[expressionUnary.synFinalResult]
        { $synFinalResult = $expressionMultTemp.synFinalResult; }
    ;

    // DONE
    expressionMultTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        operator=('*' | '/')
        expressionUnary
        {
            BinaryExpression currentRes = new BinaryExpression(
                $inhCurrentResult, $expressionUnary.synFinalResult,
                ($operator.text.equals('*')) ? BinaryOperator.mult : BinaryOperator.div
            );
            // TODO : check this later:
            $inhCurrentResult = currentRes;
        }
        expressionMultTemp[inhCurrentResult]
        | { $synFinalResult = $inhCurrentResult; }
    ;

    // DONE
    expressionUnary returns [Expression synFinalResult]:
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

    // DONE
    expressionMem returns [Expression synFinalResult]:
        expressionMethods
        expressionMemTemp[expressionMethods.synFinalResult]
        { $synFinalResult = $expressionMemTemp.synFinalResult; }
    ;

    // DONE
    expressionMemTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        '[' expression ']'
            {
                $synFinalResult = new ArrayCall($inhCurrentResult, $expression.synFinalResult);
            }
        |   { $synFinalResult = $inhCurrentResult; }
    ;

    // DONE
    expressionMethods returns [Expression synFinalResult]:
        expressionOther
        expressionMethodsTemp[expressionOther.synFinalResult]
        { $synFinalResult = $expressionMethodsTemp.synFinalResult; }
    ;

    // DONE
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

    // DONE
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

    // DONE
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
