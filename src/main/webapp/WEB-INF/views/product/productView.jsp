<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript">
	var pc, ps
	var cnt = 1
	function colorAdd(productColor) {
		console.log(productColor)
		pc = productColor
	}
	
	function sizeAdd(proSize) {
		console.log(proSize)
		ps = proSize
		productSelect()
	}
	
	function productSelect() {
		
		if(pc != '' & ps != '') {
			$("#proOrderAdd").append("<div id='"+cnt+"'>"+ pc + " / " + ps
				+ "<input type='button' value='▼' onClick='javascript:this.form.productStack.value--;'>"
				+ "<input type='text' name='productStack' id='productStack' placeholder='0'>"
				+ "<input type='button' value='▲' onClick='javascript:this.form.productStack.value++;'>"
					+" </div>")
			cnt++
		}
		pc = ''
		ps = ''
		
	}
	
	function proOrderAdd() {
		$("#proOrderAdd").hide()
	}
	
	</script>
	
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<c:set var="contextPath" value="${pageContext.request.contextPath }" />
	
	<button type="button" onclick="location.href='list'" >상품 리스트로 가기</button>
	<b> | 상품 관리 | </b>
	<button type="button" onclick="location.href='productModify_Form?productNo=${pdto.productNo}'" >상품 정보 수정</button>
	<button type="button" onclick="location.href='productDelete?productNo=${pdto.productNo}&productFile=${pdto.productFile }'">상품 삭제</button>
	<b> | 재고 관리 | </b>
	<button type="button" onclick="location.href='managementView?productNo=${pdto.productNo}'" >상품 재고 관리</button>
	
	<table border="1">
		<tr>
			<td rowspan="10">
				<c:if test="${ pdto.productFile == 'nan' }">
					<b>등록된 이미지가 없습니다.</b>
				</c:if>
				<c:if test="${ pdto.productFile != 'nan' }">
					<img width="300px" height="300px" src="${contextPath}/product/download?productFile=${pdto.productFile}">
				</c:if>
			</td>
			<th>상품 이름</th><td colspan="2">${pdto.productName }</td>
		</tr>
		<tr>
			<th>가격</th><td colspan="2">${pdto.productPrice }</td>
		</tr>
		<tr>
			<td colspan="3">리뷰 수 : ${pdto.reviewCount } / 별점 : ${pdto.productRating }</td>
		</tr>
		<tr>
			<th colspan="3">컬러</th>
		</tr>
		<tr>
			<td colspan="3">
				<c:forEach var="mcdto" items="${mclist }">
					<button onclick="colorAdd(this.id)" id="${mcdto.productColor }"">${mcdto.productColor }</button>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th colspan="3">사이즈</th>
		</tr>
		<tr>
			<td colspan="3">
				<c:forEach var="msdto" items="${mslist }">
					<button onclick="sizeAdd(this.id)" id="${msdto.productSize }">${msdto.productSize }</button>
				</c:forEach>
			</td>
		</tr>
		<tr>
		</tr>
		<tr>
			<td colspan="3">
			<form action="${contextPath}/product/product" id="proOrderFo" method="post" enctype="multipart/form-data">
				<input type="hidden" name="productNo" value="${pdto.productNo }">
				<input type="hidden" name="productName" value="${pdto.productName }">
				<input type="hidden" name="productFile" value="${pdto.productFile }">
				
				<!-- <input type="button" value="▼" onClick="javascript:this.form.productStack.value--;">
				<input type="text" name="productStack" id="productStack" placeholder="0">
				<input type="button" value="▲" onClick="javascript:this.form.productStack.value++;"> -->
				<div id="proOrderAdd">
				</div>
			</form>
			</td>
		</tr>
		<tr>
			<td><button type="button" onclick="">찜</button></td>
			<td><button type="button" onclick="location.href='${contextPath}/cart/addcart?productNo=${pdto.productNo }'">장바구니</button></td>
			<td><button type="button" onclick="location.href='${contextPath}/order/ordermain?productNo=${pdto.productNo }'">구매하기</button></td>
		</tr>
	</table>
	<hr>
	
	<div id="proContent">
	<h2>상품 상세 정보</h2>
	<hr>
	${pdto.productContent }
	</div><br><br>
	
	<div id="proReview">
	<h2>상품 후기</h2>
	<hr>
	<table border="1">
		<tr>
			<td>김**(kim*****) | 2022-08-24 | 평점 ★★★☆☆<br>후기1 입니다</td>
		</tr>
		<tr>
			<td>정**(jung*****) | 2022-08-26 | 평점 ★☆☆☆☆<br>후기2 입니다</td>
		</tr>
	</table>
	</div><br><br>
	
	<div id="changeGuide">
	<h2>배송/교환/환불 안내</h2>
	<hr>
	<table border="1">
		<tr>
			<th>배송 안내</th><td>- 저희 SeeoT는 무료 배송입니다.</td>
		</tr>
		<tr>
			<th>교환 안내</th><td>- 구매 3일안에 교환 요청시 교환이 가능합니다.</td>
		</tr>
		<tr>
			<th>환불 안내</th><td>- 구매 7일 이후 또는 개봉 후 사용 흔적이 있으면 환불이 불가능 합니다.<br>- 단순 변심으로는 환불이 안됩니다.</td>
		</tr>
	</table>
	</div>
	
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<a href="#top">최상위로</a>
	<a href="#proContent">상세정보</a>
	<a href="#proReview">상품 후기</a>
	<a href="#changeGuide">배송/교환/환불</a>
	

</body>
</html>