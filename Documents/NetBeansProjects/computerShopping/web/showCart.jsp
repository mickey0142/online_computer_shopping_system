<%-- 
    Document   : showCart
    Created on : Apr 12, 2018, 2:45:42 PM
    Author     : Mickey
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>your cart</title>
    </head>
    <body>
        <div style="display: inline-block; width: 200px; background-color: lightgreen;">
            Your cart<br>
            <c:set var="totalPrice" scope="page" value="0"/>
            <c:forEach var="i" items="${sessionScope.order.getProductList()}">
                ${i.getProduct().getId()} ${i.getProduct().getName()} ${i.getQuantity()}<br>
                <c:set var="totalPrice" scope="page" value="${totalPrice + i.getProduct().getPrice() * i.getQuantity()}"/>
            </c:forEach>
            total : ${totalPrice}
        </div>
    </body>
</html>
