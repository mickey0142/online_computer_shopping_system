<%-- 
    Document   : confirmPurchase
    Created on : Apr 16, 2018, 12:30:31 PM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <title>กรุณาเลือกวิธีการชำระเงิน</title>
        <link rel="stylesheet" href="pay.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=IBM+Plex+Sans|Pridi" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.10/css/all.css" integrity="sha384-+d0P83n9kaQMCwj8F4RJB66tzIwOKmrdb46+porD/OvrJ+37WqIM7UoBtwHO6Nlg" crossorigin="anonymous">    </head>
    <body>
        <c:if test="${sessionScope.message != '' and sessionScope.message != null}">
            <script>
                alert("${sessionScope.message}");
            </script>
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
                        <c:if test="${sessionScope.isEmp == null}">
                            <button class="btn dropdown-toggle type" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                วิธีการซื้อสินค้า/ชำระสินค้า
                            </button>
                        </c:if>
                        <div class="dropdown-menu" id="howTo" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item" href="howBuy.jsp">วิธีการสั่งซื้อสินค้า</a>
                            <a class="dropdown-item" href="howPay.jsp">วิธีการชำระสินค้า</a>
                        </div>
                    </div>
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

        <c:if test="${empty param.payType}">
            <jsp:forward page="confirmPurchase.jsp">
                <jsp:param name="payType" value="credit"></jsp:param>
            </jsp:forward>
        </c:if>
        <div class="container cart-navigation" id="body" style="margin-top: 144px">
            <div class="row margin-cart">
                <div class="col-md-8">
                    <div class="panel panel-defualt">
                        <div class="panel-heading text-left cart-navigation2">
                            <span>กรุณาเลือกวิธีชำระสินค้า</span>
                        </div>
                    </div>
                    <form action="confirmPurchase.jsp" method="POST" id="payment">
                        <input type="hidden" value="${param.payType}" id="payType" name="payType"/>
                        <div class="choose-pay">
                            <div class="payment-method-list clearfix text-right">
                                <div class="pay-method-item clearfix automation-payment-method-item" id="bank" onclick="submitPayTypeForm('bank')">
                                    <i class="fas fa-university"></i>
                                    <div>
                                        <div class="title">
                                            โอนเงินผ่านธนาคาร
                                        </div>
                                    </div>
                                </div>
                                <div class="pay-method-item clearfix automation-payment-method-item" id="openBox" onclick="submitPayTypeForm('credit')">
                                    <i class="far fa-credit-card"></i>
                                    <div>
                                        <div class="title">
                                            ชำระผ่านบัตรเครดิต/เดบิต
                                        </div>
                                    </div>
                                </div>
                                <div id="bankModel" class="model">
                                    <div class="model-content">
                                        <div class="model-header">
                                            <span class="close">&times;</span>
                                            <h2>โอนเงินผ่านธนาคาร</h2>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
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
                                        <td>รวมทั้งหมด</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <c:if test="${param.payType == 'credit'}">
                บัตรเครดิต<br>
                <form action="ConfirmPurchase.in" method="POST">
                    <div class="card card-body text-left">
                        <div class="img-list">
                            <img src="pic/visa.png" class="bank-img">
                            <img src="pic/jcb.png" class="bank-img">
                            <img src="pic/card.png" class="bank-img">
                        </div>
                        <div class="form-row">
                            <div class="col-md-4 mb-3">
                                <label for="validationDefault01" required class="next-from-item-label">หมายเลขบัตร</label>
                                <input type="text" class="form-control" id="validationDefault01" required placeholder="หมายเลขบัตร">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-6 mb-3">
                                <label for="validationDefault02" required class="next-from-item-label">ชื่อผู้ถือขัตร</label>
                                <input type="text" class="form-control" id="validationDefault03" placeholder="ชื่อผู้ถือบัตร" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-6 mb-3">
                                <label for="validationDefault03" required class="next-from-item-label">วันหมดอายุ</label>
                                <input type="text" class="form-control" id="validationDefault03" placeholder="MM/YY" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="validationDefault04" required class="next-from-item-label">CVV</label>
                                <input type="text" class="form-control" id="validationDefault03" placeholder="CVV" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="invalidCheck2" required>
                                <label class="form-check-label" for="invalidCheck2">
                                    ยินยอมกับการใช้บัตร
                                </label>
                            </div>
                        </div>
                        <button class="btn btn-primary" type="submit">สั่งซื้อสินค้า</button>
                    </div>
                    <c:set scope="session" var="paymentType" value="credit"/>
                </form>
            </c:if>
            <c:if test="${param.payType == 'bank'}">
                <form action="ConfirmPurchase.in" method="POST">
                    <div class="card card-body text-left">
                        <p>กรุณาทำรายการชำระค่าสินค้าภายใน48ชั่วโมง หากไม่ชำระภายในเวลาดังกล่าว การสั่งสินค้าของท่านจะโดนยกเลิก</p>
                        <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="customRadioInline1" name="customRadioInline1" class="custom-control-input">
                            <label class="custom-control-label" for="customRadioInline1"><img src="pic/k-bank.png" alt="ธนาคารกสิกรไทย " style="height: 45px; width: 132px"></label>
                        </div>
                        <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="customRadioInline2" name="customRadioInline1" class="custom-control-input">
                            <label class="custom-control-label" for="customRadioInline2"><img src="pic/scb.jpg" alt="ธนาคารไทยพาณิชย์ " style="height: 45px; width: 132px"></label>
                        </div>
                        <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="customRadioInline3" name="customRadioInline1" class="custom-control-input">
                            <label class="custom-control-label" for="customRadioInline3"><img src="pic/krungsri.jpg" alt="ธนาคารกรุงศรี " style="height: 45px; width: 132px"></label>
                        </div>
                        <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="customRadioInline4" name="customRadioInline1" class="custom-control-input">
                            <label class="custom-control-label" for="customRadioInline4"><img src="pic/ktb.jpg" alt="ธนาคารกรุงไทย " style="height: 45px; width: 132px"></label>
                        </div>
                        <button class="btn btn-primary" type="submit" style="width: 120px; margin-top: 15px">สั่งซื้อสินค้า</button>
                    </div>
                    <c:set scope="session" var="paymentType" value="bank"/>
                </form>
            </c:if>
            <div class="row margin-cart" id="cart">
                <div class="col-md-8 text-right">
                    <a href="#" class="btn btn-primary btn-md cart-link" role="button">
                        <i class="fas fa-angle-left" ></i>เลือกสินค้าต่อ
                    </a>
                    <a href="#" class="btn btn-primary btn-md cart-link" role="button">
                        ชำระสินค้า<i class="fas fa-angle-right"></i>
                    </a>
                </div>
            </div>
        </div>


        <!--Java Script-->
        <script>
            function submitForm(type)
            {
                document.getElementById("productType").value = type;
                document.getElementById("productTypeForm").submit();
            }
            function submitPayTypeForm(type)
            {
                document.getElementById("payType").value = type;
                document.getElementById("payment").submit();
            }
        </script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <% session.setAttribute("message", "");%>

    </body>
</html>
