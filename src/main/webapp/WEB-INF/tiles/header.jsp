<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<div class="navbar">
	<div class="login-menu">
		<ul>
			<li>
				<c:if test="${loginUser == null }">
					<a href="${contextPath }/member/login">LOGIN</a> 
				</c:if>
				<c:if test="${loginUser != null }">
					<a href="${contextPath }/member/logout">LOGOUT</a>
				</c:if>
			</li>
			<li>
				<a href="${contextPath }/member/register_form">회원가입</a>
			</li>
			<li>
				<a href="#">고객문의</a>
			</li>
		</ul>
	</div>
	<div class="left_area">
		<a href="${contextPath }/home">
		<img class="logo" src="${contextPath }/resources/images/SEEoT_h.png" width="90px" height="50px">
		</a>
		<div class="underline"></div>
		<ul class="category">
			<li>
				<a href="${contextPath }/product/list">
					<span>전체</span>
				</a>
			</li>
			<li>
				<a href="${contextPath }/product/list?productCategorie=1">
					<span>맨투맨/티셔츠</span>
				</a>
			</li>
			<li>
				<a href="${contextPath }/product/list?productCategorie=2">
					<span>원피스</span>
				</a>
			</li>
			<li>
				<a href="${contextPath }/product/list?productCategorie=3">
					<span>팬츠</span>
				</a>
			</li>
			<li>
				<a href="${contextPath }/product/list?productCategorie=2">
					<span>셔츠</span>
				</a>
			</li>
			<li>
				<a href="${contextPath }/product/list?productCategorie=1">
					<span>니트</span>
				</a>
			</li>
		</ul>
	</div>

	<div class="right_area">
		<ul>
			<li class="open-search">
				<i class="fa-solid fa-magnifying-glass" title="검색"></i>
			</li>
			<li>
				<a href="${contextPath }/cart/mycart">
					<i class="fa-solid fa-cart-shopping" title="장바구니"></i>
				</a>
			</li>
			<li>
				<a href="#">
					<i class="fa-solid fa-user" title="마이페이지"></i>
				</a>
			</li>
		</ul>
	</div>
</div>
<div class="modal-bg"></div>
<div class="modal-search">
	<i class="fa-solid fa-xmark close-search"></i>
	<div class="search">
		<div class="field">
			<input type="search" placeholder="검색어를 입력하세요">
			<input type="button" value="검색">
		</div>
	</div>
</div>

