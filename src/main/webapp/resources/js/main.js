
const container = document.querySelector('.container')
const btn1 = document.querySelector('.btn1');
const btn2 = document.querySelector('.btn2');
const btn3 = document.querySelector('.btn3');

btn1.addEventListener('click', function(){
	container.style.transform = 'translate(0vw)'
})
btn2.addEventListener('click', function(){
	container.style.transform = 'translate(-80vw)'
})
btn3.addEventListener('click', function(){
	container.style.transform = 'translate(-160vw)'
})