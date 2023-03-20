package bsMain;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.LinkedList;
import bsAPI.Sql;
import bsAPI.WherePost;

public class SellerProductList {
	private int id;
	private Sql sql;
	private Connection conn;
	private PreparedStatement prep;
	private ResultSet rs;
	private LinkedList<HashMap<String, Object>> lists;

	private void getdata() {
		try {
			lists = new LinkedList<HashMap<String, Object>>();
			sql = new Sql();
			conn = sql.conn();
			prep = conn.prepareStatement("SELECT product.pid,pname,pprice,pquantity,pbrand,wherePost,special,isSale,small FROM product,productphoto WHERE product.pid=productphoto.pid AND productphoto.defaultPic=1 AND product.id=? ORDER BY product.pid");
			prep.setInt(1, id);
			rs = prep.executeQuery();

			addDatas();

			conn.close();
			sql.closeSql();
		} catch (Exception e) {
			System.err.println(e.toString()+":SellerProductList-getdata");
			try {
				if (conn != null) {
					conn.close();
					sql.closeSql();
				}
			} catch (Exception e2) {
			}
		}
	}

	private void addDatas() {
		try {
			while (rs.next()) {
				HashMap<String, Object> data = new HashMap<String, Object>();
				data.put("pid", rs.getInt("pid"));
				data.put("pname", rs.getString("pname"));
				data.put("pprice", rs.getInt("pprice"));
				data.put("pquantity", rs.getInt("pquantity"));
				data.put("pbrand", rs.getString("pbrand"));
				data.put("wherePost", new WherePost().getWherePost(Integer.parseInt(rs.getString("wherePost"))-1));
				data.put("special", rs.getInt("special"));
				data.put("isSale", rs.getInt("isSale")==0?"未開放":"開放");
				data.put("small", rs.getString("small"));
				lists.add(data);
			}
		} catch (Exception e) {
			System.err.println(e.toString()+":SellerProductList-addDatas");
		}
	}

	public LinkedList<HashMap<String, Object>> getLists() {
		getdata();
		return lists;
	}

	public void setId(int id) {
		this.id = id;
	}
}
