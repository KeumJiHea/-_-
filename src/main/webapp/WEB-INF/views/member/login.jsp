<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	로그인 페이지입니다

	<div class="wrap">
		<div align="center">
			<form action="<%=request.getContextPath()%>/member/login_check"
				method="post">
				<input type="text" name="id" placeholder="ID입력"><br>
				<input type="text" name="pw" placeholder="PW입력"><br> 
				<input type="submit" value="로그인"> <a href="register_form">회원가입</a>
				<br> <input type="checkbox" name="autoLogin"> 로그인 유지
			</form>
		</div>
	</div>

</body>
</html>