grammar Smoola;
    @header {
        import javafx.util.Pair;
        import java.util.ArrayList;

        import ast.node.*;
        import ast.node.declaration.*;
        import ast.node.expression.*;
        import ast.node.statement.*;
        import ast.node.expression.Value.*;
        import ast.node.expression.Identifier;
        // import symbolTable.*;
        import ast.Type.PrimitiveType.*;
        import ast.Type.ArrayType.*;
        import ast.Type.UserDefinedType.*;
        import ast.Type.*;

        import ast.VisitorImpl;
    }

    @members {
        void print(Object s) {
            System.out.println(s);
        }
    }

    program:
        { Program program = new Program(); }
        mainClass { program.setMainClass($mainClass.synClassDec); }
        ( classDec=classDeclaration
            { program.addClass($classDec.synClassDec); }
        )*
        EOF
        {
            program.accept(new VisitorImpl());
        }
    ;

    mainClass returns [ClassDeclaration synClassDec]:
        // name should be checked later

        'class' self=ID '{' 'def' methodName=ID '(' ')' ':' 'int'
            {
                Identifier self = new Identifier($self.text);
                Identifier methodName = new Identifier($methodName.text);

                ClassDeclaration mainClass = new ClassDeclaration(self,
                    new Identifier(""));
                MethodDeclaration mainMethod = new MethodDeclaration(
                    methodName);

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
            '{' (
                  varDec=varDeclaration
                  { classDec.addVarDeclaration($varDec.synVarDec); } )*
                  ( methodDec=methodDeclaration
                  { classDec.addMethodDeclaration($methodDec.synMethodDec); }
            )* '}'
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
            VarDeclaration firstArg = new VarDeclaration(firstArgIdentifier,
                $firstArgType.synVarType);

            ((MethodDeclaration)$synMethodDec).addArg(firstArg);
          }
              (',' argId=ID ':' argType=type
                  {
                    Identifier argIdentifier = new Identifier($argId.text);
                    VarDeclaration newArg = new VarDeclaration(argIdentifier,
                        $argType.synVarType);
                    ((MethodDeclaration)$synMethodDec).addArg(newArg);
                  }
              )*')'
            )
        )
        ':' type
        {
          $synMethodDec.setReturnType($type.synVarType);
        }

        '{' (varDeclaration
            {
                ((MethodDeclaration)$synMethodDec).addLocalVar(
                    $varDeclaration.synVarDec);
            } )*
            statements 'return' expression ';'
        '}'
    ;

    statements returns [Statement synStatement]:
        { Block blockStatements = new Block(); }
        ( statement { blockStatements.addStatement($statement.synStatement); } )*
        { $synStatement = blockStatements; }
    ;

    statement returns [Statement synStatement]:
        statementBlock { $synStatement = $statementBlock.synStatement; } |
        statementCondition { $synStatement = $statementCondition.synStatement; } |
        statementLoop { $synStatement = $statementLoop.synStatement; } |
        statementWrite { $synStatement = $statementWrite.synStatement; } |
        statementAssignment { $synStatement = new Statement(); }//$statementAssignment.synStatement; }
    ;

    statementBlock returns [Statement synStatement]:
        '{'  statements { $synStatement = $statements.synStatement; } '}'
    ;

    statementCondition returns [Statement synStatement]:
        'if' '('expression')' 'then' statement
        {
          Conditional conditionalStatement = new Conditional($expression.synFinalResult,
              $statement.synStatement);
        }
        ( 'else' statement
            { conditionalStatement.setAlternativeBody($statement.synStatement); }
        )?
        { $synStatement = conditionalStatement; }
    ;

    statementLoop returns [Statement synStatement]:
        'while' '(' expression ')' statement
        { $synStatement = new While($expression.synFinalResult,
              $statement.synStatement); }
    ;

    statementWrite returns [Statement synStatement]:
        'writeln(' expression ')' ';'
        { $synStatement = new Write($expression.synFinalResult); }
    ;

    statementAssignment returns [Statement synStatement]:
        expression ';'
        // { $synStatement = new Assign(((BinaryExpression)($expression.synFinalResult)).getLeft(),
        //       ((BinaryExpression)($expression.synFinalResult)).getRight()); }
    ;

    expression returns [Expression synFinalResult]:
        expressionAssignment
        { $synFinalResult = $expressionAssignment.synFinalResult; }
    ;

    expressionAssignment returns [Expression synFinalResult]:
        expressionOr
        '='
        expressionAssignment // a = b = c;
        {
            $synFinalResult = new BinaryExpression(
                $expressionOr.synFinalResult,
                $expressionAssignment.synFinalResult,
                BinaryOperator.assign
            );
        }
        | expressionOr { $synFinalResult = $expressionOr.synFinalResult; }
    ;

    expressionOr returns [Expression synFinalResult]:
        expressionAnd
        expressionOrTemp[$expressionAnd.synFinalResult]
        { $synFinalResult = $expressionOrTemp.synFinalResult; }
    ;

    expressionOrTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        '||'
        expressionAnd
        {
          BinaryExpression currentRes = new BinaryExpression(
              $inhCurrentResult, $expressionAnd.synFinalResult, BinaryOperator.or
          );
          $inhCurrentResult = currentRes;
        }
        expressionOrTemp[inhCurrentResult]
        | { $synFinalResult = $inhCurrentResult; }
    ;

    expressionAnd returns [Expression synFinalResult]:
        expressionEq
        expressionAndTemp[$expressionEq.synFinalResult]
        { $synFinalResult = $expressionAndTemp.synFinalResult; }
    ;

    expressionAndTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        '&&'
        expressionEq
        {
          BinaryExpression currentRes = new BinaryExpression(
              $inhCurrentResult, $expressionEq.synFinalResult, BinaryOperator.and
          );
          $inhCurrentResult = currentRes;
        }
        expressionAndTemp[inhCurrentResult]
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
              (($operator.text.equals("==")) ? BinaryOperator.eq : BinaryOperator.neq)
          );
          $inhCurrentResult = currentRes;
        }
        expressionEqTemp[inhCurrentResult] // TODO a > b < c ??
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
              ($operator.text.equals('>')) ? BinaryOperator.gt : BinaryOperator.lt
          );
          $inhCurrentResult = currentRes;
        }
        expressionCmpTemp[inhCurrentResult] // TODO a > b < c ??
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
                ($operator.text.equals('+')) ? BinaryOperator.add : BinaryOperator.sub
            );
        }
        expressionAddTemp[currentRes]
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
                ($operator.text.equals('*')) ? BinaryOperator.mult : BinaryOperator.div
            );
            // TODO : check it later:
            $inhCurrentResult = currentRes;
        }
        expressionMultTemp[inhCurrentResult]
        | { $synFinalResult = $inhCurrentResult; }
    ;

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

    expressionMem returns [Expression synFinalResult]:
        expressionMethods
        expressionMemTemp[$expressionMethods.synFinalResult]
        { $synFinalResult = $expressionMemTemp.synFinalResult; }
    ;

    expressionMemTemp [Expression inhCurrentResult] returns [Expression synFinalResult]:
        '[' expression ']'
            {
                $synFinalResult = new ArrayCall($inhCurrentResult,
                    $expression.synFinalResult);
            }
        |   { $synFinalResult = $inhCurrentResult; }
    ;

    expressionMethods returns [Expression synFinalResult]:
        expressionOther
        expressionMethodsTemp[$expressionOther.synFinalResult]
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
            | id=ID
              {
                  Expression instance = $inhCurrentResult;
                  Identifier id = new Identifier($id.text);
                  $inhCurrentResult = new MethodCall(instance, id);
              }
              '(' (expression
                  { ((MethodCall)$inhCurrentResult).addArg($expression.synFinalResult); }
                  (',' expression
                  { ((MethodCall)$inhCurrentResult).addArg($expression.synFinalResult); }
              )*) ')'
            | 'length'
              {
                  Expression instance = $inhCurrentResult;
                  $inhCurrentResult = new Length(instance);
              }
        )
        expressionMethodsTemp[inhCurrentResult]
        | { $synFinalResult = $inhCurrentResult; }
    ;

    expressionOther returns [Expression synFinalResult]:
        num1=CONST_NUM { $synFinalResult = new IntValue(Integer.parseInt($num1.text), new IntType()); }
        |   str=CONST_STR
            {
                $synFinalResult = new StringValue($str.text, new StringType());
            }
        |   'new ' 'int' '[' num2=CONST_NUM ']'
            {
                // $synFinalResult
                NewArray temp = new NewArray();
                temp.setExpression(new IntValue(Integer.parseInt($num2.text), new IntType()));
                $synFinalResult = temp;
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
                // $synVarType
                UserDefinedType temp = new UserDefinedType();
                temp.setName(new Identifier($id.text));
                $synVarType = temp;
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
