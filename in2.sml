# Defult value for primitives
# new class().method() in argument passing

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

                expect = new Expect();
                
                babyTest = new BabyTest();
                babyTestOut = babyTest.test();

                result = expect.equalInt(babyTestOut, 0, "BabyTest (variable):");

                result = result && expect.equalInt(new BabyTest().test(), 0, "BabyTest (new class):");

                unaryOperatorTest = new UnaryOperatorTest();
                tempResult = unaryOperatorTest.test();
                tempResult = tempResult && expect.equalBool(tempResult, true, "Unary Opeartors Test :");
                result = tempResult && result;

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
                        writeln("\t###### Passed. ######");
                        result = true;
                }
                else
                {
                        writeln("\t$$$$$$ Failed! $$$$$$");
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
                        writeln("\t###### Passed. ######");
                        result = true;
                }
                else
                {
                        writeln("\t$$$$$$ Failed! $$$$$$");
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

                expect = new Expect();
                
                writeln("Unary Operator Test :\n");

                resultBool = this.notTest(true);
                result = expect.equalBool(resultBool, false, "\tNotTest :");

                resultBool = this.notTest(false);
                result = result && expect.equalBool(resultBool, true, "\tNotTest :");

                resultInt = this.minusTest(1);
                result = result && expect.equalInt(resultInt, -1, "\tMinusTest :");

                resultInt = this.minusTest(0);
                result = result && expect.equalInt(resultInt, 0, "\tMinusTest :");

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

