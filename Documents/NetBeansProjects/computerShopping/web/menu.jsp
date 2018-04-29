<%-- 
    Document   : menu
    Created on : Apr 12, 2018, 2:33:31 PM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <title>menu</title>
        <link rel="stylesheet" href="contact.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=IBM+Plex+Sans|Pridi" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/solid.css" integrity="sha384-v2Tw72dyUXeU3y4aM2Y0tBJQkGfplr39mxZqlTBDUZAb9BGoC40+rdFCG0m10lXk" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/fontawesome.css" integrity="sha384-q3jl8XQu1OpdLgGFvNRnPdj5VIlCvgsDQTQB6owSOHWlAurxul7f+JpUOVdAiJ5P" crossorigin="anonymous">
    </head>
    <body>
        <a href="index.jsp">index</a> | <a href="shoppingPage.jsp">shopping</a> | <a href="spec.jsp">spec</a> | 
        <c:if test="${!sessionScope.loginFlag || sessionScope.loginFlag == null}">
            <a href="login.jsp">login</a> | <a href="register.jsp">register</a>
        </c:if>
        <c:if test="${sessionScope.loginFlag}">
            <!--if user is employee-->
            <c:if test="${sessionScope.isEmp != null}">
                <!--if user is accounting or assemble employee-->
                <c:if test="${sessionScope.userInfo.getEmployeeType() == 'accounting' or sessionScope.userInfo.getEmployeeType() == 'assemble'}">
                    <a href="manageOrder.jsp">manage order</a>
                </c:if>
                <!--if user is warehouse employee-->
                <c:if test="${sessionScope.userInfo.getEmployeeType() == 'warehouse'}">
                    <a href="manageProduct.jsp">manage product</a>
                </c:if>
            </c:if>
            <!--if user is not employee-->
            <c:if test="${sessionScope.isEmp == null}">
                <a href="orderHistory.jsp">order history</a> | <a href="manageCart.jsp">manage cart</a>
            </c:if>
             | <a href="LogoutServlet">logout</a>
        </c:if>
    </body>
</html>
