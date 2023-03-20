package bsMain;

import java.util.HashSet;
import java.util.LinkedList;

public class CheckShoppingCartSellerIsRepeat {
	private HashSet CheckBox;
	private boolean IsRepeat;

	public CheckShoppingCartSellerIsRepeat() {
		CheckBox = new HashSet();
	}

	public void AddSellidTOCheckBox(int sellerid) {
		CheckBox.add(sellerid);
	}

	public int CheckSellerIsRepeat() {
		return CheckBox.size();
	}
}
