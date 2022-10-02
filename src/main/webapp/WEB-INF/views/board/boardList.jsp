<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="<c:url value='/resources/css/board.css'/>" >
<body>
	<div>
		<select id="cntPerPage">
			<option value="5" <c:if test="${paging.cntPerPage == 5 }">selected</c:if>>
				5줄 보기
			</option>
			<option value="10" <c:if test="${paging.cntPerPage == 10 }">selected</c:if>>
				10줄 보기
			</option>
			<option value="15" <c:if test="${paging.cntPerPage == 15 }">selected</c:if>>
				15줄 보기
			</option>
			<option value="20" <c:if test="${paging.cntPerPage == 20 }">selected</c:if>>
				20줄 보기
			</option>
		</select>
	</div>
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
		<!-- 처음으로 -->
		<c:if test="${paging.nowPage != 1 }">
			<a href="boardList?nowPage=1&cntPerPage=${paging.cntPerPage}">처음으로</a>
		</c:if>
		<!-- 이전으로 -->
		<c:if test="${paging.startPage != 1 }">
			<a href="boardList?nowPage=${paging.startPage -1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
		</c:if>
		<!-- 페이지 숫자들 만들어주는 부분 -->
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="boardList?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<!-- (다음으로) -->
		<c:if test="${paging.endPage != paging.lastPage }">
			<a href="boardList?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
		</c:if>
		<!-- 끝으로 -->
		<c:if test="${paging.nowPage != paging.lastPage }">
			<a href="boardList?nowPage=${paging.lastPage }&cntPerPage=${paging.cntPerPage}">끝으로</a>
		</c:if>
	</div>
</body>
<script>
	let cntPerPage = document.getElementById('cntPerPage');
	
	cntPerPage.addEventListener('change', () =>{
		let select = cntPerPage.value;
		location.href="boardList?nowPage=${paging.nowPage}&cntPerPage="+select;
	})
</script>