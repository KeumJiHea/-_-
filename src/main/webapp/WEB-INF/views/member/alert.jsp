<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 회원가입 alert -->
<script>
	var rmsg = "<c:out value='${rmsg}'/>";
	var rurl = "<c:out value='${rurl}'/>";
	alert(rmsg);
	location.href = rurl;
</script>

<!-- 정보 수정 alert -->
<script>
	var msg = "<c:out value='${msg}'/>";
	var url = "<c:out value='${url}'/>";
	alert(msg);
	location.href = url;
</script>

</body>
</html>