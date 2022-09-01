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

<div class="login_input_box" align="center">
<form action="register_form" method="post">
<div class="input_id">
<span>아이디</span>
<input type="text" name="id">
</div>
<div class="input_pw">
<span>비밀번호</span>
<input type="text" name="pw">
</div>
<div class="input_pw2">
<span>비밀번호 확인</span>
<input type="text">
</div>
<div class="input_name">
<span>이름</span>
<input type="text" name="name">
</div>
<div class="input_phone">
<span>전화번호</span>
<input type="text" name="phone" maxlength="13" onkeyup="addHypen(this);" placeholder="휴대폰 번호를 '-' 없이 입력">
</div>
<div class="input_email">
<span>이메일</span>
<input type="text" name="email" placeholder="이메일 주소 입력">
</div>
<div class="input_birth">
<span>생년월일</span>
<input type="text" name="birth" placeholder="ex)2000.01.01">
</div>
<div class="input_addr">
<span>주소</span>
<input type="text" readonly id="addr1" name="addr1" placeholder="우편번호">
<button type="button" onclick="daumPost()">주소 검색</button><br>
<input type="text" readonly id="addr2" name="addr2" placeholder="주소"><br>
<input type="text" id="addr3" name="addr3" placeholder="상세주소"><br>
</div>
<div>
<input type="submit" value="가입">
</div>
</form>
</div>

<script type="text/javascript">

/* 휴대폰 번호 입력시 '-' 자동 입력 처리 */
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







