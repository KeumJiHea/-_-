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
#reviewContents {
    width: 100%;
    height: 150px;
    padding: 10px;
    box-sizing: border-box;
    border: solid 1.5px #D3D3D3;
    border-radius: 5px;
    font-size: 16px;
    resize: none;
}
</style> <link href="/assets/css/star.css" rel="stylesheet"/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="icon" href="/favicon.ico" type="image/x-icon">

<body onload=getCommentList()>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
/*
 * 댓글 등록하기(Ajax)
 */
function fn_comment(code){
    
    $.ajax({
        type:'POST',
        url : "<c:url value='/board/addComment.do'/>",
        data:$("#reviewForm").serialize(),
        success : function(data){
            if(data=="success")
            {
                getCommentList();
                $("#comment").val("");
            }
        },
        error:function(request,status,error){
            //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       }
        
    });
}
 
/**
 * 초기 페이지 로딩시 댓글 불러오기
 */
$(function(){
    
    getCommentList();
    
});
 
/**
 * 댓글 불러오기(Ajax)
 */
function getCommentList(){
    
    $.ajax({
        type:'GET',
        url : "",
        dataType : "json",
        data:$("#reviewForm").serialize(),
        contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
        success : function(data){
            
            var html = "";
            var cCnt = data.length;
            
            if(data.length > 0){
                
                for(i=0; i<data.length; i++){
                    html += "<div>";
                    html += "<div><table class='table'><h6><strong>"+data[i].writer+"</strong></h6>";
                    html += data[i].comment + "<tr><td></td></tr>";
                    html += "</table></div>";
                    html += "</div>";
                }
                
            } else {
                
                html += "<div>";
                html += "<div><table class='table'><h6><strong>등록된 댓글이 없습니다.</strong></h6>";
                html += "</table></div>";
                html += "</div>";
                
            }
            
            $("#cCnt").html(cCnt);
            $("#commentList").html(html);
            
        },
        error:function(request,status,error){
            
       }
        
    });
}

$("reviewbtn").click(function(){
	<% 
	if("" == null){%>
})
alert("로그인이 필요합니다");
location.href='#';
<% }else{%>
 $.ajax({
	 url: 
		 type:"post",
		 data:,
		 success: function(){
			 console.log("보내기성공");
			 location.reload()
		 },
 })
 <%}%>
 </script>


<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:forEach var="dto" items="${reviewList }">
작성자: ${dto.memberId }	
내용: ${dto.reviewContent }	
별점: ${dto.reviewStar }	
상품: ${dto.productNo }	
등록일: ${dto.reviewDate }	<br>
</c:forEach>
<!-- 
<form id="review">
		<input type="hidden" name="memberId" id="memberId"
								value="${dto.memberId }">
		<b>답글 작성 페이지</b><hr>
		<b>작성자 : </b>${dto.memberId }<hr>
		<b>제목</b><br>
		<input type="text" id="title" 
							name="title" size="30"><hr>
		<b>내용</b><br>
		<textarea rows="5" cols="30" 
					name="content" id="content"></textarea>
		<hr>
		<button type="button" onclick="rep()">답글</button>
		<button type="button" onclick="slide_hide()">취소</button>
	</form>
 -->
 
<div>
            <div>
                <span><strong>REVIEW</strong></span> <span id="cCnt"></span><hr>
            </div>
            <div>

 	<form class="mb-3" name="reviewForm" id="reviewForm" method="post"	>
 	<!--  action="${contextPath}/review/reviwSave" enctype="multipart/form-data" -->
 
	<fieldset>
		<span class="text-bold">별점을 선택해주세요</span>
		<input type="radio" name="reviewStar" value="5" id="rate1"><label
			for="rate1">★</label>
		<input type="radio" name="reviewStar" value="4" id="rate2"><label
			for="rate2">★</label>
		<input type="radio" name="reviewStar" value="3" id="rate3"><label
			for="rate3">★</label>
		<input type="radio" name="reviewStar" value="2" id="rate4"><label
			for="rate4">★</label>
		<input type="radio" name="reviewStar" value="1" id="rate5"><label
			for="rate5">★</label>
	</fieldset>
	<div>
	<!-- 
	<input type="hidden" id="memberId" value="${dto.memberId }">
	<input type="hidden" id="reviewDate" value="${dto.reviewDate }">
	<input type="hidden" id="productNo" value="${dto.productNo }"> -->
		<textarea class="col-auto form-control" type="text" id="reviewContents" name="reviewContent"
				  placeholder="리뷰작성"></textarea>
	<input type="file" name="reviewFile" onchange="readURL(this);" /> 
	<button type="button" onclick="review()">등록</button>
	<button type="button" id="reviewbtn">등록</button>
	<button type="button" onclick="reviewDelete()">취소</button>
	</div>
</form>	
</body>
</html>