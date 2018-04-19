<%-- 
    Document   : selectProduct
    Created on : Apr 9, 2018, 9:30:25 AM
    Author     : Mickey
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="/WEB-INF/tlds/shortcut" prefix="shortcut" %>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="productId"%>
<%@attribute name="search"%>

<%-- any content can be specified here e.g.: --%>
<sql:query dataSource="comshopdb" var="product">
    select * from products where productId like "${productId}%" and productName like "%${search}%"
</sql:query>
    <% System.out.println(search); %>
<c:forEach var="i" items="${product.rows}">
    <shortcut:show data="${i}"></shortcut:show>
</c:forEach>