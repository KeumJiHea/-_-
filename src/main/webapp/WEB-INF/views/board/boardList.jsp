<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<body>
	<table border='1' style="text-align: center;">
		<tr>
			<th>번호</th>
			<th>상담유형</th>
			<th>제목</th>
			<th>작성자</th>
			<th>날짜</th>
			<th>처리상태</th>
			<th>그룹</th>
			<th>indent</th>
			<!-- 나중에 그룹,indent 가리기 -->
		</tr>
		
		<c:if test="${boardList.size() == 0 }">
			<tr>
				<td colspan="7">게시글 없음</td>
			</tr>
		</c:if>
		
		<c:forEach var="dto" items="${boardList }">
			<tr>
				<td>${dto.boardNo }</td>
				<td>${dto.boardQnAType }</td>
				<td><a href="${contextPath }/board/boardContentView?boardNo=${dto.boardNo}">
					${dto.boardTitle }</a>
				</td>
				<td>${dto.memberName }</td>
				<td>${dto.boardDate }</td>
				<td>처리상태</td>
				<td>${dto.boardGroup }</td>
				<td>${dto.boardIndent }</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="7">
				<input type="button" onclick="location.href='boardWrite'" value="문의하기">
			</td>
		</tr>

	</table>
</body>
</html>