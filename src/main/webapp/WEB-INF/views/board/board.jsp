<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<body onload="getReply()">
<table class="board">
	<tr>
		<th>제목</th>
		<td class="title">${dto.boardTitle }</td>
		<th>작성자</th>
		<td class="memberName">${dto.memberName }</td>
	</tr>
	<tr>
		<th>문의 일시</th>
		<td class="boardDate">${dto.boardDate }</td>
		<th>처리 상태</th>
		<td class="boardStatus">${dto.boardStatus }</td>
	</tr>
	<tr>
		<td colspan="4" class="content">${dto.boardContent }</td>
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

<div class="reply-box">
	<c:if test="${loginUser == null }">
		<label for="memberName">이름</label>
		<input type="text" name="memberName" placeholder="비회원" readonly>
		<br>
		<textarea placeholder="로그인 시에만 댓글 작성이 가능합니다."></textarea>
		<input type="button" class="addReply" value="작성">
	</c:if>
	
	<c:if test="${loginUser != null }">
		<form class="replyForm">
			<input type="hidden" name="memberId" id="memberId" value=${loginUser } readonly>
			<label for="memberName">이름</label>
			<input type="text" name="memberName" id="memberName" value=${loginUser }>
			<br>
			<textarea name="replyContent" class="repleContent" id="replyContent" rows="5" cols="100" placeholder="댓글을 입력해주세요."></textarea>
			<button type="button" class="addReply" onclick="saveReply()">작성</button>
		</form>
	</c:if>
</div>
<div class="reply-list"></div>

<button class="list button" onclick="location.href='boardList'">목록으로</button>

<c:if test="${dto.memberId == loginUser}">
	<button class="modify button" onclick="location.href='modifyForm?boardNo=${dto.boardNo}'">수정</button>
	<button class="delete button" onclick="location.href='delete?boardNo=${dto.boardNo}'">삭제</button>
</c:if>
</body>
<script>
	function saveReply(){
		const memberId = "${loginUser}";
		const memberName = $('#memberName').val();
		const replyContent = $('#replyContent').val();
		const boardNo = ${dto.boardNo};
		
		$.ajax({
			type: "POST",
			url: 'http://localhost:8085/seeot/board/reply',
			data: JSON.stringify(
				{
					"memberId":memberId,
					"memberName":memberName,
					"replyContent":replyContent,
					"boardNo":boardNo
				}
			),
			contentType: "application/json;charset-utf8",
			success: function(){
				alert("댓글이 작성되었습니다.");
				getReply();
			}
		})
	}
	
	function getReply(){
		$.ajax({
			type: "GET",
			url: "http://localhost:8085/seeot/board/replyList/"+${dto.boardNo},
			dataType: "json",
			success: function(replyList){
				console.log(replyList);
				let html = "";
				if(replyList.length == 0){
					html = "등록된 댓글이 없습니다."
				}else{
					replyList.forEach((reply,index)=>{
						console.log(reply,index);
						html += "<div class='reply'>";
						html += "<div class='replyWriter'>"+reply.memberName+"</div>";
						html += "<div class='replyContent'>"+reply.replyContent+"</div>";
						html += "<div class='replyDate'>"+reply.replyDate+"</div>";
						html += "</div>"
						html += "<hr>"
					});
				}
				$(".reply-list").html(html);
			}
			
		})
	}
</script>
