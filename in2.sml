class Main 
{
        def main(): int
        {
                return "Main" + 1 && true;
                # Error: Invalid return value # Exist
        }
}

class A
{
        var test : A; 
        var A : A;
        var B : B;
        var intVal : int;

        def methodA(flag : boolean) : int
        {
                test = 8;
                this.methodNotExist() = 3;
                intVal = new B().intTest();
                intVal = B.E(intVal);
                # intVal = B.E();       Error
                return intVal;
        }

}

class B extends A 
{
        var testA : A;

        def C() : A
        {
                return testA;
        }        
        
        def D() : B
        {
                return new B();
        }

        def E(a : int) : int
        {
                return 0;
        }

        def intTest() : int
        {
                return this.E(0) + testA.methodA(false);
        }
}