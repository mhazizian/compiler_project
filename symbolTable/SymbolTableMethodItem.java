package symbolTable;

import ast.Type.Type;

import java.util.ArrayList;
import symbolTable.SymbolTableClassItem;

public class SymbolTableMethodItem extends SymbolTableItem {

    ArrayList<Type> argTypes = new ArrayList<>();
    SymbolTableClassItem this_obj;

    public SymbolTableMethodItem(String name, ArrayList<Type> argTypes) {
        this.name = name;
        this.argTypes = argTypes;
    }

    public void setThisObject(SymbolTableClassItem this_obj) {
        this.this_obj = this_obj;
    }

    public SymbolTableClassItem getThisObject() {
        return this.this_obj;
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
