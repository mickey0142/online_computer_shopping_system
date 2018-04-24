<%-- 
    Document   : index
    Created on : Apr 9, 2018, 9:26:48 AM
    Author     : Mickey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="/WEB-INF/tlds/shortcut" prefix="shortcut" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping</title>
        <link rel="stylesheet" href="index.css">
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
        <% session.setAttribute("message", "");%>
        <c:if test="${sessionScope.productTypeId == null}">
            <c:set scope="session" var="productTypeId" value="%"/>
        </c:if>
        ${sessionScope.productTypeId}
        <%@include file="menu.jsp" %><br>
        
        <form action="index.jsp">
            <div class="col-6 searching">
                <input class="form-control mr-sm-2" type="text" placeholder="ค้นหาสินค้าที่คุณต้องการ..." aria-label="Search" name="searchName" >
            </div>
        </form>
        
        <form action="SetSessionValue?attributeName=productTypeId" method="POST" id="productTypeForm">
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
        </form>
        
        <shortcut:select productId="${sessionScope.productTypeId}" search="${param.searchName}"></shortcut:select>
        <c:if test="${sessionScope.loginFlag and sessionScope.isEmp == null}">
            <%@include file="showCart.jsp" %>
        </c:if>
        
        <!--javascript-->
        <script>
            function submitForm(type)
            {
                document.getElementById("productType").value = type;
                document.getElementById("productTypeForm").submit();
            }
        </script>
    </body>
</html>
