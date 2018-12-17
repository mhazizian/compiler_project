package symbolTable;

import ast.Type.Type;

import java.util.ArrayList;
import symbolTable.SymbolTableClassItem;
import symbolTable.SymbolTableItemType;

public class SymbolTableNoTypeItem extends SymbolTableItem {

    public SymbolTableNoTypeItem(String name) {
        this.name = name;
    }

    @Override
    public String getKey() {
        return "nt_" + this.name;
    }

    @Override
    public SymbolTableItemType getItemType() {
        return SymbolTableItemType.NoType;
    }

    @Override
    public String getName() {
        return this.name;
    }

}

