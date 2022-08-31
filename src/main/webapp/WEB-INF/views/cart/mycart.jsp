<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="num" value="1"/>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
function cartchk(){
	if(!$('#orderchk1').is(':checked')){
		alert('주문할 상품을 골라주세요!')
	}else{
		alert('주문페이지로 이동합니다')
		location.href='${contextPath}/order/cartorder';
	}
}

$(document).ready(function(){
	
	$("#orderchk1").change(function(){
		if($('#orderchk1').is(':checked')){
			$("#productStack1").on("change keyup paste input",function(){
				const stack1 = $(this).val();
				const price1 = $("tr:eq(1)>td:eq(3)").html();	
				sum1 = price1*stack1
				$("#price1").text(sum1);
			});
		}
	});							
	$("#orderchk2").change(function(){
		if($('#orderchk2').is(':checked')){
			$("#productStack2").on("change keyup paste input",function(){
				const stack2 = $(this).val();
				const price2 = $("tr:eq(2)>td:eq(3)").html();	
				sum2 = price2*stack2	
				$("#price2").text(sum2);
			});
		}
	});							
	$("#orderchk3").change(function(){
		if($('#orderchk3').is(':checked')){
			$("#productStack3").on("change keyup paste input",function(){
				const stack3 = $(this).val();
				const price3 = $("tr:eq(3)>td:eq(3)").html();	
				sum3 = price3*stack3	
				$("#price3").text(sum3);
			});
		}
	});	
});


function checkAll() {
	if($("#orderAllCheck").is(':checked')) {
		$("input[name=orderChkbox]").prop("checked", true);
	} else {
		$("input[name=orderChkbox]").prop("checked", false);
	}
}

$(document).ready(function() {
	$("#orderAllCheck").click(function() {
		if($("#orderAllCheck").is(":checked")) $("input[name=orderChkbox]").prop("checked", true);
		else $("input[name=orderChkbox]").prop("checked", false);
	});

	$("input[name=orderChkbox]").click(function() {
		var total = $("input[name=orderChkbox]").length;
		var checked = $("input[name=orderChkbox]:checked").length;

		if(total != checked) $("#orderAllCheck").prop("checked", false);
		else $("#orderAllCheck").prop("checked", true); 
	});
});
</script>
</head>
<body>

	<div align="center">
		<form action="${contextPath}/order/cartorder" method="post">
			<table border="1">
				<tr>
					<th>전체 선택<br><input type='checkbox' name='orderAllCheck' id="orderAllCheck" onclick='checkAll()'/></th><th>상품번호</th><th>상품이미지</th><th>상품명</th><th>상품가격</th><th>구매수량</th>
				</tr>
				<c:if test="${cart.size()==0 }">
					<tr>
						<td colspan="6">등록된 장바구니가 없습니다</td>
					</tr>
				</c:if>
				<c:if test="${cart.size()!=0 }">
					<c:forEach var="cart" items="${cart }" varStatus="status">					
					<tr>
						<th><input type="checkbox" name='orderChkbox' id="orderchk${status.count }"></th><td>${cart.productNo }</td>
					<td>
						<c:if test="${ cart.productFile == 'nan' }">
							<b>등록된 이미지가 없습니다.</b>
						</c:if>
						<c:if test="${ cart.productFile != 'nan' }">
							<img width="100px" height="100px" src="${contextPath}/product/download?productFile=${cart.productFile}">
						</c:if>
					</td>
					<td>${cart.productName }</td>
					<td>${cart.productPrice }</td>
					<td>
						<input type="number" min="0" max="10" name="productStack" id="productStack${status.count }" placeholder="0"><br>
						<span id="price${status.count }">0</span>원
					</td>
					</tr>
					</c:forEach>
				</c:if>
			</table>
			<hr>
				총 금액 <span id="orderPrice">0</span>원<br>
				<button type="button" onclick="cartchk()">결제하기</button>
		</form>
	</div>	
</body>
</html>