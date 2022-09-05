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
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<form method="post" action="${contextPath}/board/writeSave" 
											enctype="multipart/form-data">
											
		<b>작성자</b><br>	<!-- readonly : 읽기 전용 -->
		<input type="text" name="id" value="${loginUser }" readonly />
		<hr>
		<b>제목</b> <br> 
		<input type="text" size="50" name="title" /><hr>
		 <b>내용</b> <br>
		<textarea name="content" rows="10" cols="50"></textarea><hr>
		<b>이미지파일 첨부</b><br>
		<input type="file" name="boardFile" onchange="readURL(this);" /> 
		<img id="preview" src="#" width=100 height=100 alt="선택된 이미지가 없습니다" />
		<hr> 
		<input type="submit" value="글쓰기" />
		<input type=button value="목록보기" 
					onClick="location.href='${contextPath}/board/boardList'">
	</form>


</body>
</html>