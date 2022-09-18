<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 	
	<style type="text/css">
	    .wrapper {
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
 -->
</head>
<body>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
		
	<h2>상품목록</h2>
	<button onclick="">카테고리 필터</button>
	<button onclick="">정렬</button>
	
	<div>
		<hr>
		<form action="listSelect" method="get">
			<input type="checkbox" id="">상품필터체크박스...
		</form>
	</div>
	
	<hr>
<!-- 	
	<div class="wrapper">
	    <div class="product">
	        여기에 상품 이미지, 카테고리 등 내용
	        <h1>상품1</h1>
	    </div>
	    <div class="product">
	        여기에 상품 이미지, 카테고리 등 내용
	        <h1>상품2</h1>
	    </div>
	</div>
	 -->
	
	
	<table border="1">
		<tr>
			<th>상품이미지</th>
			<th>이름</th>
			<th>상품가격</th>
			<th>리뷰수</th>
			<th>상품별점</th>
		</tr>
		
		<c:if test="${list.size() == 0 }">
				<tr>
					<th colspan="12">등록된 상품이 없습니다.</th>
				</tr>
		</c:if>
		
		<c:forEach var="dto" items="${list }">
			<tr>
				<c:if test="${ dto.productFile == 'nan' }">
					<td><a href="${contextPath}/product/productView?productNo=${dto.productNo }"><b>등록된 이미지가 없습니다.</b></a></td>
				</c:if>
				<c:if test="${ dto.productFile != 'nan' }">
					<td><a href="${contextPath}/product/productView?productNo=${dto.productNo }"><img width="200px" height="100px" src="${contextPath}/product/download?productFile=${dto.productFile}"></a></td>
				</c:if>
				<td><a href="${contextPath}/product/productView?productNo=${dto.productNo }">${dto.productName }</a></td>
				<td>${dto.productPrice }</td>
				<td>${dto.reviewCount }</td>
				<td>${dto.productRating }</td>
			</tr>
		</c:forEach>
		
	</table>
	<button onclick="location.href='productRegister'">상품 추가</button>
	
</body>
</html>