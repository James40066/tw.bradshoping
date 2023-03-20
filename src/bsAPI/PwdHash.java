package bsAPI;

import com.berry.BCrypt;

public class PwdHash {
	
	//PS:將密碼加密，回傳加密後的String
	public static String toHash(String pwd) {
		return createHash(pwd);
	}

	//PS：參數說明(使用者輸入密碼，資料庫加密密碼)
	public static Boolean checkPwd(String pwd, String dataPwd) {
		return ckPwd(pwd, dataPwd);
	}
	
	
	private static String createHash(String str) {
		String pwdHash = BCrypt.hashpw(str, BCrypt.gensalt());
		return pwdHash;
	}
	private static Boolean ckPwd(String str, String dataSrc) {
		boolean isright = false;
		if(dataSrc.startsWith("$2a$10$")){
			isright = BCrypt.checkpw(str, dataSrc);
		}
		return isright;
	}
}
