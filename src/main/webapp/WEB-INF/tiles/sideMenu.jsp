<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="side-menu">
	<div class="recentBtn">
		<i class="fa-solid fa-clock-rotate-left"></i>
		<h3>최근 본 상품</h3>
		<div class="recentList">
			<ul></ul>
		</div>
	</div>
	<div class="cartBtn" onclick="location.href='<%=request.getContextPath() %>/cart/mycart'">
		<i class="fa-solid fa-cart-shopping"></i>
		<h3>장바구니</h3>
	</div>
	<div class="topBtn">
		<i class="fa-solid fa-arrow-up"></i>
		<h3>TOP</h3>
	</div>
</div>
<script src="<%=request.getContextPath() %>/resources/js/header.js"></script>