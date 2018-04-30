<%-- 
    Document   : spec
    Created on : Apr 26, 2018, 11:10:28 AM
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
        <title>ระบบจัดสเปค คอมพิวเตอร์</title>
        <link rel="stylesheet" href="spec.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
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
        <c:if test="${sessionScope.specProductTypeId == null}">
            <c:set scope="session" var="specProductTypeId" value="01"/>
        </c:if>
        <% session.setAttribute("message", "");%>
        <c:if test="${sessionScope.specPageNum == null}">
            <c:set scope="session" var="specPageNum" value="1"/>
        </c:if>
        <c:if test="${sessionScope.sortBy == null}">
            <c:set scope="session" var="sortBy" value="productId"/>
        </c:if>
        <c:set scope="page" var="firstChar" value="_"/>
        <c:set scope="page" var="secondChar" value="_"/>
        <c:if test="${sessionScope.compCodeC != null}">
            <c:set scope="page" var="firstChar" value="${sessionScope.compCodeC}"/>
        </c:if>
        <c:if test="${sessionScope.compCodeMC != null}">
            <c:set scope="page" var="firstChar" value="${sessionScope.compCodeMC}"/>
        </c:if>
        <c:if test="${sessionScope.compCodeMR != null}">
            <c:set scope="page" var="secondChar" value="${sessionScope.compCodeMR}"/>
        </c:if>
        <sql:query dataSource="${applicationScope.datasourceName}" var="product">
            select * from products left outer join producttype2 using (productId)
            where productId like "${sessionScope.specProductTypeId}%" and productName like "%${param.search}%" and
            (compatibility like '${firstChar}__' or compatibility < '0${secondChar}' or compatibility is null)
        </sql:query>
        <c:set scope="session" var="allPageCount" value="0"/>
        <c:forEach var="i" items="${product.rows}">
            <c:set scope="session" var="allPageCount" value="${sessionScope.allPageCount + 1}"/>
        </c:forEach>
        <c:set scope="session" var="allPageCount" value="${sessionScope.allPageCount / 12}"/>
        <c:set scope="session" var="allPageCount" value="${sessionScope.allPageCount+(1-(sessionScope.allPageCount%1))%1}"/>
        <c:if test="${sessionScope.specPageNum > sessionScope.allPageCount}">
            <c:set scope="session" var="specPageNum" value="1"/>
        </c:if>

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
                                <a class="dropdown-item" href="#" onclick="submitShopForm('%')">สินค้าทั้งหมด</a>
                                <a class="dropdown-item" href="#" onclick="submitShopForm('01')">Mainboard</a>
                                <a class="dropdown-item" href="#" onclick="submitShopForm('02')">CPU</a>
                                <a class="dropdown-item" href="#" onclick="submitShopForm('03')">RAM</a>
                                <a class="dropdown-item" href="#" onclick="submitShopForm('04')">Power supply</a>
                                <a class="dropdown-item" href="#" onclick="submitShopForm('05')">Graphic card</a>
                                <a class="dropdown-item" href="#" onclick="submitShopForm('06')">Harddisk</a>
                                <!--                                <a class="dropdown-item" href="#" onclick="//submitForm('07')">Monitor</a>
                                                                <a class="dropdown-item" href="#" onclick="//submitForm('08')">Keyboard</a>
                                                                <a class="dropdown-item" href="#" onclick="//submitForm('09')">Mouse</a>-->
                                <a class="dropdown-item" href="#" onclick="submitShopForm('10')">Case</a>
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
                <div class="part-catgory col-xl-3" style="position: absolute">
                    <div>
                        <div id="part-total-price" class="banner total-price default"><b>Select Component</b></div>
                    </div>
                    <form action="SetSessionValue" method="POST" id="specProductTypeForm">
                        <ul>
                            <div class="box" onclick="submitForm('01')">
                                <span style="padding-left: 40px; font-size: 20px;">
                                    <c:if test="${sessionScope.inSpec.get(1) == null}">
                                        Mainboard
                                    </c:if>
                                    ${sessionScope.inSpec.get(1).getProduct().getName()}
                                </span>
                            </div>
                            <c:if test="${sessionScope.inSpec.get(1) != null}">
                                <center>
                                    <a href="RemoveFromSpec?index=1">
                                        <div class="box" style="display: inline-block;width: 100px">remove</div>
                                    </a>
                                </center>
                            </c:if>
                        </ul>
                        <ul>
                            <div class="box" onclick="submitForm('02')">
                                <span style="padding-left: 40px; font-size: 20px;">
                                    <c:if test="${sessionScope.inSpec.get(2) == null}">
                                        CPU
                                    </c:if>
                                    ${sessionScope.inSpec.get(2).getProduct().getName()}
                                </span>
                            </div>
                            <c:if test="${sessionScope.inSpec.get(2) != null}">
                                <center>
                                    <a href="RemoveFromSpec?index=2">
                                        <div class="box" style="display: inline-block;width: 100px">remove</div>
                                    </a>
                                </center>
                            </c:if>
                        </ul>
                        <ul>
                            <div class="box" onclick="submitForm('03')">
                                <span style="padding-left: 40px; font-size: 20px;">
                                    <c:if test="${sessionScope.inSpec.get(3) == null}">
                                        RAM
                                    </c:if>
                                    ${sessionScope.inSpec.get(3).getProduct().getName()}
                                </span>
                            </div>
                            <c:if test="${sessionScope.inSpec.get(3) != null}">
                                <center>
                                    <a href="RemoveFromSpec?index=3">
                                        <div class="box" style="display: inline-block;width: 100px">remove</div>
                                    </a>
                                </center>
                            </c:if>
                        </ul>
                        <ul>
                            <div class="box" onclick="submitForm('04')">
                                <span style="padding-left: 40px; font-size: 20px;">
                                    <c:if test="${sessionScope.inSpec.get(4) == null}">
                                        Power Supply
                                    </c:if>
                                    ${sessionScope.inSpec.get(4).getProduct().getName()}
                                </span>
                            </div>
                            <c:if test="${sessionScope.inSpec.get(4) != null}">
                                <center>
                                    <a href="RemoveFromSpec?index=4">
                                        <div class="box" style="display: inline-block;width: 100px">remove</div>
                                    </a>
                                </center>
                            </c:if>
                        </ul>
                        <ul>
                            <div class="box" onclick="submitForm('05')">
                                <span style="padding-left: 40px; font-size: 20px;">
                                    <c:if test="${sessionScope.inSpec.get(5) == null}">
                                        Graphic Card
                                    </c:if>
                                    ${sessionScope.inSpec.get(5).getProduct().getName()}
                                </span>
                            </div>
                            <c:if test="${sessionScope.inSpec.get(5) != null}">
                                <center>
                                    <a href="RemoveFromSpec?index=5">
                                        <div class="box" style="display: inline-block;width: 100px">remove</div>
                                    </a>
                                </center>
                            </c:if>
                        </ul>
                        <ul>
                            <div class="box" onclick="submitForm('06')">
                                <span style="padding-left: 40px; font-size: 20px;">
                                    <c:if test="${sessionScope.inSpec.get(6) == null}">
                                        Harddisk
                                    </c:if>
                                    ${sessionScope.inSpec.get(6).getProduct().getName()}
                                </span>
                            </div>
                            <c:if test="${sessionScope.inSpec.get(6) != null}">
                                <center>
                                    <a href="RemoveFromSpec?index=6">
                                        <div class="box" style="display: inline-block;width: 100px">remove</div>
                                    </a>
                                </center>
                            </c:if>
                        </ul>
                        <!--                        <ul>
                                                    <div class="box"onclick="submitForm('07')">
                                                        <span style="padding-left: 40px; font-size: 20px;">
                        <c:if test="${sessionScope.inSpec.get(7) == null}">
                            Monitor
                        </c:if>
                        ${sessionScope.inSpec.get(7).getProduct().getName()}
                    </span>
                </div>
                        <c:if test="${sessionScope.inSpec.get(7) != null}">
                            <center>
                                <a href="RemoveFromSpec?index=7">
                                    <div class="box" style="display: inline-block;width: 100px">remove</div>
                                </a>
                            </center>
                        </c:if>
                    </ul>
                    <ul>
                        <div class="box"onclick="submitForm('08')">
                            <span style="padding-left: 40px; font-size: 20px;">
                        <c:if test="${sessionScope.inSpec.get(8) == null}">
                            Keyboard
                        </c:if>
                        ${sessionScope.inSpec.get(8).getProduct().getName()}
                    </span>
                </div>
                        <c:if test="${sessionScope.inSpec.get(8) != null}">
                            <center>
                                <a href="RemoveFromSpec?index=8">
                                    <div class="box" style="display: inline-block;width: 100px">remove</div>
                                </a>
                            </center>
                        </c:if>
                    </ul>
                    <ul>
                        <div class="box"onclick="submitForm('09')">
                            <span style="padding-left: 40px; font-size: 20px;">
                        <c:if test="${sessionScope.inSpec.get(9) == null}">
                            Mouse
                        </c:if>
                        ${sessionScope.inSpec.get(9).getProduct().getName()}
                    </span>
                </div>
                        <c:if test="${sessionScope.inSpec.get(9) != null}">
                            <center>
                                <a href="RemoveFromSpec?index=9">
                                    <div class="box" style="display: inline-block;width: 100px">remove</div>
                                </a>
                            </center>
                        </c:if>
                    </ul>-->
                        <ul>
                            <div class="box"onclick="submitForm('10')">
                                <span style="padding-left: 40px; font-size: 20px;">
                                    <c:if test="${sessionScope.inSpec.get(10) == null}">
                                        Case
                                    </c:if>
                                    ${sessionScope.inSpec.get(10).getProduct().getName()}
                                </span>
                            </div>
                            <c:if test="${sessionScope.inSpec.get(10) != null}">
                                <center>
                                    <a href="RemoveFromSpec?index=10">
                                        <div class="box" style="display: inline-block;width: 100px">remove</div>
                                    </a>
                                </center>
                            </c:if>
                        </ul>
                        <input type="hidden" value="${sessionScope.specProductTypeId}" id="specProductType" name="specProductTypeId"/>
                        <input type="hidden" value="spec.jsp" id="backTo" name="backTo"/>
                        <input type="hidden" value="specProductTypeId" name="attributeName"/>
                    </form>
                    <br><br>
                    <ul>
                        <a href="RemoveFromSpec?index=-1">
                            <div class="box">
                                <span style="padding-left: 40px; font-size: 20px;">clear</span>
                            </div>
                        </a>
                    </ul>
                    <c:if test="${sessionScope.isEmp == null}">
                        <ul>
                            <a href="BuySpec.in">
                                <div class="box">
                                    <span style="padding-left: 40px; font-size: 20px;">สั่งซื้อspec นี้</span>
                                </div>
                            </a>
                        </ul>
                    </c:if>
                </div>
                <div class="part-select col-xl-11">
                    <div class="select-path">
                        <div class="sort">
                            <div class="text-left">
                                <h1 style="font-size: 24px">
                                    <c:if test="${sessionScope.specProductTypeId == '01'}">
                                        Mainboard
                                    </c:if>
                                    <c:if test="${sessionScope.specProductTypeId == '02'}">
                                        CPU
                                    </c:if>
                                    <c:if test="${sessionScope.specProductTypeId == '03'}">
                                        RAM
                                    </c:if>
                                    <c:if test="${sessionScope.specProductTypeId == '04'}">
                                        Power supply
                                    </c:if>
                                    <c:if test="${sessionScope.specProductTypeId == '05'}">
                                        Graphic card
                                    </c:if>
                                    <c:if test="${sessionScope.specProductTypeId == '06'}">
                                        Harddisk
                                    </c:if>
                                    <c:if test="${sessionScope.specProductTypeId == '07'}">
                                        Monitor
                                    </c:if>
                                    <c:if test="${sessionScope.specProductTypeId == '08'}">
                                        Keyboard
                                    </c:if>
                                    <c:if test="${sessionScope.specProductTypeId == '09'}">
                                        Mouse
                                    </c:if>
                                    <c:if test="${sessionScope.specProductTypeId == '10'}">
                                        Case
                                    </c:if>
                                </h1>
                            </div>
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
                                        <input type="hidden" value="spec.jsp" id="backTo" name="backTo"/>
                                        <input type="hidden" value="sortBy" name="attributeName"/>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="box-product" style="display: inline-block;">
                            <shortcut:select productId="${sessionScope.specProductTypeId}" search="${param.searchName}" fromPage="spec" pageNum="${sessionScope.specPageNum}"></shortcut:select>
                            </div>
                            <div class="select-pages col-12" style="padding-top: 15px; padding-left: 15px">
                                <nav aria-label="...">
                                    <form action="SetSessionValue?attributeName=specPageNum" method="POST" id="pageNumForm">
                                        <ul class="pagination">
                                        <c:if test="${sessionScope.specPageNum > 1}">
                                            <li class="page-item">
                                                <span class="page-link" onclick="submitPageNumForm(${sessionScope.specPageNum - 1})">Previous</span>
                                            </li>
                                        </c:if>
                                        <c:forEach var="i" begin="1" end="${sessionScope.allPageCount}">
                                            <c:if test="${i == sessionScope.specPageNum}">
                                                <li class="page-item active">
                                                    <span class="page-link">${i}
                                                        <span class="sr-only">(current)</span>
                                                    </span>
                                                </li>
                                            </c:if>
                                            <c:if test="${i != sessionScope.specPageNum}">
                                                <li class="page-item">
                                                    <a class="page-link" href="#" onclick="submitPageNumForm('${i}')">${i}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${sessionScope.specPageNum < allPageCount}">
                                            <li class="page-item">
                                                <a class="page-link" href="#" onclick="submitPageNumForm('${sessionScope.specPageNum + 1}')">Next</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                    <input type="hidden" value="${sessionScope.specPageNum}" id="specPageNum" name="specPageNum"/>
                                    <input type="hidden" value="spec.jsp" id="backTo" name="backTo"/>
                                    <input type="hidden" value="specPageNum" name="attributeName"/>
                                </form>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--java script-->
        <script>
            function submitShopForm(type)
            {
                document.getElementById("productType").value = type;
                document.getElementById("backTo").value = "shoppingPage.jsp";
                document.getElementById("productTypeForm").submit();
            }
            function submitPageNumForm(num)
            {
                document.getElementById("specPageNum").value = num;
                document.getElementById("pageNumForm").submit();
            }
            function submitForm(type)
            {
                document.getElementById("specProductType").value = type;
                document.getElementById("backTo").value = "spec.jsp";
                document.getElementById("specProductTypeForm").submit();
            }
        </script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html>
