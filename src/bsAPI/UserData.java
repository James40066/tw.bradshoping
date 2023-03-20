package bsAPI;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.MissingFormatWidthException;

import org.json.JSONObject;

public class UserData {

	private HashMap<String, Object> member;
	private ResultSet rs;
	private String json;
	private int loginFrom;
	public static final int NORMAL = 0;
	public static final int GOOGLE = 1;
	public static final int FACEBOOK = 2;
	public static final int APP = 3;

	public UserData(String json) {
		this.json = json;
		createAPPMember();
	}

	public UserData(ResultSet rs) {
		this(rs, 0);
	}

	public UserData(ResultSet rs, int loginFrom) throws ArrayIndexOutOfBoundsException {
		if (loginFrom < 0 || loginFrom > 3) {
			System.err.println("loginFrom:超過範圍");
			throw new ArrayIndexOutOfBoundsException();
		} else {
			this.rs = rs;
			this.loginFrom = loginFrom;
			createMember();
		}
	}

	public HashMap<String, Object> getMember() {
		return member;
	}

	private void createMember() {
		member = new HashMap<String, Object>();
		try {
			member.put("name", rs.getString("name"));
			member.put("birthday", rs.getString("birthday"));
			member.put("account", rs.getString("account"));
			member.put("id", rs.getInt("id"));
			member.put("gender", rs.getInt("gender"));

			String tel = rs.getString("tel");
			member.put("tel", tel != null ? tel : null);
			String address = rs.getString("address");
			member.put("address", address != null ? address : null);

			int isseller = rs.getInt("isseller");
			member.put("isseller", isseller);
			member.put("storeName", isseller != 0 ? rs.getString("storeName") : null);
			member.put("faceAddress", isseller != 0 ? rs.getString("faceAddress") : null);

			// loginFrom
			member.put("loginFrom", loginFrom);
		} catch (SQLException e) {
			System.err.println(e.toString() + ":Member");
		}
	}

	private void createAPPMember() {
		try {
			JSONObject jsonObject = new JSONObject(json);
			member = (HashMap<String, Object>)jsonObject.toMap();
		} catch (Exception e) {
			System.out.println(e.toString() + ":MemberAPP");
		}
	}
}
