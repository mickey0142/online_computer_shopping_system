<%-- 
    Document   : showCart
    Created on : Apr 12, 2018, 2:45:42 PM
    Author     : Mickey
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <title>ตะกร้าสินค้า</title>
        <link rel="stylesheet" href="cart.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=IBM+Plex+Sans|Pridi" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/solid.css" integrity="sha384-v2Tw72dyUXeU3y4aM2Y0tBJQkGfplr39mxZqlTBDUZAb9BGoC40+rdFCG0m10lXk" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/fontawesome.css" integrity="sha384-q3jl8XQu1OpdLgGFvNRnPdj5VIlCvgsDQTQB6owSOHWlAurxul7f+JpUOVdAiJ5P" crossorigin="anonymous">
    </head>
    <body>

        <div >
            <div class="panel panel-defualt">
                <div class="panel-heading text-left cart-navigation2">
                    <span>สินค้าในตะกร้า</span>
                </div>
            </div>
            <div class="table-response">
                <table class="table table-hover table-striped">
                    <thead>
                        <tr>
                            <th class="text-center">ชื่อสินค้า</th>
                            <th class="text-center">จำนวน</th>
                            <th class="text-center">ราคา</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="totalPrice" scope="page" value="0"/>
                        <c:forEach var="i" items="${sessionScope.order.getProductList()}">
                            <tr>
                                <td>${i.getProduct().getName()}</td>
                                <td>${i.getQuantity()}</td>
                                <td>${i.getProduct().getPrice()}</td>
                            </tr>
                            <c:set var="totalPrice" scope="page" value="${totalPrice + i.getProduct().getPrice() * i.getQuantity()}"/>
                        </c:forEach>
                    </tbody>
                </table>
                ราคารวม : ${totalPrice}
            </div>
        </div>
    </body>
</html>
