<%-- 
    Document   : index
    Created on : Apr 9, 2018, 9:26:48 AM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="/WEB-INF/tlds/shortcut" prefix="shortcut" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping</title>
    </head>
    <body>
        <%@include file="menu.jsp" %><br>
        <shortcut:select productId="%"></shortcut:select>
        <c:if test="${sessionScope.loginFlag}">
            <%@include file="showCart.jsp" %>
        </c:if>
    </body>
</html>
