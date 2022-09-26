<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
   function readURL(input) {
	   var file = input.files[0] //파일에 대한 정보
	   console.log(file)
      if (file != '') {
	      var reader = new FileReader();
	      reader.readAsDataURL(file); //파일의 정보를 토대로 파일을 읽고 
	      reader.onload = function (e) { // 파일 로드한 값을 표현한다
	    	//e : 이벤트 안에 result값이 파일의 정보를 가지고 있다.
	        $('#preview').attr('src', e.target.result);
          }
      }
  }  
   
  
</script>
</head>
<body>
modify
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form action="modify" enctype="multipart/form-data" method="post" name="modify" >
	<input type="hidden" name="reviewNo" value="${rdto.reviewNo }">
	<input type="hidden" name="productNo" value="${rdto.productNo }">
	아이디 <input type="text" name="memberId" value="${rdto.memberId }" readonly="readonly"><br>
	 작성일<input type="text" name="reviewDate" value="${rdto.reviewDate }" readonly="readonly"><br>
	 
	  
	  <fieldset> 
	<span class="text-bold">별점을 선택해주세요</span>
		<input type="radio" name="reviewStar" value=1 id="rate1">
		<label for="rate1">★</label>
		<input type="radio" name="reviewStar" value=2 id="rate2">
		<label for="rate2">★</label>
		<input type="radio" name="reviewStar" value=3 id="rate3">
		<label for="rate3">★</label>
		<input type="radio" name="reviewStar" value=4 id="rate4">
		<label for="rate4">★</label>
		<input type="radio" name="reviewStar" value=5 id="rate5">
		<label for="rate5">★</label>
	</fieldset>
	
	   내용<input type="text" name="reviewContent" value="${rdto.reviewContent }"><br>
	   <input type="hidden" name="reviewFile" value="${rdto.reviewFile }"><br>
	   
	   <img width="200px" height="100px" id="preview"
		src="download?file=${rdto.reviewFile}"  >
		<input type="file" name="reviewFile" onchange="readURL(this)" >
		
		<input type="submit" value="수정하기">
	<input type="button" onclick="history.back()" value="이전으로 돌아가기">
	
</form>
</body>
</html>