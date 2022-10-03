<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="<c:url value='/resources/css/board.css'/>" >
<body>
<table class="board">
	<tr>
		<th>제목</th>
		<td class="title">${dto.boardTitle }</td>
		<th>작성자</th>
		<td class="memberName">${dto.memberName }</td>
	</tr>
	<tr>
		<th>상담 유형</th>
		<td class="title">${dto.boardQnAType }</td>
		<th>문의 일시</th>
		<td class="boardDate">${dto.boardDate }</td>
	</tr>
	<tr>
		<td colspan="4" class="boardContent">
			${dto.boardContent }
			<br>
			<c:forEach var="file" items="${fileList }">
				<br>
				<img src="${contextPath }/board/download?file=${file.fileSaveName }" alt="${file.fileOriginName }">
			</c:forEach>
		</td>
	</tr>
	<tr>
		<c:if test="${fileList != '[]' }">
			<th>첨부파일</th>
			<td colspan="3" class="file">
					<c:forEach var="file" items="${fileList }">
						<a href="${contextPath }/board/download?file=${file.fileSaveName }">
							<img src="${contextPath }/board/download?file=${file.fileSaveName }" alt="${file.fileOriginName }" 
							width="100px" height="100px">
						</a>
					</c:forEach>
					<br>
					<span>이미지 클릭시 다운로드 됩니다.</span>
			</td>
		</c:if>
	</tr>
</table>
<c:if test="${dto.memberId == loginUser}">
	<div class="board-buttons">
		<button class="modifyBoard button">수정</button>
		<button class="deleteBoard button">삭제</button>
	</div>
</c:if>

<div class="reply-box">
	<c:if test="${loginUser == null }">
		<label for="memberName">이름</label>
		<input type="text" name="memberName" id="memberName" placeholder="비회원" readonly>
		<br>
		<textarea class="replyContent" placeholder="로그인 시에만 댓글 작성이 가능합니다." readonly></textarea>
		<input type="button" class="addReply" value="작성" disabled="disabled">
	</c:if>
	
	<c:if test="${loginUser != null }">
		<form class="replyForm">
			<input type="hidden" name="memberId" id="memberId" value="${loginUser }" readonly>
			<label for="memberName">이름</label>
			<input type="text" name="memberName" id="memberName" value="${userName }" readonly>
			<br>
			<textarea name="replyContent" class="replyContent" id="replyContent" placeholder="댓글을 입력해주세요."></textarea>
			<button type="button" class="addReply" onclick="saveReply()">작성</button>
		</form>
	</c:if>
</div>
<div class="reply-list"></div>

<button class="list button">목록으로</button>
</body>
<script>
const boardNo = ${dto.boardNo};
const memberId = "${loginUser}";
const boardWriter = "${dto.memberId}";
const memberName = $('#memberName').val();
</script>
<script src="<%=request.getContextPath() %>/resources/js/board/board.js"></script>