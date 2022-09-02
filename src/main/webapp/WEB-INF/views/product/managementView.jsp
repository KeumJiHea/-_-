<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<h2>${param.productNo }번 상품의 재고 상황</h2>
	<button type="button" onclick="location.href='productView?productNo=${param.productNo }'" >상품으로</button>
	<button type="button" onclick="location.href='managementRegister_Form?productNo=${param.productNo }'" >상품 재고 등록</button>
	<hr>
	<table border="1">
		<tr>
			<th>남은 재고 수량</th> <th>보유 사이즈</th> <th>보유 색</th> <th>재고 관리</th>
		</tr>
		<c:forEach var="mdto" items="${list }">
			<tr>
				<td>${mdto.productStack }</td> <td>${mdto.productSize}</td> <td>${mdto.productColor }</td>
				<td>
					<button type="button" onclick="location.href='managementModify_Form?productNo=${mdto.productNo}&productSize=${mdto.productSize }&productColor=${mdto.productColor }'" >상품 재고 수정</button> | 
					<button type="button" onclick="location.href='managementDelete?productNo=${mdto.productNo}&productSize=${mdto.productSize }&productColor=${mdto.productColor }'" >상품 재고 삭제</button>
				</td>
			</tr>
		</c:forEach>
	</table>
	
	
</body>
</html>