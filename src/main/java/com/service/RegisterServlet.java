package com.service;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.dao.UserDAO;
import com.model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		User u = new User();
		u.setName(request.getParameter("name"));
		u.setEmail(request.getParameter("email"));
		u.setPassword(request.getParameter("password"));
		u.setMobile(request.getParameter("mobile"));
		UserDAO dao = new UserDAO();
		boolean status = dao.register(u);
		if (status) {
			dao.commit();
			System.out.println("successful");

			request.setAttribute("message", "Registration successful. Please login.");
		} else {
			System.out.println("failed");
			request.setAttribute("message", "Registration failed. Email may already exist.");
		}
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}
}
