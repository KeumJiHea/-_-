<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="<c:url value='/resources/css/board.css'/>" >
<body>
	<form id="modifyForm">
		<input type="number" name="boardNo" value=${dto.boardNo } hidden="hidden">
		<input type="text" name="memberId" value="${dto.memberId }" hidden="hidden"/>
		
		<table class="board">
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="memberName" value="${dto.memberName }" readonly required/>
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
					<input class="title" type="text" size="50" name="boardTitle" value="${dto.boardTitle }" required/>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea class="boardContent" name="boardContent" rows="10" cols="50" required>${dto.boardContent }</textarea>
				</td>
			</tr>
			<tr>
				<th>파일 첨부</th>
				<td>
					<input type="file" name="boardFile" onchange="addFile(this);" multiple />
					<div class="file-list">
						<c:forEach var="file" items="${fileList }" varStatus="vs">
							<div id="file${vs.index }" class="filebox">
								<img src="${contextPath }/board/download?file=${file.fileSaveName }" width="100px" height="100px;">
								<p class="name">${file.fileOriginName }</p>
								<p class="saveName" hidden="hidden">${file.fileSaveName }</p>
								<a class="delete" onclick="deleteFile(${vs.index});">삭제</a>
							</div>
						</c:forEach>
					</div>
				</td>
			</tr>
		</table>
		<div class="board-buttons">
			<button class="button" type="button" onclick="modifyForm()">수정하기</button>
			<button class="button" type="button" onclick="history.back()">이전으로</button>
		</div>
	</form>
	<div id="response" hidden="hidden"></div>
</body>
<script src="<%=request.getContextPath() %>/resources/js/board/board.js"></script>
