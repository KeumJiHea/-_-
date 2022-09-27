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
<form action="modify" enctype="multipart/form-data" method="post" >
	<input type="text" name="writeNo" value="${rdto.reviewNo}">
	<input type="text" name="reviewFile" value="${rdto.reviewFile}">
	아이디 <input type="text" name="memberId" value="${rdto.memberId }"><br>
	 작성일<input type="text" name="reviewDate" value="${rdto.reviewDate }"><br>
	  별점<input type="text" name="reviewStar" value="${rdto.reviewStar }"><br>
	   내용<input type="text" name="reviewContent" value="${rdto.reviewContent }"><br>
	   <input type="text" name="reviewFile" value="${rdto.reviewFile}"><br>
	   
	   <img width="200px" height="100px" id="preview"
		src="download?file=${rdto.reviewFile}">
		<input type="file" name="imageFileName" onchange="readURL(this)">
		
		<input type="submit" value="수정하기">
	<input type="button" onclick="history.back()" value="이전으로 돌아가기">
	
</form>
</body>
</html>