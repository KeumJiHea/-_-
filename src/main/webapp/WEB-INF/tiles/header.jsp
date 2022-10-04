<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<div class="navbar">
	<div class="login-menu">
		<ul>
			<li>
				<c:if test="${loginUser == null }">
					<a href="${contextPath }/member/register_form">회원가입 |</a>
				</c:if>
				<c:if test="${loginUser != null }">
					<span>${userName }님 환영합니다.</span>
				</c:if>
			</li>
			<li>
				<c:if test="${loginUser == null }">
					<a href="${contextPath }/member/login">LOGIN</a> 
				</c:if>
				<c:if test="${loginUser != null }">
					<a href="${contextPath }/member/logout">LOGOUT</a>
				</c:if>
			</li>
			<c:if test="${loginUser == 'admin' }">
				<li>
					<a href="${contextPath }/admin/admin">| 관리자 페이지 </a>
				</li>
			</c:if>
			<li>
				<a href="${contextPath }/board/boardList">| 고객문의</a>
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
					<span>티셔츠</span>
				</a>
			</li>
			<li>
				<a href="${contextPath }/product/list?productCategorie=2">
					<span>셔츠</span>
				</a>
			</li>
			<li>
				<a href="${contextPath }/product/list?productCategorie=3">
					<span>가디건</span>
				</a>
			</li>
			<li>
				<a href="${contextPath }/product/list?productCategorie=4">
					<span>자켓</span>
				</a>
			</li>
			<li>
				<a href="${contextPath }/product/list?productCategorie=5">
					<span>코트</span>
				</a>
			</li>
			<li>
				<a href="${contextPath }/product/list?productCategorie=6">
					<span>하의</span>
				</a>
			</li>
			<li>
				<a href="${contextPath }/product/list?productCategorie=7">
					<span>신발</span>
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
				<a href="${contextPath }/member/info?id=${loginUser}">
				${LOGIN }
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
		<form id="searchForm" action="${contextPath }/default/search" method="GET">
			<div class="field">
				<input type="search" name="keyword" placeholder="검색어를 입력하세요">
				<input type="submit" value="검색">
			</div>
		</form>
	</div>
</div>
<script src="<%=request.getContextPath() %>/resources/js/common/header.js"></script>
