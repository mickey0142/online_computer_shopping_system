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
        <sql:query dataSource="mysql" var="product">
            select * from products where productId = '${param.name}'
        </sql:query>
        <h1>Manage Product</h1>
        <c:forEach var="i" items="${product.rows}">
            <form action="ManageProduct.emp" method="POST">
                Product id : <input type="text" name="productId" value="${i.productName}" readonly="readonly" /><br>
                Product Name : <input type="text" name="productName" value="" /><br>
                Description : <input type="text" name="Description" value="" /><br>
                In Stock : <input type="text" name="inStock" value="" /><br>
                Price : <input type="text" name="price" value="" /><br>
                <c:if test="${i.productType == 'type1'}">
                    <sql:query dataSource="mysql" var="producttype1">
                        select * from producttype1 where productId = '${i.productId}'
                    </sql:query>
                    <c:forEach var="j" items="${producttype1.rows}">
                        Power Consumption : <input type="text" name="powerConsumption" value="" /><br>
                    </c:forEach>
                </c:if>
                <c:if test="${i.productType == 'type2'}">
                    <sql:query dataSource="mysql" var="producttype2">
                        select * from producttype2 where productId = '${i.productId}'
                    </sql:query>
                    <c:forEach var="j" items="${producttype2.rows}">
                        Power Consumption : <input type="text" name="powerConsumption" value="" /><br>
                        Compatibility : <input type="text" name="compatibility" value="" /><br>
                    </c:forEach>
                </c:if>
                <input type="submit" value="update" />
            </form>
        </c:forEach>
    </body>
</html>
