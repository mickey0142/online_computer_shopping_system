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
        <title>Confirm Purchase</title>
    </head>
    <body>
        <c:if test="${sessionScope.message != '' and sessionScope.message != null}">
            <script>
                alert("${sessionScope.message}");
            </script>
        </c:if>
        <h1>confirm purchase</h1>
        เลือกประเภทการชำระเงิน <br>
        <c:if test="${empty param.paytype}">
            <jsp:forward page="confirmPurchase.jsp">
                <jsp:param name="paytype" value="credit"></jsp:param>
            </jsp:forward>
        </c:if>
        <form action="confirmPurchase.jsp" method="POST" id="payment">
            <c:if test="${param.paytype == 'credit'}">
                บัตรเครดิต : <input type="radio" name="paytype" value="credit" checked="checked" onclick="submitForm()" /> 
                โอนผ่านธนาคาร : <input type="radio" name="paytype" value="bank" onclick="submitForm()" /><br>
            </c:if>
            <c:if test="${param.paytype == 'bank'}">
                บัตรเครดิต : <input type="radio" name="paytype" value="credit" onclick="submitForm()" /> 
                โอนผ่านธนาคาร : <input type="radio" name="paytype" value="bank" checked="checked" onclick="submitForm()" /><br>
            </c:if>
        </form>
        <c:if test="${param.paytype == 'credit'}">
            บัตรเครดิต<br>
            <form action="ConfirmPurchase.in" method="POST">
                หมายเลขบัตร : <input type="text" name="cardNumber" value="" /><br>
                ชื่อผู้ถือบัตร : <input type="text" name="cardName" value="" /><br>
                วันหมดอายุ : <input type="text" name="expireDate" value="" /><br>
                CVV : <input type="text" name="cvv" value="" /><br>
                <c:set scope="session" var="paymentType" value="credit"/>
                <input type="submit" value="ยืนยันการสั่งซื้อ" />
            </form>
        </c:if>
        <c:if test="${param.paytype == 'bank'}">
            โอน<br>
            <form action="ConfirmPurchase.in" method="POST">
                อัพโหลดรูป<br>
                <c:set scope="session" var="paymentType" value="bank"/>
                <input type="submit" value="ยืนยันการสั่งซื้อ" />
            </form>
        </c:if>
        <% session.setAttribute("message", "");%>
        
        <!--javascript-->
        <script>
            function submitForm()
            {
                document.getElementById("payment").submit();
            }
        </script>
    </body>
</html>
