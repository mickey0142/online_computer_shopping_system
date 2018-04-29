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
<%@attribute name="fromPage" %>
<%@attribute name="pageNum" %>

<%-- any content can be specified here e.g.: --%>
<c:if test="${fromPage == 'shopping'}">
    <sql:query dataSource="${applicationScope.datasourceName}" var="product">
        select * from products where productId like "${productId}%" and productName like "%${search}%"
    </sql:query>
</c:if>
<c:if test="${fromPage == 'spec'}">
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
        where productId like "${productId}%" and productName like "%${search}%" and
        (compatibility like '${firstChar}__' or compatibility < '0${secondChar}' or compatibility is null)
    </sql:query>
</c:if>
<jsp:useBean id="DBConn" scope="page" class="model.DBConnector"/>
<!--query for using in spec : select * from products left outer join producttype2 using (productId) where เหมือนเดิม and 
(compatibility like 'ตัวแปร__' or compatibility < '0I_' or compatibility is null)
use fn:substring in el expression $ { } in here      ^ to cut string to only second char of compatibility-->
<c:set scope="page" var="count" value="1"/>
<c:forEach var="i" items="${product.rows}">
    <c:if test="${count <= pageNum*12 and count > (pageNum-1)*12}">
        <shortcut:show data="${i}"></shortcut:show>
    </c:if>
    <c:set var="count" value="${count + 1}"/>
</c:forEach>