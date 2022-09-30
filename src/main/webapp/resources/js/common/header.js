/**
 * 메뉴바 언더라인
 */
let underline = document.querySelector('.underline');
let category = document.querySelectorAll('.category > li > a > span');

category.forEach((menu) => 
	menu.addEventListener('mouseover', (e) => indicator(e))
);

function indicator(e){
	underline.style.left = e.currentTarget.offsetLeft + 'px';
	underline.style.width = e.currentTarget.offsetWidth + 'px';
	underline.style.top = 
		e.currentTarget.offsetTop + e.currentTarget.offsetHeight + 'px';
}

/**
 * 서치 모달창 스크립트
 */
const modalBg = document.querySelector('.modal-bg');
const openSearch = document.querySelector('.open-search');
const modalSearch = document.querySelector('.modal-search');
const closeSearch = document.querySelector('.close-search');
const main = document.querySelector('#main');

openSearch.addEventListener('click', function(){
	modalSearch.classList.add('active');
	modalBg.style.display = 'block';
});
closeSearch.addEventListener('click', function(){
	modalSearch.classList.remove('active');
	modalBg.style.display = 'none';
});
modalBg.addEventListener('click', function(){
	modalSearch.classList.remove('active');
	modalBg.style.display = 'none';

});

/**
	최근 본 목록 스크립트
 */
recentList = sessionStorage.getItem('recentItem');
let recent = JSON.parse(recentList).reverse(); //최근 순 정렬
let html = '';


	if(recent != null){
	recent.forEach((item)=>{
		$.ajax({
		url: "http://localhost:8085/seeot/getRecent?productNo="+item,
		type: "GET",
		dataType: "json",
		success: function(data){
			console.log(data);
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





});

