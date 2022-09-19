<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<body>
	<form id="modifyForm">
		<input type="number" name="boardNo" value=${dto.boardNo } hidden="hidden">
		<input type="text" name="memberId" value="${dto.memberId }" hidden="hidden"/>
		<label for="memberName">작성자</label>
		<input type="text" name="memberName" value="${dto.memberName }" readonly required/>
		<hr>
		<label for="boardQnAType">문의 유형</label>
		<select name="boardQnAType">
			<option value="상품">상품</option>
			<option value="배송">배송</option>
			<option value="반품">반품</option>
			<option value="교환">교환</option>
			<option value="환불">환불</option>
			<option value="기타">기타</option>
		</select>
		<hr>
		<label for="boardTitle">제목</label>
		<input type="text" size="50" name="boardTitle" value="${dto.boardTitle }" required/>
		<hr>
		<label for="boardContent">내용</label>
		<textarea name="boardContent" rows="10" cols="50" required>${dto.boardContent }</textarea>
		<hr>
		<label for="file">파일 첨부</label>
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
		
		<hr>
		<input type="button" value="수정하기" onclick="modifyForm()" />
		<input type=button value="이전으로" onclick="history.back()">
	</form>
	<div id="response" hidden="hidden"></div>
</body>
<script src="<%=request.getContextPath() %>/resources/js/board.js"></script>
