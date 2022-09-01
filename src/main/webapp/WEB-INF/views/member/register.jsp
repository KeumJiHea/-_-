<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="<c:url value='/resources/css/members.css'/>"rel="stylesheet">
</head>
<body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/daum_post.js"></script>

	<div class="members-wrapper register">
		<div class="user-login">
			<h2 class="title">회원가입</h2>
			<p class="text">
				간단한 정보 입력 후 가입해보세요.<br>
				<a href="login">로그인 페이지로 돌아가기</a>
			</p>
			<form action="register" method="post">
				<div class="field input_id">
					<span>아이디</span> <input type="text" name="id">
				</div>
				<div class="field input_pw">
					<span>비밀번호</span> <input type="password" name="pw" placeholder="">
				</div>
				<div class="field input_pw2">
					<span>비밀번호 확인</span> <input type="password">
				</div>
				<div class="field input_name">
					<span>이름</span> <input type="text" name="name">
				</div>
				<div class="field input_phone">
					<span>전화번호</span> <input type="text" name="phone" maxlength="13"
						onkeyup="addHypen(this);" placeholder="휴대폰 번호를 '-' 없이 입력">
				</div>
				<div class="field input_email">
					<span>이메일</span> <input type="text" name="email"
						placeholder="이메일 주소 입력">
				</div>
				<div class="field input_birth">
					<span>생년월일</span> <input type="text" name="birth"
						placeholder="ex)2000.01.01">
				</div>
				<div class="field input_addr">
					<span>주소</span> <input type="text" readonly id="addr1" name="addr1"
						placeholder="우편번호">
					<button type="button" onclick="daumPost()" style="cursor: pointer;">주소 검색</button>
					<input type="text" readonly id="addr2" name="addr2"
						placeholder="주소"> <input type="text" id="addr3"
						name="addr3" placeholder="상세주소 ex) 303호">
				</div>
				<div class="login-checkbox agreement">
					<input type="checkbox" name="agreement02"><a href="#">쇼핑몰
						이용약관에 동의합니다. (필수)</a>
				</div>
				<div class="login-checkbox agreement">
					<input type="checkbox" name="agreement01"><a href="#">만
						14세 이상입니다. (필수)</a>
					<ul>
						<li>만 14세 미만의 아동은 회원가입 시 법적대리인의 동의가 필요합니다.</li>
						<li>회원가입에 필요한 최소한의 정보만 입력 받음으로써 고객님의 개인정보 수집을 최소화하고 편리한 회원가입을
							제공합니다.</li>
					</ul>
				</div>
				<div>
					<input type="submit" class="button" value="회원가입">
				</div>
			</form>
		</div>
	</div>

	<script type="text/javascript">
		/* 휴대폰 번호 입력시 '-' 자동 입력 처리 */
		function addHypen(obj) {
			var number = obj.value.replace(/[^0-9]/g, "");
			var phone = "";

			if (number.length < 4) {
				return number;
			} else if (number.length < 7) {
				phone += number.substr(0, 3);
				phone += "-";
				phone += number.substr(3);
			} else if (number.length < 11) {
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







