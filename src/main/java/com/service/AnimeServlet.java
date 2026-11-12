
package com.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.dao.AnimeDAO;
import com.model.User;

@WebServlet("/anime")
public class AnimeServlet extends HttpServlet {

	private boolean isUser(HttpSession session) {
		return session != null && "USER".equals(session.getAttribute("role"));
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (!isUser(session)) {

			if (session != null && "ADMIN".equals(session.getAttribute("role"))) {
				response.sendRedirect("getAllAnimes");
			} else {
				response.sendRedirect("login.jsp");
			}

			return;
		}

		AnimeDAO dao = new AnimeDAO();

		String action = request.getParameter("action");

		if ("detail".equals(action)) {

			int id = Integer.parseInt(request.getParameter("id"));

			request.setAttribute("anime", dao.getById(id));

			request.getRequestDispatcher("anime-details.jsp").forward(request, response);

			return;
		}

		if ("favorites".equals(action)) {

			User user = (User) session.getAttribute("user");

			request.setAttribute("animes", dao.getFavorites(user.getId()));

			request.getRequestDispatcher("favorites.jsp").forward(request, response);

			return;
		}

		request.setAttribute("animes", dao.getAll());

		request.getRequestDispatcher("user.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (!isUser(session)) {
			response.sendRedirect("login.jsp");
			return;
		}

		User user = (User) session.getAttribute("user");

		String action = request.getParameter("action");
		String animeId = request.getParameter("animeId");

		if (animeId == null || animeId.isBlank()) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Anime ID is required");
			return;
		}

		try {
			int id = Integer.parseInt(animeId);

			AnimeDAO dao = new AnimeDAO();

			if ("favorite".equals(action)) {

				boolean status = dao.addFavorite(user.getId(), id);

				if (status) {
					dao.commit();
				} else {
					dao.rollback();
				}

			} else if ("rate".equals(action)) {

				String ratingParam = request.getParameter("rating");

				if (ratingParam != null && !ratingParam.isBlank()) {

					double rating = Double.parseDouble(ratingParam);

					if (rating >= 1 && rating <= 10) {

						boolean status = dao.rate(user.getId(), id, rating);

						if (status) {
							dao.commit();
						} else {
							dao.rollback();
						}
					}
				}
			}

			response.sendRedirect("anime?action=detail&id=" + id);

		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input");
		}
	}
}
