<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<link href="<c:url value='/resources/css/members.css'/>"rel="stylesheet">
</head>
<body>
<header>

</header>

	<div class="members-wrapper login">
		<div class="kakao-login">
			<h2 class="title">로그인</h2>
			<p class="text">
				아이디와 비밀번호 입력하기 귀찮으시죠?<br>카카오로 1초 만에 로그인 하세요.
			</p>
			<a class="button kakao-button" href="#">카카오 1초 로그인/회원가입</a>
		</div>
		<div class="user-login">
			<div class="form-wrapper">
				<form name="fo"
					action="<%=request.getContextPath()%>/member/login_check"
					method="post">
					<div>
						<div class="input-box">
							<input id="username" type="text" name="id" placeholder="아이디">
							<input id="password" type="password" name="pw" placeholder="비밀번호">
						</div>
						<div class="login-checkbox">
							<input type="checkbox" name="autoLogin"><label
								for="save_id">로그인 상태 유지</label>
							<div class="util-menu">
								<a href="#">아이디</a> | <a href="#">비밀번호 찾기</a>
							</div>
						</div>
						<button type="button" class="button login-button"
							onclick="loginChk()">로그인</button>
						<a href="register_form" class="button register-button">회원가입</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function loginChk() {
			var form = document.fo;
			if (!form.id.value) {
				alert("아이디를 입력해주세요.");
				form.id.focus();
				return;
			}

			if (!form.pw.value) {
				alert("비밀번호를 입력해주세요.");
				form.pw.focus();
				return;
			}
			form.action = "<%=request.getContextPath()%>/member/login_check";
		    form.submit();
		}
		</script>
		
<footer>

</footer>
</body>
</html>













