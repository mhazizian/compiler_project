package symbolTable;

import ast.Type.Type;

import java.util.ArrayList;
import symbolTable.SymbolTableClassItem;

public class SymbolTableMethodItem extends SymbolTableItem {

    ArrayList<Type> argTypes = new ArrayList<>();
    SymbolTableClassItem thisObj;

    public SymbolTableMethodItem(String name, ArrayList<Type> argTypes) {
        this.name = name;
        this.argTypes = argTypes;
        this.itemType = "method";
    }

    public void setThisObject(SymbolTableClassItem thisObj) {
        this.thisObj = thisObj;
    }

    public SymbolTableClassItem getThisObject() {
        return this.thisObj;
    }

    @Override
    public String getKey() {
        return "m_" + this.name;
        // return this.name;
        //@TODO
    }

    public ArrayList<Type> getArgs() {
        return this.argTypes;
    }

    public String getName() {
        return this.name;
    }
}
