<%-- 
    Document   : register
    Created on : Apr 9, 2018, 11:09:47 AM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>register</title>
    </head>
    <body>
        <c:if test="${sessionScope.message != ''}">
            <script>
                alert("${sessionScope.message}");
            </script>
        </c:if>
        <h1>Register</h1>
        <%@include file="menu.jsp" %><br>
        <form action="RegisterServlet" method="POST">
            first name : <input type="text" name="firstname" value="" size="30" /><br>
            last name : <input type="text" name="lastname" value="" size="30" /><br>
            username : <input type="text" name="username" value="" size="30" /><br>
            password : <input type="text" name="password" value="" size="30" /><br>
            phone number : <input type="text" name="phone" value="" size="30" /><br>
            email : <input type="text" name="email" value="" size="30" /><br>
            address : <input type="text" name="address" value="" size="30" /><br>
            <input type="submit" value="register" />
        </form>
        <% session.setAttribute("message", "");%>
    </body>
</html>
