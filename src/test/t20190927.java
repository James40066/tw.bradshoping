package test;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Collection;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
@MultipartConfig
@WebServlet("/t20190927")
public class t20190927 extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		String uploadPath = getServletContext().getInitParameter("uploadPath");
		Collection<Part> parts =  request.getParts();
		System.err.println(parts.size());
		Iterator it = parts.iterator();
		while (it.hasNext()) {
			Part part = (Part)it.next();
			String file = uploadPath + "//" + part.getSubmittedFileName();

			BufferedInputStream in = new BufferedInputStream(part.getInputStream());
			byte buf[] = new byte[(int) part.getSize()];
			in.read(buf);
			in.close();
			BufferedOutputStream bout = new BufferedOutputStream(
					new FileOutputStream(new File(uploadPath, part.getSubmittedFileName())));
			bout.write(buf);
			bout.flush();
			bout.close();
		}
		System.out.println("OK");
		response.sendRedirect("t20190926AppMap.jsp");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
