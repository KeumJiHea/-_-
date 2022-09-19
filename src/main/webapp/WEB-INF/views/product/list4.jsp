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
	        width: calc( 100% / 4 - 10px );
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
	
	/* 카테고리 넘버 가져오기 */
	const url = window.location.search;
	var params = new URLSearchParams(url);
	var productCategorie = params.get('productCategorie');
	if( productCategorie == null ) {
		productCategorie = 0;
	}

	
	function listOrder(orderBy) {
		console.log(orderBy)	
		$.ajax({
			url: "prolist?productCategorie=" + productCategorie,
			type: "post",
			data: {
				orderBy : orderBy
			},
			datatype:"json",
			success: function(list) {
				console.log("전체 리스트  :" + list)
				console.log("리스트 갯수 : " + list.length)
				
				let html = "";
				let paging = "";
				
				var num = 1;
				var pageViewProduct = 16;
				var productCount = list.length;
				var repeat = parseInt(productCount / pageViewProduct);
				if( productCount / pageViewProduct != 0) {
					repeat += 1;
				}
				var end = num * pageViewProduct;
				var start = end + 1 - pageViewProduct;
				
				
				for(i=0; i<list.length; i++) {
					html += "<div class='product'>";
					html += "<a href='${contextPath}/product/productView?productNo=" + list[i].productNo + "'>";
					html += "<span><img width='240px' height='300px' src='${contextPath}/product/download?productFile=" + list[i].productFile  + "'></span><br>";
					html += "<span><b>" + list[i].productName + "</b></span><br>";
					html += "<span><b>" + list[i].productPrice + "</b></span></a>";
					html += "</div>";
					$(".wrapper").html(html);
				}
				
				for(i=0; i<repeat; i++) {
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