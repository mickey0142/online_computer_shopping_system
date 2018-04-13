<%-- 
    Document   : manageCart
    Created on : Apr 12, 2018, 2:49:02 PM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="menu.jsp" %>
        <h1>Manage cart</h1>
        <div style="display: inline-block; width: 200px; background-color: lightgreen;">
            Your cart<br>
            <c:set var="totalPrice" scope="page" value="0"/>
            <c:set var="index" value="0"/>
            <form action="ManageCart.in" method="POST">
                <c:forEach var="i" items="${sessionScope.order.getProductList()}">
                    ${i.getId()} ${i.getName()} ${i.getPrice()} <input type="submit" value="remove" name="button${index}" /><br>
                    <c:set var="totalPrice" scope="page" value="${totalPrice + i.getPrice()}"/>
                    <c:set var="index" value="${index + 1}"/>
                </c:forEach>
                total : ${totalPrice}
                <jsp:useBean id="order" scope="session" class="model.Orders"/>
                <jsp:setProperty name="order" property="totalPrice" value="${totalPrice}"/>
            </form>
        </div>
            <br>
        <a href="ConfirmPurchase.in">
            <div style="display: inline-block; width: 100px; background-color: coral;">
                Confirm Purchase
            </div>
        </a>
    </body>
</html>
