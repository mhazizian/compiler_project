class Main
{
        def main(): int
        {
                var i : int;
                var stringT : string;
                var arrayT : int[];
                var intT : int;
                var boolT : boolean;
                var classT : SecClass;
                var classThird : ThirdClass;

                intT = 3;
                writeln(intT);

                writeln("#### Equality Test ####");

                if(true == true) then
                        writeln("if: eqtest: eq");
                else
                        writeln("Nothing!");  

                writeln("#### Non-equality Test ####");

                if(true <> false) then
                        writeln("if: neqtest: neq");
                else
                        writeln("Nothing!");

                writeln("#### Less than Test ####");

                if(0 < 1) then
                        writeln("if: lttest: lt");
                else
                        writeln("Nothing!");

                if(1 < 0) then
                        writeln("Nothing!");
                else
                        writeln("else: lttest: gt");

                writeln("#### Greater than Test ####");

                if(1 > 0) then
                        writeln("if: gttest: gt");
                else
                        writeln("Nothing!");

                if(0 > 1) then
                        writeln("Nothing!");
                else
                        writeln("else: gttest: lt");

                writeln("#### OR Test ####");

                if(false || true) then
                        writeln("if: ortest: true");
                else
                        writeln("Nothing!");

                if(false || false) then
                        writeln("Nothing!");
                else
                        writeln("else: ortest: false");

                writeln("#### AND Test ####");

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

                writeln("#### Fake loop Test ####");

                while (0 == 1)
                        writeln("Fake Loop!");                        

                writeln("### Mohammad Hosein is Here :D");
                stringT = "salam";
                writeln(stringT);

                intT = 2;
                writeln(intT);
    
                writeln("### while  and ArrayCall test");
                i = 0;
                arrayT = new int[20];
                while (i < 20) {
                        arrayT[i] = 2 * i;
                        writeln(arrayT[i]);  
                        i = i + 1;                      
                }

                writeln("### Write array test");

                writeln(arrayT);

                writeln("### Method Call Test");

                classT = new SecClass();
                writeln(classT.subClassMethod("1"));

                classThird = new ThirdClass();
                intT = classThird.thirdClassMethod();

                return 0;
        }
}

class SecClass {
        var firstField : int;

        def subClassMethod(a : string): int {
                # var methodVar : boolean;
                # writeln(a);
                # writeln(b);
                writeln("inside method :D");
                # methodVar = true;
                return 13;
        }
}

class ThirdClass extends SecClass{

        def thirdClassMethod() : int {
                var index : int;
                var size : int;

                size = 24;
                index = this.subClassMethod("1");
                # index = 20;

                writeln("### Inside the thridClassMethod ###");

                while (index < size) {
                        writeln(index);
                        index = index + 1;        
                }

                writeln("$$$ End of the thridClassMethod $$$");

                return 0;
        }
}