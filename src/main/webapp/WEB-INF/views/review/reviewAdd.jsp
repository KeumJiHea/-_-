<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#reviewForm fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
}
#reviewForm fieldset legend{
    text-align: right;
}
#reviewForm input[type=radio]{
    display: none;
}
#reviewForm label{
    font-size: 3em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
#reviewForm label:hover{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#reviewForm label:hover ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#reviewForm input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#reviewContent {
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
</head>

<body>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="http://madalla.kr/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
$(function() {
    $("#reviewFile").on('change', function(){
    readURL(this);
    });
});
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        
        reader.onload = function (e) {
        $('#View').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}

</script>
 


<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<div>
   <div>
      <span><strong>REVIEW</strong></span><hr>
   </div>
</div>

 	<form class="mb-3" name="reviewForm" id="reviewForm" 
 	 action="${contextPath}/review/reviewAddSave" method="post" enctype="multipart/form-data">
 	
	<c:if test="${sessionScope.loginUser != null}">
	<input type="hidden" name="memberId" value="${sessionScope.loginUser }"> 	
	</c:if>
	<c:if test="${sessionScope.loginUser == null}">
	<input type="hidden" name="memberId" value="seeotuser"> 	
	</c:if>
	<br>
	<fieldset> 
	
	
		<span class="text-bold">별점을 선택해주세요</span>
		<input type="radio" name="reviewStar" value=5 id="rate1"><label
			for="rate1">★</label>
		<input type="radio" name="reviewStar" value=4 id="rate2"><label
			for="rate2">★</label>
		<input type="radio" name="reviewStar" value=3 id="rate3"><label
			for="rate3">★</label>
		<input type="radio" name="reviewStar" value=2 id="rate4"><label
			for="rate4">★</label>
		<input type="radio" name="reviewStar" value=1 id="rate5"><label
			for="rate5">★</label>
	</fieldset>
	<div>
	

	
	<input type="hidden" id="productNo" value="${productNo }" name="productNo">

	<textarea class="reviewContent" id="reviewContent"
								 name="reviewContent"   placeholder="리뷰작성"></textarea>
				  
	<b>이미지파일 첨부</b><br>
	
    <input type='file' id="reviewFile" name="reviewFile"  multiple="multiple"/>
    <img id="View" src="#" width=100 height=100 alt="선택된 이미지가 없습니다" name="file"/>

		<br>
		
    
	<input type="button" onclick="history.back()" value="이전으로 돌아가기">
	<input type="submit" value="후기등록">

	
	
	</div>
</form>	
</body>
</html>