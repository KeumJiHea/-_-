/**
 * 
 */
let fileNo = 0; //파일 고유 넘버
let filesArr = []; //올라온 파일들의 배열(삭제해도 배열에서는 지워지지 않음)
				   //fileNo로 인덱스 조회하기 때문

function addFile(obj){
	let maxFileCnt = 5; //최대 첨부 가능 파일 개수
	let attFileCnt = document.querySelectorAll('.filebox').length; //현재 올라간 파일 개수
	let remainFileCnt = maxFileCnt - attFileCnt; //더 올릴 수 있는 파일 개수
	let curFileCnt = obj.files.length; //지금 input된 파일 개수
	let files = obj.files;

	
	if(curFileCnt > remainFileCnt){
		alert("첨부파일은 최대"+ maxFileCnt +"개까지 첨부 가능합니다.");
	}else{
		let inputFilesArr = [];
		inputFilesArr = Array.prototype.slice.call(files); //지금 input된 파일들의 배열
		filesArr.push(...inputFilesArr); //filesArr에 지금 input된 파일들 넣어줌
		
		inputFilesArr.forEach((file,index)=>{ //지금 input된 파일들에 개별로 실행하는 함수
			if(validation(file)){ //유효성 검증
				let reader = new FileReader();
				reader.onload = function(e){
					let htmlData = '';
					htmlData += '<div id="file' + fileNo + '"class="filebox">';
	 				htmlData += '<img src="'+e.target.result+'" id="preview' + fileNo + '"';
					htmlData += 'width="100px" height="100"';
					htmlData += 'alt="'+ file.name +'">';
					htmlData += '<p class="name">' + file.name + '</p>';
					htmlData += '<a class="delete" onclick="deleteFile(' + fileNo + ');">삭제</a>';
					htmlData += '</div>';
					$('.file-list').append(htmlData);
					fileNo++;
				}
				reader.readAsDataURL(file);
			}else{ //유효성 검증 실패시
				//document.querySelector("input[type=file]").value="";
				return;
			}
		})
	}
	document.querySelector("input[type=file]").value="";
}

function validation(obj){
	if(obj.name.length>100){
		alert('파일명이 100자 이상인 파일은 제외되었습니다.');
		return false;
	}else if(obj.size > (50 * 1024 * 1024)){
		alert('50MB를 초과한 파일은 제외되었습니다.');
		return false;
	}else if(!obj.type.match('image.*')){
		alert('이미지 파일만 첨부할 수 있습니다.')
		return false;
	}else{
		return true;
	}
}

function deleteFile(num){
	document.querySelector("#file"+num).remove();
	filesArr[num].is_delete = true; //filesArr에 is_delete = true 키 값 추가
}

function submitForm(){
	let form = $('#writeForm')[0];
	let formData = new FormData(form);
	formData.delete('boardFile');
	filesArr.forEach((file)=>{
		if(!file.is_delete){
			formData.append('image', file);
			//<input name='image' value=file>와 같은 의미
		}
	})
	
	$.ajax({
		type:"POST",
		enctype: 'multipart/form-data',
		url: 'http://localhost:8085/seeot/board/writeSave',
		data: formData,
		dataType: 'text',
		processData:false,
		contentType:false,
		cache:false,
		success: function(data){
			$("#response").html(data);
		},
		error: function(e){
			console.log("error: ", e);
			alert("글 작성에 실패했습니다.")
		}
	});
}