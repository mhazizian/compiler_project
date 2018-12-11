package symbolTable;

import ast.Type.Type;

import java.util.ArrayList;
import symbolTable.SymbolTableClassItem;

public class SymbolTableMethodItem extends SymbolTableItem {

    ArrayList<Type> argTypes = new ArrayList<>();
    Type returnType;
    SymbolTableClassItem thisObj;

    public SymbolTableMethodItem(String name, ArrayList<Type> argTypes, Type returnType) {
        this.name = name;
        this.argTypes = argTypes;
        this.returnType = returnType;
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

    @Override
    public String getItemType() {
        return "method";
    }


    public Type getReturnType() {
        return this.returnType;
    }

    public ArrayList<Type> getArgs() {
        return this.argTypes;
    }

    public String getName() {
        return this.name;
    }
}
