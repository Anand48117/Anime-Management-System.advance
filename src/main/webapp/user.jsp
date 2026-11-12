<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.model.Anime,com.model.User"%>

<%
if (session.getAttribute("role") == null || !"USER".equals(session.getAttribute("role"))) {
	response.sendRedirect("login.jsp");
	return;
}
User current = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
<title>Anime Catalogue</title>
<link rel="stylesheet" href="style.css">

<style>
.anime-card {
	overflow: hidden;
}

.anime-image {
	width: 100%;
	height: 250px;
	object-fit: cover;
	border-radius: 8px;
}
</style>
</head>

<body>
	<header>
		<h1>ANIME WORLD</h1>
		<nav>
			<a href="anime">All Anime</a> <a href="anime?action=favorites">My
				Favorites</a> <span>Welcome, <%=current.getName()%></span> <a
				href="logout">Logout</a>
		</nav>
	</header>

	<main class="wide">
		<h2>Explore Anime</h2>

		<div class="cards">
			<%
			List<Anime> list = (List<Anime>) request.getAttribute("animes");

			if (list != null && !list.isEmpty()) {
				for (Anime a : list) {
			%>

			<div class="anime-card">

				<!-- Anime Image -->
				<img class="anime-image"
					src="<%=a.getImageUrl() != null && !a.getImageUrl().trim().isEmpty() ? a.getImageUrl()
		: request.getContextPath() + "/images/no-image.png"%>"
					alt="<%=a.getName()%>"
					onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/no-image.png';">

				<h3><%=a.getName()%></h3>
				<p>
					<b>Year:</b>
					<%=a.getYear()%>
				</p>

				<p>
					<b>Seasons:</b>
					<%=a.getSeasons()%>
				</p>

				<p>
					<b>Rating:</b>
					<%=a.getRating()%>/10
				</p>

				<p><%=a.getDescription()%></p>

				<a class="btn" href="anime?action=detail&id=<%=a.getId()%>">
					View Details </a>

			</div>

			<%
			}
			} else {
			%>

			<p>No anime available.</p>

			<%
			}
			%>
		</div>
	</main>
</body>
</html>
