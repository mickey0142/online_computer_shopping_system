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
<sql:query dataSource="${applicationScope.datasourceName}" var="product">
    select * from products where productId like "${productId}%" and productName like "%${search}%"
</sql:query>
<jsp:useBean id="DBConn" scope="page" class="model.DBConnector"/>
<!--query for using in spec : select * from products left outer join producttype2 using (productId) where เหมือนเดิม and 
(compatibility like 'ตัวแปร__' or compatibility < '0I_' or compatibility is null)
use fn:substring in el expression $ { } in here      ^ to cut string to only second char of compatibility-->
<c:forEach var="i" items="${product.rows}">
    <shortcut:show data="${i}"></shortcut:show>
</c:forEach>