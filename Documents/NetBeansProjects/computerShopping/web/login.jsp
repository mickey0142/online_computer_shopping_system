<%-- 
    Document   : login
    Created on : Apr 11, 2018, 10:54:12 AM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="login.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=IBM+Plex+Sans|Pridi" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/solid.css" integrity="sha384-v2Tw72dyUXeU3y4aM2Y0tBJQkGfplr39mxZqlTBDUZAb9BGoC40+rdFCG0m10lXk" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/fontawesome.css" integrity="sha384-q3jl8XQu1OpdLgGFvNRnPdj5VIlCvgsDQTQB6owSOHWlAurxul7f+JpUOVdAiJ5P" crossorigin="anonymous">
    </head>
    <body>
        <c:if test="${sessionScope.message != '' and sessionScope.message != null}">
            <script>
                alert("${sessionScope.message}");
            </script>
        </c:if>
        <section class="hidden-md-down header-box">
            <nav class="navbar navbar-toggleable-md navbar-light bg-faded fixed-top">
                <div class="container">
                    <div class="col-3 loGo">
                        <a href="index.html"><img src="pic/logo.png" alt="This is logo for web" class="resize"></a>
                    </div>
                    <div class="col-6 searching">
                        <input class="form-control mr-sm-2" type="search" placeholder="ค้นหาสินค้าที่คุณต้องการ..." aria-label="Search">
                    </div>
                    <div class="col etc">
                        <div class="row">
                            <div class="col-4 text-right">
                                <i class="fas fa-shopping-cart" aria-hidden="true"></i>
                            </div>
                            <div class="col nav-item dropdown">
                                <button class="dropdown-toggle" type="button" data-toggle="dropdown">
                                    <i class="fas fa-user-circle" style="vertical-align: middle; color: #000;" aria-hidden="true"></i>Username
                                    <span class="caret"></span>
                                </button>
                                <div class="dropdown-menu">
                                    <li><a href="#" class="dropdown-item">Login</a></li >
                                    <li><a href="#" class="dropdown-item">Register</a></li>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>
            <nav class="navbar navbar-toggleable-md navbar-light bg-faded fixed-top2">
                <div class="container pl-0 pr-0">
                    <!--<div class="collapse navbar-collapse">-->
                    <!--<ul class="navbar-nav nav-fill w-100">-->
                    <li class="nav-item text-left">
                        <a href="#">
                            สินค้า
                        </a>
                    </li>
                    <li class="nav-item text-left">
                        <a href="#">วิธีสั่งซื้อ/ชำระเงิน</a>
                    </li>
                    <li class="nav-item text-left">
                        <a href="#">แจ้งวิธีการชำระเงิน</a>
                    </li>
                    <li class="nav-item text-left">
                        <a href="#">เช็คสถานะการสั่งซื้อ/จัดส่ง</a>
                    </li>
                    <li class="nav-item text-left">
                        <a href="#">ติดต่อเรา</a>
                    </li>
                    </ul>
                    <!--</div>-->
                </div>
            </nav>
        </section>
        <div class="container">
            <div>
                <div class="box">
                    <form action="LoginServlet" method="POST">
                        <div class="userPass">
                            <h1>เข้าสู่ระบบ</h1><br>
                            Username: <input type="text" placeholder="Username" name="username" value=""><br><br>
                            Password: <input type="password" placeholder="Password" name="password" value=""><br><br>
                            <button type="submit" value="login">เข้าสู่ระบบ</button>
                            <hr>
                            <a href="rememberPass.html" id="remember">ลืมรหัสผ่าน</a>${applicationScope.datasourceName}
                            <% session.setAttribute("message", "");%>
                        </div>
                    </form>
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
