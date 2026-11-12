
package com.service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.dao.AnimeDAO;

@WebServlet("/getAllAnimes")
public class GetAllAnimeServlet extends HttpServlet {

	private boolean isAdmin(HttpSession session) {
		return session != null && "ADMIN".equals(session.getAttribute("role"));
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (!isAdmin(session)) {
			response.sendRedirect("login.jsp");
			return;
		}

		AnimeDAO dao = new AnimeDAO();

		String action = request.getParameter("action");

		// Load individual anime for editing
		if ("edit".equals(action)) {

			String idParam = request.getParameter("id");

			if (idParam == null || idParam.isBlank()) {
				response.sendRedirect("getAllAnimes");
				return;
			}

			request.setAttribute("anime", dao.getById(Integer.parseInt(idParam)));

			request.getRequestDispatcher("anime-form.jsp").forward(request, response);

			return;
		}

		request.setAttribute("animes", dao.getAll());

		request.getRequestDispatcher("admin.jsp").forward(request, response);
	}
}
