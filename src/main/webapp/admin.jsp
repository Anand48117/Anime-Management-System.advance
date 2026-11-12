
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.model.Anime"%>

<%
if (session.getAttribute("role") == null || !"ADMIN".equals(session.getAttribute("role"))) {
	response.sendRedirect("login.jsp");
	return;
}

List<Anime> list = (List<Anime>) request.getAttribute("animes");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Anime World</title>
<link rel="stylesheet" href="style.css">

<style>
.anime-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
	gap: 25px;
	margin-top: 30px;
}

.anime-card {
	background: #1e1e2f;
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
	transition: transform 0.3s, box-shadow 0.3s;
	color: white;
}

.anime-card:hover {
	transform: translateY(-7px);
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5);
}

.anime-card img {
	width: 100%;
	height: 300px;
	object-fit: cover;
	display: block;
}

.anime-info {
	padding: 18px;
}

.anime-info h3 {
	margin: 0 0 10px;
	font-size: 21px;
}

.anime-meta {
	display: flex;
	justify-content: space-between;
	color: #bbb;
	font-size: 14px;
	margin-bottom: 12px;
}

.anime-description {
	font-size: 14px;
	line-height: 1.5;
	color: #ddd;
	min-height: 63px;
}

.anime-rating {
	color: #ffc107;
	font-weight: bold;
	font-size: 17px;
	margin: 12px 0;
}

.anime-actions {
	display: flex;
	align-items: center;
	gap: 12px;
	margin-top: 15px;
}

.anime-actions a, .anime-actions button {
	flex: 1;
	text-align: center;
	padding: 9px;
	border: none;
	border-radius: 6px;
	text-decoration: none;
	cursor: pointer;
	font-size: 14px;
}

.edit-btn {
	background: #3498db;
	color: white;
}

.delete-btn {
	background: #e74c3c;
	color: white;
}

.anime-actions form {
	flex: 1;
	margin: 0;
}

.anime-actions button {
	width: 100%;
}

.no-anime {
	text-align: center;
	color: #bbb;
	padding: 40px;
	grid-column: 1/-1;
}

@media ( max-width : 600px) {
	.anime-grid {
		grid-template-columns: 1fr;
	}
}
</style>
</head>

<body>

	<header>
		<h1>ANIME WORLD - ADMIN</h1>

		<nav>
			<a href="anime">Manage Anime</a> <a href="users">View Users</a> <a
				href="logout">Logout</a>
		</nav>
	</header>

	<main class="wide">

		<div class="topline">
			<h2>Manage Anime</h2>
			<a class="btn" href="anime-form.jsp">+ Add Anime</a>
		</div>

		<div class="anime-grid">

			<%
			if (list != null && !list.isEmpty()) {
				for (Anime a : list) {
			%>

			<div class="anime-card">

				<img src="<%=a.getImageUrl()%>" alt="<%=a.getName()%>"
					onerror="this.src='https://placehold.co/300x400?text=No+Image'">

				<div class="anime-info">

					<h3><%=a.getName()%></h3>

					<div class="anime-meta">
						<span>📅 <%=a.getYear()%></span> <span>📺 <%=a.getSeasons()%>
							Seasons
						</span>
					</div>

					<p class="anime-description">
						<%=a.getDescription()%>
					</p>

					<div class="anime-rating">
						⭐
						<%=a.getRating()%>
						/ 10
					</div>

					<div class="anime-actions">

						<a class="edit-btn"
							href="getAllAnimes?action=edit&id=<%=a.getId()%>"> Edit </a>

						<form action="deleteAnime" method="post"
							onsubmit="return confirm('Delete this anime?');">

							<input type="hidden" name="id" value="<%=a.getId()%>">

							<button class="delete-btn" type="submit">Delete</button>

						</form>

					</div>

				</div>

			</div>

			<%
			}
			} else {
			%>

			<div class="no-anime">
				<h3>No Anime Found!</h3>
				<p>Click Add Anime to add your first anime.</p>
			</div>

			<%
			}
			%>
		</div>
	</main>
</body>
</html>