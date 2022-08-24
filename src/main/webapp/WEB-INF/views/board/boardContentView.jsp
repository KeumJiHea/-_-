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
	<caption><font size="5"><b>개인 정보</b></font></caption>

	<tr>
		<th width="100">글 번호</th> 
		<td width="200">${dto.boardNo}</td> 
		<th width="100">작성자</th>  
		<td width="200">${dto.memberId}</td>
	</tr>
	<tr>
		<th>제목</th> <td>${dto.boardTitle}</td> 
		<th>등록일자</th> <td><%-- ${dto.baordDate} --%></td>
	</tr>
	<tr>
		<th>내용</th><td>${dto.boardContent}</td> 
		<td colspan="2">
			<c:if test="${ dto.boardFile == 'nan' }"> <b>이미지가 없습니다</b> </c:if>
		<!-- 	<c:if test="${ dto.boardFile != 'nan' }">
				<img width="200px" height="100px" 
					src="${contextPath}/board/download?boardFile=${dto.boardFile}">
			</c:if> -->
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center">
	<!-- 		<c:if test="${ loginUser == dto.memberId }">
				<input type="button" onclick="location.href='modify_form?writeNo=${dto.boardNo}'" value="수정하기"> 
				<input type="button" onclick="location.href='delete?boardNo=${dto.boardNo}&boardFile=${dto.boardFile}'" value="삭제하기">
			</c:if> -->
			<input type="button" onclick="location.href='boardreply?memberId=${dto.memberId}'" value="답글달기"> 
			<input type="button" onclick="location.href='boardList'" value="리스트로 돌아가기">
		</td>
	</tr>
	</table>
</body>
</html>