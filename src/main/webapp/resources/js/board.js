/**
 * 
 */
let fileNo = 0;
let filesArr = new Array();
let thumbArr = new Array();

function addFile(obj){
	let maxFileCnt = 5;
	let attFileCnt = document.querySelectorAll('.filebox').length;
	let remainFileCnt = maxFileCnt - attFileCnt;
	let curFileCnt = obj.files.length;
	
	if(curFileCnt > remainFileCnt){
		alert("첨부파일은 최대" + maxFileCnt + "개까지 첨부 가능합니다.");
	}else{
		for(const file of obj.files){
			if(validation(file)){ //파일 유효성 검증
				let reader = new FileReader();
				
				/* reader.onload가 가장 늦게 실행됨!!! */
				reader.onload = function(e){
					filesArr.push(file);
					thumbArr.push(e.target.result);
					$('#preview'+(fileNo-1)).attr("src", thumbArr[fileNo-1]);
				};
				reader.readAsDataURL(file);
				
				let htmlData = '';
				htmlData += '<div id="file' + fileNo + '"class="filebox">';
 				htmlData += '<img src="#" id="preview' + fileNo + '"';
				htmlData += 'width="100px" height="100"';
				htmlData += 'alt="'+ file.name +'">';
				htmlData += '<p class="name">' + file.name + '</p>';
				htmlData += '<a class="delete" onclick="deleteFile(' + fileNo + ');">삭제</a>';
				htmlData += '</div>';
				
				$('.file-list').append(htmlData);
			
				fileNo++;

			}else{
				continue;
			}
		}
	}
	
	//document.querySelector("input[type=file]").value="";
}

function validation(obj){
	if(obj.name.length>100){
		alert('파일명이 100자 이상인 파일은 제외되었습니다.');
		return false;
	}else if(obj.size > (50 * 1024 * 1024)){
		alert('50MB를 초과한 파일은 제외되었습니다.');
		return false;
	}else{
		return true;
	}
}

function deleteFile(num){
	document.querySelector("#file"+num).remove();
	filesArr[num].is_delete = true;
	thumbArr[num].is_delete = true;
}