class Main
{
        def main(): int
        {
                # var flag : boolean;
                # var arr : int[];
                # arr = new int[13];

                # if(flag == true) then
                #         writeln(arr.length);

                # if(false == true) then
                #         writeln("first if");   
                # else
                #         writeln("else: eqtest: neq");               
                        
                # if(true == true) then
                #         writeln("if: eqtest: eq");  
                # else
                #         writeln("second else");        

                writeln("Between statements");

                if(false <> true) then
                        writeln("if: neqtest: neq");   
                else
                        writeln("first else");               
                        
                if(true <> true) then
                        writeln("second if");   
                else
                        writeln("else: neqtest: eq");       


                return 0;
        }
}

class SubClass extends Main {
        var firstField : int;

        def subClassMethod(flag : boolean): boolean {
                var methodVar : boolean;
                return methodVar;
        }
}