<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
		
	<h2>상품목록</h2>
	<button onclick="">카테고리 필터</button>
	<button onclick="">정렬</button>
	
	<div>
		<form action="">
			
		</form>
	</div>
	
	<hr>
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