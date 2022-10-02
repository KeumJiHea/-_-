$(document).on('click',".cancelOk",function(){
   
		var no = $("#orderNo").val();
		var cost =$("#cost").val();
		
		jQuery.ajax({
		      "url": "cancelOk", // 예: http://www.myservice.com/payments/cancel
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
		    	alert('주문취소완료');
		    	window.close();
		    	opener.parent.location.reload();    	
		    }).fail(function(result){
		    	alert('주문취소실패! \n잠시후 다시 시도 해주세요.')
		    });	
		
		
						
	});
 	
	$(document).on('click',".cancelNone",function(){
		var form={
				memberId : $("#memberId").val(),
				orderNo : $("#orderNo").val()
			};		
			$.ajax({
				url : "noncancel",
				type : "POST",
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(form)
				}).done(function(){
					alert($("#orderNo").val()+'주문취소 취소처리 완료');
			    	window.close();
			    	opener.parent.location.reload();	
				}).fail(function(data){
					alert('실패'+data)
				});
						
	});