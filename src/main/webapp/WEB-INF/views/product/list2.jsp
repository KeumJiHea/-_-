<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<style type="text/css">
	    .wrapper {
	    	width : 35%;
	        display: flex;
	        flex-wrap: wrap;
	    }
	    .product {
	        width: calc( 100% / 3 - 10px );
	        justify-content: space-between;
	        background-color: #ddd;
	        margin: 5px;
	    }
	</style>
 
</head>
<body>

	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<c:set var="contextPath" value="${pageContext.request.contextPath }" />
	 
	<button onclick="">카테고리 필터</button>
	<button onclick="">정렬</button>
	
	<div>
		<hr>
		<form action="listSelect" method="get">
			<input type="checkbox" id="">상품필터체크박스...
		</form>
	</div>
	
	<hr>
	 
	 <div class="wrapper">
		 <c:forEach var="dto" items="${list }">
		 <div class="product">
			<a href="${contextPath}/product/productView?productNo=${dto.productNo }">
		 	<span><img width="240px" height="300px" src="${contextPath}/product/download?productFile=${dto.productFile}"></span><br>
		 	<span><b>${dto.productName }</b></span><br>
		 	<span><b><fmt:formatNumber value="${dto.productPrice }" pattern="###,###,###"/></b></span>
		 	</a> 
		 </div>
		 </c:forEach>
	 </div>

</body>
</html>