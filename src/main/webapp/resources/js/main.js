const container = document.querySelector('.container')
const btn1 = document.querySelector('.btn1');
const btn2 = document.querySelector('.btn2');
const btn3 = document.querySelector('.btn3');
const leftBtn = document.querySelector('.left-btn');
const rightBtn = document.querySelector('.right-btn');
let index = 0;

btn1.addEventListener('click', function(){
	container.style.transform = `translate(index * -80vw)`;
	index++;
})
btn2.addEventListener('click', function(){
	container.style.transform = 'translate(-80vw)'
})
btn3.addEventListener('click', function(){
	container.style.transform = 'translate(-160vw)'
})

leftBtn.addEventListener('click', function(){
	container.style.transform = 'translate'
})