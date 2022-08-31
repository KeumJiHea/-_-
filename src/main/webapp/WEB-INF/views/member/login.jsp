<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<style type="text/css">

.input_login_btn{
    width: 210px;
	height: 40px;
	margin: auto;
	display: block;
	text-align: center;
	font-size: 18px;
	cursor: pointer;
	color: white;
	background-color: black;
	border: gray;
}
</style>

</head>
<body>

	<div class="wrap">
		<div align="center">
			<form action="<%=request.getContextPath()%>/member/login_check" method="post">
				<div class="input_login">
				<input type="text" name="id" autocomplete="off" placeholder="ID" 
				style="width: 200px; height: 15px; border: none; border-bottom: 1px solid black; font-size: 18px;"><br>
				<input type="text" name="pw" autocomplete="off" placeholder="PW"
				style="width: 200px; height: 15px; border: none; border-bottom: 1px solid black; font-size: 18px;"><br> 
				</div>
				<div class="input_login_btn">
				<input type="submit" value="로그인">
				</div>
				<a href="register_form">회원가입</a><a href="#">ID/PW찾기</a>
				<br> <input type="checkbox" name="autoLogin"> 자동 로그인
			</form>
		</div>
	</div>
	
</body>
</html>
















