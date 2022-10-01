function slideClick(){
	$("#first").slideDown("slow");
	$("#modal_wrap").show();
}
function slide_hide(){	
	$("#first").hide();
	$("#modal_wrap").hide();	
}		
	
		
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