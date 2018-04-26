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
        <%@include file="menu.jsp" %>
        <h1>Manage Product</h1>
        <sql:query dataSource="${applicationScope.datasourceName}" var="product">
            select * from products
        </sql:query>
        <form action="deleteProduct.emp" method="POST" id="deleteProduct">
            <input type="hidden" name="deleteId" value="test" id="deleteId"/>
        </form>
        <table>
            <tr>
                <th>Product Id</th><th>Product Name</th><th>Price</th><th>In Stock</th><th>update</th><th>delete</th>
            </tr>

            <c:forEach var="i" items="${product.rows}">
                <tr>
                    <td>${i.productId}</td><td>${i.productName}</td><td>${i.inStock}</td><td>${i.price}</td><td><a href="updateProduct.jsp?id=${i.productId}">update</a></td>
                    <td><a href="#" onclick="deleteConfirm(${i.productId})">delete</a></td>
                </tr>
            </c:forEach>
        </table>

        <a href="addProduct.jsp">add product</a>

        <!--java script-->
        <script>
            function deleteConfirm(productId)
            {
                if (confirm("Are you sure?"))
                {
                    document.getElementById("deleteId").value = productId;
                    document.getElementById("deleteProduct").submit();
                }
                else
                {
                    
                }
            }
        </script>
    </body>
</html>
