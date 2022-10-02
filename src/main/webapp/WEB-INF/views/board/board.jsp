<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="<c:url value='/resources/css/board.css'/>" >
<body onload="getReply()">
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
		<td colspan="4" class="boardContent">${dto.boardContent }</td>
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
<script src="<%=request.getContextPath() %>/resources/js/board/board.js"></script>
<script>
const boardNo = ${dto.boardNo};

	function saveReply(){
		const memberId = "${loginUser}";
		const memberName = $('#memberName').val();
		const replyContent = $('#replyContent').val();
		
		$.ajax({
			type: "POST",
			url: '${root}/seeot/board/reply',
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
				$('#replyContent').val('');
				getReply();
			}
		})
	}
	
	function getReply(){
		$.ajax({
			type: "GET",
			url: "${root}/seeot/board/replyList/"+boardNo,
			dataType: "json",
			success: function(replyList){
				let html = "";
				if(replyList.length == 0){
					html = "등록된 댓글이 없습니다."
				}else{
					replyList.forEach((reply,index)=>{
						html += "<div id='reply"+reply.replyNo+"'>";
						html += "<div class='writer'>"+reply.memberName+"</div>";
						html += "<div class='content'>"+reply.replyContent+"</div>";
						html += "<div class='replyDate'>"+reply.replyDate+"</div>";
						html += '<button class="modifyReply" onclick="modifyReply('+reply.replyNo+',\''+reply.memberName+'\',\''+reply.replyContent+'\')">수정</button>';
						html += '<button class="deleteReply" onclick="deleteReply('+reply.replyNo+',\''+reply.boardNo+'\')">삭제</button>';
						html += "</div>";
						html += "<hr>";
					});
				}
				$(".reply-list").html(html);
			}
			
		})
	}
	
	function modifyReply(replyNo, memberName, replyContent){
		let modifyHtml = "";
		
		modifyHtml += "<div id='reply"+replyNo+"'>";
		modifyHtml += "<div class='writer'>"+memberName+"</div>";
		modifyHtml += "<textarea class='UpdateContent'>"+replyContent+"</textarea>";
		modifyHtml += "<button class='modifyReply' onclick='updateReply("+replyNo+")'>수정</button>";
		modifyHtml += "<button class='cancleReply' onclick='getReply()'>취소</button>";
		modifyHtml += "</div>";
		
		$('#reply'+replyNo).replaceWith(modifyHtml);
		$('.UpdateContent').focus();
	};
	
	function updateReply(replyNo){
		let updateContent = $('.UpdateContent').val();
		
		$.ajax({
			type: "POST",
			url: "${root}/seeot/board/modifyReply/"+replyNo+'/'+updateContent,
			dataType: "json",
			success: function(result){
				if(result==1){
					alert("댓글이 수정되었습니다.");
				}else{
					alert("댓글 수정에 실패했습니다.");
				}
				getReply();
			}
		})
	}
	
	function deleteReply(replyNo, boardNo){
		if(confirm('삭제하시겠습니까?')){
	 		$.ajax({
				type: "POST",
				url: "${root}/seeot/board/deleteReply/"+replyNo+'/'+boardNo,
				dataType: "json",
				success: function(result){
					if(result==1){
						alert('댓글이 삭제되었습니다.');
					}else{
						alert('댓글을 삭제하지 못했습니다.');
					}
					getReply();
				}
			});
		};
	}
</script>