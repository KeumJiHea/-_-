<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<body>
	<form method="post" action="${contextPath}/board/writeSave"
		enctype="multipart/form-data">
		
		<input type="text" name="memberId" value="${loginUser }" hidden="hidden"/>
		<label>작성자</label>
		<input type="text" name="memberName" required/>
		<hr>
		<label>문의 유형</label>
		<select name="boardQnAType">
			<option value="상품">상품</option>
			<option value="배송">배송</option>
			<option value="반품">반품</option>
			<option value="교환">교환</option>
			<option value="환불">환불</option>
			<option value="기타">기타</option>
		</select>
		<hr>
		<label>제목</label>
		<input type="text" size="50" name="boardTitle" required/>
		<hr>
		<label>내용</label>
		<textarea name="boardContent" rows="10" cols="50" required></textarea>
		<hr>
		<label>파일 첨부</label>
		<input type="file" name="fileOriginName" onchange="addFile(this);" multiple />
		<div class="file-list"></div>
		<hr>
		<input type="submit" value="글쓰기" />
		<input type=button value="목록보기" onclick="location.href='${contextPath}/board/boardList'">
	</form>
</body>
<script src="<%=request.getContextPath() %>/resources/js/board.js"></script>