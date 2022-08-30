/**
 * 메뉴바 언더라인
 */
let underline = document.querySelector('.underline');
let category = document.querySelectorAll('.category > li > a > span');
console.log(category);

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
 *  TOP버튼 스크립트
 */
const topBtn = document.querySelector('.topBtn')

topBtn.addEventListener('click', function(){
	console.log('클릭')
	window.scrollTo({top: 0, behavior:'smooth'});
})