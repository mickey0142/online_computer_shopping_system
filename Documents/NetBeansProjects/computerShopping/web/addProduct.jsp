<%-- 
    Document   : addProduct
    Created on : Apr 21, 2018, 5:21:25 PM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Product</title>
    </head>
    <body>
        <%@include file="menu.jsp" %>
        <h1>Add Product</h1>
        <form action="AddProduct.emp" method="POST">
            Product Id : <input type="text" name="productId" value="" id="productId"/><br>
            Product Name : <input type="text" name="productName" value="" /><br>
            Description : <textarea name="description" rows="8" cols="50"></textarea><br>
            In Stock : <input type="text" name="inStock" value="" /><br>
            Price : <input type="text" name="price" value="" /><br>
            Power Consumption : <input type="text" name="powerConsumption" value="" /><br>
            Compatibility : <input type="text" name="compatibility" value="" /><br>
            <input type="submit" value="add"/><br>
        </form>
    </body>
</html>
