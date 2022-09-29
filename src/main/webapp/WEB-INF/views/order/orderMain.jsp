<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- jQuery -->
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/common.css">
<body>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
	<input type="hidden" id="hipath" value="${contextPath }">
	<input type="hidden" id="hiemail" val="${info.email }">
	<input type="hidden" id="hiname" val="${info.name }">
	<input type="hidden" id="hiphone" val="${info.phone }">
	<input type="hidden" id="hipostcode" value="${info.addr1}">
	<input type="hidden" id="hiaddr1" value="${info.addr2}">
	<input type="hidden" id="hiaddr2" value="${info.addr3}">
	<div>
		<form action="#" method="post">
			<input type="hidden" name="productPrice" id ="productPrice" value="${pdto.productPrice }">
			<table id="orderTable" border="1">				
				<tr>
					<th>상품번호</th><th>상품이미지</th><th>상품명</th><th>옵션</th><th>상품가격</th><th>구매수량</th>
				</tr>
				<tbody id="tbody">
				<c:forEach var="pdto" items="${list }" varStatus="status">
					<tr>
						<td id="productnotd${status.index }">${pdto.productNo }</td>
					<td>
						<c:if test="${ pdto.productFile == 'nan' }">
							<b>등록된 이미지가 없습니다.</b>
						</c:if>
						<c:if test="${ pdto.productFile != 'nan' }">
							<img width="100px" height="100px" id="file${status.index }" src="${contextPath}/product/download?productFile=${pdto.productFile}">
						</c:if>
					</td>
					<td id="pname${status.index }">${pdto.productName }</td>
					<td><span id="color${status.index }">${pdto.productColor }</span>/<span id="size${status.index }">${pdto.productSize }</span></td>
					<td>
						<span id="price${status.index }">${pdto.productPrice }</span>						
					</td>
					<td>
						<input type="number" min="0" max="10" name="productStack" id="productStack${status.index }" placeholder="1" onchange="change()" value="${pdto.productStack }"><br>
						<span id="goods_total_price${status.index }">${pdto.productPrice*pdto.productStack }</span>원
					</td>
					</tr>
				</c:forEach>
				</tbody>	
			</table>
				<hr>
				총 금액 <span id="total_price">${pdto.productPrice*pdto.productStack }</span>원<br>
				<hr>
				배송지 입력 (가입시 등록주소)<input type="checkbox" onchange="setaddr()" name="orderaddr" id="orderaddr"><br>
				<input type="text" onclick="daumPost()" id="postcode"><br>
				<input type="text" onclick="daumPost()" id="addr1" ><br>				
				<input type="text" onclick="daumPost()" id="addr2" ><br>
				<button type="button" onclick="order()">결제하기</button>
		</form>
	</div>
</body>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/order/orderMain.js"></script>