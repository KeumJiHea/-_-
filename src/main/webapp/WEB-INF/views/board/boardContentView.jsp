<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<table border="1" >
	<caption><font size="5"><b>내용</b></font></caption>

	<tr>
		<th width="100">글 번호</th> 
		<td width="200">${dto.boardNo}</td> 
		<th width="100">작성자</th>  
		<td width="200">${dto.memberId}</td>
	</tr>
	<tr>
		<th>제목</th> <td>${dto.boardTitle}</td> 
		<th>등록일자</th> <td> ${dto.boardDate} <%----%></td>
	</tr>
	<tr>
		<th>내용</th><td colspan="2">${dto.boardContent}</td> 
		<td > <c:if test="${ dto.boardFile == 'nan' }"> <b>이미지가 없습니다</b> </c:if>
	</tr>
	
		
		<!-- 	<c:if test="${ dto.boardFile != 'nan' }">
				<img width="200px" height="100px" 
					src="${contextPath}/board/download?boardFile=${dto.boardFile}">
			</c:if> -->
	
	<tr>
		<td colspan="4" align="center">
	<!-- --><c:if test="${ loginUser == dto.memberId }"> </c:if>
			<input type="button" onclick="location.href='delete?boardNo=${dto.memberId}&boardFile=${dto.boardFile}'" value="삭제하기">
		 	<input type="button" onclick="location.href='boardModifyForm?memberId=${dto.memberId}'" value="수정하기"> 
			
			<input type="button" onclick="location.href='boardReply?memberId=${dto.memberId}'" value="답글달기"> 
			<input type="button" onclick="location.href='boardList'" value="리스트로 돌아가기">
		</td>
	</tr>
	</table>
</body>
</html>