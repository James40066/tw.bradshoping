package bsAPI;

public class getname {

	public static void main(String[] args) {
		String pwd = "$2a$10$I3vx1tCVNVMvB.vAzl3Wc.Lhf4pJnegNqhOhLmsLZQIQrSHQrjxJ.";
		PwdHash.checkPwd(pwd, pwd);
        System.out.println("OK");
	}

}
