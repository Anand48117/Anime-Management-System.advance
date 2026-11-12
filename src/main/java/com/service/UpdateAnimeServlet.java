
package com.service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.dao.AnimeDAO;
import com.model.Anime;

@WebServlet("/updateAnime")
public class UpdateAnimeServlet extends HttpServlet {

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

		try {
			Anime anime = new Anime();

			anime.setId(Integer.parseInt(request.getParameter("id")));
			anime.setName(request.getParameter("name"));
			anime.setYear(Integer.parseInt(request.getParameter("year")));
			anime.setSeasons(Integer.parseInt(request.getParameter("seasons")));
			anime.setDescription(request.getParameter("description"));
			anime.setRating(Double.parseDouble(request.getParameter("rating")));
			anime.setImageUrl(request.getParameter("imageUrl"));

			AnimeDAO dao = new AnimeDAO();

			boolean status = dao.update(anime);

			if (status) {
				dao.commit();
			} else {
				dao.rollback();
			}

		} catch (NumberFormatException e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid numeric input");
			return;
		}

		response.sendRedirect("getAllAnimes");
	}
}
