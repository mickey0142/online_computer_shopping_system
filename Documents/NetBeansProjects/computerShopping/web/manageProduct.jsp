<%-- 
    Document   : manageProduct
    Created on : Apr 21, 2018, 4:42:19 PM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Product</title>
    </head>
    <body>
        <a href="manageOrder.jsp">manage order</a> | <a href="manageProduct.jsp">manage product</a> | <a href="LogoutServlet">log out</a>
        <h1>Manage Product</h1>
        <sql:query dataSource="comshopdb" var="product">
            select * from products
        </sql:query>
        <table>
            <tr>
                <th>Product Id</th><th>Product Name</th><th>Price</th><th>In Stock</th><th>update</th>
            </tr>
            <c:forEach var="i" items="${product.rows}">
                <tr>
                    <td>${i.productId}</td><td>${i.productName}</td><td>${i.inStock}</td><td>${i.price}</td><td><a href="updateProduct.jsp?name=${i.productId}">update</a></td>
                </tr>
            </c:forEach>
        </table>
        <a href="addProduct.jsp">add product</a>
    </body>
</html>
