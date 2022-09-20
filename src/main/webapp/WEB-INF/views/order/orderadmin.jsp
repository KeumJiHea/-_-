<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
 	$(document).ready(function(){ //9020 중복되는 주문번호 합쳐보기
		for(i=0;i<$("#tbody tr").length;i++){
			if(i>$("#tbody tr").length){
				i=$("#tbody tr").length
				if($("#no"+i).text()==$("#no"+(i+1)).text()){
					$("#no"+i).attr('rowspan',(i));
				}			
			}
		}
	}) 
</script>
</head>
<body>
	<table border="1">
		<tr>
			<td>주문번호</td><td>주문상품</td><td>가격</td><td>주문상태</td>
		</tr>
		<tbody id="tbody">
			<c:forEach var="odto" items="${list }" varStatus="status">				
				<tr>
					<td id="no${status.index }">${odto.orderNo }</td><td>${odto.productName }</td><td>${odto.productPrice }</td><td>${odto.orderStatus }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>