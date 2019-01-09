
# class Main
# {
#         def main(): int
#         {
#                 var i : int;
#                 var stringT : string;
#                 var string2T : string;
#                 var string3T : string;
#                 var arrayT : int[];
#                 var intT : int;
#                 var boolT : boolean;
#                 var classT : SecClass;
#                 var classThird : ThirdClass;
#                 var classFourh : FourthClass;
#                 var initT_s : string;
#                 var initT_i : int;
#                 var initT_z : boolean;

#                 writeln(initT_s);
#                 writeln(initT_i);
#                 writeln(initT_z);

#                 i = intT = initT_i = 20;


#                 writeln(initT_i);
#                 writeln(intT);
#                 writeln(i);

#                 stringT = string2T = string3T = "salam";

#                 writeln(stringT);
#                 writeln(string2T);
#                 writeln(string3T);
                

#                 intT = 3;
#                 writeln(intT);

#                 writeln("#### Equality Test ####");

#                 if (!false) then {
#                        writeln("not, test 1 , pass"); 
#                 }

#                 if (!0) then {
#                        writeln("not, test 2 , pass"); 
#                 }

#                 if (!true) then {} else {
#                        writeln("not, test 3 , pass"); 
#                 }

#                 if (!(2 + 3 - 5 + 17)) then {} else {
#                        writeln("not, test 4 , pass"); 
#                 }

#                 if(true == true) then
#                         writeln("if: eqtest: eq");
#                 else
#                         writeln("Nothing!");  

#                 writeln("#### Non-equality Test ####");

#                 if(true <> false) then
#                         writeln("if: neqtest: neq");
#                 else
#                         writeln("Nothing!");

#                 writeln("#### Less than Test ####");

#                 if(0 < 1) then
#                         writeln("if: lttest: lt");
#                 else
#                         writeln("Nothing!");

#                 if(1 < 0) then
#                         writeln("Nothing!");
#                 else
#                         writeln("else: lttest: gt");

#                 # while (1 > 0)
#                 #         writeln("Indefinite Loop!");                        

#                 writeln("#### Fake loop Test ####");

#                 while (0 == 1)
#                         writeln("Fake Loop!");                        

#                 writeln("### Mohammad Hosein is Here :D");
#                 stringT = "salam";
#                 writeln(stringT);

#                 intT = 2;
#                 writeln(intT);
                # writeln("### while  and ArrayCall test");
                # i = 1;
                # arrayT = new int[40];
                # while (i < 40) {
                #         arrayT[i] = arrayT[i - 1] = 2 * i;
                #         # arrayT[i] = 2 * i;
                #         writeln(arrayT[i]);  
                #         i = i + 1;                      
                # }

                # writeln("### Write array test");

                # writeln(arrayT);

                # writeln("### Method Call Test");

                # classT = new SecClass();
                # writeln(classT.subClassMethod("1"));
                # intT = classT.inc_array_call();
                # intT = classT.inc_array_call();
                # intT = classT.inc_array_call();



#         def f2() : int {
#                 var a : int;
#                 a = 17;
#                 writeln(a);
#                 return 0;
#         }
# }

class main
{
        def main() : int
        {
                return new Test().test3();       
        }
}

class Test
{
        def test() : int
        {
                var t1 : Test;
                var t2 : Test;

                t1 = new Test();
                t2 = new Test();

                writeln("Test");

                return 0;
        }

        def test2() : int[]
        {
                var a : int[];
                var b : int;

                b = this.test();

                a = new int[18];
                a[17] = 17 * 17;
                writeln("Test2");
                return a;
        }

        def test3() : int
        {
                var b : int[];
                b = this.test2();
                # b = new Test().test2();
                writeln(b[17]);
                return 0;
        }
}