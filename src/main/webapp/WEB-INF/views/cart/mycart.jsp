<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	console.log($('#orderchk1').is(':checked'))
	$("#orderchk1").change(function(){
		if($('#orderchk1').is(':checked')){
			$("#productStack").on("change keyup paste input",function(){
				const stack = $(this).val();
				const price = $("tr:eq(1)>td:eq(3)").html();	
				var sum = price*stack
				$("#orderPrice").text(sum)					
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
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
	<div align="center">
		<form action="" method="post">
			<table border="1">
				<tr>
					<th><input type='checkbox' name='orderAllCheck' id="orderAllCheck" onclick='checkAll()'/><br>전체 선택</th><th>상품번호</th><th>상품이미지</th><th>상품명</th><th>상품가격</th><th>구매수량</th>
				</tr>
				<c:if test="${cart.size==0 }">
					<tr>
						<td colspan="6">등록된 장바구니가 없습니다</td>
					</tr>
				</c:if>
				<c:if test="${cart.size!=0 }">
					<tr>
						<th><input type="checkbox" name='orderChkbox' id="orderchk1"></th><td>${pdto.productNo }</td>
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
						<input type="number" min="0" max="10" name="productStack" id="productStack" placeholder="1">
					</td>
					</tr>
				</c:if>
			</table>
		</form>
	</div>	
</body>
</html>