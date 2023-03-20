package bsMain;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collections;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import org.json.JSONObject;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;

import bsAPI.BSapp;
import bsAPI.PwdHash;
import bsAPI.Sql;
import bsAPI.UserData;

//負責所有登入邏輯
@WebServlet("/loginM")
public class loginM extends HttpServlet {
	private HttpServletRequest request;
	private HttpServletResponse response;
	private HttpSession session;
	private Sql sql;
	private Connection conn;
	private String sql1 = null;
	private HashMap<String, Object> loginInfo;
	private PrintWriter out;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.request = request;
		this.response = response;
		this.session = request.getSession();
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String requestHeader = request.getHeader("user-agent");
		out = response.getWriter();
		// 接收參數
		String account = request.getParameter("account");
		String passwd = request.getParameter("password");
		String Gtoken = request.getParameter("Gtoken");
		String FBtoken = request.getParameter("FBtoken");

		// 判斷為哪種登入方式
		if (account != null && passwd != null) {
			// 一般登入丟自訂類別SQL查詢
			selectIdToSQL(UserData.NORMAL, account, null, null, account, passwd);
		} else if (Gtoken != null) {
			// googleGtoken解析
			
			checkIsGoogle(Gtoken);
		} else if (FBtoken != null) {
			// FacebookFBtoken解析
			;
			checkIsFacebook(FBtoken);
		} else {
			response.sendRedirect("login.jsp");
		}
	}

	// googleGtoken解析
	private void checkIsGoogle(String Gtoken) {
		try {
			GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(),
					JacksonFactory.getDefaultInstance())
							.setAudience(Collections.singletonList(
									"1030776440854-8opl3a2kf1enumeurrve0q5r1tr44vh4.apps.googleusercontent.com"))
							.setIssuer("accounts.google.com").build();
			GoogleIdToken idToken = verifier.verify(Gtoken);
			Payload payload = idToken.getPayload();

			String id = payload.getSubject();
			String email = payload.getEmail();
			String name = (String) payload.get("name");
			int type = UserData.GOOGLE;
			// 自訂類別SQL查詢
			selectIdToSQL(type, id, name, email, null, null);
		} catch (Exception e) {
			System.err.println(e.toString());
		}
	}

	// FacebookFBtoken解析
	private void checkIsFacebook(String FBtoken) {
		try {
			// 參數接收解JSON
			JSONObject j = new JSONObject(FBtoken);
			String id = j.getString("id");
			String name = j.getString("name");
			String email = j.getString("email");
			int type = UserData.FACEBOOK;
			// 自訂類別SQL查詢
			selectIdToSQL(type, id, name, email, null, null);
		} catch (Exception e) {
			System.err.println(e.toString());
		}
	}

	// 資料庫查詢
	private void selectIdToSQL(int type, String id, String name, String email, String account, String passwd) {
		try {
			openSQL();
			switch (type) {
			case UserData.NORMAL:
				sql1 = "SELECT * FROM member where account = ?";
				break;
			case UserData.GOOGLE:
				sql1 = "SELECT * FROM member where isgoogle = ?";
				break;
			case UserData.FACEBOOK:
				sql1 = "SELECT * FROM member where isfacebook = ?";
				break;
			}

			PreparedStatement prep1 = conn.prepareStatement(sql1);
			prep1.setString(1, id);
			ResultSet rs = prep1.executeQuery();

			// 資料庫有id=>UserData種member後登入,
			if (rs.next()) {
				// ----第三方登入----
				if (type != UserData.NORMAL) {
					session.setAttribute("member", new UserData(rs, type).getMember());
					response.sendRedirect("index.jsp");
					closeSQL();

				// ----普通登入----
				} else if (PwdHash.checkPwd(passwd, rs.getString("password"))) {
					session.setAttribute("member", new UserData(rs, type).getMember());
					response.sendRedirect("index.jsp");
					closeSQL();
				// 密碼錯誤
				} else {
					tologin();
				}
			// 資料庫沒id=>填寫會員內容再登入
			} else {
				if (type != UserData.NORMAL) {
					setloginInfo(id, email, name, type);
				} else {
					tologin();
				}
			}

		} catch (Exception e) {
			System.err.println(e.toString());
		}
	}

	// 種SESSION(第三方登入用)
	private void setloginInfo(String id, String email, String name, Object type) {
		try {
			loginInfo = new HashMap<String, Object>();
			loginInfo.put("loginId", id);
			loginInfo.put("email", email);
			loginInfo.put("name", name);
			loginInfo.put("logintype", type);
			loginInfo.put("loginFrom", true);
			session.setAttribute("loginInfo", loginInfo);
			response.sendRedirect("registered.jsp");
			closeSQL();
		} catch (IOException e) {
			System.err.println(e.toString());
		}
	}

	private void tologin() {
		try {
			closeSQL();
			response.sendRedirect("login.jsp");
		} catch (Exception e) {
			System.err.println(e.toString());
		}

	}

	private void openSQL() {
		try {
			sql = new Sql();
			conn = sql.conn();
		} catch (Exception e) {
			System.err.println(e.toString());
		}
	}

	private void closeSQL() {
		try {
			sql.closeSql();
			conn.close();
		} catch (Exception e) {
			System.err.println(e.toString());
		}
	}

}
