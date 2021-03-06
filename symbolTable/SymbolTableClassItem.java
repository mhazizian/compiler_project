package symbolTable;

import ast.Type.Type;
import java.util.*;

public class SymbolTableClassItem extends SymbolTableItem {

    SymbolTableClassItem parent;
    public HashMap<String, SymbolTableItem> items;

    public SymbolTableClassItem(String name) {
        this.name = name;
        this.items = new HashMap<String, SymbolTableItem>();
    }

    public SymbolTableClassItem(String name, SymbolTableClassItem newParent) {
        this.name = name;
        this.parent = newParent;
        this.items = new HashMap<String, SymbolTableItem>();
    }

    public boolean hasItem(SymbolTableItem item) {
        if(items.containsKey(item.getKey()))
            return true;

        if (this.parent == null)
            return false;

        return this.parent.hasItem(item);
    }

    public void put(SymbolTableItem item) throws ItemAlreadyExistsException {

        if(this.hasItem(item))
            throw new ItemAlreadyExistsException();
        items.put(item.getKey(), item);
    }

    public SymbolTableItem get(String key) throws ItemNotFoundException {
        SymbolTableItem value = items.get(key);
        if(value == null && parent != null)
            return parent.get(key);
        else if(value == null)
            throw new ItemNotFoundException();
        else
            return value;
    }


    public SymbolTableClassItem getPreSymbolTableClassItem() {
        return parent;
    }

    public void setParent(SymbolTableClassItem newParent) {
        this.parent = newParent;
    }

    public boolean hasParent(String parentName) {
        if (this.name.equals(parentName))
            return true;
        if (this.parent == null)
            return false;
        return this.parent.hasParent(parentName);
    }

    public void addSubItemsToSymbolTable() {
        if (this.parent != null)
            this.parent.addSubItemsToSymbolTable();

        Iterator it = this.items.entrySet().iterator();    
        while (it.hasNext()) {

            Map.Entry pair = (Map.Entry)it.next();
            try {
                SymbolTable.top.put((SymbolTableItem)pair.getValue());
            } catch (ItemAlreadyExistsException e) {
            }
            // it.remove();
        }
    }
    

    @Override
    public String getKey() {
        return "c_" + this.name;
    }

    @Override
    public String getName() {
        return this.name;
    }
    @Override
    public SymbolTableItemType getItemType() {
        return SymbolTableItemType.classType;
    }
}
