<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
</head>
<body>

<table border="1" id="ordertable">
	<tr>
		<th>주문번호</th><th>이미지</th><th>상품명/옵션</th><th>상품금액/수량</th><th>주문상태</th><th>확인/리뷰</th>
	</tr>
	<c:if test="${sessionScope.orderdata ==null }">
		<tr>
			<th colspan="5">주문한 상품이 없습니다</th>
		</tr>
	</c:if>
	<c:if test="${sessionScope.orderdata != null }">	
		<c:forEach begin="0" end="${result-1 }" var="i">			
			<tr>
				<th>${order.merchant_uid }</th><th><img width="50px" height="50px" src="${order.gfile[i] }"></th><th>${order.glist[i]}</th><th>${order.gcost[i] }/${order.gstack[i] }</th><th>주문완료</th><th>확인</th>
			</tr>
		</c:forEach>	
	</c:if>
</table>
	총 세션 : ${sessionScope.orderdata}<br>
	주문번호 : ${sessionScope.orderdata.merchant_uid }<br>
	제품번호 배열 : ${sessionScope.orderdata.gno }<br>
	각제품명 배열 : ${sessionScope.orderdata.glist }<br>
	각제품갯수 배열 : ${sessionScope.orderdata.gstack }<br>
	간단한 제품명 : ${sessionScope.orderdata.name  }<br>
	총 가격 : ${sessionScope.orderdata.amount  }<br>
	구매자 이름 : ${sessionScope.orderdata.buyer_name  }<br>
	구매자 주소 : ${sessionScope.orderdata.buyer_addr  }<br>
	구매자 우편번호 : ${sessionScope.orderdata.buyer_postcode  }<br>
	<hr>
	총 세션 : ${sessionScope.orderdata}<br>
	주문번호 : ${order.merchant_uid }<br>
	제품번호 배열 : ${order.gno }<br>
	각제품명 배열 : ${order.glist }<br>
	각제품갯수 배열 : ${order.gstack }<br>
	간단한 제품명 : ${order.name  }<br>
	총 가격 : ${order.amount  }<br>
	구매자 이름 : ${order.buyer_name  }<br>
	구매자 주소 : ${order.buyer_addr  }<br>
	구매자 우편번호 : ${order.buyer_postcode  }<br>
	${paramValues.order.glist }
</body>
</html>