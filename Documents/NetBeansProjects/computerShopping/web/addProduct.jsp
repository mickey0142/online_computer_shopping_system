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
        <a href="manageOrder.jsp">manage order</a> | <a href="manageProduct.jsp">manage product</a> | <a href="LogoutServlet">log out</a>
        <h1>Add Product</h1>
        <form action="AddProduct.emp" method="POST">
            Product Id : <input type="text" name="productId" value="" /><br>
            Product Name : <input type="text" name="productName" value="" /><br>
            Description : <input type="text" name="description" value="" /><br>
            In Stock : <input type="text" name="inStock" value="" /><br>
            Price : <input type="text" name="price" value="" /><br>
            Power Consumption : <input type="text" name="powerConsumption" value="" /><br>
            Compatibility : <input type="text" name="compatibility" value="" /><br>
            <input type="submit" value="add" />
        </form>
    </body>
</html>