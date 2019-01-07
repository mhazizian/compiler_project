class Main

{
        def main(): int
        {
                var i : int;
                var stringT : string;
                var arrayT : int[];
                var intT : int;
                var boolT : boolean;

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

                if(0 || 1) then
                        writeln("if: orTest");
                else
                        writeln("Nothing!");
                if(0 && 1) then
                        writeln("Nothing!");
                else
                        writeln("else: andTest");
                        
                writeln("### while  and ArrayCall testTest");
                i = 0;
                arrayT = new int[20];
                while (i < 20) {
                        arrayT[i] = 2 * i;
                        writeln(arrayT[i]);  
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