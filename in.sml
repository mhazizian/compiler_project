class Main
{
        def main(): int
        {
                #### Equality Test ####

                if(true == true) then
                        writeln("if: eqtest: eq");
                else
                        writeln("Nothing!");  

                #### Non-equality Test ####

                if(true <> false) then
                        writeln("if: neqtest: neq");
                else
                        writeln("Nothing!");

                #### Less than Test ####

                if(0 < 1) then
                        writeln("if: lttest: lt");
                else
                        writeln("Nothing!");

                if(1 < 0) then
                        writeln("Nothing!");
                else
                        writeln("else: lttest: gt");

                #### Greater than Test ####

                if(1 > 0) then
                        writeln("if: gttest: gt");
                else
                        writeln("Nothing!");

                if(0 > 1) then
                        writeln("Nothing!");
                else
                        writeln("else: gttest: lt");

                #### OR Test ####

                if(false || true) then
                        writeln("if: ortest: true");
                else
                        writeln("Nothing!");

                if(false || false) then
                        writeln("Nothing!");
                else
                        writeln("else: ortest: false");

                #### AND Test ####

                if(false && true) then
                        writeln("Nothing!");
                else
                        writeln("else: andtest: false");

                if(true && true) then
                        writeln("if: andtest: true");
                else
                        writeln("Nothing!");

                #### Indefinite loop Test ####

                # while (1 > 0)
                #         writeln("Indefinite Loop!");                        

                #### Fake loop Test ####

                while (0 == 1)
                        writeln("Fake Loop!");                        

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