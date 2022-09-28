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
let pgnum = 1;

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
	let pageViewProduct = 12;
	$.ajax({
		url: "http://localhost:8085/seeot/searchList?keyword=" + keyword,
		type: "POST",
		data: {
			productCategorie : productCategorie,
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
			};
			
			if(num == 1) {
				paging += "<button onclick='javascript:startPagNum(1)' disabled> 처음으로 </button>";
				paging += "&nbsp; <button onclick='javascript:prePagNum()' disabled> 이전 </button> &nbsp;";
			}else if(num > 5){
				paging += "<button onclick='javascript:startPagNum(1)'> 처음으로 </button>";
				paging += "&nbsp; <button onclick='javascript:prePagNum()'> 이전 </button> &nbsp;";
			}else{
				paging += "<button onclick='javascript:startPagNum(1)'> 처음으로 </button>";
				paging += "&nbsp; <button onclick='javascript:prePagNum()' disabled> 이전 </button> &nbsp;";
			};
			
			if( (pgnum+5) <= repeat ) {
				for(i=pgnum; i<=(pgnum+4); i++) {
					paging += "&nbsp; <a href='javascript:void(0);' onclick='javascript:pagingNum(" + [i] + ")'>" + [i] + "</a> &nbsp;"
				}
			}else {
				for(i=pgnum; i<=repeat; i++) {
					paging += "&nbsp; <a href='javascript:void(0);' onclick='javascript:pagingNum(" + [i] + ")'>" + [i] + "</a> &nbsp;"
				};
			}
			
			if(num == repeat){
				paging += "&nbsp; <button onclick='javascript:nextPagNum()' disabled> 다음 </button> &nbsp;";
				paging += "<button onclick='javascript:endPagNum(" + repeat + ")' disabled> 끝으로 </button>";
			}else if( (pgnum + 5) >repeat ) {
				paging += "&nbsp; <button onclick='javascript:nextPagNum()'  disabled> 다음 </button> &nbsp;";
				paging += "<button onclick='javascript:endPagNum(" + repeat + ")'> 끝으로 </button>";
			}else {
				paging += "&nbsp; <button onclick='javascript:nextPagNum()'> 다음 </button> &nbsp;";
				paging += "<button onclick='javascript:endPagNum(" + repeat + ")'> 끝으로 </button>";
			};
			
			$(".paging").html(paging);
					
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
}
	
	
let chkColor_arr = [];
let chkPrice_arr = [];

function selectSearch() {
	chkColor_arr = [];
	$("input[name=Color]:checked").each(function(){
		let chkColor = $(this).val();
		chkColor_arr.push(chkColor);
	})
	
	chkPrice_arr = [];
	$("input[name=Price]:checked").each(function(){
		let chkPrice = $(this).val();
		chkPrice_arr.push(chkPrice);
	})
	num = 1;
	pgnum = 1;
	
	productList();
}

function filter() {
	$('#filter').slideToggle("slow")
}