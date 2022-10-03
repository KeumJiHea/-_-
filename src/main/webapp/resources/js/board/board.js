//board
$(document).ready(getReply());
//로그인 시 수정, 삭제 버튼에 링크
if(memberId == boardWriter){
	const modifyBtn = document.querySelector('.modifyBoard');
	const deleteBtn = document.querySelector('.deleteBoard');
	
	//수정 버튼 눌렀을 때
	modifyBtn.addEventListener('click', function(){
		location.href='modifyForm?boardNo='+boardNo;
	})
	
	//삭제 버튼 눌렀을 때
	deleteBtn.addEventListener('click', function(){
		if(confirm('삭제하시겠습니까?')){
			location.href='delete?boardNo='+boardNo;
		};
	})
}

//목록으로 버튼
const listBtn = document.querySelector('.list.button');

listBtn.addEventListener('click', function(){
	location.href='boardList';
})

//댓글 저장
function saveReply(){
	const replyContent = $('#replyContent').val();
	if(replyContent != ''){
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
				$('#replyContent').val('');
				getReply();
			}
		})
	}else{
		alert('댓글의 내용을 입력하세요.')
	}
}

//댓글 불러오기
function getReply(){
	$.ajax({
		type: "GET",
		url: "http://localhost:8085/seeot/board/replyList/"+boardNo,
		dataType: "json",
		success: function(replyList){
			let html = "";
			if(replyList.length == 0){
				html = "등록된 댓글이 없습니다."
			}else{
				replyList.forEach((reply)=>{
					html += "<div id='reply"+reply.replyNo+"'>";
					html += "<div class='writer'>"+reply.memberName+"</div>";
					html += "<div class='content'>"+reply.replyContent+"</div>";
					html += "<div class='replyDate'>"+reply.replyDate+"</div>";
					if(reply.memberId == memberId){
						html += '<button class="modifyReply" onclick="modifyReply('+reply.replyNo+',\''+reply.memberName+'\',\''+reply.replyContent+'\')">수정</button>';
						html += '<button class="deleteReply" onclick="deleteReply('+reply.replyNo+',\''+reply.boardNo+'\')">삭제</button>';
					}
					html += "</div>";
					html += "<hr>";
				});
			}
			$(".reply-list").html(html);
		}
	})
}

//댓글 수정폼 만들기
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

//댓글 수정
function updateReply(replyNo){
	let updateContent = $('.UpdateContent').val();
	if(updateContent != ''){
		$.ajax({
			type: "POST",
			url: "http://localhost:8085/seeot/board/modifyReply/"+replyNo+'/'+updateContent,
			dataType: "json",
			success: function(result){
				if(result==1){
					alert("댓글이 수정되었습니다.");
				}else{
					alert("댓글 수정에 실패했습니다.");
				}
				getReply();
			}
		});
	}else{
		alert('댓글의 내용을 입력하세요.')
	}
}

//댓글 삭제
function deleteReply(replyNo, boardNo){
	if(confirm('삭제하시겠습니까?')){
 		$.ajax({
			type: "POST",
			url: "http://localhost:8085/seeot/board/deleteReply/"+replyNo+'/'+boardNo,
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