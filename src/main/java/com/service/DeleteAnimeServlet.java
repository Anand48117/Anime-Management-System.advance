
package com.service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.dao.AnimeDAO;

@WebServlet("/deleteAnime")
public class DeleteAnimeServlet extends HttpServlet {

	private boolean isAdmin(HttpSession session) {
		return session != null && "ADMIN".equals(session.getAttribute("role"));
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (!isAdmin(session)) {
			response.sendRedirect("login.jsp");
			return;
		}

		String idParam = request.getParameter("id");

		if (idParam == null || idParam.isBlank()) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Anime ID is required");
			return;
		}

		try {
			int id = Integer.parseInt(idParam);

			AnimeDAO dao = new AnimeDAO();

			dao.delete(id);
			dao.commit();

		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid anime ID");
			return;
		}

		response.sendRedirect("getAllAnimes");
	}
}
