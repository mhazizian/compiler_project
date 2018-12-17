class Main 
{
        def main(): int
        {
                return "Main" + 1 && true;
        }
}

class A
{
        var test : A;
        var A : A;
        var B : B;
        var intVal : int;
        var arr : int[];

        def methodA(flag : boolean) : int
        {
                test = 8;
                this.noMethod() = 3;
                intVal = new B().intTest();
                noVariable = B.intTest();
                intVal = B.D().methodA(true) + arr[noVariable];
                return intVal + noVariable;
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