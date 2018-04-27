<%-- 
    Document   : manageProduct
    Created on : Apr 15, 2018, 3:26:09 PM
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
        <sql:query dataSource="${applicationScope.datasourceName}" var="product">
            select * from products where productId = '${param.id}'
        </sql:query>
        <%@include file="menu.jsp" %>
        <h1>Update Product</h1>
        <c:forEach var="i" items="${product.rows}">
            <form action="UpdateProduct.emp" method="POST">
                Product id : <input type="text" name="productId" value="${i.productId}" readonly="readonly" /><br>
                Product Name : <input type="text" name="productName" value="${i.productName}" /><br>
                Description : <textarea name="description" rows="8" cols="50">${i.description}</textarea><br>
                In Stock : <input type="text" name="inStock" value="${i.inStock}" /><br>
                Price : <input type="text" name="price" value="${i.price}" /><br>
                <c:if test="${i.productType == 'type1'}">
                    <sql:query dataSource="${applicationScope.datasourceName}" var="producttype1">
                        select * from producttype1 where productId = '${i.productId}'
                    </sql:query>
                    <c:forEach var="j" items="${producttype1.rows}">
                        Power Consumption : <input type="text" name="powerConsumption" value="${j.powerConsumption}" /><br>
                    </c:forEach>
                </c:if>
                <c:if test="${i.productType == 'type2'}">
                    <sql:query dataSource="${applicationScope.datasourceName}" var="producttype2">
                        select * from producttype2 where productId = '${i.productId}'
                    </sql:query>
                    <c:forEach var="j" items="${producttype2.rows}">
                        Power Consumption : <input type="text" name="powerConsumption" value="${j.powerConsumption}" /><br>
                        Compatibility : <input type="text" name="compatibility" value="${j.compatibility}" /><br>
                    </c:forEach>
                </c:if>
                <input type="submit" value="update" />
            </form>
            <form action="InsertPicture?id=${i.productId}&table=updateProduct" method="POST" enctype="multipart/form-data">
                Insert picture : <input type="file" name="picture" />
            </form>
        </c:forEach>
    </body>
</html>
