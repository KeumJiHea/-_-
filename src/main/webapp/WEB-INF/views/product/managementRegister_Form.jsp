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
			if (document.getElementById('productSize').value == "") {
				alert("상품 사이즈 입력 해주세요");
				productSize.focus()
			} else if (document.getElementById('productColor').value == "") {
				alert("상품 색을 입력 해주세요");
				productColor.focus()
			} else if (document.getElementById('productStack').value == "") {
				alert("상품 재고 수량을 입력 해주세요");
				productStack.focus()
			} else {
				manageRegfo.submit();
			}
		}
	</script>
	
	<b>${param.productNo }번 상품 재고 등록</b>
	<hr>
	
	<form action="managementSave" id="manageRegfo" method="post">
		<input type="hidden" name="productNo" value="${param.productNo }">
	
		<b>상품 수량</b><br>
		<input type="text" name="productStack" id="productStack" placeholder="0">
		<input type=button value="▲" onClick="javascript:this.form.productStack.value++;">
		<input type=button value="▼" onClick="javascript:this.form.productStack.value--;">
		<hr>
		
		<b>상품 색상</b><br>
		<input type="text" name="productColor" id="productColor" placeholder="productColor">
		<hr>
		
		<b>상품 사이즈</b><br>
		<input type="text" name="productSize" id="productSize" placeholder="productSize">
		<hr>
		
		<button type="button" onclick="chkData()">재고 등록</button>
		<button type="button" onclick="location.href='managementView?productNo=${param.productNo }'">등록 취소</button>
	</form>
	
	
</body>
</html>