const container = document.querySelector('.container');
const banners = document.querySelectorAll('.inner');

const leftBtn = document.querySelector('.left-btn');
const rightBtn = document.querySelector('.right-btn');

const bannerLen = banners.length;
let index = 0;

//ul 페이지네이션
const pagination = document.querySelector('.slide_pagination');

for(let i=0 ; i<bannerLen ; i++){
	if(i===0) pagination.innerHTML += `<li class="active">•</li>`;
	else pagination.innerHTML += `<li>•</li>`;
}

const paginationItems = document.querySelectorAll('.slide_pagination > li');
console.log(paginationItems);

for(let i=0 ; i<bannerLen ; i++){
	paginationItems[i].addEventListener('click', () =>{
		index = i;
		container.style.transform = `translate(${index * -80}vw)`;
		paginationItems.forEach((i) => i.classList.remove('active'));
		paginationItems[index].classList.add('active');
	});
}


//좌우버튼 눌렀을 때 이동하는 함수//
rightBtn.addEventListener('click', function(){
	if(index < bannerLen-1){
		container.style.transform = `translate(${(index+1)*-80}vw)`;
	}else{
		container.style.transform = `translate(0vw)`;
		index = -1;
	}
	curBanner = banners[++index];
	
	paginationItems.forEach((i) => i.classList.remove('active'));
	paginationItems[index].classList.add('active');
})
leftBtn.addEventListener('click', function(){
	if(index >= 0){
		container.style.transform = `translate(${(index-1)*-80}vw)`;
	}
	if(index===0){
		index = bannerLen;
		container.style.transform = `translate(${(index-1) * -80}vw)`;
	}
	curBanner = banners[--index];
	
	paginationItems.forEach((i) => i.classList.remove('active'));
	paginationItems[index].classList.add('active');
})

// 배너 자동 스크롤링
function move(){
	time = setInterval(function(){
		if(index === bannerLen-1){
			index = -1;
		}
		container.style.transition = '0.5s';
		container.style.transform = `translate(-${80*(index+1)}vw)`;
		index++;
		paginationItems.forEach((i) => i.classList.remove('active'));
		paginationItems[index].classList.add('active');
	},3000);
}
function stopMove(){
	clearInterval(time);
}

const outer = document.querySelector('.outer');
outer.addEventListener('mouseover', stopMove);
outer.addEventListener('mouseout', move);