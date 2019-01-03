class Main
{
        def main(): int
        {
                # var flag : boolean;
                # var arr : int[];
                # arr = new int[13];

                # if(flag == true) then
                #         writeln(arr.length);

                if(true == false) then
                        writeln("Salam");                        

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