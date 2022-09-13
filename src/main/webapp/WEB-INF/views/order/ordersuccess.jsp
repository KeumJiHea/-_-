<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	주문번호 : ${order.merchant_uid }
	제품명 : ${order.name }
	총 가격 : ${order.amount }
	구매자 이름 : ${order.buyer_name }
	구매자 주소 : ${order.buyer_addr }
	구매자 우편번호 : ${order.buyer_postcode }
</body>
</html>