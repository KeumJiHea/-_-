<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="<c:url value='/resources/css/board.css'/>" >
<body>
	<form id="writeForm">
		<input type="text" name="memberId" value="${loginUser }" hidden="hidden"/>
		<table class="board">
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="memberName" value="${userName }"/>
				</td>
			</tr>
			<tr>
				<th>문의 유형</th>
				<td>
					<select class="title" name="boardQnAType">
						<option disabled selected>문의 유형을 선택해주세요.</option>
						<option value="상품">상품</option>
						<option value="배송">배송</option>
						<option value="반품">반품</option>
						<option value="교환">교환</option>
						<option value="환불">환불</option>
						<option value="기타">기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input class="title" type="text" size="50" name="boardTitle"/>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea class="boardContent" name="boardContent" rows="10" cols="50"></textarea>
				</td>
			</tr>
			<tr>
				<th>파일 첨부</th>
				<td>
					<input type="file" name="boardFile" onchange="addFile(this);" multiple />
					<div class="file-list"></div>
				</td>
			</tr>
		</table>
		<div class="board-buttons">
			<button class="button" type="button" onclick="submitForm()">글쓰기</button>
			<button class="button" type="button" onclick="location.href='boardList'">목록으로</button>
		</div>
	</form>
	<div id="response" hidden="hidden"></div>
</body>
<script src="<%=request.getContextPath() %>/resources/js/board/boardWrite.js"></script>