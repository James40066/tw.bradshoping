package bsMain;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.LinkedList;

import bsAPI.ParseJSON;
import bsAPI.Sql;
import bsAPI.WherePost;

public class ProductDataM {
	private HashMap<String, Object> datas;
	private Boolean isEditMode;
	
	public ProductDataM(String pid) {
		this(pid,-1,1);
		datas.put("openEditMode", false);
	}
	public ProductDataM(String pid, int id) {
		this(pid,id,0);
		datas.put("openEditMode", true);
	}
	
	public ProductDataM(String pid, int id, int isSale) {
		datas = new HashMap();
		Sql sql = null;
		Connection conn =null;
		PreparedStatement selectProduct = null;
		CallableStatement call = null;
		try {
			sql = new Sql();
			conn = sql.conn();
			if (id==-1) {
				call = conn.prepareCall("{call getProductData(?,?)}");
				isEditMode = false;
			}else {
				call = conn.prepareCall("{call getProductDataEdit(?,?,?)}");
				call.setInt(3, id);

				isEditMode = true;
			}
			call.setInt(1, Integer.parseInt(pid));
			call.setInt(2, isSale);
			
			ResultSet rs = call.executeQuery();
			if (rs.next()) {
				datas.put("pid", rs.getInt("pid"));
				datas.put("pname",rs.getString("pname"));
				datas.put("pprice",rs.getInt("pprice"));
				datas.put("pquantity",rs.getInt("pquantity"));
				datas.put("pbrand",rs.getString("pbrand"));
				datas.put("wherePost",Integer.parseInt(rs.getString("wherePost"))-1);
				datas.put("addFormat",rs.getString("addFormat").equals("null")?null:new ParseJSON().getFormatDatas(rs.getString("addFormat")));
				datas.put("pdetail",rs.getString("pdetail"));
				datas.put("special",rs.getInt("special"));
				datas.put("storeName",rs.getString("storeName"));
				
				LinkedList<String> photos = new LinkedList();
				selectProduct = conn.prepareStatement("SELECT big FROM productphoto WHERE pid=? ORDER BY defaultPic DESC");
				selectProduct.setInt(1, Integer.parseInt(pid));
				rs = selectProduct.executeQuery();
				while (rs.next()) {
					photos.add(rs.getString("big"));
				}
				datas.put("photoPath", photos.isEmpty()?null:photos);
				
			}else {
				datas.put("isEditMode", isEditMode);
			}
			
			conn.close();
			sql.closeSql();
			
		} catch (Exception e) {
			System.out.println(e.toString()+":productData");
			if (conn!=null) {
				try {
					conn.close();
					sql.closeSql();
				} catch (Exception e2) {}
			}
		}
	}
	
	public HashMap<String, Object> getData() {
		return datas;
	}
}
