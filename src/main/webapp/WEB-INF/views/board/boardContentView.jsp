<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<body>
<table border="1">
	<tr>
		<th>제목</th><td>${dto.boardTitle }</td>
		<th>작성자</th><td>${dto.memberName }</td>
	</tr>
	<tr>
		<th>문의 일시</th><td>${dto.boardDate }</td>
		<th>처리 상태</th><td>${dto.boardStatus }</td>
	</tr>
	<tr>
		<td colspan="4">${dto.boardContent }</td>
	</tr>
</table>
</body>
