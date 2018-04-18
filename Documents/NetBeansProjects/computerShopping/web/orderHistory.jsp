<%-- 
    Document   : orderHistory
    Created on : Apr 13, 2018, 6:27:23 PM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>order history</title>
    </head>
    <body>
        <%@include file="menu.jsp" %>
        <h1>Order history</h1>
        <sql:query dataSource="mysql" var="data">
            select * from orders where customerId = ${sessionScope.userInfo.getId()}
        </sql:query>
        <c:forEach var="i" items="${data.rows}">
            <h2>orderid : ${i.orderId} <br>
            paymentproof : ${i.paymentProof} status : ${i.status} totalprice : ${i.totalPrice} orderdate : ${i.orderDate}</h2>
            <sql:query dataSource="mysql" var="detail">
                select * from orderdetails where orderId = ${i.orderId}
            </sql:query>
            <c:forEach var="j" items="${detail.rows}">
                Product Id : ${j.productId} Quantity : ${j.quantity} price : ${j.price}<br>
            </c:forEach>
            <br><br>
        </c:forEach>
    </body>
</html>
