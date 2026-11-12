
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.model.Anime"%>

<%
if (session.getAttribute("role") == null || !"ADMIN".equals(session.getAttribute("role"))) {
	response.sendRedirect("login.jsp");
	return;
}

Anime a = (Anime) request.getAttribute("anime");
boolean edit = a != null;
%>

<!DOCTYPE html>
<html>
<head>
<title>Anime Form - Anime World</title>
<link rel="stylesheet" href="style.css">

<style>
.image-preview {
	width: 150px;
	height: 200px;
	object-fit: cover;
	border-radius: 8px;
	margin-top: 10px;
	display: <%=edit && a.getImageUrl() != null && !a.getImageUrl().trim().isEmpty() ? "block" : "none"%>;
}
</style>
</head>

<body>

	<header>
		<h1>ANIME WORLD - ADMIN</h1>

		<nav>
			<a href="getAllAnimes">Manage Anime</a> <a href="users">View
				Users</a> <a href="logout">Logout</a>
		</nav>
	</header>

	<div class="panel">

		<h2><%=edit ? "Update Anime" : "Add Anime"%></h2>

		<!-- Separate servlet for Add and Update -->
		<form action="<%=edit ? "updateAnime" : "addAnime"%>" method="post">

			<%
			if (edit) {
			%>

			<input type="hidden" name="id" value="<%=a.getId()%>">

			<%
			}
			%>

			<label>Anime Name</label> <input type="text" name="name"
				value="<%=edit ? a.getName() : ""%>" required> <label>Release
				Year</label> <input type="number" name="year" min="1900" max="2100"
				value="<%=edit ? a.getYear() : ""%>" required> <label>Number
				of Seasons</label> <input type="number" name="seasons" min="1"
				value="<%=edit ? a.getSeasons() : ""%>" required> <label>Description</label>

			<textarea name="description" rows="5" required><%=edit ? a.getDescription() : ""%></textarea>


			<label>Anime Image URL</label> <input type="url" name="imageUrl"
				id="imageUrl" placeholder="https://example.com/anime.jpg"
				value="<%=edit && a.getImageUrl() != null ? a.getImageUrl() : ""%>"
				required> <img id="imagePreview" class="image-preview"
				src="<%=edit && a.getImageUrl() != null ? a.getImageUrl() : ""%>"
				alt="Anime Image Preview" onerror="this.style.display='none';">


			<label>Rating (0 to 10)</label> <input type="number" name="rating"
				min="0" max="10" step="0.1" value="<%=edit ? a.getRating() : ""%>"
				required>


			<button type="submit">
				<%=edit ? "Update Anime" : "Save Anime"%>
			</button>

		</form>

	</div>


	<script>
		const imageInput = document.getElementById("imageUrl");
		const imagePreview = document.getElementById("imagePreview");

		imageInput.addEventListener("input", function() {

			const url = this.value.trim();

			if (url) {
				imagePreview.src = url;
				imagePreview.style.display = "block";
			} else {
				imagePreview.style.display = "none";
			}

		});
	</script>

</body>
</html>
