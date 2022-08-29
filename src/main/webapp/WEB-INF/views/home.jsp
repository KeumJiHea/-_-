<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<body onload='move()'>
<div class="outer">
	<img class="left-btn" src="resources/images/left.png">
	<img class="right-btn" src="resources/images/right.png">
	
	<div class="container">
		<div class="inner">
			<img src="resources/images/slide01.jpg">
		</div>
		<div class="inner">
			<img src="resources/images/slide02.jpg">
		</div>
		<div class="inner">
			<img src="resources/images/slide03.jpg">
		</div>
	</div>
</div>

<div class="buttons">
	<input class="btn1" type="radio" name="banner-btn" checked>
	<input class="btn2" type="radio" name="banner-btn">
	<input class="btn3" type="radio" name="banner-btn">
</div>

<div class="item">
	<div class="section-name best">요즘 잘 나가요</div>
	<div class="items">
		<img src="resources/images/20220823_1_10001.jpg">
		<img src="resources/images/20220823_1_10002.jpg">
		<img src="resources/images/20220823_1_10003.jpg">
	</div>
	<button class="item-link-btn">더보기</button>
</div>
<hr>
<div class="banners">
	<img class="banner" src="resources/images/slide01.jpg">
</div>

<div class="item">
	<div class="section-name new">새로 나왔어요</div>
	<div class="items">
		<img src="resources/images/20220823_2_20001.jpg">
		<img src="resources/images/20220823_2_20002.jpg">
		<img src="resources/images/20220823_2_20003.jpg">
	</div>
	<button class="item-link-btn">더보기</button>
</div>
<hr>
<div class="banners">
	<img class="banner" src="resources/images/slide01.jpg">
</div>

<div class="item">
	<div class="section-name season">겨울 추천템</div>
	<div class="items">
		<img src="resources/images/20220823_3_30001.jpg">
		<img src="resources/images/20220823_3_30002.jpg">
		<img src="resources/images/20220823_3_30003.jpg">
	</div>
	<button class="item-link-btn">더보기</button>
</div>
</body>
<script src="resources/js/main.js"></script>