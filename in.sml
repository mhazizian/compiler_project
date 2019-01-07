class Main

{
        def main(): int
        {
                var i : int;
                var stringT : string;
                var intT : int;

                writeln("### assignTest");
                stringT = "salam";
                writeln(stringT);

                intT = 2;
                writeln(intT);

                writeln("### if Teset");

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

                writeln("Between statements");

                if(1 > 0) then
                        writeln("if: gttest: gt");
                else
                        writeln("Nothing!");

                writeln("Between statements");

                if(0 > 1) then
                        writeln("Nothing!");
                else
                        writeln("else: gttest: lt");


                i = 0;
                writeln("### while Teset");
                while (i < 20) {
                        writeln(i);  
                        i = i + 1;                      
                }


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