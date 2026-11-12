
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Anime World</title>

    <link rel="stylesheet" href="style.css">

    <style>
        body {
            margin: 0;
            min-height: 100vh;

            background:
                linear-gradient(
                    rgba(0, 0, 0, 0.45),
                    rgba(0, 0, 0, 0.45)
                ),
                url("https://wallpaperaccess.com/full/8956994.jpg");

            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
    </style>
</head>

<body>

    <header>
        <h1>ANIME WORLD</h1>

        <nav>
            <a href="index.jsp">Home</a>
            <a href="register.jsp">Register</a>
            <a href="login.jsp">Login</a>
        </nav>
    </header>

    <main class="hero">
        <h2>Discover your next favourite anime</h2>

        <p>
            Explore anime, save favourites and share your ratings.
        </p>

        <a class="btn" href="login.jsp">Get Started</a>
    </main>

</body>
</html>
