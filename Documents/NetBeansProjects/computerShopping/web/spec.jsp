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
        <title>spec</title>
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
        <%@include file="menu.jsp" %><br>
        <h1>จัด spec</h1>
        C : ${sessionScope.compCodeC}<br>MC : ${sessionScope.compCodeMC}<br>MR : ${sessionScope.compCodeMR}<br>R : ${sessionScope.compCodeR}<br>
        <a href="RemoveFromSpec?index=-1">
                    <div style="background-color: lightgoldenrodyellow; width: 50px;">clear</div>
                </a>
        <form action="SetSessionValue" method="POST" id="productTypeForm">
            <div onclick="submitForm('01')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                mainboard${sessionScope.inSpec.get(1).getProduct().getName()}
            </div>
            <c:if test="${sessionScope.inSpec.get(1) != null}">
                <a href="RemoveFromSpec?index=1">
                    <div style="background-color: lightgoldenrodyellow; width: 50px;">remove</div>
                </a>
            </c:if>
            <div onclick="submitForm('02')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                cpu${sessionScope.inSpec.get(2).getProduct().getName()}
            </div>
            <c:if test="${sessionScope.inSpec.get(2) != null}">
                <a href="RemoveFromSpec?index=2">
                    <div style="background-color: lightgoldenrodyellow; width: 50px;">remove</div>
                </a>
            </c:if>
            <div onclick="submitForm('03')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                ram${sessionScope.inSpec.get(3).getProduct().getName()}
            </div>
            <c:if test="${sessionScope.inSpec.get(3) != null}">
                <a href="RemoveFromSpec?index=3">
                    <div style="background-color: lightgoldenrodyellow; width: 50px;">remove</div>
                </a>
            </c:if>
            <div onclick="submitForm('04')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                power supply${sessionScope.inSpec.get(4).getProduct().getName()}
            </div>
            <c:if test="${sessionScope.inSpec.get(4) != null}">
                <a href="RemoveFromSpec?index=4">
                    <div style="background-color: lightgoldenrodyellow; width: 50px;">remove</div>
                </a>
            </c:if>
            <div onclick="submitForm('05')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                graphic card${sessionScope.inSpec.get(5).getProduct().getName()}
            </div>
            <c:if test="${sessionScope.inSpec.get(5) != null}">
                <a href="RemoveFromSpec?index=5">
                    <div style="background-color: lightgoldenrodyellow; width: 50px;">remove</div>
                </a>
            </c:if>
            <div onclick="submitForm('06')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                harddisk${sessionScope.inSpec.get(6).getProduct().getName()}
            </div>
            <c:if test="${sessionScope.inSpec.get(6) != null}">
                <a href="RemoveFromSpec?index=6">
                    <div style="background-color: lightgoldenrodyellow; width: 50px;">remove</div>
                </a>
            </c:if>
            <div onclick="submitForm('07')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                monitor${sessionScope.inSpec.get(7).getProduct().getName()}
            </div>
            <c:if test="${sessionScope.inSpec.get(7) != null}">
                <a href="RemoveFromSpec?index=7">
                    <div style="background-color: lightgoldenrodyellow; width: 50px;">remove</div>
                </a>
            </c:if>
            <div onclick="submitForm('08')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                keyboard${sessionScope.inSpec.get(8).getProduct().getName()}
            </div>
            <c:if test="${sessionScope.inSpec.get(8) != null}">
                <a href="RemoveFromSpec?index=8">
                    <div style="background-color: lightgoldenrodyellow; width: 50px;">remove</div>
                </a>
            </c:if>
            <div onclick="submitForm('09')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                mouse${sessionScope.inSpec.get(9).getProduct().getName()}
            </div>
            <c:if test="${sessionScope.inSpec.get(9) != null}">
                <a href="RemoveFromSpec?index=9">
                    <div style="background-color: lightgoldenrodyellow; width: 50px;">remove</div>
                </a>
            </c:if>
            <div onclick="submitForm('10')" style="background-color: lightgray; margin-top: 5px; width: 100px;">
                case${sessionScope.inSpec.get(10).getProduct().getName()}
            </div>
            <c:if test="${sessionScope.inSpec.get(10) != null}">
                <a href="RemoveFromSpec?index=10">
                    <div style="background-color: lightgoldenrodyellow; width: 50px;">remove</div>
                </a>
            </c:if>
            <input type="hidden" value="${sessionScope.specProductTypeId}" id="productType" name="specProductTypeId"/>
            <input type="hidden" value="spec.jsp" id="backTo" name="backTo"/>
            <input type="hidden" value="specProductTypeId" name="attributeName"/>
        </form>

        <shortcut:select productId="${sessionScope.specProductTypeId}" search="${param.searchName}"></shortcut:select>

        <!--javascript-->
        <script>
            function submitForm(type)
            {
                document.getElementById("productType").value = type;
                document.getElementById("backTo").value = "spec.jsp";
                document.getElementById("productTypeForm").submit();
            }
            function submitRemoveForm(type)
            {
                
            }
        </script>
    </body>
</html>
