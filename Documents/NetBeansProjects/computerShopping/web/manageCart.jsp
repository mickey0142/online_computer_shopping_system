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
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=IBM+Plex+Sans|Pridi" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/solid.css" integrity="sha384-v2Tw72dyUXeU3y4aM2Y0tBJQkGfplr39mxZqlTBDUZAb9BGoC40+rdFCG0m10lXk" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/fontawesome.css" integrity="sha384-q3jl8XQu1OpdLgGFvNRnPdj5VIlCvgsDQTQB6owSOHWlAurxul7f+JpUOVdAiJ5P" crossorigin="anonymous">
    </head>
    <body>
        <section class="hidden-md-down header-box">
            <nav class="navbar navbar-toggleable-md navbar-light bg-faded ">
                <div class="container">
                    <div class="col-2 loGo">
                        <a href="index.jsp"><img src="pic/logo.png" alt="This is logo for web" class="resize"></a>
                    </div>
                    <form action="shoppingPage.jsp" id="searchForm">
                        <div class="col-6 searching">
                            <div class="easy-autocomplete" style="width: 540px">
                                <input class="form-control mr-sm-2 searchTerm" type="search" placeholder="ค้นหาสินค้าที่คุณต้องการ..." aria-label="Search" name="searchName">
                                <button type="submit" class="searchButton" onclick="submitForm()"><i class="fa fa-search" aria-hidden="true" onclick="submitForm()"></i></button>
                            </div>
                        </div>
                    </form>
                    <div class="col etc">
                        <div class="row">
                            <div class="col-4 text-right">
                                <c:if test="${sessionScope.loginFlag and sessionScope.isEmp == null}">
                                    <a href="manageCart.jsp" id="goCart"><i class="fas fa-shopping-cart" aria-hidden="true"></i></a>
                                </c:if>
                            </div>
                            <div class="col nav-item dropdown">
                                <button class="btn dropdown-toggle username" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fas fa-user-circle"></i> 
                                    <c:if test="${!sessionScope.loginFlag || sessionScope.loginFlag == null}">เข้าสู่ระบบ</c:if>
                                    <c:if test="${sessionScope.loginFlag}">${sessionScope.userInfo.getUsername()}</c:if>
                                    </button>
                                    <div class="dropdown-menu" id="login" aria-labelledby="dropdownMenuButton">
                                    <c:if test="${!sessionScope.loginFlag || sessionScope.loginFlag == null}">
                                        <a class="dropdown-item" href="login.jsp">เข้าสู่ระบบ</a>
                                        <a class="dropdown-item" href="register.jsp">สมัครสมาชิก</a>
                                    </c:if>
                                    <c:if test="${sessionScope.loginFlag}">
                                        <a class="dropdown-item" href="LogoutServlet">ออกจากระบบ</a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>
            <nav class="navbar navbar-toggleable-md navbar-light bg-faded ">
                <div class="container pl-0 pr-0">
                    <div class="nav-item text-left">
                        <a href="index.jsp">
                            หน้าหลัก
                        </a>
                    </div>
                    <div class="dropdown">
                        <form action="SetSessionValue?attributeName=productTypeId" method="POST" id="productTypeForm">
                            <button class="btn dropdown-toggle type" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                ประเภทสินค้า
                            </button>
                            <div class="dropdown-menu" id="type" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="#" onclick="submitForm('%')">สินค้าทั้งหมด</a>
                                <a class="dropdown-item" href="#" onclick="submitForm('01')">Mainboard</a>
                                <a class="dropdown-item" href="#" onclick="submitForm('02')">CPU</a>
                                <a class="dropdown-item" href="#" onclick="submitForm('03')">RAM</a>
                                <a class="dropdown-item" href="#" onclick="submitForm('04')">Power supply</a>
                                <a class="dropdown-item" href="#" onclick="submitForm('05')">Graphic card</a>
                                <a class="dropdown-item" href="#" onclick="submitForm('06')">Harddisk</a>
<!--                                <a class="dropdown-item" href="#" onclick="submitForm('07')">Monitor</a>
                                <a class="dropdown-item" href="#" onclick="submitForm('08')">Keyboard</a>
                                <a class="dropdown-item" href="#" onclick="submitForm('09')">Mouse</a>-->
                                <a class="dropdown-item" href="#" onclick="submitForm('10')">Case</a>
                            </div>
                            <input type="hidden" value="${sessionScope.productTypeId}" id="productType" name="productTypeId"/>
                            <input type="hidden" value="shoppingPage.jsp" id="backTo" name="backTo"/>
                        </form>
                    </div>
                    <div class="dropdown">
                        <button class="btn dropdown-toggle type" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            วิธีการซื้อสินค้า/ชำระสินค้า
                        </button>
                        <div class="dropdown-menu" id="howTo" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item" href="howBuy.jsp">วิธีการสั่งซื้อสินค้า</a>
                            <a class="dropdown-item" href="howPay.jsp">วิธีการชำระสินค้า</a>
                        </div>
                    </div>
                    <div class="nav-item text-left">
                        <a href="spec.jsp">จัดสเปคคอมพิวเตอร์</a>
                    </div>
                    <c:if test="${sessionScope.loginFlag}">
                        <div class="nav-item text-left">
                            <a href="orderHistory.jsp">เช็คสถานะออเดอร์ </a>
                        </div>
                    </c:if>
                    <div class="nav-item text-left">
                        <a href="contact.jsp">ติดต่อเรา</a>
                    </div>
                    </ul>
                </div>
                </div>
            </nav>
        </section>

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
                                            <td class="text-center"><img src="ShowPicture?id=${i.getProduct().getId()}&table=productpictures" style="width: 100px; height: 100px;"/></td>
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
                                        <td>ราคารวม</td><td>${totalPrice}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row margin-cart">
                <div class="col-md-8 text-right">
                    <a href="shoppingPage.jsp" class="btn btn-primary btn-md cart-link" role="button">
                        <i class="fas fa-angle-left"></i>เลือกสินค้าต่อ
                    </a>
                    <a href="confirmPurchase.jsp" class="btn btn-primary btn-md cart-link" role="button">
                        ชำระสินค้า<i class="fas fa-angle-right"></i>
                    </a>
                </div>
            </div>
        </div>

        <!--Java Script-->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script>
            function submitForm(type)
            {
                document.getElementById("productType").value = type;
                document.getElementById("backTo").value = "shoppingPage.jsp";
                document.getElementById("productTypeForm").submit();
            }
        </script>
    </body>
</html>
