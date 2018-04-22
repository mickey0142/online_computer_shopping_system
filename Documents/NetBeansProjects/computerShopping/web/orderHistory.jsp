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
        <sql:query dataSource="comshopdb" var="data">
            select * from orders where customerId = ${sessionScope.userInfo.getId()}
        </sql:query>
        <c:forEach var="i" items="${data.rows}">
            <div style="border: 1px solid black">
                <h2>orderid : ${i.orderId} <br>
                    payment proof : <img src="ShowPicture?id=${i.orderId}"/> status : ${i.status} totalprice : ${i.totalPrice} orderdate : ${i.orderDate}</h2>
                <sql:query dataSource="comshopdb" var="detail">
                    select * from orderdetails where orderId = ${i.orderId}
                </sql:query>
                <table>
                    <tr>
                        <th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th>
                    </tr>
                    <c:forEach var="j" items="${detail.rows}">
                        <tr>
                            <td>${j.productId}</td><td>${j.productName}</td><td>${j.quantity}</td><td>${j.price}</td>
                        </tr>
                    </c:forEach>
                </table>
                <c:set scope="session" value="orderHistory.jsp" var="back"/>
                <form action="InsertPicture?id=${i.orderId}" method="POST" enctype="multipart/form-data">
                    file : <input type="file" name="picture" <c:if test="${i.status != 'not paid'}">disabled="disabled"</c:if> />
                    <input type="submit" value="upload" <c:if test="${i.status != 'not paid'}">disabled="disabled"</c:if>/>
                </form>
                <form action="CancelOrder.in?id=${i.orderId}" method="POST">
                    <input type="submit" value="cancel order" <c:if test="${i.status == 'cancelled'}">disabled="disabled"</c:if> />
                </form>
            </div>
        </c:forEach>
    </body>
</html>
