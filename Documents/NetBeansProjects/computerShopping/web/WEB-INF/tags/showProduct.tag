<%-- 
    Document   : showProduct
    Created on : Apr 9, 2018, 9:34:26 AM
    Author     : Mickey
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="data" type="java.util.TreeMap" %>

<%-- any content can be specified here e.g.: --%>
<a href="product.jsp?id=${data.productId}"
   <div style="border: 1px solid black; width: 30%; height: 50%; margin: 10px; display: inline-block">
        ${data.productId} ${data.productName}
    </div>
</a>