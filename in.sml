class MainClass {
    def main(): int {
        return 0;
    }
}

# class B {
#     var i : int;
# }


class C {
    def t(): int[] {
        var c : D;
        var a : B;
        var b : int;
        var arr : int[];
        var boolVal : boolean;
        var boolVal2 : boolean;

        a = new A().i().j();
        b = a.k();

        arr = new int[10];
        ccc = 2;

        b = arr[2];
        b = arr[2 + 5 / 3];
        b = arr[true];
        ccc = b;

        
        writeln(a.j());
        ccc = a;
        
        if(a.j()) then
            writeln("Hello");

        if (!boolVal <> boolVal2) then
            writeln(arr);
        
        if (false) then
            writeln(a);
        else
            while(true)
                writeln(b);
        
        boolVal2 = !boolVal && !b;
        boolVal2 = !boolVal - true;
        2 = !boolVal && boolVal2;
        boolVal2 = 2;
        return a.j();
    }
}

class B {
    # def j(): int {
    #     return 0;
    # }
    def j(): int {
        var a : int[];
        return a;
    }
}
class A extends B{
    def i(): B {
        # var q : Test2;
        # q = new Test2().method();
        return new B();
    }
    def j(): int {
        var a : int[];
        return a;
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
