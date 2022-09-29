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
				<a href="${contextPath }/home">| 매장 페이지 |</a>
			</li>
			<li>
				<a href="${contextPath }/admin/admin">관리자 페이지</a>
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
				<a href="${pageContext.request.contextPath}/member/memberlist">
					<span>회원 관리</span>
				</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/product/productList">
					<span>상품 관리</span>
				</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/order/orderadmin">
					<span>주문 관리</span>
				</a>
			</li>		
		</ul>
	</div>

</div>
<script src="<%=request.getContextPath() %>/resources/js/common/header.js"></script>
