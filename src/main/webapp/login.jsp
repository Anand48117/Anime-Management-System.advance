
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Anime World</title>
    <link rel="stylesheet" href="style.css">
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

    <div class="panel">

        <h2>Welcome Back!</h2>

        <p style="text-align:center; margin-bottom:20px;">
            Login to explore your favourite anime.
        </p>

        <%
        if (request.getAttribute("message") != null) {
        %>
            <p class="message">
                <%=request.getAttribute("message")%>
            </p>
        <%
        }
        %>

        <form action="login" method="post">

            <label>Email</label>
            <input type="email" name="email"
                   placeholder="Enter your email" required>

            <label>Password</label>
            <input type="password" name="password"
                   placeholder="Enter your password" required>

            <button type="submit">Login</button>

        </form>

        <p style="text-align:center; margin-top:18px;">
            New user?
            <a href="register.jsp">Create account</a>
        </p>

    </div>

</body>
</html>
