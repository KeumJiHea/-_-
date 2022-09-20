<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리 페이지</title>
<style type="text/css">
.admin-members-title {
    font-weight: 400;
    text-align: center;
    color: #222;
    padding-bottom: 20px;
    cursor: pointer;
}
.admin-members-input {
	border : none;
	font-size : 20px;
	text-align : left;
	width: 230px;
	height: 50px;
	margin-bottom: 10px;
}
.admin-wrapper {
	text-align: center;
}
</style>
</head>
<body>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 회원 목록 -->
<div class="admin-wrapper">
<h1 class="admin-members-title">회원 관리 페이지</h1>
<c:forEach var="member" items="${list}">
	<label style="font-size: 20px;">아이디 : </label><input type="text" readonly class="admin-members-input" value="${member.id}">
	<label style="font-size: 20px;">이름 : </label><input type="text" readonly class="admin-members-input" value="${member.name}">
	<label style="font-size: 20px;">이메일 : </label><input type="text" readonly class="admin-members-input" value="${member.email}"><br><hr style="width: 930px;">
</c:forEach>
<form action="delete">
<input type="text" name="id"><br>
<label>탈퇴시킬 회원 ID 입력</label><br>
<input type="submit" value="탈퇴">
</form>
<input type="button" value="이전으로" onclick="history.back()">
</div>
</body>
</html>