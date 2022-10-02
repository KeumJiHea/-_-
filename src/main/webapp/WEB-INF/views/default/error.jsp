<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<% response.setStatus(200); %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error Page</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/common.css" >
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/error.css" >
<script src="https://kit.fontawesome.com/7bffe1de66.js" crossorigin="anonymous"></script>
</head>
<body>
	<div class="error">
		<img src="<%=request.getContextPath()%>/resources/images/sorry.png">
		<div class="error-page">
	        <h2>서비스 이용에 불편을 드려 죄송합니다.</h2>
	        <p>
	        	지금 입력하신 주소의 페이지는 사라졌거나 다른 페이지로 변경되었습니다.
	        	<br>
	        	입력하신 페이지의 주소가 정확한지 다시 한번 확인해 주세요.
	        </p>
	        <button class="button" onclick="location.href='<%=request.getContextPath() %>/home'">메인으로</button>
		</div>
	</div>
	<a href="https://www.flaticon.com/free-icons/face" title="face icons">Face icons created by Freepik - Flaticon</a>
</body>
</html>
