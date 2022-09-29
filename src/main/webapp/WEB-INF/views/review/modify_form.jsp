<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#modify fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
}
#modify fieldset legend{
    text-align: right;
}
#modify input[type=radio]{
    display: none;
}
#modify label{
    font-size: 3em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
#modify label:hover{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#modify label:hover ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#modify input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#modifyContent {
    width: 100%;
    height: 150px;
    padding: 10px;
    box-sizing: border-box;
    border: solid 1.5px #D3D3D3;
    border-radius: 5px;
    font-size: 16px;
    resize: none;
}
</style>
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

   $(document).on('click','#btn',function(){
	   console.log($("#modify div input").val())
	   if($("#histar").val() == ""){
		   alert('별점을 입력해주세요')
	   }else{
	    $("#modify").submit();
		 
	   }
	   	
	  });
   $(document).on('click','.star',function(){
	   $("#histar").attr('value',$(this).val())
	   console.log($("#histar").attr('value'));
   })
	   
   
   
</script>
</head>
<body>
<h2>리뷰 수정</h2>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form action="modify" enctype="multipart/form-data" method="post" name="modify" id="modify">
	<input type="hidden" name="reviewNo" value="${rdto.reviewNo }">
	<input type="hidden" name="productNo" value="${rdto.productNo }">
	<input type="hidden" name="memberId" value="${rdto.memberId }"><br>
	<input type="hidden" name="reviewDate" value="${rdto.reviewDate }" ><br>
	 
	  <input type="hidden" value="${rdto.reviewStar }" id="star" name="star">
	  <fieldset> 
	
	<div class="stardiv">
		<input type="radio" name="reviewStar" value=5 id="rate1" class="star">
		<label for="rate1">★</label>
		<input type="radio" name="reviewStar" value=4 id="rate2" class="star">
		<label for="rate2">★</label>
		<input type="radio" name="reviewStar" value=3 id="rate3" class="star">
		<label for="rate3">★</label>
		<input type="radio" name="reviewStar" value=2 id="rate4" class="star">
		<label for="rate4">★</label>
		<input type="radio" name="reviewStar" value=1 id="rate5" class="star">
		<label for="rate5">★</label>
		<input type="hidden" id="histar">
	</div>
	</fieldset>
	
	   <input type="text" name="reviewContent" value="${rdto.reviewContent }" id="modifyContent" placeholder="내용"><br>
	   <input type="hidden" name="reviewFile" value="${rdto.reviewFile }"><br>
	   
	   <img width="200px" height="100px" id="preview"
		src="download?file=${rdto.reviewFile}"  >
		<input type="file" name="reviewFile" onchange="readURL(this)" >
		
		<input type="button" value="수정하기" id="btn">
	<input type="button" onclick="history.back()" value="이전으로 돌아가기">
	
</form>
</body>
</html>