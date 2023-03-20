package bsAPI;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsersProduct {
	private Sql sql = null;
	private Connection conn = null;
	
	private Boolean ckUsersProduct(int userId,String Pid) {
		Boolean isOk=false;
		try {
			sql = new Sql();
			conn = sql.conn();
			PreparedStatement ck = conn.prepareStatement("select id from product where pid = ?");
			ck.setString(1, Pid);
			ResultSet rs= ck.executeQuery();
			rs.next();
			if(rs.getInt("id")==userId){
				isOk = true;
			}else {
				isOk = false;
			}
			conn.close();
			sql.closeSql();
			
			return isOk;
		} catch (Exception e) {
			System.out.println(e.toString());
			if (conn!=null) {
				try {
					conn.close();
					sql.closeSql();
				} catch (SQLException e1) {
					System.out.println(e.toString());
				}
			}
			return isOk;
		}
		
	}
	//PS:修改商品明細，會需要再次確認修改者是否為同一人。
	public Boolean isUsersProduct(int userId,String Pid) {
		return ckUsersProduct(userId, Pid);
	}
}
