class MainClass {
    def main(): int {
        return 0;
    }
}

# class B {
#     var i : int;
# }

class A{
    def i(): int {
        # var q : Test2;
        # q = new Test2().method();
        return 2;
    }
}

class C {
    def t(): int {
        var a : A;
        var b : int;
        a = new A();
        b = a.i();
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
