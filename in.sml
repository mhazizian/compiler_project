class Main
{
        def main(): int
        {
                if(true == true) then
                        writeln("if: eqtest: eq");
                else
                        writeln("Nothing!");  

                writeln("Between statements");

                if(true <> false) then
                        writeln("if: neqtest: neq");
                else
                        writeln("Nothing!");

                writeln("Between statements");

                if(0 < 1) then
                        writeln("if: lttest: lt");
                else
                        writeln("Nothing!");

                writeln("Between statements");

                if(1 < 0) then
                        writeln("Nothing!");
                else
                        writeln("else: lttest: gt");

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