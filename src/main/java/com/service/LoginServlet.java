package com.service;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.dao.UserDAO;
import com.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email"), password = request.getParameter("password");
		HttpSession session = request.getSession();
		if ("admin@anime.com".equals(email) && "admin123".equals(password)) {
			session.setAttribute("role", "ADMIN");
			session.setAttribute("email", email);
			response.sendRedirect("anime");
			return;
		}
		User user = new UserDAO().login(email, password);
		if (user != null) {
			session.setAttribute("user", user);
			session.setAttribute("role", "USER");

			System.out.println("LOGIN SESSION ID: " + session.getId());
			System.out.println("LOGIN USER: " + session.getAttribute("user"));

			session.setAttribute("email", user.getEmail());
			response.sendRedirect("anime");
		} else {
			request.setAttribute("message", "Invalid email or password.");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
}
