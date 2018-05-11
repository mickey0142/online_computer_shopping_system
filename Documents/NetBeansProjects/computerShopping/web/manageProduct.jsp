<%-- 
    Document   : manageProduct
    Created on : Apr 21, 2018, 4:42:19 PM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>รายการสินค้า</title>
        <link rel="stylesheet" href="eaProduct.css">
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
                                <button type="submit" class="searchButton" onclick="submitSearchForm()"><i class="fa fa-search" aria-hidden="true" onclick="submitSearchForm()"></i></button>
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
                    <c:if test="${sessionScope.isEmp == null}">
                        <div class="dropdown">
                            <button class="btn dropdown-toggle type" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                วิธีการซื้อสินค้า/ชำระสินค้า
                            </button>
                            <div class="dropdown-menu" id="howTo" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="howBuy.jsp">วิธีการสั่งซื้อสินค้า</a>
                                <a class="dropdown-item" href="howPay.jsp">วิธีการชำระสินค้า</a>
                            </div>
                        </div>
                    </c:if>
                    <div class="nav-item text-left">
                        <a href="spec.jsp">จัดสเปคคอมพิวเตอร์</a>
                    </div>
                    <c:if test="${sessionScope.isEmp != null}">
                        <c:if test="${sessionScope.userInfo.getEmployeeType() == 'accounting' or sessionScope.userInfo.getEmployeeType() == 'assemble'}">
                            <div class="nav-item text-left">
                                <a href="manageOrder.jsp">จัดการรายการออเดอร์</a>
                            </div>
                        </c:if>
                    </c:if>
                    <c:if test="${sessionScope.isEmp != null}">
                        <c:if test="${sessionScope.userInfo.getEmployeeType() == 'warehouse'}">
                            <div class="nav-item text-left">
                                <a href="manageProduct.jsp">จัดการข้อมูลสินค้า</a>
                            </div>
                        </c:if>
                    </c:if>
                    <c:if test="${sessionScope.loginFlag and sessionScope.isEmp == null}">
                        <div class="nav-item text-left">
                            <a href="orderHistory.jsp">เช็คสถานะออเดอร์ </a>
                        </div>
                    </c:if>
                    <c:if test="${sessionScope.isEmp == null}">
                        <div class="nav-item text-left">
                            <a href="contact.jsp">ติดต่อเรา</a>
                        </div>
                    </c:if>
                    </ul>
                </div>
                </div>
            </nav>
        </section>

        <sql:query dataSource="${applicationScope.datasourceName}" var="product">
            select * from products where productId like '${sessionScope.productTypeId}%'
            <c:if test="${param.search != '' and param.search != null}"> and productName like '${param.search}%'</c:if>
        </sql:query>

        <!--        <form action="SetSessionValue?attributeName=productTypeId" method="POST" id="productTypeForm">
                    <div onclick="submitForm('%')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                        all
                    </div>
                    <div onclick="submitForm('01')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                        mainboard
                    </div>
                    <div onclick="submitForm('02')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                        cpu
                    </div>
                    <div onclick="submitForm('03')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                        ram
                    </div>
                    <div onclick="submitForm('04')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                        power supply
                    </div>
                    <div onclick="submitForm('05')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                        graphic card
                    </div>
                    <div onclick="submitForm('06')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                        harddisk
                    </div>
                    <div onclick="submitForm('07')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                        monitor
                    </div>
                    <div onclick="submitForm('08')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                        keyboard
                    </div>
                    <div onclick="submitForm('09')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                        mouse
                    </div>
                    <div onclick="submitForm('10')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                        case
                    </div>
                    <input type="hidden" value="${sessionScope.productTypeId}" id="productType" name="productTypeId"/>
                    <input type="hidden" value="manageProduct.jsp" id="backTo" name="backTo"/>
                </form>-->

        <jsp:useBean id="DBConn" scope="page" class="model.DBConnector"/>
        <form action="deleteProduct.emp" method="POST" id="deleteProduct">
            <input type="hidden" name="deleteId" value="test" id="deleteId"/>
        </form>

        <div class="container cart-navigation" id="body" style="margin-top: 60px">
            <form action="manageProduct.jsp" method="POST">
                Product Name : <input type="search" name="search" value="" /> 
                <input type="submit" value="search" />
            </form>
            <nav class="navbar navbar-light" style="border-radius: 5px; margin-bottom: -20px; padding-left: 2px; padding-right: 2px">
                <a class="navbar-brand"style="font-weight: 30px; font-weight: bold; color: #109AD7;">จัดการสินค้า</a>
                <a href="addProduct.jsp">เพิ่มสินค้า <button type="button" class="btn btn-light btn-sm"><i class="fas fa-plus"></i></button></a>
            </nav>
            <br>
            <div class="row margin-cart" style="background: #fafafa;">
                <div class="col-md">
                    <div class="table-response">
                        <table class="table table-hover table-striped">
                            <thead>
                                <tr>
                                    <th class="text-center">รหัสสินค้า</th>
                                    <th class="text-center">ชื่อสินค้า</th>
                                    <th class="text-center">จำนวนในคลัง</th>
                                    <th class="text-center">ราคา</th>
                                    <th class="text-center">แก้ไข</th>
                                    <th class="text-center">ลบสินค้า</th>
                                </tr>
                            </thead>
                            <c:forEach var="i" items="${product.rows}">
                                <tbody>
                                <th class="text-center">${i.productId}</th>
                                <th class="text-center">${i.productName}</th>
                                <th class="text-center">${i.inStock}</th>
                                <th class="text-center">${i.price}</th>
                                <th class="text-center"><a href="updateProduct.jsp?id=${i.productId}"><button type="button" class="btn btn-light btn-sm"><i class="fas fa-wrench"></i></button></a></th>
                                <th class="text-center"><a href="#" onclick="deleteConfirm(${i.productId})"><button type="button" class="btn btn-light btn-sm"><i class="fas fa-minus"></i></button></a></th>
                                </tbody>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!--java script-->
        <script>
            function deleteConfirm(productId)
            {
                if (confirm("Are you sure?"))
                {
                    document.getElementById("deleteId").value = productId;
                    document.getElementById("deleteProduct").submit();
                } else
                {

                }
            }
            function submitForm(type)
            {
                document.getElementById("productType").value = type;
                document.getElementById("productTypeForm").submit();
            }
        </script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
    </body>
</html>
