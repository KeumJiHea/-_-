<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="boardReplySvae?memberid=${dto.memberId }" method="post" enctype="multipart/form-data">
	<table border="1">
		<!-- 원글번호 필요없으면 버리기
		<tr>
			<td>원글번호</td>
			<td> </td>
		</tr>  -->

		<tr>
			<td>작성자</td>
			<td><input type="text" readonly="readonly" value="${dto.memberId}" name="memberId">
			<input type="hidden" name="boardTitle" value=" ${dto.boardTitle}" > </td>
		</tr>
		<!-- 
		<tr>
			<td>제목</td>
			<td></td>
		</tr>
		 -->
		<tr>
			<td>답변</td>
			<td><textarea name="content" rows="10" cols="50"></textarea></td>
		</tr>
		<!-- group & indent는 나중에 가리기 -->
		<tr>
		<td>${dto.boardGroup}</td> <td>${dto.boardIndent}</td>
		</tr>
		
		<tr >
		<td colspan="2">
		<input type="submit" value="글">
			<!--<a href="location.href='write?boardGroup=${dto.boardGroup}&boardIndent=${dto.boardIndent}'">답글달기</a> </td>
		  --></tr>
	</table>
</form>
</body>
</html>