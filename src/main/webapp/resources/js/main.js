
//배너 관련 변수
const container = document.querySelector('.container');
const banners = document.querySelectorAll('.inner');

const leftBtn = document.querySelector('.left-btn');
const rightBtn = document.querySelector('.right-btn');

const bannerLen = banners.length;
let index = 0;

container.style.width = `${bannerLen * 80}vw`;

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

//마우스 올렸을 때 배너 멈추는 함수
const outer = document.querySelector('.outer');
outer.addEventListener('mouseover', stopMove);
outer.addEventListener('mouseout', move);


$(function(){
	$.ajax({ //전체 상품리스트 불러오는 ajax
		url: "getProduct",
		type: "get",
		dataType: "json",
		success: function(data){
			
			//리스트 별점순 정렬함
			const productRatingDesc = data.sort((a,b) => b.productRating - a.productRating);
			console.log("productRatingDesc: ", productRatingDesc);
			
			for(i=0;i<3;i++){ //그중 앞의 3개만 가져와서 이미지 추가
				let product = '';
				product += '<div class="item">';
				product += '<a href="product/productView?productNo=';
				product += productRatingDesc[i].productNo + '">';
				product += '<img src="http://localhost:8085/seeot/resources/images/' + productRatingDesc[i].productFile + '">';
				product += '<div class="itemInfo">';
				product += '<p>' + productRatingDesc[i].productName + '</p>';
				product += '<p>' + productRatingDesc[i].productPrice + '원</p>';
				product += '</div>';
				product += '</a>';
				product += '</div>';
				$('.best-items').append($(product));
			}
			
			//리스트 최신순 정렬함
			const productDateAsc = data.sort((a,b)=>new Date(b.productDate) - new Date(a.productDate));
			console.log("productDateAsc: ", productDateAsc);
			
			for(i=0;i<3;i++){ //그중 앞의 3개만 가져와서 이미지 추가
				let product = '';
				product += '<div class="item">';
				product += '<a href="product/productView?productNo=';
				product += productDateAsc[i].productNo + '">';
				product += '<img src="http://localhost:8085/seeot/resources/images/' + productDateAsc[i].productFile + '">';
				product += '<div class="itemInfo">';
				product += '<p>' + productDateAsc[i].productName + '</p>';
				product += '<p>' + productDateAsc[i].productPrice + '원</p>';
				product += '</div>';
				product += '</a>';
				product += '</div>';
				$('.new-items').append($(product));
			}
		}
	})
});

