<%-- 
    Document   : login
    Created on : Apr 11, 2018, 10:54:12 AM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <h1>Login</h1>
        <%@include file="menu.jsp" %><br>
        ${sessionScope.message}
        <form action="LoginServlet" method="POST">
            Username : <input type="text" name="username" value="" size="20" /><br>
            Password : <input type="password" name="password" value="" size="20" /><br>
            <input type="submit" value="login" />
        </form>
        <% session.setAttribute("message", ""); %>
    </body>
</html>
