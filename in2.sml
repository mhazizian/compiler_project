# Defult value for primitives

class Test
{
        def main() : int
        {
                var expect : Expect;
                var result : boolean;
                var tempResult : boolean;

                var babyTest : BabyTest;
                var babyTestOut : int;

                var unaryOperatorTest : UnaryOperatorTest; 

                var binaryOperatorTest : BinaryOperatorTest; 

                expect = new Expect();
                
                babyTest = new BabyTest();
                babyTestOut = babyTest.test();

                result = expect.equalInt(babyTestOut, 0, "BabyTest (variable):");

                result = result && expect.equalInt(new BabyTest().test(), 0, "BabyTest (new class):");

                unaryOperatorTest = new UnaryOperatorTest();
                tempResult = unaryOperatorTest.test();
                tempResult = tempResult && expect.equalBool(tempResult, true, "Unary Opeartors Test :");
                result = tempResult && result;

                binaryOperatorTest = new BinaryOperatorTest();
                tempResult = binaryOperatorTest.test();
                tempResult = tempResult && expect.equalBool(tempResult, true, "Binary Opeartors Test :");
                result = tempResult && result;                

                result = expect.equalBool(result, true, "Test :");

                return 0;
        }
}

class Expect
{        
        def equalInt(output : int, expected : int, message : string) : boolean
        {
                var result : boolean;

                writeln(message);

                if (expected == output) then
                {
                        writeln("\t###### Passed ######");
                        result = true;
                }
                else
                {
                        writeln("\t$$$$$$ Failed $$$$$$");
                        result = false;
                }
                writeln("");
                return result;
        }

        def equalBool(expected : boolean, output : boolean, message : string) : boolean
        {
                var result : boolean;

                writeln(message);

                if (expected == output) then
                {
                        writeln("\t###### Passed ######");
                        result = true;
                }
                else
                {
                        writeln("\t$$$$$$ Failed $$$$$$");
                        result = false;
                }
                writeln("");
                return result;
        }
}

class BabyTest
{
        def test() : int 
        {
                return 0;
        }
}

class UnaryOperatorTest
{
        def test() : boolean
        {
                var expect : Expect;

                var result : boolean;
                var resultBool : boolean;
                var resultInt : int;
                var tempBool : boolean;
                var tempInt : int;

                tempBool = false;
                tempInt = 1;

                expect = new Expect();
                
                writeln("Unary Operator Test :\n");

                resultBool = this.notTest(true);
                result = expect.equalBool(resultBool, false, "\tNotTest : True");

                resultBool = this.notTest(false);
                result = result && expect.equalBool(resultBool, true, "\tNotTest : False");

                resultBool = this.notTest(tempBool);
                result = expect.equalBool(resultBool, true, "\tNotTest : variable");

                resultInt = this.minusTest(1);
                result = result && expect.equalInt(resultInt, -1, "\tMinusTest : True");

                resultInt = this.minusTest(0);
                result = result && expect.equalInt(resultInt, 0, "\tMinusTest : False");

                resultInt = this.minusTest(tempInt);
                result = result && expect.equalInt(resultInt, -1, "\tMinusTest : variable");

                return result;
        }

        def minusTest(value : int) : int
        {
                return -value;
        } 

        def notTest(value : boolean) : boolean
        {
                return !value;
        } 
}

class BinaryOperatorTest
{
        def test() : boolean
        {
                var expect : Expect;

                var result : boolean;
                var resultBool : boolean;
                var resultInt : int;

                var tempInt : int;
                var tempBool : boolean;

                expect = new Expect();
                tempInt = 13;
                tempBool = true;
                
                writeln("Binary Operator Test :\n");

                #### ADD ####

                resultInt = this.addTest(-1, 1);
                result = expect.equalInt(resultInt, 0, "\tAddTest :");

                resultInt = this.addTest(tempInt, tempInt);
                result = result && expect.equalInt(resultInt, 26, "\tAddTest : Variable");

                resultInt = this.addTest(tempInt, 23);
                result = result && expect.equalInt(resultInt, 36, "\tAddTest : var + const");

                #### SUB ####

                resultInt = this.subTest(3, 0);
                result = result && expect.equalInt(resultInt, 3, "\tSubTest : Constant");

                resultInt = this.subTest(tempInt, tempInt);
                result = result && expect.equalInt(resultInt, 0, "\tSubTest : Variable");

                resultInt = this.subTest(tempInt, 23);
                result = result && expect.equalInt(resultInt, -10, "\tSubTest : var + const");

                #### MULT ####

                resultInt = this.multTest(3, 0);
                result = result && expect.equalInt(resultInt, 0, "\tmultTest : Constant");

                tempInt = 2;
                resultInt = this.multTest(tempInt, tempInt);
                result = result && expect.equalInt(resultInt, 4, "\tmultTest : Variable");

                resultInt = this.multTest(tempInt, -2);
                result = result && expect.equalInt(resultInt, -4, "\tmultTest : var + const");

                #### DIV ####

                resultInt = this.divTest(3, 1);
                result = result && expect.equalInt(resultInt, 3, "\tdivTest : Constant");

                resultInt = this.divTest(tempInt, tempInt);
                result = result && expect.equalInt(resultInt, 1, "\tdivTest : Variable");

                resultInt = this.divTest(0, tempInt);
                result = result && expect.equalInt(resultInt, 0, "\tdivTest : var + const");

                #### AND ####

                resultBool = this.andTest(true, true);
                result = result && expect.equalBool(resultBool, true, "\tandTest : Constant");

                resultBool = this.andTest(tempBool, tempBool);
                result = result && expect.equalBool(resultBool, true, "\tandTest : Variable");

                resultBool = this.andTest(false, tempBool);
                result = result && expect.equalBool(resultBool, false, "\tandTest : var + const");

                #### OR ####

                resultBool = this.orTest(tempBool, false);
                result = result && expect.equalBool(resultBool, true, "\torTest : Constant");

                resultBool = this.orTest(tempBool, !tempBool);
                result = result && expect.equalBool(resultBool, true, "\torTest : Variable");

                resultBool = this.orTest(false, !tempBool);
                result = result && expect.equalBool(resultBool, false, "\torTest : var + const");

                #### EQ ####

                resultBool = this.eqTest(tempBool, true);
                result = result && expect.equalBool(resultBool, true, "\teqTest : Constant");

                resultBool = this.eqTest(tempBool, !tempBool);
                result = result && expect.equalBool(resultBool, false, "\teqTest : Variable");

                resultBool = this.eqTest(false, tempBool);
                result = result && expect.equalBool(resultBool, false, "\teqTest : var + const");

                #### NEQ ####

                resultBool = this.neqTest(tempBool, true);
                result = result && expect.equalBool(resultBool, false, "\tneqTest : Constant");

                resultBool = this.neqTest(tempBool, !tempBool);
                result = result && expect.equalBool(resultBool, true, "\tneqTest : Variable");

                resultBool = this.neqTest(false, tempBool);
                result = result && expect.equalBool(resultBool, true, "\tneqTest : var + const");

                #### LT ####

                resultBool = this.ltTest(-1, 1);
                result = result && expect.equalBool(resultBool, true, "\tltTest : Constant");

                resultBool = this.ltTest(tempInt - 1, tempInt);
                result = result && expect.equalBool(resultBool, true, "\tltTest : Variable");

                resultBool = this.ltTest(20, tempInt);
                result = result && expect.equalBool(resultBool, false, "\tltTest : var + const");

                #### GT ####

                resultBool = this.gtTest(-1, 1);
                result = result && expect.equalBool(resultBool, false, "\tgtTest : Constant");

                resultBool = this.gtTest(tempInt - 1, tempInt);
                result = result && expect.equalBool(resultBool, false, "\tgtTest : Variable");

                resultBool = this.gtTest(20, tempInt);
                result = result && expect.equalBool(resultBool, true, "\tgtTest : var + const");

                return result;
        }

        def addTest(firstOp : int, secondOp : int) : int
        {
                return firstOp + secondOp;
        }
        
        def subTest(firstOp : int, secondOp : int) : int
        {
                return firstOp - secondOp;
        }
        
        def multTest(firstOp : int, secondOp : int) : int
        {
                return firstOp * secondOp;
        }
        
        def divTest(firstOp : int, secondOp : int) : int
        {
                return firstOp / secondOp;
        }
        
        def andTest(firstOp : boolean, secondOp : boolean) : boolean
        {
                return firstOp && secondOp;
        }
        
        def orTest(firstOp : boolean, secondOp : boolean) : boolean
        {
                return firstOp || secondOp;
        }
        
        def eqTest(firstOp : boolean, secondOp : boolean) : boolean
        {
                return firstOp == secondOp;
        }
        
        def neqTest(firstOp : boolean, secondOp : boolean) : boolean
        {
                return firstOp <> secondOp;
        }
        
        def ltTest(firstOp : int, secondOp : int) : boolean
        {
                return firstOp < secondOp;
        }
        
        def gtTest(firstOp : int, secondOp : int) : boolean
        {
                return firstOp > secondOp;
        }
        
        # def assign(int rval, int lval)
        # {
        #         return firstOp  secondOp;
        # }
}