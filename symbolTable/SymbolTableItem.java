package symbolTable;

import ast.Type.Type;

public abstract class SymbolTableItem {
	protected String name;

	public SymbolTableItem() {}
	public abstract SymbolTableItemType getItemType();
	public abstract String getKey();
	public abstract String getName();
}
