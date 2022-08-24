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
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<table border=1>
<tr>
<th> no </th><th> 아이디 </th> <th> 작성자 </th>  <th> 제목 </th>
<th> 그룹 </th> <th> indent </th> <!-- 나중에 그룹,indent 가리기 -->

</tr>
<c:if test="${boardList.size() == 0 }">
	<tr>
		<td colspan="6">저장 데이터 없음</td>
	</tr>
</c:if>
<c:forEach var="dto" items="${boardList }">
<tr>
<td>${dto.boardNo }</td>
<td>${dto.memberId }</td>
<td>${dto.memberName }</td> 
<td><a href="${contextPath }/board/boardContentView?memberId=${dto.memberId}">${dto.boardTitle }</a></td>
   <td>${dto.boardGroup }</td><td>${dto.boardIndent }</td><!--  -->
</tr>
</c:forEach>
<tr>
<td colspan="6">
<input type="button" onclick="location.href='boardWrite'" value="문의하기">
</td>
</tr>

</table>
</body>
</html>