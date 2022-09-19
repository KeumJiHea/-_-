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
	<tr>
		<c:if test="${fileList != '[]' }">
			<th>첨부파일</th>
			<td colspan="3">
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
<button onclick="location.href='boardReply?boardNo=${dto.boardNo}'">답글 달기</button>
<button onclick="location.href='boardList'">목록으로</button>
<c:if test="${dto.memberId == loginUser}">
	<button onclick="location.href='modifyForm?boardNo=${dto.boardNo}'">수정</button>
	<button onclick="location.href='delete?boardNo=${dto.boardNo}'">삭제</button>
</c:if>
</body>
