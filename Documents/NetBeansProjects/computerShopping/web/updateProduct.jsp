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
        <meta charset="UTF-8">
        <title>แก้ไขสินค้า</title>
        <link rel="stylesheet" href="editP.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=IBM+Plex+Sans|Pridi" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/solid.css" integrity="sha384-v2Tw72dyUXeU3y4aM2Y0tBJQkGfplr39mxZqlTBDUZAb9BGoC40+rdFCG0m10lXk" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/fontawesome.css" integrity="sha384-q3jl8XQu1OpdLgGFvNRnPdj5VIlCvgsDQTQB6owSOHWlAurxul7f+JpUOVdAiJ5P" crossorigin="anonymous">
    </head>
    <body>
        <sql:query dataSource="${applicationScope.datasourceName}" var="product">
            select * from products where productId = '${param.id}'
        </sql:query>
        <c:set scope="session" value="updateProduct.jsp?id=${param.id}" var="back"/>
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
                                <a class="dropdown-item" href="#" onclick="//submitForm('07')">Monitor</a>
                                <a class="dropdown-item" href="#" onclick="//submitForm('08')">Keyboard</a>
                                <a class="dropdown-item" href="#" onclick="//submitForm('09')">Mouse</a>
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

        <div class="container">
            <div class="card" style="margin-top: 3.5rem">
                <h3 class="card-header" style="font-size: 20px; font-weight: bold">แก้ไขข้อมูลสินค้า</h3>
                <div class="card-body">
                    <c:forEach var="i" items="${product.rows}">
                        <form action="UpdateProduct.emp" method="POST">
                            <p class="card-text" style="padding-left: 4rem">Product id : <input type="text" name="productId" value="${i.productId}" readonly="readonly" /></p>
                            <p class="card-text" style="padding-left: 4rem">Product Name : <input type="text" name="productName" value="${i.productName}" /></p>
                            <p class="card-text" style="padding-left: 4rem">Description : <textarea name="description" rows="8" cols="50">${i.description}</textarea></p>
                            <p class="card-text" style="padding-left: 4rem">In Stock : <input type="text" name="inStock" value="${i.inStock}" /></p>
                            <p class="card-text" style="padding-left: 4rem">Price : <input type="text" name="price" value="${i.price}" /></p>
                                <c:if test="${i.productType == 'type1'}">
                                    <sql:query dataSource="${applicationScope.datasourceName}" var="producttype1">
                                    select * from producttype1 where productId = '${i.productId}'
                                </sql:query>
                                <c:forEach var="j" items="${producttype1.rows}">
                                    <p class="card-text" style="padding-left: 4rem">Power Consumption : <input type="text" name="powerConsumption" value="${j.powerConsumption}" /></p>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${i.productType == 'type2'}">
                                    <sql:query dataSource="${applicationScope.datasourceName}" var="producttype2">
                                    select * from producttype2 where productId = '${i.productId}'
                                </sql:query>
                                <c:forEach var="j" items="${producttype2.rows}">
                                    <p class="card-text" style="padding-left: 4rem">Power Consumption : <input type="text" name="powerConsumption" value="${j.powerConsumption}" /></p>
                                    <p class="card-text" style="padding-left: 4rem">Compatibility : <input type="text" name="compatibility" value="${j.compatibility}" /></p>
                                    </c:forEach>
                                </c:if>
                            <button type="submit" class="btn btn-primary btn-xl" style="background-color: #3385ff; margin-top: 15px;">update</button>
                        </form>
                            รูปสินค้า : <img src="ShowPicture?id=${i.productId}&table=productpictures" style="width: 500px; height: 500px;"/>
                            <form action="InsertPicture?id=${i.productId}&table=updateProduct" method="POST" enctype="multipart/form-data">
                                เลือกรูปสินค้า : <input type="file" name="picture" />
                                <button type="submit" class="btn btn-primary btn-xl" style="background-color: #3385ff; margin-top: 15px;">อัพโหลด</button>
                            </form>  
                    </div>
                </div>
            </div>
        </c:forEach>

        <!--java script-->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
    </body>
</html>
