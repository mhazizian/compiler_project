package symbolTable;

import ast.Type.Type;

public abstract class SymbolTableItem {
	protected String name;
	protected String itemType;

	public SymbolTableItem() {
	}

	public String getItemType() {
		return this.itemType;
	}

	public abstract String getKey();

}