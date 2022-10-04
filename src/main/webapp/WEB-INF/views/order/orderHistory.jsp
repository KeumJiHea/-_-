<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
 <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/common.css">
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
	th, td{padding: 25px;}
</style>
<body>
<div id="modal_wrap">
	<div id="first">
	<br><br><br>
		<div style="width: 250px; margin: auto; padding-top: 20px;">
			<form>
				<input type="hidden" name="orderNo" id="orderNo">
				<b>취소 사유</b><br>
				<textarea rows="5" cols="30" name="reason" id="reason"></textarea>
				<hr>
				<button type="button" class="fcancel">주문취소</button>
				<button type="button" onclick="slide_hide()">접기</button>
			</form>
		</div>
	</div>
</div>
<div align="center">
	<table border="1" id="ordertable">
		<tr>
			<th>주문번호</th>
			<th>이미지</th>
			<th>상품명/옵션</th>
			<th>상품금액</th>
			<th>수량</th>
			<th>주문상태<br>
				<form id="searchform">
					<select name="type" onchange="getSearchList()">
						<option value="1">선택하세요</option>
						<option value="1">주문완료</option>
						<option value="0">주문취소중</option>
						<option value="-1">취소완료</option>
						<option value="2">배송중</option>
						<option value="3">배송완료</option>
					</select>
		</form></th><th>확인/리뷰</th>
		</tr>
		<c:if test="${orderli == null }">
			<tr>
				<th colspan="5">주문한 상품이 없습니다</th>
			</tr>
		</c:if>
		<c:if test="${orderli != null }">
		<tbody id="tbody">	
			<c:forEach var="dto" items="${orderli }" varStatus="status">			
				<tr>
					<th id="no${status.index }">${dto.hiOrderNo }</th>
					<td><img width="50px" height="50px" src="${dto.hiProductFile }"></td>
					<td>${dto.hiProductName}<br>옵션 : ${dto.hiProductColor } / ${dto.hiProductSize }</td>
					<td>${dto.hiProductPrice }</td>
					<td>${dto.hiOrderStack }</td>
					<th id="status${status.index }"> 
						<c:if test="${dto.hiOrderStatus == 1}"><span id="status">주문완료</span><br>
						<button type="button" class='cancel'>주문 취소</button>
						</c:if>
						<c:if test="${dto.hiOrderStatus == 0}">취소중<br></c:if>
						<c:if test="${dto.hiOrderStatus == -1}">취소완료</c:if>
						<c:if test="${dto.hiOrderStatus == 2}">배송중<br><button type="button" class="endDelevery">배송 완료</button></c:if>
						<c:if test="${dto.hiOrderStatus == 3}">배송완료</c:if>
						</th>
						<td>리뷰남기기</td>
				</tr>
			</c:forEach>
		</tbody>	
		</c:if>
	</table>
</div>
</body>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/order/orderhistory.js"></script>