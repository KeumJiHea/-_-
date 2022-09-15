<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<script type="text/javascript">
		function chkData() {
			if (document.getElementById('moProductSize').value == "") {
				alert("상품 사이즈 입력 해주세요");
				moProductSize.focus()
			} else if (document.getElementById('moProductColor').value == "") {
				alert("상품 색을 입력 해주세요");
				moProductColor.focus()
			} else if (document.getElementById('moProductStack').value == "") {
				alert("상품 재고 수량을 입력 해주세요");
				moProductStack.focus()
			} else {
				managemodifyfo.submit();
			}
		}
	</script>
	
	<h2>${mdto.productNo }번 상품 재고 수정</h2>
	
	<form action="managementModify" id="managemodifyfo" method="post">
		<input type="hidden" name="productNo" value="${mdto.productNo }">
		<input type="hidden" name="productStack" value="${mdto.productStack }">
		<input type="hidden" name="productColor" value="${mdto.productColor }">
		<input type="hidden" name="productSize" value="${mdto.productSize }">
		
		<b>남은 재고 수량</b><br>
		<input type="text" name="moProductStack" id="moProductStack" value="${mdto.productStack }" placeholder="0">
		<input type=button value="▲" onClick="javascript:this.form.productStack.value++;">
		<input type=button value="▼" onClick="javascript:this.form.productStack.value--;">
		<hr>
		
		<b>보유 색상</b><br>
		<input type="text" name="moProductColor" id="moProductColor" value="${mdto.productColor }" placeholder="productColor">
		<hr>
		
		<b>보유 사이즈</b><br>
		<input type="text" name="moProductSize" id="moProductSize" value="${mdto.productSize }" placeholder="productSize">
		<hr>
		
		<button type="button" onclick="chkData()">재고 수정</button>
		<button type="button" onclick="location.href='managementView?productNo=${mdto.productNo }'">수정 취소</button>
	</form>
	
</body>
</html>