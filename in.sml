class MainClass {
    def main(): int {
        return 0;
    }
}

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
        b = arr.length;
        b = a.length;
        b = boolVal.length;

        ccc = 2;

        b = arr[2];
        b = arr[2 + 5 + ccc / arr[2]];
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
    def j(): int {
        var a : int[];
        return a;
    }
}

class A extends B{
    def i(): B {
        return new B();
    }
    def j(): int {
        var a : int[];
        return a;
    }
}