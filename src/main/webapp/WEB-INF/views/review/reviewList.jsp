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
        //reader.readAsDataURL(file);
        reader.onload = function (e) {
        $('#View').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}

var cnt=1;//파일 업로드 name값을 다르게 하는 변수
function addFile(){
   $("#addfile").append("<div id='"+cnt+"'><input type='file' name='file"+cnt+"' >"
           
            +"<img id='View' src='#' width=100 height=100 alt='선택된 이미지가 없습니다' name='file"+cnt+"'/>"
            +"<input type='button' value='삭제' onclick='delFile()'> </div>")
   cnt++
}
function delFile(){
   cnt--
   $("#"+cnt).remove()
}

/* ajax로 리뷰 저장 -(form으로 보내기 만들면 삭제) 이미지 보내기 문제

function review(){//리뷰저장
	console.log(reviewFile)
	console.log(file)
	console.log
	var queryString = $('reviewForm').serialize();
	var memberId = "seeotuser" //아이디 불러오면 삭제하기
	var productNo = "10001"//상품별 리뷰 출력을 위해  필요함
	//var files=$("input[name='reviewFile']")

	var reviewFile = $("input[name='reviewFile']")
//	var reviewFile = "nan" //이미지 저장 기능 만드고 주석으로바꾸기
//	var memberId = $("input[name='memberId']").val()  //회원아이디 입력받게 만들기
	var reviewContent = $("textarea[name='reviewContent']").val()
	var reviewStar =$('[name=reviewStar]:checked').val() 
	
	console.log(reviewFile)
	//	var formData = new FormData();
	// formData.append('file', $('#uploadFile')[0].files[0]);

	//var reviewFile =$("file[name='reviewFile']").val     reviewFile:reviewFile
	
	var form = {memberId:memberId, reviewContent:reviewContent 
			,productNo:productNo, reviewFile:reviewFile, reviewStar:reviewStar }

	console.log(form)
	
	$.ajax({
	url:"addReview" , type:"post",
	contentType:"application/json; charset=utf-8",
	data:JSON.stringify(form),
	dataType:"json",
	success:function(data){
		alert('리뷰등록'),
		replyData();
	},error:function(data){alert('문제발생'), console.log(form)}
})

}
 */
 
</script>
 


<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<div>
   <div>
      <span><strong>REVIEW</strong></span><hr>
   </div>
</div>

 	<form class="mb-3" name="reviewForm" id="reviewForm" 
 	 action="${contextPath}/review/reviewSave" method="post" enctype="multipart/form-data">
 	
	<c:if test="${sessionScope.loginUser != null}">
	<input type="hidden" name="memberId" value="${sessionScope.loginUser } "> 	
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
	
	<!-- 상세페이지의 해당 상품의 상품번호 불러오기 -->
	
	<input type="hidden" id="productNo" value="">
	<textarea class="reviewContent" type="text" id="reviewContent"
								 name="reviewContent"   placeholder="리뷰작성"></textarea>
				  
	<b>이미지파일 첨부</b><br>
	<input type="button" value="파일추가" onclick="addFile()"><br>
    <input type='file' id="reviewFile" name="reviewFile"/>
    <img id="View" src="#" width=100 height=100 alt="선택된 이미지가 없습니다" name="file"/>

		<br>
		
      <div id="addfile"></div>
	
	<input type="submit" value="후기등록">

	
	
	</div>
</form>	
</body>
</html>