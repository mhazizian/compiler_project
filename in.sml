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
                var classFourh : FourthClass;
                var initT_s : string;
                var initT_i : int;
                var initT_z : boolean;

                writeln(initT_s);
                writeln(initT_i);
                writeln(initT_z);

                intT = 3;
                writeln(intT);

                writeln("#### Equality Test ####");

                if (!false) then {
                       writeln("not, test 1 , pass"); 
                }

                if (!0) then {
                       writeln("not, test 2 , pass"); 
                }

                if (!true) then {} else {
                       writeln("not, test 3 , pass"); 
                }

                if (!(2 + 3 - 5 + 17)) then {} else {
                       writeln("not, test 4 , pass"); 
                }

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
                intT = classT.inc_array_call();
                intT = classT.inc_array_call();
                intT = classT.inc_array_call();


                classThird = new ThirdClass();
                intT = classThird.thirdClassMethod();

                intT = classThird.inc_int_field();
                intT = classThird.inc_int_field();
                intT = classThird.inc_int_field();

                classFourh = new FourthClass();
                intT = classFourh.f1();

                return 0;
        }
}

class SecClass {
        var arrayInc : int[];
        var intInc : int;

        def inc_array_call() : int {
                arrayInc[3] = arrayInc[3] + 1;
                writeln("## inc_array_call function ##");
                writeln(arrayInc[3]);
                return 1;       
        }

        def subClassMethod(a : string): int {
                arrayInc = new int[10];
                arrayInc[3] = 0;

                intInc = 17;
                # var methodVar : boolean;

                # temp = 17;
                # writeln(temp);

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

                intInc = 17;

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

        def inc_int_field() : int {
                intInc = intInc + 1;
                writeln("## inc_int_field function ##");
                writeln(intInc);
                return 1;       
        }
}

class FourthClass  {
        def f1() : int {
                var a : int;
                var temp : int;
                a = 1;
                writeln(a);
                temp = this.f2();
                writeln(a);
                return 0;
        }

        def f2() : int {
                var a : int;
                a = 17;
                writeln(a);
                return 0;
        }
}