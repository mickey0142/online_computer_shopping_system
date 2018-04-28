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
        <title>product</title>
    </head>
    <body>
        <%@include file="menu.jsp" %><br>
        <h1>Product !</h1>
        <sql:query dataSource="${applicationScope.datasourceName}" var="product">
            select * from products where productId = "${param.id}"
        </sql:query>
        <jsp:useBean id="DBConn" scope="page" class="model.DBConnector"/>
        <c:forEach var="i" items="${product.rows}">
            Product Id : ${i.productId}<br>
            Product Name : ${i.productName}<br>
            Description : ${i.description}<br>
            Price : ${i.price}<br>
            <c:if test="${i.instock <= 0}">
                Out of Stock !!
            </c:if>
            <!-- check if to query for more data if product is not normal type -->
            <c:if test="${i.instock > 0 and sessionScope.isEmp == null}">
                <a href="AddToCart.in?productId=${i.productId}">
                    <div style="display: inline-block; width: 100px; height: 100px; background-color: lightblue">
                        add to cart
                    </div>
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
                <c:if test="${fn:startsWith(i.productId, '04') or fn:startsWith(i.productId, '05') or fn:startsWith(i.productId, '06')}">
                    <sql:query dataSource="${applicationScope.datasourceName}" var="type1">
                        select * from producttype1 where productId = ${i.productId}
                    </sql:query>
                    <c:forEach var="j" items="${type1.rows}">
                        <input type="hidden" name="powerConsumption" value="${j.powerConsumption}" />
                    </c:forEach>
                </c:if>
                <div onclick="submitForm()" style="width: 100px; height: 100px; background-color: lightcoral">
                    add to spec
                </div>
            </form>
        </c:forEach>
        <br>
        <c:if test="${sessionScope.isEmp == null and sessionScope.loginFlag}">
            <%@include file="showCart.jsp" %>
        </c:if>

        <!--javascript-->
        <script>
            function submitForm()
            {
                document.getElementById("AddToSpec").submit();
            }
        </script>
    </body>
</html>
