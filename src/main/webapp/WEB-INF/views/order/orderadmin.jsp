<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#tbody th:not(.start){
		display: none;
	}
	#modal_wrap{position: fixed; z-index: 9;margin: auto; display:none;
	 top:0; left: 0; right: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.4)
	}
	#first{position: fixed; z-index: 10;margin: auto; display:none;
	 top:30px; left: 0; right: 0; width: 350px; height: 450px; background-color: white;
	}
	#ordersection :hover {cursor: pointer;}
	#totalsection :hover {cursor: pointer;}
	#idsection :hover {cursor: pointer;}
</style>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<div id="modal_wrap">
	<div id="first">
		<div style="width: 250px; margin: auto; padding-top: 20px;">
			<form>
				아이디 : <input type="text" name="memberId" id="memberId" value="${cdto.memberId }" readonly="readonly"><br>
				주문번호 : <input type="text" name="orderNo" id="orderNo" value="${cdto.orderNo }" readonly="readonly"><br>
				<b>취소 사유</b><br>
				<textarea rows="5" cols="30" name="reason" id="reason" readonly="readonly">${cdto.reason }</textarea>
				<hr>
				<button type="button" class="cancelOk">주문취소 승인</button>
				<button type="button" class="cancelNone">주문취소 거절</button>
				<button type="button" onclick="slide_hide()">접기</button>
			</form>
		</div>
	</div>
</div>
	<h2>현재 접속자 : ${sessionScope.loginUser }</h2>
	<form id="searchform">
		<select name="type"><option value="orderNo">주문번호</option><option value="memberId">아이디</option></select><input type="text" name="keyword"><button type="button" onclick="getSearchList()">검색</button>
	</form>
	<table border="1" id="table">
		<tr>		
			<td id="ordersection">주문번호<img class="sort" src="http://localhost:8085/seeot/resources/images/sortingarrow.png" width="13px;" height=13px;"></td><td id="idsection">아이디<img class="sort" src="http://localhost:8085/seeot/resources/images/sortingarrow.png" width="13px;" height=13px;"></td><td>주문상품/옵션</td><td>구매수량</td><td>가격</td><td id="totalsection">총 주문 금액<img class="sort" src="http://localhost:8085/seeot/resources/images/sortingarrow.png" width="13px;" height=13px;"></td><td class="status">주문상태</td>
		</tr>
		<tbody id="tbody">
			<c:forEach var="odto" items="${list }" varStatus="status">				
				<tr>
					<th id="no${status.index }">${odto.orderNo }</th>
					<th id="id${status.index }">${odto.memberId }</th>
					<td> <img width="30px" height="30px" src="${odto.productFile}">${odto.productName } / ${odto.productColor } ${odto.productSize }</td>
					<td>${odto.orderStack }</td>
					<td id="price${status.index }">${odto.productPrice }</td>
					<th id="total${status.index }">1</th>
					<th id="status${status.index }">
						<c:if test="${odto.orderStatus == 1}">결제완료<br><button type="button" class="delevery">배송 시작</button></c:if>
						<c:if test="${odto.orderStatus == 0}">취소중<br><button type="button" onclick="slideClick()">취소 사유</button></c:if>
						<c:if test="${odto.orderStatus == -1}">취소완료</c:if>
						<c:if test="${odto.orderStatus == 2}">배송중<br><button type="button" class="endDelevery">배송 완료</button></c:if>
						<c:if test="${odto.orderStatus == 3}">배송완료</c:if></th>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/order/orderAdmin.js"></script>
</html>