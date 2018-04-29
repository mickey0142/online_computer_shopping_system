<%-- 
    Document   : shoppingPage
    Created on : Apr 26, 2018, 2:40:17 PM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="/WEB-INF/tlds/shortcut" prefix="shortcut" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <title>ซื้อขายคอมพิวเตอร์ออนไลน์</title>
        <link rel="stylesheet" href="product.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=IBM+Plex+Sans|Pridi" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/solid.css" integrity="sha384-v2Tw72dyUXeU3y4aM2Y0tBJQkGfplr39mxZqlTBDUZAb9BGoC40+rdFCG0m10lXk" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/fontawesome.css" integrity="sha384-q3jl8XQu1OpdLgGFvNRnPdj5VIlCvgsDQTQB6owSOHWlAurxul7f+JpUOVdAiJ5P" crossorigin="anonymous">
    </head>
    <body>
        <c:if test="${sessionScope.productTypeId == null}">
            <c:set scope="session" var="productTypeId" value="%"/>
        </c:if>
        <c:if test="${sessionScope.pageNum == null}">
            <c:set scope="session" var="pageNum" value="1"/>
        </c:if>
        <c:if test="${sessionScope.sortBy == null}">
            <c:set scope="session" var="sortBy" value="productId"/>
        </c:if>
        <sql:query dataSource="${applicationScope.datasourceName}" var="product">
            select * from products where productId like "${sessionScope.productTypeId}%" and productName like "%${param.search}%"
        </sql:query>
        <c:set scope="session" var="allPageCount" value="0"/>
        <c:forEach var="i" items="${product.rows}">
            <c:set scope="session" var="allPageCount" value="${sessionScope.allPageCount + 1}"/>
        </c:forEach>
        <c:set scope="session" var="allPageCount" value="${sessionScope.allPageCount / 12}"/>
        <c:set scope="session" var="allPageCount" value="${sessionScope.allPageCount+(1-(sessionScope.allPageCount%1))%1}"/>

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

        <div class="container float-container" style="background-color: #fff;">
            <div id="part-box">
                <div class="part-select col-xl">
                    <div class="select-path">
                        <div class="sort">
                            <div class="text-left"><h1 style="font-size: 24px; padding-left: 15px">
                                    <c:if test="${sessionScope.productTypeId == '%'}">
                                        สินค้าทั้งหมด
                                    </c:if>
                                    <c:if test="${sessionScope.productTypeId == '01'}">
                                        Mainboard
                                    </c:if>
                                    <c:if test="${sessionScope.productTypeId == '02'}">
                                        CPU
                                    </c:if>
                                    <c:if test="${sessionScope.productTypeId == '03'}">
                                        RAM
                                    </c:if>
                                    <c:if test="${sessionScope.productTypeId == '04'}">
                                        Power supply
                                    </c:if>
                                    <c:if test="${sessionScope.productTypeId == '05'}">
                                        Graphic card
                                    </c:if>
                                    <c:if test="${sessionScope.productTypeId == '06'}">
                                        Harddisk
                                    </c:if>
                                    <c:if test="${sessionScope.productTypeId == '07'}">
                                        Monitor
                                    </c:if>
                                    <c:if test="${sessionScope.productTypeId == '08'}">
                                        Keyboard
                                    </c:if>
                                    <c:if test="${sessionScope.productTypeId == '09'}">
                                        Mouse
                                    </c:if>
                                    <c:if test="${sessionScope.productTypeId == '10'}">
                                        Case
                                    </c:if>
                                </h1></div>
                            <div class="text-right">
                                <div class="dropdown">
                                    <b>Sort by </b>
                                    <form action="SetSessionValue?attributeName=sortBy" method="POST" id="sortByForm">
                                        <select name="sortBy" onchange="this.form.submit()" id="sortBy">
                                            <option>เลือกวิธีการเรียงลำดับ</option>
                                            <option>หมายเลขสินค้า</option>
                                            <option>ชื่อสินค้า</option>
                                            <option>ราคาจากน้อยไปมาก</option>
                                            <option>ราคาจากมากไปน้อย</option>
                                        </select>
                                        <input type="hidden" value="${sessionScope.sortBy}" id="sortBy" name="sortBy"/>
                                        <input type="hidden" value="shoppingPage.jsp" id="backTo" name="backTo"/>
                                        <input type="hidden" value="sortBy" name="attributeName"/>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="box-product" style="display: inline-block;">
                            <shortcut:select productId="${sessionScope.productTypeId}" search="${param.searchName}" fromPage="shopping" pageNum="${sessionScope.pageNum}"></shortcut:select>
                            </div>

                            <div class="select-pages col-12" style="padding-top: 15px; padding-left: 15px">
                                <nav aria-label="...">
                                    <form action="SetSessionValue?attributeName=pageNum" method="POST" id="pageNumForm">
                                        <ul class="pagination">
                                        <c:if test="${sessionScope.pageNum > 1}">
                                            <li class="page-item">
                                                <span class="page-link" onclick="submitPageNumForm(${sessionScope.pageNum - 1})">Previous</span>
                                            </li>
                                        </c:if>
                                        <c:forEach var="i" begin="1" end="${sessionScope.allPageCount}">
                                            <c:if test="${i == sessionScope.pageNum}">
                                                <li class="page-item active">
                                                    <span class="page-link">${i}
                                                        <span class="sr-only">(current)</span>
                                                    </span>
                                                </li>
                                            </c:if>
                                            <c:if test="${i != sessionScope.pageNum}">
                                                <li class="page-item">
                                                    <a class="page-link" href="#" onclick="submitPageNumForm('${i}')">${i}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${sessionScope.pageNum < allPageCount}">
                                            <li class="page-item">
                                                <a class="page-link" href="#" onclick="submitPageNumForm('${sessionScope.pageNum + 1}')">Next</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                    <input type="hidden" value="${sessionScope.pageNum}" id="pageNum" name="pageNum"/>
                                    <input type="hidden" value="shoppingPage.jsp" id="backTo" name="backTo"/>
                                    <input type="hidden" value="pageNum" name="attributeName"/>
                                </form>
                            </nav>
                        </div>
                        <div class="select-pages col-12" style="padding-top: 15px; padding-left: 15px">
                            <c:if test="${sessionScope.loginFlag and sessionScope.isEmp == null}">
                                <div class="box-product" style="display: inline-block; width: 100%;">
                                    <%@include file="showCart.jsp" %>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--javascript-->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script>
                                                    function submitForm(type)
                                                    {
                                                        document.getElementById("productType").value = type;
                                                        document.getElementById("backTo").value = "shoppingPage.jsp";
                                                        document.getElementById("productTypeForm").submit();
                                                    }
                                                    function submitPageNumForm(num)
                                                    {
                                                        document.getElementById("pageNum").value = num;
                                                        document.getElementById("pageNumForm").submit();
                                                    }
                                                    function submitSortByForm()
                                                    {

                                                        document.getElementById("sortByForm").submit();
                                                    }
        </script>
    </body>
</html>
