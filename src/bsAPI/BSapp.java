package bsAPI;

import javax.servlet.http.HttpServletRequest;

public class BSapp {

	private static boolean isApp(HttpServletRequest request) {
		return request.getHeader("User-Agent").contains("frombsapp");
	}
	public static boolean isUseApp(HttpServletRequest request) {
		return isApp(request);
	}
}
