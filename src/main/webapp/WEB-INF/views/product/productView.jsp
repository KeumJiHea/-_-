<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style type="text/css">
	.pst {
		width:25px;
		height:15px;
	}
	#proicon {
		width:25px;
		height:25px;
		margin: -7px 5px;
	}
</style>
</head>
<body onload="saveRecentList()">
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	
<!-- 	<script type="text/javascript">
	 
	jQuery( document ).ready( function ( $ ) {
		var isVisible = false;
		$(window).on('scroll',function() {
		    if (checkVisible($('#changeGuide'))&&!isVisible) {
		    	$('.pronav').attr("style","position: fixed;");
		        isVisible=true;
		    }else{
		    	
		    }
		});
		
		function checkVisible( elm, eval ) {
		    eval = eval || "object visible";
		    var viewportHeight = $(window).height(), // Viewport Height
		        scrolltop = $(window).scrollTop(), // Scroll Top
		        y = $(elm).offset().top,
		        elementHeight = $(elm).height();   
		    
		    if (eval == "object visible") return ((y < (viewportHeight + scrolltop)) && (y > (scrolltop - elementHeight)));
		    if (eval == "above") return ((y < (viewportHeight + scrolltop)));
		}
	 });
	</script> -->
	<script type="text/javascript">
	
	
	var pc='', ps='';
	var cnt = 0;
	var selColCount = 0, selSizCount = 0;	
	
	function colorAdd(productColor) {
		console.log("선택 색 : " + productColor)
		
		if(pc == null || pc == '') {
			pc = productColor;
			const PCelement = document.getElementById(pc);
			PCelement.style.backgroundColor = 'white';
			PCelement.style.color = 'black';
		}else {
			PCelement = document.getElementById(pc);
			PCelement.style.backgroundColor = 'black';
			PCelement.style.color = 'white';
			pc = productColor;
			PCelement = document.getElementById(pc);
			PCelement.style.backgroundColor = 'white';
			PCelement.style.color = 'black';
		}
		
		if(ps != '') {
			PSelement = document.getElementById(ps);
			PSelement.style.backgroundColor = 'black';
			PSelement.style.color = 'white';
			ps = '';
		}
	}
	
	
	
	function sizeAdd(proSize) {
		console.log("선택 사이즈 : " + proSize)
		if(ps == null || ps == ''){
			ps = proSize;
			const PSelement = document.getElementById(ps);
			PSelement.style.backgroundColor = 'white';
			PSelement.style.color = 'black';
		}else {
			PSelement = document.getElementById(ps);
			PSelement.style.backgroundColor = 'black';
			PSelement.style.color = 'white';
			ps = proSize;
			PSelement = document.getElementById(ps);
			PSelement.style.backgroundColor = 'white';
			PSelement.style.color = 'black';
		}
		
		if(pc != '' & ps != '') {
			productSelect();
		}
	}
	
 	function productSelect() {
		console.log('상품 선택 :  productNo : ${pdto.productNo}, pc : ' + pc + ', ps : ' + ps)
		
			$.ajax({
				url: "proStackGet",
				type:"get",
				data:{
					productNo : '${pdto.productNo}',
					productColor : pc,
					productSize : ps
				},
				datatype:"json",
				success: function(data) {
					
					console.log(data)
					
					if(data != '' ) {
						console.log("상품 선택값 추가" + data.productColor + ", " + data.productSize)
						
						if(document.getElementById(data.productColor + data.productSize) == null) {
							cnt++;
							$("#proOrderAdd").append("<div id='" + data.productColor + data.productSize + "' class='" +  data.productColor + data.productSize + "'>"+ data.productColor + " / " + data.productSize
									+ "<input type='hidden' name='productColor' value='" + data.productColor + "' id='productColor'> &nbsp;"
									+ "<input type='hidden' name='productSize' value='" + data.productSize + "' id='productSize'>"
								 	+ "<img src='<c:url value='/resources/images/proup.png'/>'  onClick='stackUp(this)' class='productStack" + cnt + "' id='proicon'>"
									+ "<input type='hidden' id='MaxproductStack" + cnt + "' value='" + data.productStack + "'>"
									+ "<input type='text' name='productStack' id='productStack" + cnt + "' value='1' class='pst' readonly>"
									+ "<img src='<c:url value='/resources/images/prodown.png'/>'  onClick='stackDown(this)' class ='productStack" + cnt + "' id='proicon'>"
									+ "금액 <span id='PriceproductStack" + cnt + "'>" + '${pdto.productPrice}' + "</span> 원"
									+ "&nbsp; <img src='<c:url value='/resources/images/prodelete.png'/>'  onclick='deleteSelPro(this)' class='" + data.productColor + data.productSize +"' id='proicon'></div>");
							
							proTotalSelectCount();
						}else {
							alert('이미 추가되었습니다.');
						};
					}else {
						alert('상품 재고가 없습니다.');
					};
	
				}
			});
		
		PSelement = document.getElementById(ps);
		PSelement.style.backgroundColor = 'black';
		PSelement.style.color = 'white';
		ps = '';
		
		if(pc == null || pc == '') {
			pc = '';
		}else {
			PCelement = document.getElementById(pc);
			PCelement.style.backgroundColor = 'black';
			PCelement.style.color = 'white';
			pc = '';
		}
		
	}
 	function stackUp(product_id) {
		var product_id =  $(product_id).attr('class')
		console.log("@@@@ product_id : " + product_id)
		stack = $("#" + product_id).val();
		Maxstack = $("#Max" + product_id).val();
		stack++;
		if(stack > Maxstack) {
			alert('최대 구매 수량은 ' + Maxstack + '개 입니다.')
			stack = Maxstack;
		}
		var productPrice = ${pdto.productPrice};
		var productStackPrice = stack * productPrice;
		console.log("@@@@ stack : " + stack)
		$('#' + product_id).val(stack);
		$( '#Price' + product_id).text( productStackPrice );
		proTotalSelectCount();
	}
	
	function stackDown(product_id) {
		var product_id =  $(product_id).attr('class')
		console.log("@@@@ product_id : " + product_id)
		stack = $("#" + product_id).val();
		stack--;
		if(stack <= 0) {
			alert('최소 구매 수량은 1개 입니다.')
			stack = 1;
		}
		var productPrice = ${pdto.productPrice};
		var productStackPrice = stack * productPrice;
		console.log("@@@@ stack : " + stack)
		$('#' + product_id).val(stack);
		$( '#Price' + product_id).text( productStackPrice );
		proTotalSelectCount();
	}
	
	function deleteSelPro(id) {
		var delId =  $(id).attr('class')
		console.log(delId)
		$("div").remove("#"+delId)
		proTotalSelectCount()
	}
	


	function proTotalSelectCount() {
		var total_stack = 0;
		var ProductStackTotalPrice = 0;
		var productPrice = ${pdto.productPrice};
		if(cnt > 0) {
			for (var i = 1; i <= cnt ; i++) {
				var product_stack =  parseInt($('#productStack' + i).val());
				if (isNaN(product_stack)) { // 값이 없어서 NaN값이 나올 경우
					product_stack = 0;
					}
				total_stack = parseInt(total_stack +  product_stack);
				var ProductStackTotalPrice = total_stack * productPrice;
				$( '#ProductStackTotalPrice').text( "총 금액 : " + ProductStackTotalPrice + " 원");
				if(total_stack == 0) {
					$( '#ProductStackTotalPrice').text('');
				}
			}	
		}
	}
	
	
	var loginsession = '${sessionScope.loginUser}';
    function productOrder() {
      if(loginsession =='admin'){
         alert('관리자는 구매할수없습니다')
       }else{
          form = document.profo;
            form.method = "post";
            form.action = '${pageContext.request.contextPath }/order/ordermain'
            var name = $('.pst').attr('name');
            if(name == null){
               alert('구매 상품을 선택해주세요')
            }else{
               form.submit();
            }
          
       }
   }
   
    function productCart() {
      if(loginsession =='admin'){
         alert('관리자는 구매할수없습니다')
      }else{
         form = document.profo;
         form.method = "post";
         form.action = '${pageContext.request.contextPath }/cart/addcart'
         var name = $('.pst').attr('name');
         if(name == null){
            alert('구매 상품을 선택해주세요')
         }else{
            form.submit();
         }
          
      }
   }
	
	
		
	
	   
	  
	 
	/*리뷰 불러오기*/
	/* function rePrint(){
		
		
	$.ajax({
		url:"../review/replyData", type:"get",
		data:{ productNo : "${pdto.productNo}"},
		dataType :"json", //받아올 데이터 자료형
		success : function( reviewData ){
			
			let html = ""
		for( i=0; i<reviewData.length; i++){
				let date = new Date( reviewData[i].reviewDate )
				let wd = date.getFullYear()+"-";
				wd += (date.getMonth()+1) + "-";
				wd += date.getDate();
				
				html += "<div align='left'><b>아이디 : </b>"+reviewData[i].memberId+"님  &nbsp ";
				html += "<b>작성일 : </b>"+ wd+" &nbsp";
				html += "<b>별점 : </b>"+reviewData[i].reviewStar+"<br>";
				html += "<b>내용 : </b>"+reviewData[i].reviewContent;
				html += "reviewNo: "+reviewData[i].reviewNo; //나중에 지우기
				if(reviewData[i].reviewFile != 'nan'){
					html += "<div align='right'><img src='../review/download?file="+ reviewData[i].reviewFile+"' width='50' height='50' /></div>";
				}
				
				html+= "<div>"+"<a href=../review/delete?reviewNo="+reviewData[i].reviewNo+"&productNo="+reviewData[i].productNo+">삭제</a>"+"  &nbsp ";
				html+= "<a href=../review/modify_form?reviewNo="+reviewData[i].reviewNo+"&productNo="+reviewData[i].productNo+">수정</a>"+"</div>";
			
				
				html+= "<hr></div>";
			}
			
			html += "<div>"+"페이지"+"</div>";
			
			
		
			$("#reply").html( html )
			},
		error: function(){alert("function error")}
			
	})
	
	
} */
	</script>
	
	
	
	<table border="1">
		<tr>
			<td rowspan="10">
				<c:if test="${ pdto.productFile == 'nan' }">
					<b>등록된 이미지가 없습니다.</b>
				</c:if>
				<c:if test="${ pdto.productFile != 'nan' }">
					<img width="300px" height="300px" src="${contextPath}/product/download?productFile=${pdto.productFile}">
				</c:if>
			</td>
			<th>상품 이름</th><td colspan="2">${pdto.productName }</td>
		</tr>
		<tr>
			<th>가격</th><td colspan="2">${pdto.productPrice }</td>
		</tr>
		<tr>
			<td colspan="3">리뷰 수 : ${pdto.reviewCount } / 별점 : 
				<c:if test="${pdto.reviewCount == 0}">
					0
				</c:if>
				<c:if test="${pdto.reviewCount != 0}">
					<fmt:formatNumber value="${pdto.productRating/pdto.reviewCount}" pattern=".00"/>
					
				</c:if>
			</td>
		</tr>
		<tr>
			<th colspan="3">컬러</th>
		</tr>
		<tr>
			<td colspan="3">
				<c:if test="${mclist.size() == 0 }">
					<button style="background-color: white; color: black;">품절</button>
				</c:if>
				<c:forEach var="mcdto" items="${mclist }">
					<button onclick="colorAdd(this.id)" id="${mcdto.productColor }">${mcdto.productColor }</button>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th colspan="3">사이즈</th>
		</tr>
		<tr>
			<td colspan="3">
				<c:if test="${mslist.size() == 0 }">
					<button style="background-color: white; color: black;">품절</button>
				</c:if>
				<c:forEach var="msdto" items="${mslist }">
					<button onclick="sizeAdd(this.id)" id="${msdto.productSize }">${msdto.productSize }</button>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td colspan="3">
			<form id="proOrderFo" name="profo">
				<input type="hidden" name="productNo" value="${pdto.productNo }">
				<input type="hidden" name="productName" value="${pdto.productName }">
				<input type="hidden" name="productFile" value="${pdto.productFile }">
				<input type="hidden" name="productPrice" id ="productPrice" value="${pdto.productPrice }">
				<div id="proOrderAdd">
				</div>
			</form>
			</td>
		</tr>
		<tr>
			<td><span id="ProductStackTotalPrice"></span>
		</tr>
		<tr>
			<td><button type="button" onclick="productCart()">장바구니</button></td>
			<td><button type="button" onclick="productOrder()">구매하기</button></td>
		</tr>
	</table>
	
	<div id="proContent">
	<h2>상품 상세 정보</h2>
	<hr>
	<div>
	<c:if test="${ pdto.productContent == 'nan' }">
		<b>등록된 이미지가 없습니다.</b>
	</c:if>
	<c:if test="${ pdto.productContent != 'nan' }">
		<img src="${contextPath}/product/download?productFile=${pdto.productContent}">
	</c:if>
	</div>
	</div><br><br>
	
	<div id="proReview">
	<h2>상품 후기</h2>
	<hr>
	<input type="hidden" id="productNo" name="productNo" value="${pdto.productNo }">
	
	<!-- 
	<table border="1">
		<tr>
			<td>
				<div id="review"></div>
			</td>
		</tr>
		<tr>
		
		</tr>
	</table>
	 -->
	 <div>
	
	<div id="reply"></div>
	
	
	
	</div>
	</div><br><br>
	
	<div id="changeGuide">
	<h2>배송/교환/환불 안내</h2>
	<hr>
	<table border="1">
		<tr>
			<th>배송 안내</th><td>- 저희 SeeoT는 무료 배송입니다.</td>
		</tr>
		<tr>
			<th>교환 안내</th><td>- 구매 3일안에 교환 요청시 교환이 가능합니다.</td>
		</tr>
		<tr>
			<th>환불 안내</th><td>- 구매 7일 이후 또는 개봉 후 사용 흔적이 있으면 환불이 불가능 합니다.<br>- 단순 변심으로는 환불이 안됩니다.</td>
		</tr>
	</table>
	</div>
	
	

</body>
<script src="<%=request.getContextPath() %>/resources/js/recentList.js"></script>
</html>