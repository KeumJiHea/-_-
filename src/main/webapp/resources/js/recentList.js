/**
 * 최근 본 상품
 */
$(function(){
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
	
	if(recentList.length==maxList){
		recentList.shift();
	}
	recentList.push(productNo);
	recentList = new Set(recentList);
	recentList = [...recentList];
	sessionStorage.setItem('recentItem', JSON.stringify(recentList));
})
