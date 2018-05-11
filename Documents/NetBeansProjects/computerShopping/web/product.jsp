<%-- 
    Document   : product
    Created on : Apr 11, 2018, 1:08:56 PM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <title>รายละเอียดสินค้า</title>
        <link rel="stylesheet" href="detailProduct.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=IBM+Plex+Sans|Pridi" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.10/css/all.css" integrity="sha384-+d0P83n9kaQMCwj8F4RJB66tzIwOKmrdb46+porD/OvrJ+37WqIM7UoBtwHO6Nlg" crossorigin="anonymous">
    </head>
    <body>
        <sql:query dataSource="${applicationScope.datasourceName}" var="product">
            select * from products where productId = "${param.id}"
        </sql:query>
        <jsp:useBean id="DBConn" scope="page" class="model.DBConnector"/>
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

        <c:forEach var="i" items="${product.rows}">
            <div class="container" style="background: #fff; position: relative;">
                <div class="row">
                    <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
                        <div class="row">
                            <div class="col-12 col-xs-12 col-sm-12 col-md-12 col-lg-7 col-xl-7">
                                <div></div>
                                <div class="productZoom">
                                    <img src="ShowPicture?id=${i.productId}&table=productpictures" style="width: 300px; height: 300px;"/>
                                </div>
                                <div class="productMoreView">
                                    <ul>
                                        <!--<li><img src="pic/logo.png" alt="รูปอื่นๆ"></li>-->
                                    </ul>
                                </div>
                            </div>
                            <div class="col-12 col-xs-12 col-sm-12 col-md-12 col-lg-5 col-xl-5">
                                <h1 class="productName">${i.productName}</h1>
                                <hr>
                                <span> ${i.price}.- </span>
                                <hr>
                                <div>
                                    <span class="small text-danger"></span>
                                </div>
                                <c:if test="${i.instock <= 0}">
                                    Out of Stock !!
                                </c:if>
                                <c:if test="${i.instock > 0 and sessionScope.isEmp == null}">
                                    <a href="AddToCart.in?productId=${i.productId}">
                                        <button type="button" class="btn btn-primary btn-xs addCart">เพิ่มลงในตะกร้าสินค้า</button>
                                    </a>
                                </c:if>
                                <form action="AddToSpec" method="POST" id="AddToSpec">
                                    <input type="hidden" name="productId" value="${i.productid}" />
                                    <input type="hidden" name="productName" value="${i.productName}" />
                                    <input type="hidden" name="description" value="${i.description}" />
                                    <input type="hidden" name="price" value="${i.price}" />
                                    <c:if test="${fn:startsWith(i.productId, '01') or fn:startsWith(i.productId, '02') or fn:startsWith(i.productId, '03')}">
                                        <sql:query dataSource="${applicationScope.datasourceName}" var="type2">
                                            select * from producttype2 where productId = ${i.productId}
                                        </sql:query>
                                        <c:forEach var="j" items="${type2.rows}">
                                            <input type="hidden" name="powerConsumption" value="${j.powerConsumption}" />
                                            <input type="hidden" name="compatibility" value="${j.compatibility}" />
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${fn:startsWith(i.productId, '04') or fn:startsWith(i.productId, '05')}">
                                        <sql:query dataSource="${applicationScope.datasourceName}" var="type1">
                                            select * from producttype1 where productId = ${i.productId}
                                        </sql:query>
                                        <c:forEach var="j" items="${type1.rows}">
                                            <input type="hidden" name="powerConsumption" value="${j.powerConsumption}" />
                                        </c:forEach>
                                    </c:if>
                                    <button type="button" class="btn btn-primary btn-xs addCart" onclick="submitSpecForm()">เพิ่มลงในสเปค</button>
                                </form>
                            </div>
                            <div class="col-12 mt-3">
                                <ul class="nav nav-tabs" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active" data-toggle="tab" role="tab" style="background: #3385ff; color: #fff;">Specification</a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="pd_spec" role="tabpanel">
                                        <table class="table table-striped productSpec">
                                            <tbody>
                                                ${i.description}
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-sm-12 col-md-12 col-lg-3 col-xl-3  productRight">
                        <section class="send pb-3">
                            <h3>ข้อมูลการจัดส่ง</h3>
                            <ul>
                                <li>
                                    <b>ส่งแบบธรรมดา</b> ใช้เวลา 3-5 วันทำการ
                                </li>
                                <li>
                                    <b>EMS</b> ใช้เวลา 1-2 วันทำการ
                                </li>
                            </ul>
                        </section>
                        <section class="payment pb-3">
                            <h3>ช่่องทางการชำระเงิน</h3>
                            <ul>
                                <li>
                                    <b>
                                        <span class="col-4 pl-0 pr-0">
                                            <i class="fas fa-university" style="font-size: 1.2rem;"></i>
                                        </span>
                                        <span class="col-8">โอนผ่านธนาคาร / ATM</span>
                                    </b>
                                </li>
                                <li>
                                    <b>
                                        <span class="col-4 pl-0 pr-0">
                                            <i class="far fa-credit-card" style="font-size: 1.2rem"></i>
                                        </span>
                                        <span class="col-8">ชำระผ่านบัตรเครดิต/เดบิต</span>
                                    </b>
                                </li>
                            </ul>
                        </section>
                        <c:if test="${sessionScope.isEmp == null and sessionScope.loginFlag}">
                            <%@include file="showCart.jsp" %>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!--Java Script-->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script>
                                        function submitSpecForm()
                                        {
                                            document.getElementById("AddToSpec").submit();
                                        }
            function submitForm(type)
            {
                document.getElementById("productType").value = type;
                document.getElementById("backTo").value = "shoppingPage.jsp";
                document.getElementById("productTypeForm").submit();
            }
        </script>
    </body>
</html>
