/**
 * 
 */

/* 카테고리 넘버 가져오기 */
const url = window.location.search;
const params = new URLSearchParams(url);
let keyword = params.get('keyword');
let productCategorie = 0;

if(keyword == '맨투맨'||keyword == '티셔츠'){
	productCategorie = 1;
}else if(keyword == '원피스'){
	productCategorie = 2;
}else if(keyword == '팬츠'||keyword == '바지'){
	productCategorie = 3;
}

let num = 1;
let orderBy = 'redate';

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
	if(productCategorie == 0){
		let pageViewProduct = 12;
		$.ajax({
			url: "http://localhost:8085/seeot/searchList?keyword=" + keyword,
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
				let paging = "";
				var productCount = list;
				var repeat = parseInt(productCount / pageViewProduct);
				if( productCount / pageViewProduct != 0) {
					repeat += 1;
				}
				
				for(i=1; i<=repeat; i++) {
					paging += "<a href='javascript:void(0);' onclick='javascript:pagingNum(" + [i] + ")'>" + [i] + "</a> &nbsp;"
					$(".paging").html(paging);
				}
						
				let html = "";
				if(list.length != 0) {
					for(i=0; i<list.length; i++) {
						html += "<div class='searchList'>";
						html += "<a href='http://localhost:8085/seeot/product/productView?productNo=" + list[i].productNo + "'>";
						html += "<span><img width='240px' height='300px' src='http://localhost:8085/seeot/resources/images/" + list[i].productFile  + "'></span><br>";
						html += "<span><b>" + list[i].productName + "</b></span><br>";
						html += "<span><b>" + list[i].productPrice + "</b></span></a>";
						html += "</div>";
						$(".searchWrapper").html(html);
					}
				}else{
						html = "<div><b>일치하는 상품이 없습니다.<b></div>";
						$(".searchWrapper").html(html);
						paging = ""
						$(".paging").html(paging);
					}
				$("#listCount").html('('+list.length+')');
			}
		})
	}else{
		$.ajax({
			url: "http://localhost:8085/seeot/product/allCount?productCategorie=" + productCategorie,
			type: "post",
			data: {
				chkColor_arr : chkColor_arr,
				chkPrice_arr : chkPrice_arr
			},
			datatype:"json",
			success: function(list) {
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
					url: "http://localhost:8085/seeot/product/prolist?productCategorie=" + productCategorie,
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
						let html = "";
						if(list.length != 0) {
						for(i=0; i<list.length; i++) {
							html += "<div class='product'>";
							html += "<a href='http://localhost:8085/seeot/product/productView?productNo=" + list[i].productNo + "'>";
							html += "<span><img width='240px' height='300px' src='http://localhost:8085/seeot/resources/images/" + list[i].productFile  + "'></span><br>";
							html += "<span><b>" + list[i].productName + "</b></span><br>";
							html += "<span><b>" + list[i].productPrice + "</b></span></a>";
							html += "</div>";
							$(".searchWrapper").html(html);
						}
						}else{
							html = "<div><b>일치하는 상품이 없습니다.<b></div>";
							$(".searchWrapper").html(html);
							paging = ""
							$(".paging").html(paging);
						}
						$("#listCount").html('('+list.length+')');
					}
					
				})
			}
		})
	}
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