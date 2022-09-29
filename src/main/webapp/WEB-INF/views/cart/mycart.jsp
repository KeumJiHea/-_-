<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/common.css">
<style>
th, td{padding: 50px;}
</style>
<body>
	<br><br><br>
	<input type="hidden" id="hipath" value="${contextPath }">
	<input type="hidden" id="hiid" value="${sessionScope.loginUser }">
	<input type="hidden" id="hiemail" value="${info.email }">
	<input type="hidden" id="hiname" value="${info.name }">
	<input type="hidden" id="hiphone" value="${info.phone }">
	<input type="hidden" id="hipostcode" value="${info.addr1}">
	<input type="hidden" id="hiaddr1" value="${info.addr2}">
	<input type="hidden" id="hiaddr2" value="${info.addr3}">
	<div align="center">
		<form action="${contextPath}/order/cartorder" method="post">
			<table id="cartTable" border="1">
			<thead> 
				<tr>
					<th>전체 선택
					<c:if test="${cart.size()!=0 }">
						<br><input type='checkbox' name='orderAllCheck' id="orderAllCheck" checked="checked" onchange="change()" onclick='checkAll()'/>
					</c:if>
					</th>
					<th>상품번호</th><th>상품이미지</th><th>상품명</th><th>옵션</th><th>상품가격</th><th>구매수량</th><th></th>
				</tr>
				<c:if test="${cart.size()==0 }">
					<tr>
						<td colspan="8">장바구니에 물건이 없습니다!!</td>
					</tr>
				</c:if>
			</thead>
				<c:if test="${cart.size()!=0 }">
				<tbody id="tbody">
					<c:forEach var="cart" items="${cart }" varStatus="status">					
					<tr>
						<th><input type="checkbox" name='orderChkbox' id="orderchk${status.index }" onchange="change()" checked="checked" value="${cart.cartNum }">
							<input type="hidden" name="cartNum${status.index }" id="cartNum${status.index}" value="${cart.cartNum }">
						</th>
						<td id="productnotd${status.index }">${cart.productNo }</td>
						<th>
							<c:if test="${ cart.productFile == 'nan' }">
								<b>등록된 이미지가 없습니다.</b>
							</c:if>
							<c:if test="${ cart.productFile != 'nan' }">
								<img id="file${status.index }" width="100px" height="100px" src="${contextPath}/product/download?productFile=${cart.productFile}">
							</c:if>
						</th>
						<th id="pname${status.index }">${cart.productName }</th>
						<th><span id="color${status.index }">${cart.productColor }</span><br> 
							<span id="size${status.index }">${cart.productSize }</span>
						</th>
						<th id="price${status.index }">${cart.productPrice }</th>
						<th>
							<input type="number" min="1" max="10" name="productStack" id="productStack${status.index }" onchange="change()" value="${cart.productStack }" placeholder="${cart.productStack }"><br>
							<span id="goods_total_price${status.index }">${cart.productPrice*cart.productStack }</span>원
						</th>
						<th><button type="button" class="deletebtn">삭제</button></th>
						</tr>
					</c:forEach>
				</tbody>
				</c:if>
			</table>
			<button type="button" class="chkdel">선택 삭제</button> <button type="button" onclick="alldel()">전체 삭제</button>
			<hr>
				총 금액<span id="total_price"></span>원<br>
			<hr>
				배송지 입력 (가입시 등록주소)<input type="checkbox" onchange="setaddr()" name="orderaddr" id="orderaddr"><br>
				<input type="text" onclick="daumPost()" id="postcode"><br>
				<input type="text" onclick="daumPost()" id="addr1"><br>
				<input type="text" onclick="daumPost()" id="addr2"><br>
				<button type="button" onclick="cartchk()">결제하기</button>
		</form>
	</div>	
	
	
</body>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/cart/cart.js"></script>