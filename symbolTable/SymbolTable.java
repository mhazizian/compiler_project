package symbolTable;

import java.util.*;

public class SymbolTable {

	SymbolTable pre;
	public HashMap<String, SymbolTableItem> items;

	// Static members region

	public static SymbolTable top;
	public static int itemIndex = 0;
	public static boolean isValidAst = true;

	private static Stack<SymbolTable> stack = new Stack<SymbolTable>();

	// Use it in pass 1 scope start
	public static void push(SymbolTable symbolTable) {
		if(top != null)
			stack.push(top);
		top = symbolTable;
	}

	// Use it in pass1 scope end
	public static void pop() {
		top = stack.pop();
	}

	// End of static members region

	public SymbolTable() {
		this(null);
	}

	public SymbolTable(SymbolTable pre) {
		this.pre = pre;
		this.items = new HashMap<String, SymbolTableItem>();
	}

	public void put(SymbolTableItem item) throws ItemAlreadyExistsException {
		if(items.containsKey(item.getKey()))
			throw new ItemAlreadyExistsException();
		items.put(item.getKey(), item);
	}

	public SymbolTableItem getInCurrentScope(String key) {
		return items.get(key);
	}

	public SymbolTableItem get(String key) throws ItemNotFoundException {
		SymbolTableItem value = items.get(key);
		if(value == null && pre != null)
			return pre.get(key);
		else if(value == null)
			throw new ItemNotFoundException();
		else
			return value;
	}

	public SymbolTableItem getItem(String name) throws ItemNotFoundException {
		try {
			return this.get("v_" + name);
		} catch (ItemNotFoundException e) {
			try {
				return this.get("m_" + name);
			} catch (ItemNotFoundException e2) {
				try {
					return this.get("c_" + name);
				} catch(ItemNotFoundException e3) {
					return this.get("nt_" + name);
				}
			}
		}
	}

	public Boolean hasItem(String key) {
		try {
			SymbolTableItem value = this.get(key);
			return true;
		} catch (ItemNotFoundException e) {
			return false;
		}
	}

	public SymbolTable getPreSymbolTable() {
		return pre;
	}

	public void printItems() {
		Iterator it = this.items.entrySet().iterator();    
        while (it.hasNext()) {

			Map.Entry pair = (Map.Entry)it.next();
        }
	}
}
