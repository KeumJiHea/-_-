<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<body onload='move()'>
<div class="outer">
	<img class="left-btn" src="${contextPath }/resources/images/left.png">
	<img class="right-btn" src="${contextPath }/resources/images/right.png">
	
	<div class="container">
		<div class="inner">
			<img src="${contextPath }/resources/images/slide01.jpg">
		</div>
		<div class="inner">
			<img src="${contextPath }/resources/images/slide02.jpg">
		</div>
		<div class="inner">
			<img src="${contextPath }/resources/images/slide03.jpg">
		</div>
	</div>
	<ul class="slide_pagination"></ul>
</div>


<div class="item">
	<div class="section-name best">요즘 잘 나가요</div>
	<div class="items">
		<img src="${contextPath }/resources/images/20220823_1_10001.jpg">
		<img src="${contextPath }/resources/images/20220823_1_10002.jpg">
		<img src="${contextPath }/resources/images/20220823_1_10003.jpg">
	</div>
	<button class="item-link-btn" onclick='location.href="product/list?productCategorie=1"'>더보기</button>
</div>
<hr>
<div class="banners">
	<img class="banner" src="${contextPath }/resources/images/slide03.jpg">
</div>

<div class="item">
	<div class="section-name new">새로 나왔어요</div>
	<div class="items">
		<img src="${contextPath }/resources/images/20220823_2_20001.jpg">
		<img src="${contextPath }/resources/images/20220823_2_20002.jpg">
		<img src="${contextPath }/resources/images/20220823_2_20003.jpg">
	</div>
	<button class="item-link-btn" onclick='location.href="product/list?productCategorie=2"'>더보기</button>
</div>
<hr>
<div class="banners">
	<img class="banner" src="${contextPath }/resources/images/slide02.jpg">
</div>

<div class="item">
	<div class="section-name season">겨울 추천템</div>
	<div class="items">
		<img src="${contextPath }/resources/images/20220823_3_30001.jpg">
		<img src="${contextPath }/resources/images/20220823_3_30002.jpg">
		<img src="${contextPath }/resources/images/20220823_3_30003.jpg">
	</div>
	<button class="item-link-btn" onclick='location.href="product/list?productCategorie=3"'>더보기</button>
</div>
</body>
<script src="${contextPath }/resources/js/main.js"></script>
<script src="${contextPath }/resources/js/header.js"></script>