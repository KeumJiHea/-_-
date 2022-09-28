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