package bsAPI;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

public class PwdTest {
	String url=null;
	Sql sql=null;
	Connection conn=null;
	PreparedStatement pr=null;
	
	public PwdTest() {
		sql=new Sql();
		conn=sql.conn();
	}
	//改變密碼有兩種
	public String pcodeCP(String hpw,String pcode,String colName) {
		try {
			pr=conn.prepareStatement("UPDATE member SET password = ? WHERE "+colName+" = ?");
			pr.setString(1, hpw);
			pr.setString(2, pcode);
			pr.executeUpdate();
			closeSql();
		}catch(Exception e) {
			System.out.println(e.toString());
		}
		url="login.jsp";
		return url;
	}
	
	public String memberCP(String hpw,int id,String colName) {
		try {
			pr=conn.prepareStatement("UPDATE member SET password = ? WHERE "+colName+" = ?");
			pr.setString(1,hpw);
			pr.setInt(2, id);
			pr.executeUpdate();
			closeSql();
		}catch(Exception e) {
			System.out.println(e.toString());
		}
		url="buyer.jsp";
		return url;
	}
	public void closeSql() throws SQLException {
		conn.close();
		sql.closeSql();
	}
	

	
}
