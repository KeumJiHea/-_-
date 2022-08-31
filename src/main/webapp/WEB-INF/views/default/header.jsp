<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.wrap {
   display: flex;
}
</style>
</head>
<body>
<div class="wrap">
		<div class="header">
			<h1 class="title">test</h1>
		</div>
	</div>
<%@ taglib prefix="c"
			uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" 
		value="${pageContext.request.contextPath}"/>
	<div class="navdiv">
		<div class="wrap">
			<nav>
				<ul>
<li> <a href="${contextPath }/index">HOME</a> </li>
<li>
	<a href="${contextPath }/member/info">마이페이지</a>
</li>
<li> 
	<c:if test="${loginUser == null }">
		<a href="${contextPath }/member/login">로그인</a> 
	</c:if>
	<c:if test="${loginUser != null }">
		<a href="${contextPath }/member/logout">로그아웃</a>
	</c:if>
</li>
				</ul>
			</nav>
		</div>
	</div>
</body>
</html>