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
</div>
<hr class="line">
<div class="banners">
	<img class="banner" src="<%=request.getContextPath() %>/resources/images/slide03.jpg">
</div>

<div class="item">
	<div class="section-name">새로 나왔어요</div>
	<div class="items new-items">
	</div>
</div>
<hr class="line">
<div class="banners">
	<img class="banner" src="<%=request.getContextPath() %>/resources/images/slide02.jpg">
</div>
</body>
<script src="<%=request.getContextPath() %>/resources/js/main.js"></script>