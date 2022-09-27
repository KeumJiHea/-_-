<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<body onload='move()'>
<div class="outer">
	<img class="left-btn" src="<%=request.getContextPath() %>/resources/images/left.png">
	<img class="right-btn" src="<%=request.getContextPath() %>/resources/images/right.png">
	
	<div class="container">
		<div class="inner">
			<img src="<%=request.getContextPath() %>/resources/images/banner/banner01.png">
		</div>
		<div class="inner">
			<img src="<%=request.getContextPath() %>/resources/images/banner/banner02.png">
		</div>
		<div class="inner">
			<img src="<%=request.getContextPath() %>/resources/images/banner/banner03.png">
		</div>
		<div class="inner">
			<img src="<%=request.getContextPath() %>/resources/images/banner/banner04.png">
		</div>
	</div>
	<ul class="slide_pagination"></ul>
</div>


<div class="item">
	<div class="section-name">요즘 잘 나가요</div>
	<div class="items best-items">
	</div>
</div>
<hr class="line">
<div class="banners">
	<img class="banner" src="<%=request.getContextPath() %>/resources/images/banner/banner03.png">
</div>

<div class="item">
	<div class="section-name">새로 나왔어요</div>
	<div class="items new-items">
	</div>
</div>
<hr class="line">
<div class="banners">
	<img class="banner" src="<%=request.getContextPath() %>/resources/images/banner/banner02.png">
</div>
</body>
<script src="<%=request.getContextPath() %>/resources/js/main.js"></script>