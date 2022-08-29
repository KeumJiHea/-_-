const container = document.querySelector('.container');
const banners = document.querySelectorAll('.inner');

const btn1 = document.querySelector('.btn1');
const btn2 = document.querySelector('.btn2');
const btn3 = document.querySelector('.btn3');

const leftBtn = document.querySelector('.left-btn');
const rightBtn = document.querySelector('.right-btn');

const bannerLen = banners.length;
let index = 0;

//라디오 버튼 눌렀을 때 이동하는 함수//
btn1.addEventListener('click', function(){
	index=0;
	container.style.transform = `translate(0vw)`;
})
btn2.addEventListener('click', function(){
	index=1;
	container.style.transform = `translate(${index * -80}vw)`;
})
btn3.addEventListener('click', function(){
	index=2;
	container.style.transform = `translate(${index * -80}vw)`;
})

//좌우버튼 눌렀을 때 이동하는 함수//
rightBtn.addEventListener('click', function(){
	if(index < bannerLen-1){
		container.style.transform = `translate(${(index+1)*-80}vw)`;
	}else{
		container.style.transform = `translate(0vw)`;
		index = -1;
	}
	curBanner = banners[++index];
	console.log(index);
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
	console.log(index);
})

function move(){
	time = setInterval(function(){
		if(index === bannerLen-1){
			index = -1;
		}
		container.style.transition = '0.5s';
		container.style.transform = `translate(-${80*(index+1)}vw)`;
		index++;
		console.log(index);
	},3000);
}
function stopMove(){
	clearInterval(time);
}

const outer = document.querySelector('.outer');
outer.addEventListener('mouseover', stopMove);
outer.addEventListener('mouseout', move);