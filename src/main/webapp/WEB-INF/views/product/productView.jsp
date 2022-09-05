<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function test(){
		$.ajax({
			url:"${contextPath}/cart/addcart",
			type:"post",
			data:{
				productNo : "${pdto.productNo}",
				productStack : $("#productStack").val()
			},
			success:function(productNo,productStack){
				console.log(productNo)
				alert('ok')
			},
			error:function(data){
				console.log(data)
				alert('no')
				
			}
		});
	}
</script>
</head>
<body>


	
	
	<button type="button" onclick="location.href='list'" >상품 리스트로 가기</button>
	<button type="button" onclick="location.href='productUpdate'" >상품 수정</button>
	<button type="button" onclick="location.href='productStackUpdate'" >상품 재고 등록</button>
	<button type="button" onclick="location.href='proDelete?productNo=${pdto.productNo}&productFile=${pdto.productFile }'">상품 삭제</button>
	
	<form action="#" method="post">
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
				<c:forEach var="mdto" items="${mlist }">
					<button>${mdto.productColor }</button>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th colspan="3">사이즈</th>
		</tr>
		<tr>
			<td colspan="3">
				<c:forEach var="mdto" items="${mlist }">
					<button>${mdto.productSize }</button>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th colspan="3">구매 갯수</th>
		</tr>
		<tr>
			<td colspan="3">
				<input type="number" name="productStack" id="productStack" placeholder="1" min="1">
			</td>
		</tr>
		<tr>
			<td><button type="button" onclick="#">찜♡</button></td>
			<td><button type="button" onclick="test()">장바구니</button></td>
			<td><button type="button" onclick="location.href='${contextPath}/order/ordermain?productNo=${pdto.productNo }'">구매하기</button></td>
		</tr>
	</table>
	</form>
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