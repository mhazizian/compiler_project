package symbolTable;

import ast.Type.Type;

import java.util.ArrayList;

public class SymbolTableClassItem extends SymbolTableItem {

    // ArrayList<Type> argTypes = new ArrayList<>();
    // SymbolTableClassItem parent = new SymbolTableClassItem()

    public SymbolTableMethodItem(String name) {
        this.name = name;
        // this.argTypes = argTypes;
    }

    @Override
    public String getKey() {
        //todo
        return null;
    }
}
