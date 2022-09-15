<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script type="text/javascript">
	function cancel(){
		alert('취소 준비중')
	}
</script>
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
				<th>${order.merchant_uid }</th><th><img width="50px" height="50px" src="${order.gfile[i] }"></th><th>${order.glist[i]}<br>옵션 : ${order.gcolor[i] } / ${order.gsize[i] }</th><th>${order.gcost[i] }/${order.gstack[i] }</th><th>주문완료<br><button type="button" onclick="cancel()">주문취소</button></th><th>확인</th>
			</tr>
		</c:forEach>	
	</c:if>
</table>
</body>
</html>