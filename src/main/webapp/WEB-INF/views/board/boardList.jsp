<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="<c:url value='/resources/css/board.css'/>" >
<body>
	<table class="board-list">
		<tr class="table-head">
			<th class="boardNo">번호</th>
			<th class="boardQnAType">상담유형</th>
			<th class="boardTitle">제목</th>
			<th class="memberName">작성자</th>
			<th class="boardDate">날짜</th>
			<th class="boardStatus">처리상태</th>
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
				<td><a href="${contextPath }/board/board?boardNo=${dto.boardNo}">
					${dto.boardTitle }</a>
				</td>
				<td>${dto.memberName }</td>
				<td>${dto.boardDate }</td>
				<td>${dto.boardStatus }</td>
			</tr>
		</c:forEach>
	</table>
	<button class="button write" onclick="location.href='boardWrite'">문의하기</button>
	
	<div class="paging">
		<c:forEach var="page" begin="1" end="${pagingCount }">
			<a href="${contextPath }/board/boardList?page=${page}">${page } </a>
		</c:forEach>
	</div>
</body>