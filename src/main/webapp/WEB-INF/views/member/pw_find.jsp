<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<body>
<h1>비밀번호 찾기</h1>
<form action="pw_find">
<div class="textbox">
  <input type="text" name="id" id="id" required="">
    <label for="text">아이디</label>
  <div class="error">아이디를 입력해주세요</div>
</div>
<div class="textbox">
  <input id="email" name="email" class="input_email" required="/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)?$/i" type="email">
    <label for="text">이메일</label>
  <div class="error">유효하지 않은 이메일 주소입니다</div>
</div><br><br>
<input type="submit" value="비밀번호 찾기" class="find">
</form>
</body>
</html>