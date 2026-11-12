package com.service;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.dao.UserDAO;

@WebServlet("/users")
public class AdminServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession s = request.getSession(false);
		if (s == null || !"ADMIN".equals(s.getAttribute("role"))) {
			response.sendRedirect("login.jsp");
			return;
		}
		request.setAttribute("users", new UserDAO().getAllUsers());
		request.getRequestDispatcher("users.jsp").forward(request, response);
	}
}
