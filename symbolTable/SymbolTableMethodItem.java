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
    }

    public void setThisObject(SymbolTableClassItem thisObj) {
        this.thisObj = thisObj;
    }

    public SymbolTableClassItem getThisObject() {
        return this.thisObj;
    }

    @Override
    public String getKey() {
        return this.name;
        //todo
        // return null;
    }

    public ArrayList<Type> getArgs() {
        return this.argTypes;
    }

    public String getName() {
        return this.name;
    }
}
