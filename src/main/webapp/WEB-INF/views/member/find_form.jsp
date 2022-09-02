<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID/PW찾기</title>
</head>
<body>
<div class="find_form">
<form action="find_id_form">
<label>--  ID찾기  --</label>
<br>
<input type="text" class="input_email" name="email"><br>
<label>이메일로 ID 찾기</label><br>
<input type="submit" value="ID찾기">
</form>

<form action="find_pw_form">
<label>PW찾기</label>
<label for="text">아이디</label>
<input type="text" class="input_id" name="id">

<input type="submit">
</form>
</div>
</body>
</html>