//최근 본 상품 저장
function saveRecentList(){
	const url = window.location.search;
	const params = new URLSearchParams(url);
	let productNo = params.get('productNo');
	let recentList = sessionStorage.getItem('recentItem');
	let maxList = 3;
	
	if(recentList == null){
		recentList = [];
	}else{
		recentList = JSON.parse(recentList);
	}

	recentList.push(productNo);
	recentList = new Set(recentList);
	recentList = [...recentList];
	if(recentList.length>maxList){
		recentList.shift();
	}
	sessionStorage.setItem('recentItem', JSON.stringify(recentList));
	getRecentList();
}

//최근 본 상품 출력
window.addEventListener('DOMContentLoaded', getRecentList());

function getRecentList(){
	recentList = sessionStorage.getItem('recentItem');
	if(recentList != null){
		let recent = JSON.parse(recentList).reverse(); //최근 순 정렬
		let html = '';

		recent.forEach((item)=>{
			$.ajax({
			url: "http://localhost:8085/seeot/getRecent?productNo="+item,
			type: "GET",
			dataType: "json",
			success: function(data){
				//console.log(data);
				html += '<li><div class="thumb">';
				html += '<a href="http://localhost:8085/seeot/product/productView?productNo='+data.productNo+'">';
				html += '<img src="http://localhost:8085/seeot/resources/images/'+data.productFile+'" alt="'+data.productName+'"></a>';
				html += '</div><div class="desc">';
				html += '<a href="http://localhost:8085/seeot/product/productView?productNo='+data.productNo+'">';
				html += '<span>'+data.productName+'</span></a>';
				html += '</div></li>';
				$('.recentList>ul').html(html);
				}
			})
		})	
	}
}

//TOP버튼
const topBtn = document.querySelector('.topBtn');

topBtn.addEventListener('click', function(){
	console.log('클릭');
	window.scrollTo({top: 0, behavior:'smooth'});
});


