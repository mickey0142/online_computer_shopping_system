<%-- 
    Document   : manageOrder
    Created on : Apr 16, 2018, 1:17:29 PM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>manage order</title>
    </head>
    <body>
        <h1>manage order</h1>
        <sql:query dataSource="comshopdb" var="orderData">
            select * from orders order by orderDate
        </sql:query>
        <table>
            <tr>
                <th>Order Id</th><th>payment Proof</th><th>status</th><th>total Price</th><th>customer Id</th><th>order Date</th><th>update</th>
            </tr>
            <c:forEach var="i" items="${orderData.rows}">
                <tr>
                    <td>${i.orderId}</td><td>${i.paymentProof}</td><td>${i.status}</td><td>${i.totalPrice}</td><td>${i.customerId}</td><td>${i.orderDate}</td>
                    <td><a href="orderDetail.jsp?orderId=${i.orderId}">update</a></td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
