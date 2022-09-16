<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
상품후기
<hr>

<div>작성자|날짜|평점</div>
<div>내용</div>
<div>이미지</div>


<div >

</div>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

function rePrint(){
	$.ajax({
		url:"replyData", type:"get",
		dataType :"json", //받아올 데이터 자료형
		success : function( reviewData ){
			if(reviewData){
				alert("reviewdata 불러오기 성공")
			}else{
				alert("reviewdata 실패")
			}
			console.log("data: "+ JSON.stringify(reviewData) )
			

			let html = ""
		for( i=0; i<reviewData.length; i++){
				let date = new Date( reviewData[i].reviewDate )
				let wd = date.getFullYear()+"년";
				wd += (date.getMonth()+1) + "월";
				wd += date.getDate()+"일";
				/*
				wd += date.getHours()+"시";
				wd += date.getMinutes()+"분";
				wd += date.getSeconds()+"초";
				*/
				html += "<div align='left'><b>아이디 : </b>"+reviewData[i].memberId+"님  &nbsp ";
				html += "<b>작성일 : </b>"+ wd+" &nbsp";
				html += "<b>별점 : </b>"+reviewData[i].reviewStar+"<br>";
				html += "<b>내용 : </b>"+reviewData[i].reviewContent+"<hr></div>";
			}
			$("#reply").html( html )
			},
		error: function(){alert("function error")}
			
	})
	
	
}
</script>

<div id="reply"></div>
<input type="button" id="data" value="button" onclick="rePrint()">


</body>
</html>