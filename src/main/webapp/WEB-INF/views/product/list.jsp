<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<style type="text/css">
	    .productWrapper {
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
	var pgnum = 1;
	
	function pagingNum(pNum) {
		num = pNum;
		productList();
	}
	
	function startPagNum(pNum) {
		pgnum = pNum;
		num = pNum;
		productList();
	}
	
	function endPagNum(pNum) {
		if( parseInt( pNum % 5 ) == 0 ){
			pgnum = pNum - 4 ;
		}else {
			pgnum = parseInt( pNum / 5 ) * 5 + 1;
		}
		num = pNum;
		productList();
	}
	
	function prePagNum() {
		pgnum = pgnum - 5;
		num = pgnum;
		productList();
	}
	
	function nextPagNum() {
		pgnum = pgnum + 5;
		num = pgnum;
		productList();
	}
	
	function listOrder(order) {
		orderBy = order;
		num = 1;
		productList();
	}
	
	
	function productList() {
		console.log("@@@@@@ Check value @@@@@")
		console.log("num : " + num)
		console.log("orderBy : " + orderBy)
		console.log("chkColor_arr : " + chkColor_arr);
		console.log("chkPrice_arr : " + chkPrice_arr);
		console.log("chkPrice_arr : " + chkPrice_arr);
		console.log("pgnum : " + pgnum);
		
		$.ajax({
			url: "allCount?productCategorie=" + productCategorie,
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
				};
				console.log("repeat : " + repeat)
				
				if(num == 1) {
					paging += "<button onclick='javascript:startPagNum(1)' disabled> 처음으로 </button>";
					paging += "<button onclick='javascript:prePagNum()' disabled> 이전 </button>";
				}else if(num > 5){
					paging += "<button onclick='javascript:startPagNum(1)'> 처음으로 </button>";
					paging += "<button onclick='javascript:prePagNum()'> 이전 </button>";
				}else{
					paging += "<button onclick='javascript:startPagNum(1)'> 처음으로 </button>";
					paging += "<button onclick='javascript:prePagNum()' disabled> 이전 </button>";
				};
				
				if( (pgnum+5) <= repeat ) {
					for(i=pgnum; i<=(pgnum+4); i++) {
						paging += "<a href='javascript:void(0);' onclick='javascript:pagingNum(" + [i] + ")'>" + [i] + "</a> &nbsp;"
					}
				}else {
					for(i=pgnum; i<=repeat; i++) {
						paging += "<a href='javascript:void(0);' onclick='javascript:pagingNum(" + [i] + ")'>" + [i] + "</a> &nbsp;"
					};
				}
				
				if(num == repeat){
					paging += "<button onclick='javascript:nextPagNum()' disabled> 다음 </button>";
					paging += "<button onclick='javascript:endPagNum(" + repeat + ")' disabled> 끝으로 </button>";
				}else if( (pgnum + 5) >repeat ) {
					paging += "<button onclick='javascript:nextPagNum()'  disabled> 다음 </button>";
					paging += "<button onclick='javascript:endPagNum(" + repeat + ")'> 끝으로 </button>";
				}else {
					paging += "<button onclick='javascript:nextPagNum()'> 다음 </button>";
					paging += "<button onclick='javascript:endPagNum(" + repeat + ")'> 끝으로 </button>";
				};
				
				$(".paging").html(paging);
				
				 $.ajax({
					url: "prolist?productCategorie=" + productCategorie,
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
						if(list.length != 0) {
						for(i=0; i<list.length; i++) {
							html += "<div class='product'>";
							html += "<a href='${contextPath}/product/productView?productNo=" + list[i].productNo + "'>";
							html += "<div style='padding-bottom:0px;'><img width='240px' height='300px' src='${contextPath}/product/download?productFile=" + list[i].productFile  + "'></div><br>";
							html += "<div style='text-align: center; height: 0px; '><b>" + list[i].productName + "</b></div><br>";
							html += "<div style='text-align: center;'><b>" + list[i].productPrice + "</b></div></a>";
							html += "<a href='${contextPath}/product/viewTest?productNo=" + list[i].productNo + "'>Test링크입니다</a>";
							html += "</div>";
							$(".productWrapper").html(html);
						}
						}else{
							html = "<div><b>일치하는 상품이 없습니다.<b></div>";
							$(".productWrapper").html(html);
							paging = ""
							$(".paging").html(paging);
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
		num = 1;
		pgnum = 1;
			
			productList();
	}
	
	</script>
	<div>
		색상
		<input type="checkbox" name="Color" value="RED" onchange="selectSearch()"> RED
		<input type="checkbox" name="Color" value="GREEN" onchange="selectSearch()"> GREEN
		<input type="checkbox" name="Color" value="BLUE" onchange="selectSearch()"> BLUE
		<input type="checkbox" name="Color" value="IVORY" onchange="selectSearch()"> IVORY
		<input type="checkbox" name="Color" value="BLACK" onchange="selectSearch()"> BLACK
		<input type="checkbox" name="Color" value="WHITE" onchange="selectSearch()"> WHITE
		<hr>
		가격범위
		<input type="checkbox" name="Price" value="PR1" onchange="selectSearch()">1만원이하
		<input type="checkbox" name="Price" value="PR2" onchange="selectSearch()">1~3만원
		<input type="checkbox" name="Price" value="PR3" onchange="selectSearch()">3만원~5만원
		<input type="checkbox" name="Price" value="PR4" onchange="selectSearch()">5만원~10만원
		<input type="checkbox" name="Price" value="PR5" onchange="selectSearch()">10만원이상
		<hr>
	</div><br>
	
	<select size="1" onchange="listOrder(this.value)">
			<option value="redate"> 최신순
			<option value="lprice"> 낮은 가격순
			<option value="hprice"> 높은 가격순
			<option value="rating"> 높은 별점순
	</select><br>
	
	
	<div class="productWrapper">
		
	</div>

	<div class="paging">
	
	</div>
	
</body>
</html>