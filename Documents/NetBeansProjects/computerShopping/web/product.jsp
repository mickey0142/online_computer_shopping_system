<%-- 
    Document   : product
    Created on : Apr 11, 2018, 1:08:56 PM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>product</title>
    </head>
    <body>
        <%@include file="menu.jsp" %><br>
        <h1>Product !</h1>
        <sql:query dataSource="comshopdb" var="product">
            select * from products where productId = "${param.id}"
        </sql:query>
        <c:forEach var="i" items="${product.rows}">
            Product Id : ${i.productId}<br>
            Product Name : ${i.productName}<br>
            Description : ${i.description}<br>
            Price : ${i.price}<br>
            <c:if test="${i.instock <= 0}">
                Out of Stock !!
            </c:if>
            <!-- check if to query for more data if product is not normal type -->
            <c:if test="${i.instock > 0}">
                <a href="addToCart.in?productId=${i.productId}">
                    <div style="display: inline-block; width: 100px; height: 100px; background-color: lightblue">
                        add to cart
                    </div>
                </a>
            </c:if>
        </c:forEach>
        <br>
        <%@include file="showCart.jsp" %>
    </body>
</html>
