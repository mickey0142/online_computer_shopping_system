<%-- 
    Document   : showProduct
    Created on : Apr 9, 2018, 9:34:26 AM
    Author     : Mickey
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="data" type="java.util.TreeMap" %>

<%-- any content can be specified here e.g.: --%>
<a href="product.jsp?id=${data.productId}">
   <div class="part-item hilight">
        <div class="part-name">
            <b>${data.productName}</b>
        </div>
        <div class="part-photo">
            <div class="part-overlay text-center"><img src="ShowPicture?id=${data.productId}&table=productpictures" class="img-prod"></div>
        </div>
        <div class="text-center">
            <div class="part-price"><b>ราคา : ${data.price}</b></div>
            <span>ดูรายละเอียดสินค้า</span>
        </div>
    </div>
</a>
