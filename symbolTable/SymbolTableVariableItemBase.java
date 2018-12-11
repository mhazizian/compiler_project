package symbolTable;

import ast.Type.Type;

public class SymbolTableVariableItemBase extends SymbolTableItem { 

    private int index;
    protected Type type;

    public SymbolTableVariableItemBase(String name, Type type, int index) {
        this.name = name;
        this.type = type;
        this.index = index;
        this.itemType = "var";
    }

    public String getName() {
        return name;
    }

    public Type getType() {
        return type;
    }

    @Override
    public String getKey() {
        return "v_" + name;
        // return name;
    }

    public int getIndex() {
        return index;
    }


}
