<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<style type="text/css">
	    .wrapper {
	    	width: 1000px;
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
<body onload=productList();>
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
	
	var num = 1;
	var orderBy = 'redate';
	
	function pagingNum(pNum) {
		num = pNum;
		productList();
	}
	
	function listOrder(order) {
		orderBy = order;
		num = 1;
		productList();
	}
	
	
	function productList() {
		
		console.log(num)
		console.log(orderBy)
		console.log(chkColor_arr);
		console.log(chkPrice_arr);
		
		$.ajax({
			url: "TestallCount?productCategorie=" + productCategorie,
			type: "post",
			data: {
				chkColor_arr : chkColor_arr,
				chkPrice_arr : chkPrice_arr
			},
			datatype:"json",
			success: function(list) {
				console.log("리스트 갯수 : " + list)

				
				let paging = "";
				
				var pageViewProduct = 12;
				var productCount = list;
				var repeat = parseInt(productCount / pageViewProduct);
				if( productCount / pageViewProduct != 0) {
					repeat += 1;
				}
				
				for(i=1; i<=repeat; i++) {
					paging += "<a href='javascript:void(0);' onclick='javascript:pagingNum(" + [i] + ")'>" + [i] + "</a> &nbsp;"
					$(".paging").html(paging);
				}
				
				$.ajax({
					url: "Testprolist?productCategorie=" + productCategorie,
					type: "post",
					data: {
						orderBy : orderBy,
						num : num,
						pageViewProduct : pageViewProduct,
						chkColor_arr : chkColor_arr,
						chkPrice_arr : chkPrice_arr
						
					},
					datatype:"json",
					success: function(list) {
						console.log("리스트 갯수 : " + list.length)
						console.log("전체 리스트  :" + list)
						
						let html = "";
						
						for(i=0; i<list.length; i++) {
							html += "<div class='product'>";
							html += "<a href='${contextPath}/product/productView?productNo=" + list[i].productNo + "'>";
							html += "<span><img width='240px' height='300px' src='${contextPath}/product/download?productFile=" + list[i].productFile  + "'></span><br>";
							html += "<span><b>" + list[i].productName + "</b></span><br>";
							html += "<span><b>" + list[i].productPrice + "</b></span></a>";
							html += "</div>";
							$(".wrapper").html(html);
						}
					}
					
				})
				
				
			}
		})
		
	}
	
	
	var chkColor_arr = [];
	var chkPrice_arr = [];
	function selectSearch() {
		chkColor_arr = [];
		$("input[name=Color]:checked").each(function(){
			var chkColor = $(this).val();
			chkColor_arr.push(chkColor);
		})
		
		chkPrice_arr = [];
		$("input[name=Price]:checked").each(function(){
			var chkPrice = $(this).val();
			chkPrice_arr.push(chkPrice);
		})
			
			productList();
	}
	
	</script>
	
	<div>
		색상
		<input type="checkbox" name="Color" value="RED"> RED
		<input type="checkbox" name="Color" value="GREEN"> GREEN
		<input type="checkbox" name="Color" value="BLUE"> BLUE
		<input type="checkbox" name="Color" value="BLACK"> BLACK
		<hr>
		가격범위
		<input type="checkbox" name="Price" value="PR1">1만원이하
		<input type="checkbox" name="Price" value="PR2">1~3만원
		<input type="checkbox" name="Price" value="PR3">3만원~5만원
		<input type="checkbox" name="Price" value="PR4">5만원~10만원
		<input type="checkbox" name="Price" value="PR5">10만원이상
		<hr>
		<input type="button" value="검색하기" onclick="selectSearch()">
	</div><br>
	
	<select size="1" onchange="listOrder(this.value)">
			<option value="redate"> 최신순
			<option value="lprice"> 낮은 가격순
			<option value="hprice"> 높은 가격순
			<option value="rating"> 높은 별점순
			<option value="review"> 리뷰 많은순
	</select><br>
	
	
	<div class="wrapper">
		
	</div>

	<div class="paging">
	
	</div>
	

</body>
</html>