class Main 
{
        def main(): int
        {
                return "Main" + 1 && true;
                # Error: Invalid return value
        }
}

class A
{
        var test : A; 
        var A : A;
        var B : B;
        var intVal : int;

        def A(flag : boolean) : int # Error: flag is not declared!
        {
                return 0;
        }

        # def A() : int
        # {
        #         return intVal;  # Error: A return type must be int!
        # }

        # def A() : A
        # {
        #         return A;       # Error : Indefinite loop
        # }

        # def A() : A
        # {
        #         return new A();
        # }

        # def A() : A
        # {
        #         return new B().D();     # Error: A return type must be A
        # }


        # def A(A : A, A : A) : boolean # Error: Redefinition
        # {
        #         return false;
        # }

        #        def B() : B
        #        {
        #                return A.AA(); # Error: There is no method named AA
        #        }
        #
        #        def C() : A
        #        {
        #                return A.A(B, true); # Error: Arguments 
        #        }
}

class B extends A 
{
        def D() : B
        {
                return new B();
        }
#        var D : A;
#
#        def D() : A
#        {
#                D = new A().A(D, D);
#                return 2;
#        }
}

# class C extends A {}
# class D extends B {}