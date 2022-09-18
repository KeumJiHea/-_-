<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<style type="text/css">
	    .wrapper {
	    	width : 35%;
	        display: flex;
	        flex-wrap: wrap;
	    }
	    .product {
	        width: calc( 100% / 3 - 10px );
	        justify-content: space-between;
	        background-color: #ddd;
	        margin: 5px;
	    }
	</style>
</head>
<body onload=listOrder('redate');>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<c:set var="contextPath" value="${pageContext.request.contextPath }" />
	
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript">
	function listOrder(orderBy) {
		console.log(orderBy)	
		$.ajax({
			url: "prolist",
			type: "post",
			data: {
				orderBy : orderBy
			},
			datatype:"json",
			success: function(list) {
				console.log("전체 리스트  :" + list)
				
				let html = ""
				let paging = ""
				for(i=0; i<6; i++) {
					html += "<div class='product'>";
					html += "<a href='${contextPath}/product/productView?productNo=" + list[i].productNo + "'>";
					html += "<span><img width='240px' height='300px' src='${contextPath}/product/download?productFile=" + list[i].productFile  + "'></span><br>";
					html += "<span><b>" + list[i].productName + "</b></span><br>";
					html += "<span><b>" + list[i].productPrice + "</b></span></a>";
					html += "</div>";
					$(".wrapper").html(html);
				}
				
				console.log("리스트 갯수 : " + list.length)
				var pagingNum = list.length / 9
				for(i=0; i<pagingNum; i++) {
					paging += "<a href=''>" + [i+1] + "</a> &nbsp;"
					$(".paging").html(paging);
				}
				
			}
			
		})
	}
	</script>
	
	<select size="1" onchange="listOrder(this.value)">
			<option value="redate"> 최신순
			<option value="lprice"> 낮은 가격순
			<option value="hprice"> 높은 가격순
			<option value="rating"> 높은 별점순
			<option value="review"> 리뷰 많은순
	</select>
	
	
	
	<div class="wrapper">
		
	</div>

	<div class="paging">
	
	</div>
	

</body>
</html>