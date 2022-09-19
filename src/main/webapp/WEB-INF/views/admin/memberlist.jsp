<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리 페이지</title>
</head>
<body>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h1>회원 목록</h1>
<table border="">
<c:forEach var="member" items="${list }">
   <tr>
     <td>${member.id}</td>
     <td>${member.pw }</td>
     <td>${member.birth }</td>
     <td>${member.addr1 }</td>
     <td>${member.addr2 }</td>
     <td>${member.addr3 }</td>
   </tr>
</c:forEach>
</table>
<form action="delete">
<input type="text" name="id"><br>
<label>탈퇴시킬 회원 ID 입력</label><br>
<input type="submit" value="탈퇴">
</form>
</body>
</html>