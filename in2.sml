# Defult value for primitives
# String as an argument
# Class field declaration
# new class().method() in argument passing
# Same name of two local variables in the same class
# Boolean argument passing failed

class Test
{
        def main() : int
        {
                var expect : Expect;
                var result : boolean;

                var babyTest : BabyTest;
                var babyTestOut : int;

                # var unaryOperatorTest : UnaryOperatorTest; 

                expect = new Expect();
                
                babyTest = new BabyTest();
                babyTestOut = babyTest.test();

                writeln("BabyTest (variable) :");
                result = expect.equalInt(babyTestOut, 0);

                # writeln("BabyTest (new class) :");
                # result = expect.equalInt(new BabyTest().test(), 0);

                return 0;
        }
}

class Expect
{        
        def equalInt(output : int, expected : int) : boolean
        {
                var result : boolean;

                if (expected == output) then
                {
                        writeln("       ###### Passed. ######");
                        result = true;
                }
                else
                {
                        writeln("       $$$$$$ Failed! $$$$$$");
                        result = false;
                }
                writeln("");
                return result;
        }

        # def equalBool(expected : boolean, output : boolean) : boolean
        # {
        #         var result : boolean;

        #         if (expected == output) then
        #         {
        #                 writeln("       ###### Passed. ######");
        #                 result = true;
        #         }
        #         else
        #         {
        #                 writeln("       $$$$$$ Failed! $$$$$$");
        #                 result = false;
        #         }
        #         writeln("");
        #         return result;
        # }
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

                # resultBool = this.notTest(true);
                # expect.equalBool(resultBool, false);

                resultBool = this.notTest(false);
                resultInt = this.minusTest(1);
                resultInt = this.minusTest(0);

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

