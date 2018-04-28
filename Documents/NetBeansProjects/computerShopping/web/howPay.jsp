<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>วิธีการชำระเงิน</title>
        <link rel="stylesheet" href="howPay.css">
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
                                <a class="dropdown-item" href="#" onclick="submitForm('07')">Monitor</a>
                                <a class="dropdown-item" href="#" onclick="submitForm('08')">Keyboard</a>
                                <a class="dropdown-item" href="#" onclick="submitForm('09')">Mouse</a>
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
                    <div class="nav-item text-left">
                        <a href="orderHistory.jsp">เช็คสถานะออเดอร์ </a>
                    </div>
                    <div class="nav-item text-left">
                        <a href="contact.html">ติดต่อเรา</a>
                    </div>
                    </ul>
                </div>
                </div>
            </nav>
        </section>

        <div class="container">
            <div class="row">
                <div class="col-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 singlepage">
                    <h1 class="title pt-2">วิธีการสั่งซื้อสินค้า</h1>
                    <div class="accordion" id="accordion">
                        <div class="card">
                            <div class="card-header" id="headingOne">
                                <h5 class="mb-0">
                                    <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                        <span>ชำระผ่านโอนเงินผ่านธนาคาร</span>
                                    </button>
                                </h5>
                            </div>
                            <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
                                <div class="card-body">
                                    <div id="card-box">
                                        <h2 class="topic-head"><b>เลขที่บัญชีในการชำระเงิน</b></h2>
                                        <div class="row">
                                            <div class="col-xs-12 col-md-6">
                                                <div class="bank-detail" style="border: 2px solid #00a950; font-size: 16px">
                                                    <img src="pic/k-bank.png" alt="ธนาคารกสิกรไทย" style="width: 120px">
                                                    <div class="nameBank" style=" color: #00a950;"><b>ธนาคาร กสิกรไทย จำกัด (มหาชน)</b></div>
                                                    <div class="nameAccount"><span>ชื่อบัญชี คอมพิวเตอร์ออนไลน์</span></div>
                                                    <div class="numberAccount" style=" color: #00a950;"><span><b>เลขที่บัญชี xxx-x-xxxxx-x</b></span></div>
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-md-6">
                                                <div class="bank-detail" style="border: 2px solid #582584; font-size: 16px">
                                                    <img src="pic/scb.jpg" alt="ธนาคารไทยพาณิชย์" style="width: 120px">
                                                    <div class="nameBank" style=" color: #582584;"><b>ธนาคาร ไทยพาณิชย์ จำกัด (มหาชน)</b></div>
                                                    <div class="nameAccount"><span>ชื่อบัญชี คอมพิวเตอร์ออนไลน์</span></div>
                                                    <div class="numberAccount" style=" color: #582584;"><span><b>เลขที่บัญชี yyy-y-yyyyy-y</b></span></div>
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-md-6">
                                                <div class="bank-detail" id="kbank" style="border: 2px solid #ffc422; font-size: 16px">
                                                    <img src="pic/krungsri.jpg" alt="ธนาคารกสิกรไทย" style="width: 120px">
                                                    <div class="nameBank" style=" color: #ffc422;"><b>ธนาคาร กรุงศรีอยุธยา จำกัด (มหาชน)</b></div>
                                                    <div class="nameAccount"><span>ชื่อบัญชี คอมพิวเตอร์ออนไลน์</span></div>
                                                    <div class="numberAccount" style=" color: #ffc422;"><span><b>เลขที่บัญชี zzz-z-zzzzz-z</b></span></div>
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-md-6">
                                                <div class="bank-detail" id="ktb" style="border: 2px solid #109AD7; font-size: 16px">
                                                    <img src="pic/ktb.jpg" alt="ธนาคารกรุงไทย" style="width: 120px">
                                                    <div class="nameBank" style=" color: #109AD7;"><b>ธนาคาร กรุงไทย จำกัด (มหาชน)</b></div>
                                                    <div class="nameAccount"><span>ชื่อบัญชี คอมพิวเตอร์ออนไลน์</span></div>
                                                    <div class="numberAccount" style=" color: #109AD7;"><span><b>เลขที่บัญชี www-w-wwwww-w</b></span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header" id="headingTwo">
                                <h5 class="mb-0">
                                    <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                        <span>วิธีการชำระเงินผ่านบัตรเครดิต/เดบิต</span>
                                    </button>
                                </h5>
                            </div>
                            <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
                                <div class="card-body">
                                    <h2 class="topic-head"><b>วิธีการชำระเงินผ่านบัตรเครดิต/เดบิต</b></h2>
                                    <div class="content-pay">
                                        <p class="content-body">1.เมื่อท่านเลือกชำระเงินผ่านบัตรเครดิต/เดบิต</p>
                                        <p class="content-body">2.ระบบจะให้ท่านกรอกรายละเอียดบัตรของท่าน</p>
                                        <p class="content-body">3.กดปุ่ม "ยืนยันการสั่งซื้อ" เพื่อดำเนินการชำระเสร็จสิ้น</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!--java script-->
        <script>
            function submitForm()
            {
                document.getElementById("searchForm").submit();
            }
            function submitForm(type)
            {
                document.getElementById("productType").value = type;
                document.getElementById("productTypeForm").submit();
            }
        </script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>

        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

    </body>
</html>