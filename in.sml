class MainClass {
    def main(): int {
        return 0;
    }
}

# class B {
#     var i : int;
# }
class B {
    def j(): int {
        return 0;
    }
}
class A{
    def i(): B {
        # var q : Test2;
        # q = new Test2().method();
        return new B();
    }
}

class C {
    def t(): int[] {
        var a : B;
        var b : int;
        var arr : int[];

        a = new A().i();
        b = a.j();
        
        writeln(a.j());
        writeln("Hello");
        writeln(2);
        writeln(arr);
        writeln(b);
        writeln(a);
        
        return 2;
    }
}


# class Test1 {
#     var i : int;
#     def method1() : string {
#         var j : string;
#         j = "hello world!";
#         return j;
#     }
# }

# class Test2 extends Test1 {
#     var variable : int[];

#     def method1(): int {
#         i = 10;
#         variable = new int[10];
#         return i;
#     }

#     def method3(): int {
#         if(a == 2) then
#             b = true;
#         else
#             b = false;

#         while(a <> 0) {
#             a = a - 1;
#         }

#         writeln("Hello kiki!");
#         return 0;
#     }

#     def method4(): int {
#         var arr : int[];
#         arr = new int[666];
#         writeln(arr.length);
#         return 0;
#     }
# }
