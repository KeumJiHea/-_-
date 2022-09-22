<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
<b style="font-size: 20px;">관리자 페이지</b><br>

<a href="${pageContext.request.contextPath}/member/logout">로그아웃</a><br>
<a href="${pageContext.request.contextPath}/member/memberlist">회원 관리</a><br>
<a href="${pageContext.request.contextPath}/order/orderadmin">주문 관리</a>
</body>
</html>