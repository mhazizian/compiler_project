# Printing int array as a field failed (Uncomment ArrayTest:test:423)
# It doesn't make the .j files when we have array in the assignment (Uncomment Fibo:initializeArray:473)
# Returning array failed
# String and other classes equality

class Main
{
        def main() : int
        {
                return new Test().test();
        }
}

class Test
{
        def test() : int
        {
                var expect : Expect;
                var result : boolean;
                var tempResult : boolean;
                var babyTest : BabyTest;
                var babyTestOut : int;
                var unaryOperatorTest : UnaryOperatorTest; 
                var binaryOperatorTest : BinaryOperatorTest;
                var arrayTest : ArrayTest; 
                var returnedClass : TestReturnedClass;
                var testInheritedClasses : TestInheritedClasses;
                var fibo : Fibo;

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
                tempResult = binaryOperatorTest.test(13, true, "Hello");
                tempResult = tempResult && expect.equalBool(tempResult, true, "Binary Opeartors Test :");
                result = tempResult && result;                

                arrayTest = new ArrayTest();
                tempResult = arrayTest.test();
                tempResult = tempResult && expect.equalBool(tempResult, true, "Array Test :");
                result = tempResult && result;                

                returnedClass = new TestReturnedClass();
                tempResult = returnedClass.test();
                tempResult = tempResult && expect.equalBool(tempResult, true, "Class returning Test :");
                result = tempResult && result;

                testInheritedClasses = new TestInheritedClasses();
                tempResult = testInheritedClasses.test();
                tempResult = tempResult && expect.equalBool(tempResult, true, "Inherited Classes Test :");
                result = tempResult && result;

                fibo = new Fibo();

                result = result && expect.equalInt(fibo.normalFibo(6), 8, "Normal Fibo Test:");
                result = result && expect.equalInt(fibo.recursiveFibo(6), 8, "Recursive Fibo Test:");
                result = result && expect.equalInt(fibo.dynamicFibo(6), 8, "Dynamic Fibo Test:");

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
                        writeln("\n\tOutput:");
                        writeln(output);
                        writeln("\n\tExpceted:");
                        writeln(expected);
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
                        writeln("\n\tOutput:");
                        writeln(output);
                        writeln("\n\tExpceted:");
                        writeln(expected);
                        result = false;
                }
                writeln("");
                return result;
        }


        def equalString(expected : string, output : string, message : string) : boolean
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
                        writeln("\n\tOutput:");
                        writeln(output);
                        writeln("\n\tExpceted:");
                        writeln(expected);
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
        var expect : Expect;
        var tempBool : boolean;
        var tempInt : int;

        def test() : boolean
        {
                var result : boolean;
                var resultBool : boolean;
                var resultInt : int;

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
        var expect : Expect;
        var resultBool : boolean;
        var resultInt : int;
        var fieldString : string;

        ## Call it with "tempInt = 13" , "tempBool = true" ,and "tempString = "Hello"" 
        def test(tempInt : int, tempBool : boolean, tempString : string) : boolean
        {
                var result : boolean;

                fieldString = "Salam";

                expect = new Expect();
                
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

                #### INT EQ ####

                resultBool = this.eqBoolTest(tempBool, true);
                result = result && expect.equalBool(resultBool, true, "\teqTest : Constant");

                resultBool = this.eqBoolTest(tempBool, !tempBool);
                result = result && expect.equalBool(resultBool, false, "\teqTest : Variable");

                resultBool = this.eqBoolTest(false, tempBool);
                result = result && expect.equalBool(resultBool, false, "\teqTest : var + const");

                #### String EQ ####

                result = result && expect.equalString(tempString, "Hello", "\teqStringTest : Constant");

                #### NEQ ####

                resultBool = this.neqBoolTest(tempBool, true);
                result = result && expect.equalBool(resultBool, false, "\tneqTest : Constant");

                resultBool = this.neqBoolTest(tempBool, !tempBool);
                result = result && expect.equalBool(resultBool, true, "\tneqTest : Variable");

                resultBool = this.neqBoolTest(false, tempBool);
                result = result && expect.equalBool(resultBool, true, "\tneqTest : var + const");

                #### String NEQ ####

                result = result && expect.equalString(tempString, "Hello", "\tneqStringTest : Constant");

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
        
        def eqBoolTest(firstOp : boolean, secondOp : boolean) : boolean
        {
                return firstOp == secondOp;
        }
        
        def neqBoolTest(firstOp : boolean, secondOp : boolean) : boolean
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

class ArrayTest
{
        var classArray : int[];
        var expect : Expect;
        var result : boolean;

        def test() : boolean
        {
                var localArray : int[];
                var binaryOperatorTest : BinaryOperatorTest;

                binaryOperatorTest = new BinaryOperatorTest();

                localArray = new int[2];
                classArray = new int[3];
                expect = new Expect();

                classArray[0] = 13;
                classArray[1] = 26;
                classArray[2] = 39;

                localArray[0] = -26;
                localArray[1] = -13;

                classArray[0] = localArray[1];

                writeln("Array Test:");

                result = binaryOperatorTest.test(-localArray[1], true, "Hello");
                result = expect.equalBool(result, true, "Array element in binary operators :");

                result = result && expect.equalInt(5, localArray.length + classArray.length, "Array length :");                

                writeln("Array elements:");
                writeln(localArray[0]);
                writeln(localArray[1]);

                writeln("Printed array:");
                writeln(localArray);
                # writeln(classArray);

                return result;
        }
}

class Fibo
{
        var expect : Expect;
        var dp : int[];

        def normalFibo(n : int) : int
        {
                var first : int;
                var second : int;
                var index : int;
                var temp : int;

                first = 0;
                second = 1;

                while(index < n)
                {
                        temp = second;
                        second = first + second;
                        first = temp;
                        index = index + 1;
                }

                return first;
        }

        def initializeArray() : int
        {
                var index : int;
                var localArray : int[];

                index = 2;
                localArray = new int[127];
                dp = new int[127];
                dp[0] = 0;
                dp[1] = 1;

                while(index < 127)
                {
                        dp[index] = -1;
                        index = index + 1;
                }

                # localArray = dp;
                return 2;
        }

        def dynamicFibo(n : int) : int
        {
                var index : int;

                if (n > 127 || n < 0) then
                        writeln("Out of range");
                else
                {
                        index = this.initializeArray();
                        index = 2;

                        while(index < n + 1)
                        {
                                dp[index] = dp[index - 1] + dp[index - 2];
                                index = index + 1;
                        }
                }

                return dp[n];
        }

        def recursiveFibo(n : int) : int
        {
                var result : int;

                if (n < 0) then
                {
                        writeln("n < 0 occured in the fibo function!");
                        result = -1;
                }
                else if (n == 0) then
                        result = 0;
                else if (n == 1) then
                        result = 1;
                else
                        result = this.recursiveFibo(n - 1) + this.recursiveFibo(n - 2);

                return result;
        }
}

class Parent
{
        # var parentField : int[];
        var expect : Expect;
        var parentField : int;

        def parentMethod() : int
        {
                parentField = 127;
                return parentField;
        }
}

class Child extends Parent
{
        var childField : int;

        def childMethod() : int
        {
                return this.parentMethod();       
        }

        def returnItsField() : int
        {
                childField = 126;
                return childField;
        }

        def returnParentsField() : int
        {
                return parentField;
        }
}

class ReturnClass
{
        var child : Child;

        def returnClass() : Child
        {
                child = new Child();
                return child;
        }

        def returnNewClass() : Child
        {
                return new Child();
        }

        def returnLocalClass() : Child
        {
                var localClass : Child;
                localClass = new Child();
                return localClass;
        }
}

class TestReturnedClass
{
        var expect : Expect;
        var returnedClass : ReturnClass; 
        var child : Child;

        def test() : boolean
        {
                var intResult : int;
                var boolResult : boolean;

                expect = new Expect();
                returnedClass = new ReturnClass();

                ##### FIELD #####
                
                intResult = returnedClass.returnClass().childMethod();
                boolResult = expect.equalInt(intResult, 127, "Returned class (Field) called its method");

                intResult = returnedClass.returnClass().parentMethod();
                boolResult = boolResult && expect.equalInt(intResult, 127, "Returned class (Field) called parent's method");
                
                ##### NEW CLASS #####
                
                intResult = returnedClass.returnNewClass().childMethod();
                boolResult = boolResult && expect.equalInt(intResult, 127, "Returned class (new class()) called its method");

                intResult = returnedClass.returnNewClass().parentMethod();
                boolResult = boolResult && expect.equalInt(intResult, 127, "Returned class (new class()) called parent's method");

                ##### LOCAL VARIABLE #####

                child = returnedClass.returnLocalClass();
                intResult = child.childMethod();
                boolResult = boolResult && expect.equalInt(intResult, 127, "Returned class (Local variable) called its method");

                intResult = child.parentMethod();
                boolResult = boolResult && expect.equalInt(intResult, 127, "Returned class (Local variable) called parent's method");
                
                ##### RETURN ITS FIELD #####
                intResult = child.returnItsField();
                boolResult = boolResult && expect.equalInt(intResult, 126, "Returned class (Local variable) returns its field");

                ##### RETURN PARENT'S FIELD #####
                intResult = child.returnParentsField();
                boolResult = boolResult && expect.equalInt(intResult, 127, "Returned class (Local variable) returns parent's field");

                return boolResult;
        }
}

class Dummy
{

}

class TestInheritedClasses
{
        var secondClass : SecondClass;
        var firstClass : FirstClass;

        var expect : Expect;

        def test() : boolean
        {
                var result : boolean;
                var tempBool : boolean;

                var intField : int;
                var stringField : string;
                var boolField : boolean;
                var arrayField : int[];
                var dummyField : Dummy;

                expect = new Expect();
                firstClass = new SecondClass();

                writeln("Inherited Classes:");

                tempBool = firstClass.setFirstInt(13);
                result = expect.equalInt(firstClass.getFirstInt(), 13, "\tint field:");

                tempBool = firstClass.setFirstBoolean(true);
                result = expect.equalBool(firstClass.getFirstBoolean(), true, "\tboolean field:");

                # tempBool = firstClass.setFirstString("Salam");
                # result = expect.equalInt(firstClass.getFirstString().length, 6, "\tstring field");

                # tempBool = firstClass.setFirstArray(new int[20]);
                # result = expect.equalInt(firstClass.getFirstArray().length, 20, "\tint field:");

                # tempBool = firstClass.setFirstInt(13);
                # result = expect.equalInt(firstClass.getFirstInt(), 13, "\tint field:");

                return result;
        }
}

class FirstClass
{
        var intField : int;
        var stringField : string;
        var boolField : boolean;
        var arrayField : int[];
        var dummyField : Dummy;

        def setFirstInt(value : int) : boolean
        {
                intField = value;
                return true;
        }

        def setFirstBoolean(value : boolean) : boolean
        {
                boolField = value;
                return true;
        }

        def setFirstString(value : string) : boolean
        {
                stringField = value;
                return true;
        }

        def setFirstArray(value : int[]) : boolean
        {
                # arrayField = value;
                return true;
        }

        def setFirstDummy(value : Dummy) : boolean
        {
                dummyField = value;
                return true;
        }

        # @TODO: Delete fallowing methods

        def getFirstInt() : int
        {
                return intField;
        }

        def getFirstBoolean() : boolean
        {
                return boolField;
        }

        def getFirstString() : string
        {
                return stringField;
        }

        def getFirstArray() : int[]
        {
                return arrayField;
        }

        def getFirstDummy() : Dummy
        {
                return dummyField;
        }        
}

class SecondClass extends FirstClass
{
        # def getFirstInt() : int
        # {
        #         return intField;
        # }

        # def getFirstBoolean() : boolean
        # {
        #         return boolField;
        # }

        # def getFirstString() : string
        # {
        #         return stringField;
        # }

        # def getFirstArray() : int[]
        # {
        #         return arrayField;
        # }

        # def getFirstDummy() : Dummy
        # {
        #         return dummyField;
        # }        
} 