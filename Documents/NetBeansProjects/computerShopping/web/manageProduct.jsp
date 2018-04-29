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
        <title>Manage Product</title>
    </head>
    <body>
        <%@include file="menu.jsp" %>
        <h1>Manage Product</h1>
        <sql:query dataSource="${applicationScope.datasourceName}" var="product">
            select * from products where productId like '${sessionScope.productTypeId}%'
            <c:if test="${param.search != '' and param.search != null}"> and productName like '${param.search}%'</c:if>
        </sql:query>
        <form action="manageProduct.jsp" method="POST">
            Product Name : <input type="text" name="search" value="" /> 
            <input type="submit" value="search" />
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
            <input type="hidden" value="manageProduct.jsp" id="backTo" name="backTo"/>
        </form>

        <jsp:useBean id="DBConn" scope="page" class="model.DBConnector"/>
        <form action="deleteProduct.emp" method="POST" id="deleteProduct">
            <input type="hidden" name="deleteId" value="test" id="deleteId"/>
        </form>
        <table>
            <tr>
                <th>Product Id</th><th>Product Name</th><th>In Stock</th><th>Price</th><th>update</th><th>delete</th>
            </tr>

            <c:forEach var="i" items="${product.rows}">
                <tr>
                    <td>${i.productId}</td><td>${i.productName}</td><td>${i.inStock}</td><td>${i.price}</td><td><a href="updateProduct.jsp?id=${i.productId}">update</a></td>
                    <td><a href="#" onclick="deleteConfirm(${i.productId})">delete</a></td>
                </tr>
            </c:forEach>
        </table>

        <a href="addProduct.jsp">add product</a>

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
    </body>
</html>
