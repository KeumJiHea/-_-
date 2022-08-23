<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/daum_post.js"></script>

	<div align="center">
	<h1>회원가입 페이지</h1>
<form action="register" method="post">
	<input type="text" name="id" placeholder="아이디 입력"><br>
	<input type="text" id="password" name="pw" placeholder="비밀번호 입력"><br>
	<input type="text" id="passwordcheck" name="pwchk" placeholder="비밀번호 확인"><br>
	<input type="text" name="name" placeholder="이름 입력"><br>
	<input type="text" name="birth" placeholder="생년월일 입력"><br>
	<input type="text" name="phone" onkeyup="addHypen(this);" placeholder="휴대폰 번호를'-'없이 입력"><br>
	<input type="text" name="email" placeholder="이메일 입력"><br>
	<input type="text" readonly id="addr1" name="addr" placeholder="우편번호">
	<button type="button" onclick="daumPost()">우편번호찾기</button><br>
	<input type="text" readonly id="addr2" name="addr" placeholder="주 소"><br>
	<input type="text" name="addr" id="addr3" placeholder="상 세 주 소"><br>
	<input type="submit" value="가입">
</form>
	</div>
	
<script type="text/javascript">

//  < 비밀번호 유효성 검사 >
$("#password").change(function(){
    checkPassword($('#password').val(),$('id').val());
});
function checkPassword(password,id){
    
    if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test(password)){            
        alert('숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.');
        $('#password').val('').focus();
        return false;
    }    
    
    var checkNumber = password.search(/[0-9]/g);
    var checkEnglish = password.search(/[a-z]/ig);
    
    if(checkNumber <0 || checkEnglish <0){
        alert("숫자와 영문자를 혼용하여야 합니다.");
        $('#password').val('').focus();
        return false;
    }
    return true;
}

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
</script>
	
	
	
	
</body>
</html>







