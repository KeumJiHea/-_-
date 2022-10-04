$(document).on('click','.cancel',function(){
	$("#first").slideDown("slow");
	$("#modal_wrap").show();
	var num = $(this).parent().parent();
	num.attr('class','tr');
	$("#orderNo").val($(".tr th").eq(0).text());

})


function slide_hide(){	
	$("#first").hide();
	$("#modal_wrap").hide();	
}	

$(document).on('click',".fcancel",function(){
		
		
		var str = ""            
		var tdArr = new Array();    // 배열 선언            
		var checkBtn = $(this);  
		

		// td.eq(index)를 통해 값을 가져올 수도 있다.    
		var no = $("#orderNo").val();
		
		console.log(no)
		$("#orderNo").attr('value',no);
		jQuery.ajax({
		      "url": "cancel", // 예: http://www.myservice.com/payments/cancel
		      "type": "POST",
		      "contentType": "application/json",
		      "data": JSON.stringify({
		        "merchant_uid": no, // 예: ORD20180131-0000011 "cancel_request_amount": cost, // 환불금액
		        "reason": $('#reason').val(), // 환불사유
		        "refund_holder": "운영자", // [가상계좌 환불시 필수입력] 환불 수령계좌 예금주
		        "refund_bank": "88", // [가상계좌 환불시 필수입력] 환불 수령계좌 은행코드(예: KG이니시스의 경우 신한은행은 88번)
		        "refund_account": "56211105948400", // [가상계좌 환불시 필수입력] 환불 수령계좌 번호
		        "orderNo" : no
		      }),
		    }).done(function(result){
		    	console.log($('#reason').val())
		    	alert('주문취소가 신청되었습니다\n관리자 승인후 취소 및 환불처리가 진행됩니다.');
		    	location.reload();
		    	slide_hide();		    	
		    	var str = "<button type='button' class='cancel'>주문취소</button>"
		    	$("#status").text('취소중');
		    	$(".cancel:button").attr("disabled",true);
		    }).fail(function(result){
		    	alert('주문취소신청에 실패하였습니다.\n잠시후 다시 시도 해주세요.')
		    });					
	});
	
var cnt=1;
	var j=0;
	var pricelist = new Array();
 	$(document).ready(function(){ //9020 중복되는 주문번호 합쳐보기
 		
 		if($("#tbody tr").length>1){
		for(i=0;i<$("#tbody tr").length;i++){
		var sum = 0;
			if(i>$("#tbody tr").length){
				i=$("#tbody tr").length
			}
			if($("#no"+i).text()==$("#no"+(i+1)).text()){
				if(cnt++){
					j++;
				}
					sum += parseInt($("#price"+i).text())									
					pricelist.push(sum)					
			}			
			else if($("#no"+i).text()!=$("#no"+(i+1)).text()){	
					if(j!=0){						
						sum += parseInt($("#price"+i).text())
						pricelist.push(sum)
						var total = pricelist.reduce(function(a,b){ return a+b;},0);
						$("#no"+(i-j)).attr('rowspan',cnt);
	 					$("#no"+(i-j)).attr('class','start');	
						$("#no0").attr('class','start');							
						$("#status"+(i-j)).attr('rowspan',cnt);
						$("#status"+(i-j)).attr('class','start');
						$("#status0").attr('class','start');					
					}
					pricelist = [];
					
					if(j==0&&cnt==1&&i!=0){
						sum += parseInt($("#price"+i).text())
						pricelist.push(sum)
						$("#no"+(i-j)).attr('class','start');
						$("#status"+(i-j)).attr('class','start');
						$("#status0").attr('class','start');
						
					}
						pricelist = [];
					cnt=1;
					if(cnt=1){
						j=0;
					}
				}					
				}
			}else if($("#tbody tr").length==1){
						$("#no0").attr('class','start');							
						$("#status0").attr('class','start');
		}
	})
	
	function getSearchList(){
		$.ajax({
			type: 'GET',
			url : "getStatusList",
			data : $("#searchform").serialize(),
			success : function(result){
				//테이블 초기화
				$('#tbody').empty();
				if(result.length>=1){					
					result.forEach(function(hilist,index){						
						str='<tr>'
						str+="<th id='no"+index+"'>"+hilist.hiOrderNo+"</th>"
						str+="<td><img width='30px' height='30px' src='"+hilist.hiProductFile+"'></td>"
						str+="<td>"+hilist.hiProductName+"<br>옵션 : "+hilist.hiProductColor+"/ "+hilist.hiProductSize+"</td>"
						str+="<td>"+hilist.hiOrderStack+"</td>"
						str+="<td id='price"+index+"'>"+hilist.hiProductPrice+"</td>"
						str+="<th id='status"+index+"'>"
						if(hilist.hiOrderStatus ==1){
							str+="주문완료<br><button type='button' class='cancel' onclick='slideClick()'>주문 취소</button>"
						}else if(hilist.hiOrderStatus == 0){
							str+="취소중<br>"
						}else if(hilist.hiOrderStatus == -1){
							str+="취소완료"
						}else if(hilist.hiOrderStatus == 2){
							str+="배송중<br>"
						}else if(hilist.hiOrderStatus == 3){
							str+="배송완료</th>"
						}
						str+="<td>리뷰남기기</td>"
						str+="</tr>"
						$('#tbody').append(str);
						
						var plist = new Array();
						for(i=0;i<$("#tbody tr").length;i++){
							var sum = 0;
								if(i>$("#tbody tr").length){
									i=$("#tbody tr").length
								}
								if($("#no"+i).text()==$("#no"+(i+1)).text()){
									if(cnt++){
										j++;
									}
										sum += parseInt($("#price"+i).text())									
										plist.push(sum)					
								}
								else if($("#tbody tr").length==1){
									sum += parseInt($("#price"+i).text())
									plist.push(sum)
									var total = plist.reduce(function(a,b){ return a+b;},0);
									$("#no0").attr('class','start');
									$("#status0").attr('class','start');									
								}			
								else if($("#no"+i).text()!=$("#no"+(i+1)).text()){	
										if(j!=0){						
											sum += parseInt($("#price"+i).text())
											plist.push(sum)
											var total = plist.reduce(function(a,b){ return a+b;},0);
											$("#no"+(i-j)).attr('rowspan',cnt);
											$("#no"+(i-j)).attr('class','start');	
											$("#no0").attr('class','start');		
											$("#status"+(i-j)).attr('rowspan',cnt);
											$("#status"+(i-j)).attr('class','start');
											$("#status0").attr('class','start');
						
										}
										plist = [];
										
										if(j==0&&cnt==1&&i!=0){
											sum += parseInt($("#price"+i).text())
											plist.push(sum)
											$("#no"+(i-j)).attr('class','start');
											$("#no0").attr('class','start');
											$("#status"+(i-j)).attr('class','start');
											$("#status0").attr('class','start');

											
										}
										plist = [];
										cnt=1;
										if(cnt=1){
											j=0;
										}
									}
							}
	        		})				 
				}
			}
		})
	}