<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:forEach var="rdto" items="${reviewMore}">

 <div align='left'>
 <b>아이디 : </b> ${rdto.memberId }님  &nbsp;
<b>작성일 : </b>  ${rdto.reviewDate } &nbsp;
<b>별점 : </b>${rdto.reviewStar } <br>
<b>내용 : </b> ${rdto.reviewContent }<br>
<!-- reviewNo:  ${rdto.reviewNo }  productNo: ${rdto.productNo} //정보 확인용<br> -->
				<c:if test="${rdto.reviewFile ne 'nan'}">
					<div align='right'>
					<img src="download?file=${rdto.reviewFile }" width="50" height="50" />
					</div>
				</c:if>
					
					
				
			
				<c:if test="${sessionScope.loginUser == reviewData[i].memberId}"></c:if>
			<div><a href="delete?reviewNo=${rdto.reviewNo }&productNo=${rdto.productNo }&reviewStar=${rdto.reviewStar }">삭제</a> &nbsp 
			<a href="modify_form?reviewNo=${rdto.reviewNo }&productNo=${rdto.productNo }">수정</a></div>
			
				
	<hr></div>
			



</c:forEach>
</body>
</html>