<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.model.User" %>
<% if(session.getAttribute("role")==null || !"ADMIN".equals(session.getAttribute("role"))){response.sendRedirect("login.jsp");return;} %>
<!DOCTYPE html><html><head><title>Users</title><link rel="stylesheet" href="style.css"></head><body>
<header><h1>ANIME WORLD - ADMIN</h1><nav><a href="anime">Manage Anime</a><a href="users">View Users</a><a href="logout">Logout</a></nav></header>
<main class="wide"><h2>Registered Users</h2><table><tr><th>ID</th><th>Name</th><th>Email</th><th>Mobile</th><th>Role</th></tr>
<% List<User> users=(List<User>)request.getAttribute("users"); if(users!=null) for(User u:users){ %>
<tr><td><%=u.getId()%></td><td><%=u.getName()%></td><td><%=u.getEmail()%></td><td><%=u.getMobile()%></td><td><%=u.getRole()%></td></tr><% } %>
</table></main></body></html>
