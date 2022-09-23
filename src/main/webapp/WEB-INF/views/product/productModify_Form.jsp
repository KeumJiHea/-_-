<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<!-- <style type="text/css">
		.ck-editor__editable { height: 300px; }
	</style> -->

<title>Insert title here</title>
</head>
<body>

	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
		function readURL(input) {
			var file = input.files[0] //파일에 대한 정보
			console.log(file)
			if (file != '') {
				var reader = new FileReader();
				reader.readAsDataURL(file); //파일의 정보를 토대로 파일을 읽고 
				reader.onload = function(e) { // 파일 로드한 값을 표현한다
					//e : 이벤트 안에 result값이 파일의 정보를 가지고 있다.
					$('#preview').attr('src', e.target.result);
				}
			}
		}
		
		function chkData() {
			if (document.getElementById('productCategorie').value == "") {
				alert("상품 카테고리를 선택 해주세요");
				productCategorie.focus()
			} else if (document.getElementById('productName').value == "") {
				alert("상품 이름을 입력 해주세요");
				productName.focus()
			} else if (document.getElementById('productPrice').value == "") {
				alert("상품 가격을 입력 해주세요");
				productPrice.focus()
			} else {
				profo.submit();
			}
		}
		
	</script>

	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<c:set var="contextPath" value="${pageContext.request.contextPath }" />
	
	<h2>${pdto.productNo }번 상품 수정</h2>
	<hr>
	
	<form action="${contextPath }/product/productModify" id="profo" enctype="multipart/form-data" method="post">
		<input type="hidden" name="productNo" value="${pdto.productNo }">
		<input type="hidden" name="originProductFile" value="${pdto.productFile }">
		<input type="hidden" name="originProductContent" value="${pdto.productContent }">
		
		<b>상품 카테고리</b><br>
		<select size="1" name="productCategorie" id="productCategorie">
			<option value=""> ----------
			<option value="1"> 상의
			<option value="2"> 원피스
			<option value="3"> 하의
		</select>
		<hr>
		
		<b>상품 이름</b><br>
		<input type="text" name="productName" id="productName" value="${pdto.productName }" placeholder="productName">
		<hr>
		
		<b>상품  가격</b><br>
		<input type="text" name="productPrice" id="productPrice" value="${pdto.productPrice }" placeholder="productPrice">
		<hr>
		
		<b>상품 이미지</b><br>
		<img width="200px" height="200px" id="preview" src="${contextPath}/product/download?productFile=${pdto.productFile}">
		<input type="file" name="productFile" onchange="readURL(this)">
		<hr>
		
		<b>상품 설명</b><br>
		<img width="200px" height="200px" id="preview" src="${contextPath}/product/download?productFile=${pdto.productContent}">
		<input type="file" name="productContent" />
		<hr>
		
		<button type="button" onclick="chkData()">상품 수정</button>
		<button type="button" onclick="location.href='${contextPath}/product/productList'">수정 취소</button>
	</form>
	
	<!-- <script src="https://cdn.ckeditor.com/ckeditor5/35.0.1/classic/ckeditor.js"></script>
	<script src="https://cdn.ckeditor.com/ckeditor5/35.0.1/classic/translations/ko.js"></script>
	<script type="text/javascript">
		ClassicEditor.create( document.querySelector( '#productContent' ), {
	    	language: "ko"
		});
	</script> -->
	
</body>
</html>