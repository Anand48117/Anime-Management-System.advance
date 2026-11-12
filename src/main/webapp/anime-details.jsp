<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.model.Anime,com.model.User"%>

<%
if (session.getAttribute("role") == null || !"USER".equals(session.getAttribute("role"))) {
    response.sendRedirect("login.jsp");
    return;
}

Anime a = (Anime) request.getAttribute("anime");

if (a == null) {
    response.sendRedirect("anime");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Anime Details</title>
    <link rel="stylesheet" href="style.css">

    <style>
        .anime-detail-image {
            width: 250px;
            height: 350px;
            object-fit: cover;
            border-radius: 10px;
            display: block;
            margin: 20px auto;
        }
    </style>
</head>

<body>

    <header>
        <h1>ANIME WORLD</h1>

        <nav>
            <a href="anime">All Anime</a>
            <a href="anime?action=favorites">My Favorites</a>
            <a href="logout">Logout</a>
        </nav>
    </header>

    <div class="panel">

        <h2><%=a.getName()%></h2>

        <!-- Anime Poster -->
        <img
            class="anime-detail-image"
            src="<%=a.getImageUrl() != null && !a.getImageUrl().trim().isEmpty()
                ? a.getImageUrl()
                : request.getContextPath() + "/images/no-image.png"%>"
            alt="<%=a.getName()%>"
            onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/no-image.png';">

        <p>
            <b>Release Year:</b>
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

        <form action="anime" method="post">
            <input type="hidden" name="action" value="favorite">
            <input type="hidden" name="animeId" value="<%=a.getId()%>">

            <button type="submit">Add to Favorites</button>
        </form>

        <h3>Give Your Rating</h3>

        <form action="anime" method="post">
            <input type="hidden" name="action" value="rate">
            <input type="hidden" name="animeId" value="<%=a.getId()%>">

            <label>Your rating (1 to 10)</label>

            <input type="number" name="rating"
                min="1" max="10" step="0.5" required>

            <button type="submit">Submit Rating</button>
        </form>

    </div>

</body>
</html>
