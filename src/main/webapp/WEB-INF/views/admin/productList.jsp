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
	
	<script type="text/javascript">
		function chkData() {
			if (document.getElementById('val').value == "") {
				alert("검색할 내용을 입력해주세요")
				val.focus()
			} else {
				searchFo.submit();
			}
		}
	</script>
		
	<h2>전체 상품목록</h2>
	<button onclick="location.href='productList'">전체 상품 보기</button>
	<button onclick="location.href='productRegister'">상품 추가</button>
	<form action="${contextPath}/product/searchProduct" method="post" id="searchFo">
		<select size="1" name="search" id="box">
			<option value="productNo">상품 번호
			<option value="productName">상품 이름
			<option value="productCategorie">상품 카테고리
		</select>
		<input type="text" name="val" id="val" placeholder="검색할 내용">
		<button type="button" onclick="chkData()">검색</button>
	</form>
	<hr>
	
	<table border="1">
		<tr>
			<th>상품 번호</th>
			<th>상품 이미지</th>
			<th>상품 이름</th>
			<th>상품 가격</th>
			<th>리뷰 수</th>
			<th>상품 별점</th>
			<th>상품 관리</th>
			<th>상품 재고 관리</th>
		</tr>
		
		<c:if test="${list.size() == 0 }">
				<tr>
					<th colspan="8">등록된 상품이 없습니다.</th>
				</tr>
		</c:if>
		
		<c:forEach var="dto" items="${list }">
			<tr>
				<td><a href="${contextPath}/product/productView?productNo=${dto.productNo }">${dto.productNo }</a></td>
				<c:if test="${ dto.productFile == 'nan' }">
					<td><b>등록된 이미지가 없습니다.</b></a></td>
				</c:if>
				<c:if test="${ dto.productFile != 'nan' }">
					<td><img width="200px" height="100px" src="${contextPath}/product/download?productFile=${dto.productFile}"></a></td>
				</c:if>
				<td>${dto.productName }</a></td>
				<td>${dto.productPrice }</td>
				<td>${dto.reviewCount }</td>
				<td>${dto.productRating }</td>
				<td>
					<button type="button" onclick="location.href='productModify_Form?productNo=${dto.productNo }'" >상품 정보 수정</button><br>
					<button type="button" onclick="location.href='productDelete?productNo=${dto.productNo }&productFile=${dto.productFile}&productContent=${dto.productContent }'">상품 삭제</button>
				</td>
				<td><button type="button" onclick="location.href='managementView?productNo=${dto.productNo }'" >상품 재고 관리</button></td>
			</tr>
		</c:forEach>
		
	</table>

</body>
</html>