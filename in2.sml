# Defult value for primitives
# Constant string argument passing

class Test
{
        def main() : int
        {
                var expect : Expect;
                var result : boolean;

                var babyTest : BabyTest;
                var babyTestOut : int;
                
                expect = new Expect();
                
                babyTest = new BabyTest();
                babyTestOut = babyTest.test();

                writeln("BabyTest :");
                result = expect.equalInt(babyTestOut, 0);

                return 0;
        }
}

class Expect
{        
        def equalInt(output : int, expected : int) : boolean #, testName : string) : boolean
        {
                var result : boolean;

                if (expected == output) then
                {
                        writeln("       ###");
                        writeln("       Passed.");
                        writeln("       ###");
                        result = true;
                }
                else
                {
                        writeln("       $$$");
                        writeln("       Failed!");
                        writeln("       $$$");
                        result = false;
                }
                writeln("");
                return result;
        }
}

class BabyTest {
        def test(): int 
        {
                return 0;
        }
}