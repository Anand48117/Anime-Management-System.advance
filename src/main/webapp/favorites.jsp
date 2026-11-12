<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.model.Anime"%>
<%
if (session.getAttribute("role") == null || !"USER".equals(session.getAttribute("role"))) {
	response.sendRedirect("login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>My Favorites</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<header>
		<h1>ANIME WORLD</h1>
		<nav>
			<a href="anime">All Anime</a><a href="anime?action=favorites">My
				Favorites</a><a href="logout">Logout</a>
		</nav>
	</header>
	<main class="wide">
		<h2>My Favourite Anime</h2>
		<div class="cards">
			<%
			List<Anime> list = (List<Anime>) request.getAttribute("animes");
			if (list != null)
				for (Anime a : list) {
			%>
			<div class="anime-card">
				<h3><%=a.getName()%></h3>
				<p><%=a.getYear()%>
					|
					<%=a.getSeasons()%>
					seasons
				</p>
				<p><%=a.getDescription()%></p>
				<a class="btn" href="anime?action=detail&id=<%=a.getId()%>">View
					Details</a>
			</div>
			<%
			}
			%>
		</div>
	</main>
</body>
</html>
