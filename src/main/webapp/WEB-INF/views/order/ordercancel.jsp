<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<h1>ordercheck.page</h1>
	<form>
		아이디 : <input type="text" name="memberId" id="memberId" value="${cdto.memberId }" readonly="readonly"><br>
		주문번호 : <input type="text" name="orderNo" id="orderNo" value="${cdto.orderNo }" readonly="readonly"><br>
		<input type="hidden" id="cost" value="${cost }">
		<b>취소 사유</b><br>
		<textarea rows="5" cols="30" name="reason" id="reason" readonly="readonly">${reason }</textarea>
		<hr>
		<button type="button" class="cancelOk">주문취소 승인</button>
		<button type="button" class="cancelNone">주문취소 거절</button>
	</form>
</body>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/order/orderCancel.js"></script>
</html>