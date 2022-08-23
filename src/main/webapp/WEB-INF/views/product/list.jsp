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
		
	<h2>카테고리 상품</h2>
	<table border="1">
		<tr>
			<th>상품번호</th>
			<th>이름</th>
			<th>재고수량</th>
			<th>상품가격</th>
			<th>상품이미지</th>
			<th>상품카테고리</th>
			<th>상품등록일</th>
			<th>리뷰수</th>
			<th>상품별점</th>
			<th>상품사이즈</th>
			<th>상품색</th>
			<th>찜하기</th>
		</tr>
		
		<c:if test="${list.size() == 0 }">
				<tr>
					<td colspan="6">등록된 상품이 없습니다</td>
				</tr>
		</c:if>
		
		<c:forEach var="dto" items="${list }">
			<tr>
				<td>${dto.productNo }</td>
				<td>${dto.productName }</td>
				<td>${dto.productStack }</td>
				<td>${dto.productPrice }</td>
				
				<c:if test="${ dto.productFile == 'nan' }">
					<td><b>이미지가 없습니다</b></td>
				</c:if>
				<c:if test="${ dto.productFile != 'nan' }">
					<td><img width="200px" height="100px" src="${contextPath}/product/download?productFile=${dto.productFile}"></td>
				</c:if>
				
				<td>${dto.productCategorie }</td>
				<td>${dto.productDate }</td>
				<td>${dto.reviewCount }</td>
				<td>${dto.productRating }</td>
				<td>${dto.productSize }</td>
				<td>${dto.productColor }</td>
				<td><button onclick="#">찜콩</button></td>
			</tr>
		</c:forEach>
		
	</table>
	
</body>
</html>