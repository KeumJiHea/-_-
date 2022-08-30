function daumPost(){
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
            console.log( data.zonecode )
            console.log( data.userSelectedType )
            console.log( data.roadAddress )
            console.log( data.jibunAddress )
            
            //$("#addr1").val( data.zonecode )
		    document.getElementById("addr1").value = data.zonecode
		    if(data.userSelectedType == 'R'){
		    	var addr = data.roadAddress
		    }else{
		    	var addr = data.jibunAddress
		    }
		    document.getElementById("addr2").value = addr
		    
		    document.getElementById("addr3").focus()
        }
    }).open();
}