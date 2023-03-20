package bsMain;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class testform
 */
@WebServlet("/testform")
public class testform extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String requestHeader = request.getHeader("user-agent");
		String email = request.getParameter("email");
		System.out.println(requestHeader);
		if (isMobileDevice(requestHeader)) {
			System.out.println("手機瀏覽器" + email);
		} else {
			System.out.println("web瀏覽器");
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

	public static boolean isMobileDevice(String requestHeader) {
		/**
		 * android : 所有android设备 mac os : iphone ipad windows phone:Nokia等windows系统的手机
		 */
		String[] deviceArray = new String[] { "android", "mac os", "windows phone" };
		if (requestHeader == null)
			return false;
		requestHeader = requestHeader.toLowerCase();
		for (int i = 0; i < deviceArray.length; i++) {
			if (requestHeader.indexOf(deviceArray[i]) > 0) {
				System.out.println(deviceArray[i]);
				return true;
			}
		}
		return false;
	}

}
