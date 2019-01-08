package symbolTable;

import ast.Type.Type;

public class SymbolTableVariableItem extends SymbolTableItem {

    private int index;
    protected Type type;
    public boolean isField;
    private String className;

    public SymbolTableVariableItem(String name, Type type, int index) {
        this.name = name;
        this.type = type;
        this.index = index;
        this.isField = false;
    }

    public String getName() {
        return name;
    }

    public Type getType() {
        return type;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String name) {
        this.className = name;
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
