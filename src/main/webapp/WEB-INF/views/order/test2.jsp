<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	TEST2.jsp<br>
	
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<c:forEach var="dto" items="${list }">
		${dto.productNo }<br>
		${dto.productFile}<br>
		${dto.productPrice }<br>
		${dto.productName}<br>
		${dto.productColor}<br>
		${dto.productSize}<br>
		${dto.productStack}
		<hr>
	</c:forEach>
	
</body>
</html>