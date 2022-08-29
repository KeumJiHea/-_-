<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>

<style type="text/css">
/* 아이디 사용 가능 */
.id_input_re_1{
    color: green;
    display: none;
}

/* 아이디 중복 */
.id_input_re_2{
    color: red;
    display: none;
}

/* 비밀번호 사용 가능 */
.pwck_input_re_1{
    color: green;
    display: none;
}
.pwck_input_re_2{
    color: red;
    display: none;
}

/* 이메일 인증 일치 여부 */
.correct{
    color: green;
}
.incorrect{
    color: red;
}

/* 유효성 검사 문구 */
.final_id_ck{
    display: none;
}
.final_pw_ck{
    display: none;
}
.final_pwck_ck{
    display: none;
}
.final_name_ck{
    display: none;
}
.final_mail_ck{
    display: none;
}
.final_addr_ck{
    display: none;
}
.final_birth_ck{
    display: none;
}
.final_phone_ck{
    display: none;
}
/* 이메일 인증번호 전송 여부에 따른 text박스 색상 */
/* false -> 회색      true -> 흰색 */
#mail_check_input_box_false{
    background-color:#ebebe4;
}
 
#mail_check_input_box_true{
    background-color:white;
}
</style>

</head>
<body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<div align="center">
<h1>회원가입 페이지</h1>
	
<form id="join_form" method="post">
<div class="id_wrap">
  <div class="id_name">아이디</div>
    <div class="id_input_box">
	<input type="text" class="id_input" id="id" name="id"><br>
    </div>
  <span class="id_input_re_1">사용 가능한 아이디입니다</span>
  <span class="id_input_re_2">아이디가 이미 존재합니다</span>
  <span class="final_id_ck">아이디를 입력해주세요</span>
</div>

<div class="pw_wrap">
  <div class="pw_name">비밀번호</div>
    <div class="pw_input_box">
	<input type="text" class="pw_input" id="password" name="pw"><br>
    </div>
  <span class="final_pw_ck">비밀번호를 입력해주세요</span>
</div>

<div class="pwch_wrap">
  <div class="pwch_name">비밀번호 확인</div>
    <div class="pwck_input_box">
	<input type="text" class="pwck_input" id="passwordcheck" name="pwchk"><br>
	</div>
  <span class="final_pwck_ck">비밀번호 확인을 입력해주세요</span>
  <span class="pwck_input_re_1">비밀번호가 일치합니다</span>
  <span class="pwch_input_re_2">비밀번호가 일치하지 않습니다</span>
</div>

<div class="name_wrap">
  <div class="user_name">이름</div>
    <div class="name_input_box">
	<input type="text" class="name_input" id="name" name="name"><br>
	</div>
  <span class="final_name_ck">이름을 입력해주세요</span>
</div>	

<div class="birth_wrap">
  <div class="birth_name">생년월일</div>
    <div class="birth_input_box">
    <input type="text" class="birth_input" id="birth" name="birth"><br>
    </div>
  <span class="final_birth_ck">생년월일을 입력해주세요</span>
</div>

<div class="phone_wrap">
  <div class="phone_name">휴대폰 번호</div>
    <div class="phone_input_box">
    <input type="text" class="phone_input" id="phone" name="phone" onkeyup="addHypen(this);"><br>
    </div>
  <span class="final_phone_ck">휴대폰 번호를 입력해주세요</span>
</div>	

<div class="mail_wrap">
  <div class="mail_name">이메일</div>
    <div class="mail_input_box">
    <input type="text" class="mail_input" id="email" name="email"><br>
    </div>
  <span class="final_mail_ck">이메일을 입력해주세요</span>
  <div class="mail_check_wrap">
    <div class="mail_check_input_box" id="mail_check_input_box_false">
    <input class="mail_check_input" disabled="disabled">
    </div>
  <div class="mail_check_button">
    <span>인증번호 전송</span>
  </div>
  <div class="clearfix"></div>
    <span id="mail_check_input_box_warn"></span>
  </div>
</div>

<div class="addr_wrap">
  <div class="addr_name">주소</div>
<div class="daar_input_1_wrap">
  <div class="addr_input_1_box">
    <input type="text" class="addr_input1" readonly id="addr1" name="addr1" placeholder="우편번호" disabled="disabled">
  </div>
  <div class="addr_button" onclick="daumPost()">
    <span>주소 찾기</span>
  </div>
  <div class="clearfix"></div>
</div>
<span class="final_addr_ck"></span>
<div class="addr_input_2_wrap">
  <div class="addr_input_2_box">
  <input type="text" class="addr_input2" readonly id="addr2" name="addr2" disabled="disabled"><br>
  </div>
</div>
<span class="final_addr_ck"></span>
<div class="addr_input_3_wrap">
  <div class="addr_input_3_box">
  <input type="text" class="addr_input3" id="addr3" placeholder="상세주소 ex)303호" name="addr3" disabled="disabled"><br>
  </div>
</div>
  <span class="final_addr_ck">주소를 입력해주세요</span>
</div>

<div class="join_button_wrap">
  <input type="button" class="join_button" value="가입하기">
</div>	

</form>
</div>
	
<script type="text/javascript">

//  < 인증번호 data값 code변수에 저장 >
var code = "";

//  < 유효성 검사 >
var idCheck = false;              // 아이디
var idckCheck = false;            // 아이디 중복 검사
var pwCheck = false;              // 비번
var pwckCheck = false;            // 비번 확인
var pwckcorCheck = false;         // 비번 확인 일치 확인
var nameCheck = false;            // 이름
var birthCheck = false;           // 생일
var PhoneCheck = false;           // 휴대폰
var mailCheck = false;            // 이메일
var mailnumCheck = false;         // 이메일 인증번호 확인
var addr1Check = false;         // 주소
var addr2Check = false;         // 주소
var addr3Check = false;         // 주소

//  < 이메일 인증번호 전송 >
$(".mail_check_button").click(function(){
	
	var email = $(".mail_input").val();       //입력한 이메일
	var checkBox = $(".mail_check_input");    //인증번호 입력란
	var boxWrap = $(".mail_check_input_box"); //인증번호 입력란 박스
	
	$.ajax({
		type:"GET",
		url:"mailCheck?email=" + email,
		success:function(data){
		   checkBox.attr("disabled",false);   //인증번호 보내기 성공시 입력란 활성
		   boxWrap.attr("id","mail_check_input_box_true");
		   code = data;
		}		
	});
	
});

//  < 이메일 인증번호 비교 >
$(".mail_check_input").blur(function(){
	var inputCode = $(".mail_check_input").val();
	var checkResult = $("#mail_check_input_box_warn");
	
	if(inputCode == code){
		checkResult.html("인증번호가 일치합니다");
		checkResult.attr("class","correct");
		mailnumCheck = true;
	} else {
		checkResult.html("인증번호를 다시 확인해주세요");
		checkResult.attr("class","incorrect");
		mailnumCheck = false;
	}
});
 
$(document).ready(function(){
	$(".join_button").click(function(){
		var id = $('.id_input').val();       //ID입력란
		var pw = $('.pw_input').val();       //PW입력란
		var pwck = $('.pwck_input').val();     //PW확인란
		var name = $('.name_input').val();     //이름입력란
		var mail = $('.mail_input').val();     //메일입력란
		var phone = $('.phone_input').val();    //번호입력란
		var birth = $('.birth_input').val();    //생일입력란
		var addr1 = $('.addr_input1').val();    //주소1입력란
		var addr2 = $('.addr_input2').val();    //주소2입력란
		var addr3 = $('.addr_input3').val();    //주소3입력란
		
		/* ID 유효성 검사 */
		if(id == ""){
			$('.final_id_ck').css('display','block');
			idCheck = false;
		}else{
			$('.final_id_ck').css('display','none');
			idCheck = true;
		}
		/* PW 유효성 검사 */
		if(pw == ""){
			$('.final_pw_ck').css('display','block');
			pwCheck = false;
		}else{
			$('.final_pw_ck').css('display','none');
			pwCheck = true;
		}
		
		if(pwck == ""){
			$('.final_pwck_ck').css('display','block');
			pwckCheck = false;
		}else{
			$('.final_pwck_ck').css('display','none');
			pwckCheck = true;
		}
		/* 이름 유효성 검사 */
		if(name == ""){
			$('.final_name_ck').css('display','block')
			nameCheck = false;
		}else{
			$('.final_name_ck').css('display','none')
			nameCheck = true;
		}
		/* 생년월일 유효성 검사 */
		if(birth == ""){
			$('.final_birth_ck').css('display','block');
			birthCheck = false;
		}else{
		    $('.final_birth_ck').css('display','none');
		    birthCheck = true;
		}
		/* 휴대폰 번호 유효성 검사 */
		if(phone == ""){
			$('.final_phone_ck').css('display','block');
			PhoneCheck = false;
		}else{
			$('.final_phone_ck').css('display','none');
			PhoneCheck = true;
		}
		/* 이메일 유효성 검사 */
		if(mail == ""){
			$('.final_mail_ck').css('display','block');
			mailCheck = false;
		}else{
			$('.final_mail_ck').css('display','none');
			mailCheck = true;
		}
		/* 주소 유효성 검사 */
		if(addr1 == ""){
			addr1Check = false;
		}else{
			addr1Check = true;
		}
		
		if(addr2 == ""){
			addr2Check = false;
		}else{
			addr2Check = true;
		}
		
		if(addr3 == ""){
			$('.final_addr_ck').css('display','block')
			addr3Check = false;
		}else{
			$('.final_addr_ck').css('display','none')
			addr3Check = true;
		}
		/* 최종 */
		if(idCheck&&idckCheck&&pwCheck&&pwckCheck&&pwckcorCheck&&nameCheck&&
		birthCheck&&PhoneCheck&&mailCheck&&mailnumCheck&&addr1Check&&addr2Check&&addr3Check){
			$("#join_form").attr("action","/member/register_form");
			$("#join_form").submit();
		}
		return false;
	});
});
	 
//  < 아이디 중복 검사 >
$('id_input').on("propertychange change keyup paste input",function(){
	var memberId = $('.id_input').val();
	var data = {id : memberId}
	
	$.ajax({
		type : "post",
		url : "/member/memberIdChk",
		data : data,
		success : function(result){
			if(result != 'fail'){
				$('.id_input_re_1').css("display","inline-block");
				$('.id_input_re_2').css("display","none");
				idckCheck = true;
			}else{
				$('.id_input_re_2').css("display","inline-block");
				$('.id_input_re_1').css("display","none");
				idckCheck = false;
			}
		}
	});
});

//  < 비밀번호 확인 일치 검사 >
$('.pwck_input').on("propertychange change keyup paste input",function(){
	var pw = $('.pw_input').val();
	var pwck = $('.pwck_input').val();
	$('.final_pwck_ck').css('display','none');
	
	if(pw == pwck){
		$('.pwck_input_re_1').css('display','block')
		$('.pwck_input_re_2').css('display','none')
	    pwckcorCheck = true;
	}else{
		$('.pwck_input_re_1').css('display','none')
		$('.pwck_input_re_2').css('display','block')
		pwckcorCheck = false;
	}
});
//  < 휴대폰 번호 입력 사이에 '-' 자동 추가 기능 >
function addHypen(obj) {
    var number = obj.value.replace(/[^0-9]/g, "");
    var phone = "";

    if(number.length < 4) {
        return number;
    } else if(number.length < 7) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3);
    } else if(number.length < 11) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 3);
        phone += "-";
        phone += number.substr(6);
    } else {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 4);
        phone += "-";
        phone += number.substr(7);
    }
    obj.value = phone;
}

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

</script>
	
	
	
	
</body>
</html>







