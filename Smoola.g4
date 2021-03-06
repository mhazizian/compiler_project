grammar Smoola;

    @header {
        import javafx.util.Pair;
        import java.util.ArrayList;

        import ast.node.expression.Identifier;
        import ast.node.expression.Value.*;
        import ast.Type.UserDefinedType.*;
        import ast.Type.PrimitiveType.*;
        import ast.node.declaration.*;
        import ast.node.expression.*;
        import ast.node.statement.*;
        import symbolTable.*;
        import ast.Type.ArrayType.*;
        import ast.VisitorImplIter;
        import ast.VisitorImpl;
        import ast.node.*;
        import ast.Type.*;
    }

    @members {
        void print(Object s) {
            System.out.println(s);
        }
    }

    program returns [Program p]:
        { $p = new Program(); }
        mainClass { $p.setMainClass($mainClass.synClassDeclaration); }
        ( classDeclaration { $p.addClass(
              $classDeclaration.synClassDeclaration); } )*
        EOF
    ;

    mainClass returns [ClassDeclaration synClassDeclaration]:
        // name should be checked later
        'class' self=ID '{' 'def' methodName=ID '(' ')' ':' 'int'
            {
                Identifier self = new Identifier($self.text, $self.line);
                Identifier methodName = new Identifier($methodName.text, $methodName.line);

                ClassDeclaration mainClass = new ClassDeclaration(
                    self, new Identifier(""), $self.line
                );
                MethodDeclaration mainMethod = new MethodDeclaration(
                    methodName, $methodName.line);

                mainClass.addMethodDeclaration(mainMethod);

                mainMethod.setReturnType(new IntType());
                $synClassDeclaration = mainClass;
            }
            '{'
                ( varDeclaration { mainMethod.addLocalVar(
                      $varDeclaration.synVariableDeclaration); } )*

                (
                        mainStatement { mainMethod.addStatement($mainStatement.synStatement); }
                    |   statement { mainMethod.addStatement($statement.synStatement); }
                )*
                ret='return' expression
                    {
                        $expression.synFinalResult.setLineNumber($ret.line);
                        mainMethod.setReturnValue($expression.synFinalResult);
                    }
                ';'
            '}'
        '}'
    ;

    classDeclaration returns [ClassDeclaration synClassDeclaration]:
        'class' name=ID
            {
                Identifier self = new Identifier($name.text, $name.line);
                Identifier parent = new Identifier("");
            }
        ('extends' parent=ID { parent.setName($parent.text); } )?
            {
                ClassDeclaration classDec = new ClassDeclaration(self,
                    parent, $name.line);
                $synClassDeclaration = classDec;
            }
            '{'
                ( varDeclaration { classDec.addVarDeclaration(
                      $varDeclaration.synVariableDeclaration); } )*
                ( methodDeclaration { classDec.addMethodDeclaration(
                      $methodDeclaration.synMethodDeclaration); } )*
            '}'
    ;

    varDeclaration returns [VarDeclaration synVariableDeclaration]:
        'var' name=ID ':' type ';'
        {
            Identifier id = new Identifier($name.text, $name.line);
            $synVariableDeclaration = new VarDeclaration(id,
                $type.synVarType, $name.line);
        }
    ;

    methodDeclaration returns [MethodDeclaration synMethodDeclaration]:
        'def' methodName=ID
        {
            Identifier methodName = new Identifier($methodName.text, $methodName.line);
            $synMethodDeclaration = new MethodDeclaration(methodName,
                $methodName.line);
        }
        (
          '(' ')'
          | (
              '(' firstArgId=ID ':' firstArgType=type
                {
                    Identifier firstArgIdentifier = new Identifier(
                        $firstArgId.text, $firstArgId.line);
                    VarDeclaration firstArg = new VarDeclaration(
                        firstArgIdentifier, $firstArgType.synVarType,
                            $firstArgType.start.getLine()
                    );
                    $synMethodDeclaration.addArg(firstArg);
                }
                (',' argId=ID ':' argType=type
                  {
                      Identifier argIdentifier = new Identifier($argId.text, $argId.line);
                      VarDeclaration newArg = new VarDeclaration(argIdentifier,
                          $argType.synVarType, $argType.start.getLine());
                      $synMethodDeclaration.addArg(newArg);
                  }
                )*
              ')'
            )
        )
        ':' type { $synMethodDeclaration.setReturnType($type.synVarType); }

        '{' (varDeclaration { ($synMethodDeclaration).
              addLocalVar($varDeclaration.synVariableDeclaration); } )*
              ( statement { $synMethodDeclaration.addStatement(
                    $statement.synStatement); } )*
              ret='return' expression
                    {
                        $expression.synFinalResult.setLineNumber($ret.line);
                        $synMethodDeclaration.setReturnValue($expression.synFinalResult);
                    }
              ';'
        '}'
    ;

    mainStatement returns [Statement synStatement]:
        expressionMethods { $synStatement = new MainStatement($expressionMethods.synFinalResult); } ';'
    ;

    statement returns [Statement synStatement]:
        statementBlock { $synStatement = $statementBlock.synStatement; } |
        statementCondition { $synStatement = $statementCondition.synStatement; } |
        statementLoop { $synStatement = $statementLoop.synStatement; } |
        statementWrite { $synStatement = $statementWrite.synStatement; } |
        statementAssignment { $synStatement = $statementAssignment.synStatement;
        }
    ;

    statementBlock returns [Statement synStatement]:
        { Block blockStatements = new Block(); }
        '{' ( statement { blockStatements.addStatement($statement.synStatement); } )*
        { $synStatement = blockStatements; } '}'
    ;

    statementCondition returns [Statement synStatement]:
        ifExp='if' '('expression')' 'then' statement
        {
            Conditional conditionalStatement = new Conditional(
                $expression.synFinalResult, $statement.synStatement);
            conditionalStatement.setLineNumber($ifExp.line);
        }
        ( 'else' statement { conditionalStatement.setAlternativeBody(
              $statement.synStatement); } )?

        { $synStatement = conditionalStatement; }
    ;

    statementLoop returns [Statement synStatement]:
        whl='while' '(' expression ')' statement
        {
            $synStatement = new While($expression.synFinalResult,
                $statement.synStatement);
            $synStatement.setLineNumber($whl.line);
        }
    ;

    statementWrite returns [Statement synStatement]:
        wrl='writeln(' expression ')' ';'
        {
            $synStatement = new Write($expression.synFinalResult);
            $synStatement.setLineNumber($wrl.line);
        }
    ;

    statementAssignment returns [Statement synStatement]:
        exp=expression ';'
        {
            $synStatement = new Assign(
                ((BinaryExpression)($expression.synFinalResult)).getLeft(),
                ((BinaryExpression)($expression.synFinalResult)).getRight()
            );
            $synStatement.setLineNumber($exp.start.getLine());
        }
    ;

    expression returns [Expression synFinalResult]:
        expressionAssignment { $synFinalResult =
            $expressionAssignment.synFinalResult; }
    ;

    expressionAssignment returns [Expression synFinalResult]:
        expressionOr
        operator='='
        expressionAssignment
        {
            $synFinalResult = new BinaryExpression(
                $expressionOr.synFinalResult,
                $expressionAssignment.synFinalResult,
                BinaryOperator.assign
            );
            $synFinalResult.setLineNumber($operator.line);
        }
        | expressionOr { $synFinalResult = $expressionOr.synFinalResult; }
    ;

    expressionOr returns [Expression synFinalResult]:
        expressionAnd
        expressionOrTemp[$expressionAnd.synFinalResult]
        { $synFinalResult = $expressionOrTemp.synFinalResult; }
    ;

    expressionOrTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        operator='||'
        expressionAnd
        {
            BinaryExpression currentRes = new BinaryExpression(
                $inhCurrentResult, $expressionAnd.synFinalResult, BinaryOperator.or
            );
            currentRes.setLineNumber($operator.line);
        }
        expressionOrTemp[currentRes]
        { $synFinalResult = $expressionOrTemp.synFinalResult; }
        | { $synFinalResult = $inhCurrentResult; }
    ;

    expressionAnd returns [Expression synFinalResult]:
        expressionEq
        expressionAndTemp[$expressionEq.synFinalResult]
        { $synFinalResult = $expressionAndTemp.synFinalResult; }
    ;

    expressionAndTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        operator='&&'
        expressionEq
        {
            BinaryExpression currentRes = new BinaryExpression($inhCurrentResult,
                $expressionEq.synFinalResult, BinaryOperator.and);
            currentRes.setLineNumber($operator.line);
        }
        expressionAndTemp[currentRes]
        { $synFinalResult = $expressionAndTemp.synFinalResult; }
        | { $synFinalResult = $inhCurrentResult; }
    ;

    expressionEq returns [Expression synFinalResult]:
        expressionCmp
        expressionEqTemp[$expressionCmp.synFinalResult]
        { $synFinalResult = $expressionEqTemp.synFinalResult; }
    ;

    expressionEqTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        operator=('==' | '<>')
        expressionCmp
        {
            BinaryExpression currentRes = new BinaryExpression(
                $inhCurrentResult, $expressionCmp.synFinalResult,
                (($operator.text.equals("==")) ? BinaryOperator.eq : BinaryOperator.neq));
            currentRes.setLineNumber($operator.line);
        }
        expressionEqTemp[currentRes]
        { $synFinalResult = $expressionEqTemp.synFinalResult; }
        | { $synFinalResult = $inhCurrentResult; }
    ;

    expressionCmp returns [Expression synFinalResult]:
        expressionAdd
        expressionCmpTemp[$expressionAdd.synFinalResult]
        { $synFinalResult = $expressionCmpTemp.synFinalResult; }
    ;

    expressionCmpTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        operator=('<' | '>')
        expressionAdd
        {
            BinaryExpression currentRes = new BinaryExpression(
                $inhCurrentResult, $expressionAdd.synFinalResult,
                ($operator.text.equals(">")) ? BinaryOperator.gt : BinaryOperator.lt);
            currentRes.setLineNumber($operator.line);
        }
        expressionCmpTemp[currentRes]
        { $synFinalResult = $expressionCmpTemp.synFinalResult; }
        | { $synFinalResult = $inhCurrentResult; }
    ;

    expressionAdd returns [Expression synFinalResult]:
        expressionMult
        expressionAddTemp[$expressionMult.synFinalResult]
        { $synFinalResult = $expressionAddTemp.synFinalResult; }
    ;

    expressionAddTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        operator=('+' | '-')
        expressionMult
        {
            BinaryExpression currentRes = new BinaryExpression(
                $inhCurrentResult, $expressionMult.synFinalResult,
                ($operator.text.equals("+")) ? BinaryOperator.add : BinaryOperator.sub
            );
            currentRes.setLineNumber($operator.line);
        }
        expressionAddTemp[currentRes]
        { $synFinalResult = $expressionAddTemp.synFinalResult; }
        | { $synFinalResult = $inhCurrentResult; }
    ;

    expressionMult returns [Expression synFinalResult]:
        expressionUnary
        expressionMultTemp[$expressionUnary.synFinalResult]
        { $synFinalResult = $expressionMultTemp.synFinalResult; }
    ;

    expressionMultTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        operator=('*' | '/')
        expressionUnary
        {
            BinaryExpression currentRes = new BinaryExpression(
                $inhCurrentResult, $expressionUnary.synFinalResult,
                ($operator.text.equals("*")) ? BinaryOperator.mult : BinaryOperator.div);
            currentRes.setLineNumber($operator.line);
        }
        expressionMultTemp[currentRes]
        { $synFinalResult = $expressionMultTemp.synFinalResult; }
        | { $synFinalResult = $inhCurrentResult; }
    ;

    expressionUnary returns [Expression synFinalResult]:
        operator=('!' | '-')
        expressionUnary
        { 
            $synFinalResult = new UnaryExpression(
                ($operator.text.equals("!")) ? UnaryOperator.not : UnaryOperator.minus,
                $expressionUnary.synFinalResult
            );
            $synFinalResult.setLineNumber($operator.line);
        }
        | expressionMem { $synFinalResult = $expressionMem.synFinalResult; }
    ;

    expressionMem returns [Expression synFinalResult]:
        expressionMethods
        expressionMemTemp[$expressionMethods.synFinalResult]
        { $synFinalResult = $expressionMemTemp.synFinalResult; }
    ;

    expressionMemTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        '[' exp=expression ']'
            {
                $synFinalResult = new ArrayCall($inhCurrentResult,
                    $expression.synFinalResult);
                $synFinalResult.setLineNumber($exp.start.getLine());
            }
        | { $synFinalResult = $inhCurrentResult; }
    ;

    expressionMethods returns [Expression synFinalResult]:
        expressionOther
        expressionMethodsTemp[$expressionOther.synFinalResult]
        { $synFinalResult = $expressionMethodsTemp.synFinalResult; }
    ;

    expressionMethodsTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
      '.' id=ID '(' ')'
        {
            Expression instance = $inhCurrentResult;
            MethodCallIdentifier identifier = new MethodCallIdentifier($id.text, $id.line);
            MethodCall returnValue = new MethodCall(instance, identifier);
            returnValue.setLineNumber($id.line);
        }
        expressionMethodsTemp[returnValue]
        { $synFinalResult = $expressionMethodsTemp.synFinalResult; }

      | '.' id=ID
        {
            Expression instance = $inhCurrentResult;
            MethodCallIdentifier id = new MethodCallIdentifier($id.text, $id.line);
            MethodCall returnValue = new MethodCall(instance, id);
            returnValue.setLineNumber($id.line);
        }
        '('
          (
            expression { ((MethodCall)returnValue).addArg($expression.synFinalResult); }
            (',' expression { ((MethodCall)returnValue).addArg($expression.synFinalResult); } )*
          )
        ')'

        expressionMethodsTemp[returnValue]
        { $synFinalResult = $expressionMethodsTemp.synFinalResult; }

      | '.' length='length'
        {
            Expression instance = $inhCurrentResult;
            Length returnValue = new Length(instance);
            returnValue.setLineNumber($length.line);
        }
        expressionMethodsTemp[returnValue]
        { $synFinalResult = $expressionMethodsTemp.synFinalResult; }
      | { $synFinalResult = $inhCurrentResult; }
    ;

    expressionOther returns [Expression synFinalResult]:
            num1=CONST_NUM { $synFinalResult =
                new IntValue(Integer.parseInt($num1.text), new IntType()); }
        |   str=CONST_STR { $synFinalResult =
                new StringValue($str.text, new StringType()); }
        |   'new ' 'int' '[' num2=CONST_NUM ']'
            {
                NewArray temp = new NewArray();
                temp.setLineNumber($num2.line);
                temp.setExpression(new IntValue(Integer.parseInt($num2.text),
                    new IntType()));
                temp.setType(new ArrayType());
                $synFinalResult = temp;
            }
        |   'new ' newClassId=ID '(' ')'
            {
                Identifier id = new Identifier($newClassId.text, $newClassId.line);
                $synFinalResult = new NewClass(id);
            }
        |   'this'  { $synFinalResult = new This();}
        |   'true'  { $synFinalResult = new BooleanValue(true, new BooleanType());}
        |   'false' { $synFinalResult = new BooleanValue(false, new BooleanType());}
        |   id=ID   { $synFinalResult = new Identifier($id.text, $id.line); }
        |   id=ID '[' expression ']'
            {
                Identifier instance = new Identifier($id.text, $id.line);
                Expression exp = $expression.synFinalResult;
                $synFinalResult = new ArrayCall(instance, exp);
                $synFinalResult.setLineNumber($id.line);
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
                UserDefinedType temp = new UserDefinedType();
                temp.setName(new Identifier($id.text, $id.line));
                $synVarType = temp;
            }
    ;

    CONST_NUM:
        ('+' | '-')? [0-9]+
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
