package symbolTable;

import ast.Type.Type;

public class SymbolTableVariableItem extends SymbolTableItem {

    private int index;
    protected Type type;

    public SymbolTableVariableItem(String name, Type type, int index) {
        this.name = name;
        this.type = type;
        this.index = index;
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

    @Override
    public SymbolTableItemType getItemType() {
        return SymbolTableItemType.variableType;
    }

    public int getIndex() {
        return index;
    }


}
