<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="<c:url value='/resources/css/search.css'/>" >

<body>
	<div class="searchBar">
		<c:if test="${keyword != '' }">
			<p><b>${keyword }</b>에 대한 검색 결과입니다.</p>
		</c:if>
		<c:if test="${keyword == '' }">
			<p>검색어를 다시 입력해주세요.</p>
		</c:if>
	</div>
	<div><button onclick="filter()">Filter</button></div>
	<div id="filter">
	<hr>
		Color | 
		<input type="checkbox" name="Color" value="RED" onchange="selectSearch()"> RED
		<input type="checkbox" name="Color" value="GREEN" onchange="selectSearch()"> GREEN
		<input type="checkbox" name="Color" value="BLUE" onchange="selectSearch()"> BLUE
		<input type="checkbox" name="Color" value="IVORY" onchange="selectSearch()"> IVORY
		<input type="checkbox" name="Color" value="BLACK" onchange="selectSearch()"> BLACK
		<input type="checkbox" name="Color" value="WHITE" onchange="selectSearch()"> WHITE
		<hr>
		Price | 
		<input type="checkbox" name="Price" value="PR1" onchange="selectSearch()">1만원이하
		<input type="checkbox" name="Price" value="PR2" onchange="selectSearch()">1~3만원
		<input type="checkbox" name="Price" value="PR3" onchange="selectSearch()">3만원~5만원
		<input type="checkbox" name="Price" value="PR4" onchange="selectSearch()">5만원~10만원
		<input type="checkbox" name="Price" value="PR5" onchange="selectSearch()">10만원이상
		<hr>
	</div><br>
	<div id="order" align="right">
	<select size="1" onchange="listOrder(this.value)">
			<option value="redate"> 최신순
			<option value="lprice"> 낮은 가격순
			<option value="hprice"> 높은 가격순
			<option value="rating"> 높은 별점순
	</select>
	</div>
	<br>
	
	<div class="searchWrapper"></div>

	<div class="paging" align="center"></div>
</body>
<script src="<%=request.getContextPath() %>/resources/js/common/search.js"></script>
