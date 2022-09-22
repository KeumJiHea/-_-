<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script type="text/javascript">
		
		
function slideClick(){
	$("#first").slideDown("slow");
	$("#modal_wrap").show();
}
function slide_hide(){	
	$("#first").hide();
	$("#modal_wrap").hide();	
}		
$(document).ready(function(){
	var rowspan = $("#tbody tr").length;
	var statustd = $("#statustd0");
	statustd.attr('rowspan',rowspan);
	for(i=1;i<$("#tbody tr").length;i++){
		$("#statustd"+i).remove();
	}
})		
		
$(document).on('click',".fcancel",function(){
		
		var str = ""            
		var tdArr = new Array();    // 배열 선언            
		var checkBtn = $("#tbody");
		// checkBtn.parent() : checkBtn의 부모는 <td>이다.    
		// checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.    
		var tr = checkBtn.parent().parent();    
		var td = tr.children(); 

		// td.eq(index)를 통해 값을 가져올 수도 있다.    
		var no = $("#tbody td").eq(0).text();
		var cost =$("#tbody td").eq(3).text();
		console.log(no)
		console.log(cost)
		$("#orderNo").attr('value',no);
		jQuery.ajax({
		      "url": "cancel", // 예: http://www.myservice.com/payments/cancel
		      "type": "POST",
		      "contentType": "application/json",
		      "data": JSON.stringify({
		        "merchant_uid": no, // 예: ORD20180131-0000011
		        "cancel_request_amount": cost, // 환불금액
		        "reason": $('#reason').val(), // 환불사유
		        "refund_holder": "운영자", // [가상계좌 환불시 필수입력] 환불 수령계좌 예금주
		        "refund_bank": "88", // [가상계좌 환불시 필수입력] 환불 수령계좌 은행코드(예: KG이니시스의 경우 신한은행은 88번)
		        "refund_account": "56211105948400", // [가상계좌 환불시 필수입력] 환불 수령계좌 번호
		        "orderNo" : no
		      }),
		    }).done(function(result){
		    	console.log($('#reason').val())
		    	alert('주문취소가 신청되었습니다\n관리자 승인후 취소 및 환불처리가 진행됩니다.');
		    	slide_hide();		    	
		    	var str = "<button type='button' class='cancel'>주문취소</button>"
		    	$("#status").text('취소진행중');
		    	$(".cancel:button").attr("disabled",true);
		    }).fail(function(result){
		    	alert('주문취소신청에 실패하였습니다.\n잠시후 다시 시도 해주세요.')
		    });					
	});
</script>
<style type="text/css">
	#modal_wrap{position: fixed; z-index: 9;margin: auto; display:none;
	 top:0; left: 0; right: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.4)
	}
	#first{position: fixed; z-index: 10;margin: auto; display:none;
	 top:30px; left: 0; right: 0; width: 350px; height: 450px; background-color: white;
	}
</style>
</head>
<body>
<div id="modal_wrap">
	<div id="first">
		<div style="width: 250px; margin: auto; padding-top: 20px;">
			<form>
				<input type="hidden" name="orderNo" id="orderNo">
				<b>취소 사유</b><br>
				<textarea rows="5" cols="30" name="reason" id="reason"></textarea>
				<hr>
				<button type="button" class="fcancel">주문취소</button>
				<button type="button" onclick="slide_hide()">접기</button>
			</form>
		</div>
	</div>
</div>
<table border="1" id="ordertable">
	<tr>
		<th>주문번호</th><th>이미지</th><th>상품명/옵션</th><th>상품금액</th><th>수량</th><th>주문상태</th><th>확인/리뷰</th>
	</tr>
	<c:if test="${sessionScope.orderdata ==null }">
		<tr>
			<th colspan="5">주문한 상품이 없습니다</th>
		</tr>
	</c:if>
	<c:if test="${sessionScope.orderdata != null }">
	<tbody id="tbody">	
		<c:forEach begin="0" end="${result-1 }" var="i" varStatus="status">			
			<tr>
				<td id="order${status.index }">${order.merchant_uid }</td><td><img width="50px" height="50px" src="${order.gfile[i] }"></td><td>${order.glist[i]}<br>옵션 : ${order.gcolor[i] } / ${order.gsize[i] }</td><td>${order.gcost[i] }</td><td>${order.gstack[i] }</td><td id="statustd${status.index }"><span id="status">주문완료</span><br><button type="button" name="cancelBtn" class='cancel' onclick="slideClick()">주문취소</button></td><td>확인</td>
			</tr>
		</c:forEach>
	</tbody>	
	</c:if>
</table>
</body>
</html>