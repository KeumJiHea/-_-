<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<!-- <style type="text/css">
		.ck-editor__editable { height: 300px; }
	</style> -->
	
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
		
		/* var cnt=1;
		function addFile(){
			$("#addfile").append("<div id='productContent"+cnt+"'><input type='file' name='productContent'>"
			         +"<input type='button' value='삭제' onclick='delFile()'> </div>")
			cnt++
		}
		
		function delFile(){
			cnt--
			$("#productContent"+cnt).remove()
		} */
		
		function chkData() {
			if (document.getElementById('productNo').value == "") {
				alert("상품 번호를 입력해주세요")
				productNo.focus()
			} else if (document.getElementById('productCategorie').value == "") {
				alert("상품 카테고리를 선택 해주세요");
				productCategorie.focus()
			} else if (document.getElementById('productName').value == "") {
				alert("상품 이름을 입력 해주세요");
				productName.focus()
			} else if (document.getElementById('productSize').value == "") {
				alert("상품 사이즈 입력 해주세요");
				productSize.focus()
			} else if (document.getElementById('productColor').value == "") {
				alert("상품 색을 입력 해주세요");
				productColor.focus()
			} else if (document.getElementById('productPrice').value == "") {
				alert("상품 가격을 입력 해주세요");
				productPrice.focus()
			} else if (document.getElementById('productStack').value == "") {
				alert("상품 재고 수량을 입력 해주세요");
				productStack.focus()
			} else {
				profo.submit();
			}
		}
		
	</script>
	
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />

	<h2>상품등록</h2>
	
	<form id="profo" method="post" action="${contextPath}/product/productSave" enctype="multipart/form-data">
		<b>상품 번호</b><br>
		<input type="text" name="productNo" id="productNo" placeholder="productNo"><br>
		<hr>
		
		<b>상품 카테고리</b><br>
		<select size="1" name="productCategorie" id="productCategorie">
			<option value=""> ----------
			<option value="1"> 상의
			<option value="2"> 원피스
			<option value="3"> 하의
		</select>
		<hr>
		
		<b>상품 이름</b><br>
		<input type="text" name="productName" id="productName" placeholder="productName">
		<hr>
		
		<b>상품 사이즈</b><br>
		<input type="text" name="productSize" id="productSize" placeholder="productSize">
		<hr>
		
		<b>상품 색</b><br>
		<input type="text" name="productColor" id="productColor" placeholder="productColor">
		<hr>
		
		<b>상품 가격</b><br>
		<input type="text" name="productPrice" id="productPrice" placeholder="productPrice">
		<hr>
		
		<b>상품 재고 수량</b><br>
		<input type="text" name="productStack" id="productStack" placeholder="0">
		<input type=button value="▲" onClick="javascript:this.form.productStack.value++;">
		<input type=button value="▼" onClick="javascript:this.form.productStack.value--;">
		<hr>
		
		<b>상품 이미지</b><br>
		<img id="preview" src="#" width=100 height=100 alt="선택된 이미지가 없습니다" /><br>
		<input type="file" name="productFile" onchange="readURL(this);" />
		<hr>
		
		<b>상품 설명</b><br>
		<input type="file" name="productContent" />
		<!-- <textarea name="productContent" id="productContent"></textarea> -->
		<!-- <input type="button" value="설명 이미지 추가" onclick="addFile()"><br>
		<div id="addfile"></div> -->
		
		<hr>
		<button type="button" onclick="chkData()">상품 등록</button>
		<button type="button" onclick="location.href='productList'">등록 취소</button>
	</form>

<!-- 	<script src="https://cdn.ckeditor.com/ckeditor5/35.0.1/classic/ckeditor.js"></script>
	<script src="https://cdn.ckeditor.com/ckeditor5/35.0.1/classic/translations/ko.js"></script>
	<script type="text/javascript">
		ClassicEditor.create( document.querySelector( '#productContent' ), {
	    	language: "ko"
		});
	</script> -->
	

</body>
</html>