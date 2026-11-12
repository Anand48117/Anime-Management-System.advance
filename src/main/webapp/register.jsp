
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Register - Anime World</title>
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

        <h2>Join Anime World!</h2>

        <p style="text-align:center; margin-bottom:20px;">
            Create your account and explore the world of anime.
        </p>

        <form action="register" method="post">

            <label>Name</label>
            <input type="text" name="name"
                   placeholder="Enter your name" required>

            <label>Email</label>
            <input type="email" name="email"
                   placeholder="Enter your email" required>

            <label>Password</label>
            <input type="password" name="password"
                   placeholder="Create a password" required>

            <label>Mobile Number</label>
            <input type="tel" name="mobile"
                   placeholder="Enter 10-digit mobile number"
                   pattern="[0-9]{10}" required>

            <button type="submit">Create Account</button>

        </form>

        <p style="text-align:center; margin-top:18px;">
            Already registered?
            <a href="login.jsp">Login</a>
        </p>

    </div>

</body>
</html>
