<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="<c:url value='/resources/css/board.css'/>" >
<body>
	<table class="board-list">
		<thead>
			<tr>
				<th>번호</th>
				<th>상담유형</th>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
		</thead>
		<c:if test="${boardList.size() == 0 }">
			<tr>
				<td colspan="7">게시글 없음</td>
			</tr>
		</c:if>
		
		<c:forEach var="dto" items="${boardList }">
			<tr>
				<td class="boardNo">${dto.boardNo }</td>
				<td class="boardQnAType">${dto.boardQnAType }</td>
				<td class="boardTitle"><a href="${contextPath }/board/board?boardNo=${dto.boardNo}">
					${dto.boardTitle }</a>
					<span class="replyCount">[${dto.replyCount }]</span>
				</td>
				<td class="memberName">${dto.memberName }</td>
				<td class="boardDate">${dto.boardDate }</td>
				<td class="boardHit">${dto.boardHit }</td>
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