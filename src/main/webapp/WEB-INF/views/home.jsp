<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<body onload='move()'>
<div class="outer">
	<img class="left-btn" src="<%=request.getContextPath() %>/resources/images/left.png">
	<img class="right-btn" src="<%=request.getContextPath() %>/resources/images/right.png">
	
	<div class="container">
		<div class="inner">
			<img src="<%=request.getContextPath() %>/resources/images/slide01.jpg">
		</div>
		<div class="inner">
			<img src="<%=request.getContextPath() %>/resources/images/slide02.jpg">
		</div>
		<div class="inner">
			<img src="<%=request.getContextPath() %>/resources/images/slide03.jpg">
		</div>
	</div>
	<ul class="slide_pagination"></ul>
</div>


<div class="item">
	<div class="section-name">요즘 잘 나가요</div>
	<div class="items best-items">
	</div>
	<button class="item-link-btn" onclick='location.href="product/list?productCategorie=1"'>더보기</button>
</div>
<hr class="line">
<div class="banners">
	<img class="banner" src="<%=request.getContextPath() %>/resources/images/slide03.jpg">
</div>

<div class="item">
	<div class="section-name">새로 나왔어요</div>
	<div class="items new-items">
	</div>
	<button class="item-link-btn" onclick='location.href="product/list?productCategorie=2"'>더보기</button>
</div>
<hr class="line">
<div class="banners">
	<img class="banner" src="<%=request.getContextPath() %>/resources/images/slide02.jpg">
</div>

<div class="item">
	<div class="section-name">겨울 추천템</div>
	<div class="items season-items">
		<img src="<%=request.getContextPath() %>/resources/images/20220823_3_30001.jpg">
		<img src="<%=request.getContextPath() %>/resources/images/20220823_3_30002.jpg">
		<img src="<%=request.getContextPath() %>/resources/images/20220823_3_30003.jpg">
	</div>
	<button class="item-link-btn" onclick='location.href="product/list?productCategorie=3"'>더보기</button>
</div>
</body>
<script src="<%=request.getContextPath() %>/resources/js/main.js"></script>
<script type="text/javascript">
$(function(){
	$.ajax({ //전체 상품리스트 불러오는 ajax
		url: "getProduct",
		type: "get",
		dataType: "json",
		success: function(data){
			
			//리스트 최신순 정렬함
			const productDateAsc = data.sort((a,b)=>new Date(b.productDate) - new Date(a.productDate));
			console.log("productDateAsc: ", productDateAsc);
			
			for(i=0;i<3;i++){ //그중 앞의 3개만 가져와서 이미지 추가
				let product = '';
				product += '<a href="<%=request.getContextPath() %>/product/productView?productNo=';
				product += productDateAsc[i].productNo + '">';
				product += '<img src="<%=request.getContextPath() %>/resources/images/' + productDateAsc[i].productFile + '">';
				product += '</a>';
				$('.new-items').append($(product));
			}
			
			//리스트 별점순 정렬함
			const productRatingDesc = data.sort((a,b) => b.productRating - a.productRating);
			console.log("productRatingDesc: ", productRatingDesc);
			
			for(i=0;i<3;i++){ //그중 앞의 3개만 가져와서 이미지 추가
				let product = '';
				product += '<a href="<%=request.getContextPath() %>/product/productView?productNo=';
				product += productRatingDesc[i].productNo + '">';
				product += '<img src="<%=request.getContextPath() %>/resources/images/' + productRatingDesc[i].productFile + '">';
				product += '</a>';
				$('.best-items').append($(product));
			}
		}
	})
});
</script>