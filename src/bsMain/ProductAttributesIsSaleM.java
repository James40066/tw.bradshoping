package bsMain;

import java.sql.Connection;
import java.sql.PreparedStatement;

import bsAPI.Sql;

public class ProductAttributesIsSaleM {
	private int id,pid;
	private boolean saleClose,editMode;
	private Sql sql;
	private Connection conn;
	private String url;

	public ProductAttributesIsSaleM(int id, int pid, boolean saleClose, boolean editMode) {
		this.id=id;
		this.pid=pid;
		this.saleClose=saleClose;
		this.editMode=editMode;
		updateIsSale();
	}
	
	private void updateIsSale() {
		try {
			sql = new Sql();
    		conn = sql.conn();
    		PreparedStatement prep = conn.prepareStatement("UPDATE product SET isSale=? WHERE pid=? AND id=?");
    		prep.setInt(1, saleClose?0:1);
    		prep.setInt(2, pid);
    		prep.setInt(3, id);
    		setUrl(prep.executeUpdate());
			conn.close();sql.closeSql();
			
		} catch (Exception e) {
			System.err.println(e.toString()+":ProductAttributesIsSaleM");
			if(conn!=null) {
				try {
					conn.close();sql.closeSql();
				} catch (Exception e2) {}
			}
		}
	}
	
	private void setUrl(int isUpdataOK) {
		if (isUpdataOK!=0) {
			if (editMode) {
				url="productShow.jsp?product="+pid+"&edit=0";
			}else {
				url=saleClose?"seller.jsp":"productShow.jsp?product="+pid;
			}
		}
	}
	
	public String getUrl() {
		return url;
	}
}
