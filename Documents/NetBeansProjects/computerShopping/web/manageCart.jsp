<%-- 
    Document   : manageCart
    Created on : Apr 12, 2018, 2:49:02 PM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <title>ตะกร้าสินค้า</title>
        <link rel="stylesheet" href="cart.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=IBM+Plex+Sans|Pridi" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/solid.css" integrity="sha384-v2Tw72dyUXeU3y4aM2Y0tBJQkGfplr39mxZqlTBDUZAb9BGoC40+rdFCG0m10lXk" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/fontawesome.css" integrity="sha384-q3jl8XQu1OpdLgGFvNRnPdj5VIlCvgsDQTQB6owSOHWlAurxul7f+JpUOVdAiJ5P" crossorigin="anonymous">
    </head>
    <body>
        <%@include file="menu.jsp" %>
        <div class="container cart-navigation" id="body" style="margin-top: 144px">
            <div class="row margin-cart">
                <div class="col-md-8">
                    <div class="panel panel-defualt">
                        <div class="panel-heading text-left cart-navigation2">
                            <span>สินค้าในตะกร้า</span>
                        </div>
                    </div>
                    <div class="table-response">
                        <form action="ManageCart.in" method="POST">
                            <table class="table table-hover table-striped">
                                <thead>
                                    <tr>
                                        <th class="text-center">รูปสินค้า</th>
                                        <th class="text-center">ชื่อสินค้า</th>
                                        <th class="text-center">ราคา</th>
                                        <th class="text-center">จำนวน</th>
                                        <th class="text-center">ลบ</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="totalPrice" scope="page" value="0"/>
                                    <c:set var="index" value="0"/>
                                    <c:forEach var="i" items="${sessionScope.order.getProductList()}">
                                        <tr>
                                            <td class="text-center">${i.getProduct().getId()}</td>
                                            <td class="text-center">${i.getProduct().getName()}</td>
                                            <td class="text-center">${i.getProduct().getPrice()}</td>
                                            <td class="text-center">${i.getQuantity()}</td>
                                            <td class="text-center"><input type="submit" value="ลบ" name="button${index}" /></td>
                                        </tr>
                                        <c:set var="totalPrice" scope="page" value="${totalPrice + i.getProduct().getPrice() * i.getQuantity()}"/>
                                        <c:set var="index" value="${index + 1}"/>
                                    </c:forEach>
                                    <jsp:useBean id="order" scope="session" class="model.Orders"/>
                                    <jsp:setProperty name="order" property="totalPrice" value="${totalPrice}"/>
                                </tbody>
                            </table>
                        </form> 
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="panel panel-defualt">
                        <div class="panel-heading text-left">
                            <strong>ข้อมูลการสั่งซื้อ</strong>
                        </div>
                        <div class="panel-body f14 text-left">
                            <table>
                                <tbody>
                                    <tr>
                                        <td>รวมทั้งหมด</td> <td>${totalPrice}</td>
                                    </tr>
                                    <tr>
                                        <td>ราคาสุธิที่ต้องชำระ</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row margin-cart">
                <div class="col-md-8 text-right">
                    <a href="index.jsp" class="btn btn-primary btn-md cart-link" role="button">
                        <i class="fas fa-angle-left"></i>เลือกสินค้าต่อ
                    </a>
                    <a href="confirmPurchase.jsp" class="btn btn-primary btn-md cart-link" role="button">
                        ชำระสินค้า<i class="fas fa-angle-right"></i>
                    </a>
                </div>
            </div>
        </div>

        <!--Java Script-->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script
            src="https://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"></script>
    </body>
</html>
