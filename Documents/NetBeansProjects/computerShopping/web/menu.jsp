<%-- 
    Document   : menu
    Created on : Apr 12, 2018, 2:33:31 PM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>menu</title>
    </head>
    <body>
        <a href="index.jsp">index</a> | 
        <c:if test="${!sessionScope.loginFlag || sessionScope.loginFlag == null}">
            <a href="login.jsp">login</a> | <a href="register.jsp">register</a> 
        </c:if>
        <c:if test="${sessionScope.loginFlag}">
            <a href="orderHistory.jsp">order history</a> | <a href="manageCart.jsp">manage cart</a> | <a href="LogoutServlet">logout</a>
        </c:if>
    </body>
</html>
