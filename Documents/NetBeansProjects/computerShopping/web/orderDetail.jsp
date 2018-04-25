<%-- 
    Document   : orderDetail
    Created on : Apr 16, 2018, 2:13:17 PM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>order detail</title>
    </head>
    <body>
        <%@include file="menu.jsp" %>
        <h1>order detail</h1>
        <sql:query dataSource="${applicationScope.datasourceName}" var="orderData">
            select * from orders join customers using(customerId) where orderId = ${param.orderId}
        </sql:query>
        <sql:query dataSource="${applicationScope.datasourceName}" var="orderDetail">
            select * from orders join orderdetails using(orderId) join products using(productId) where orderId = ${param.orderId}
        </sql:query>
        <c:forEach var="i"  items="${orderData.rows}">
            order Id : ${i.orderId}<br>
            payment Proof : <img src="ShowPicture?id=${i.orderId}"/><br>
            Status : ${i.status}<br>
            Total Price : ${i.totalPrice}<br>
            Customer Id : ${i.customerId}<br>
            Customer name : ${i.firstname} ${i.lastname}<br>
            Order Date : ${i.orderDate}<br>
            <c:forEach var="j" items="${orderDetail.rows}">
                Product Id : ${j.productId} Product Name : ${j.productName} Quantity : ${j.quantity} Price : ${j.price}<br>
            </c:forEach>
            <form action="UpdateOrder.emp" method="POST">
                update status : <select name="status">
                    <option>not paid</option>
                    <option>paid</option>
                    <option>shipping</option>
                    <option>cancelled</option>
                </select>
                <c:set scope="session" var="orderId" value="${i.orderId}" />
                <input type="submit" value="update" />
            </form>
        </c:forEach>
    </body>
</html>
