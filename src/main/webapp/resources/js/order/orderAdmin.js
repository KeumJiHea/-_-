	function slideClick(){
		var form={
			memberId : $("#tbody th").eq(1).text(),
			orderNo : $("#tbody th").eq(0).text()
		}
		$("#first").slideDown("slow");
		$("#modal_wrap").show();		
		$.ajax({
			url : "cancelchk",
			type : "POST",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(form)
			}).done(function(){
				$("#memberId").val(form.memberId);
				$("#orderNo").val(form.orderNo);
				$("#reason").val('${sessionScope.reason}')
			}).fail(function(data){
				alert('실패'+data)
			});
		}

	function slide_hide(){	
		$("#first").hide();
		$("#modal_wrap").hide();	
	}
 	var cnt=1;
	var j=0;
	var pricelist = new Array();
 	$(document).ready(function(){ //9020 중복되는 주문번호 합쳐보기
 		
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
						$("#id"+(i-j)).attr('rowspan',cnt);
						$("#id"+(i-j)).attr('class','start');	
						$("#id0").attr('class','start');	
						$("#status"+(i-j)).attr('rowspan',cnt);
						$("#status"+(i-j)).attr('class','start');
						$("#status0").attr('class','start');
						$("#total"+(i-j)).attr('rowspan',cnt);
						$("#total"+(i-j)).attr('class','start');
						$("#total0").attr('class','start');
						$("#total"+(i-j)).text(total);						
						$("#total0").text(total);	
						$("#no"+(i-j)).attr('rowspan',cnt);						
					}
					pricelist = [];
					
					if(j==0&&cnt==1&&i!=0){
						sum += parseInt($("#price"+i).text())
						pricelist.push(sum)
						$("#no"+(i-j)).attr('class','start');
						//$("#no0").attr('class','start');
						$("#id"+(i-j)).attr('class','start');
						$("#id0").attr('class','start');
						$("#status"+(i-j)).attr('class','start');
						$("#status0").attr('class','start');
						$("#total"+(i-j)).attr('class','start');
						$("#total0").attr('class','start');
						$("#total"+(i-j)).text(pricelist[0]);
						$("#total0").text(pricelist[0]);
						
					}
						pricelist = [];
					cnt=1;
					if(cnt=1){
						j=0;
					}
				}
		}		
	})  
	
	$(document).on('click','.delevery',function(){
		var checkBtn = $(this);
		// checkBtn.parent() : checkBtn의 부모는 <td>이다.    
		// checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.    
		var tr = checkBtn.parent().parent();    
		var th = tr.children(); 

		// td.eq(index)를 통해 값을 가져올 수도 있다.    
		var no = th.eq(0).text(); 
			$.ajax({
				url : "delevery",
				type : "POST",
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify({
					orderNo : no
				}),
				}).done(function(){
					alert('주문배송시작');
			    	location.reload();
				}).fail(function(data){
					alert('실패'+data)
					console.log(no)
				});
	});
	$(document).on('click','.endDelevery',function(){
		var checkBtn = $(this);
		// checkBtn.parent() : checkBtn의 부모는 <td>이다.    
		// checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.    
		var tr = checkBtn.parent().parent();    
		var th = tr.children(); 

		// td.eq(index)를 통해 값을 가져올 수도 있다.    
		var no = th.eq(0).text();
			$.ajax({
				url : "enddelevery",
				type : "POST",
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify({
					orderNo : no
				}),
				}).done(function(){
					alert('주문배송완료');
			    	location.reload();
				}).fail(function(data){
					alert('실패'+data)
					
				});
	});
	
	$(document).on('click',".cancelOk",function(){
   
		var no = $("#tbody th").eq(0).text();
		var cost =$("#tbody th").eq(3).text();
		
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
		    	location.reload();
		    	slide_hide();		    	
		    }).fail(function(result){
		    	alert('주문취소실패! \n잠시후 다시 시도 해주세요.')
		    });	
		
		
						
	});
 	
	$(document).on('click',".cancelNone",function(){
		var form={
				memberId : $("#tbody th").eq(1).text(),
				orderNo : $("#tbody th").eq(0).text()
			};		
			$.ajax({
				url : "noncancel",
				type : "POST",
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(form)
				}).done(function(){
					alert($("#tbody th").eq(0).text()+'주문취소 취소처리 완료');
			    	location.reload();	
				}).fail(function(data){
					alert('실패'+data)
				});
						
	});

	function getSearchList(){
		$.ajax({
			type: 'GET',
			url : "getSearchList",
			data : $("#searchform").serialize(),
			success : function(result){
				//테이블 초기화
				$('#tbody').empty();
				if(result.length>=1){
					
					result.forEach(function(list,index){						
						str='<tr>'
						str+="<th id='no"+index+"'>"+list.orderNo+"</th>"
						str+="<th id='id"+index+"'>"+list.memberId+"</th>"
						str+="<td><img width='30px' height='30px' src='"+list.productFile+"'>"+list.productName+" / "+list.productColor+" "+list.productSize+"</td>"
						str+="<td>"+list.orderStack+"</td>"
						str+="<td id='price"+index+"'>"+list.productPrice+"</td>"
						str+="<th id='total"+index+"'>1</th>"
						str+="<th id='status"+index+"'>"
						if(list.orderStatus ==1){
							str+="결제완료<br><button type='button' class='delevery'>배송 시작</button>"
						}else if(list.orderStatus == 0){
							str+="취소중<br><button type='button' onclick='slideClick()'>취소 사유</button>"
						}else if(list.orderStatus == -1){
							str+="취소완료"
						}else if(list.orderStatus == 2){
							str+="배송중<br><button type='button' class='endDelevery'>배송 완료</button>"
						}else if(list.orderStatus == 3){
							str+="배송완료</th>"
						}
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
									$("#id0").attr('class','start');
									$("#status0").attr('class','start');
									$("#total0").attr('class','start');
									$("#total0").text(total);
								}			
								else if($("#no"+i).text()!=$("#no"+(i+1)).text()){	
										if(j!=0){						
											sum += parseInt($("#price"+i).text())
											plist.push(sum)
											var total = plist.reduce(function(a,b){ return a+b;},0);
											$("#no"+(i-j)).attr('rowspan',cnt);
											$("#no"+(i-j)).attr('class','start');	
											$("#no0").attr('class','start');	
											$("#id"+(i-j)).attr('rowspan',cnt);
											$("#id"+(i-j)).attr('class','start');	
											$("#id0").attr('class','start');	
											$("#status"+(i-j)).attr('rowspan',cnt);
											$("#status"+(i-j)).attr('class','start');
											$("#status0").attr('class','start');
											$("#total"+(i-j)).attr('rowspan',cnt);
											$("#total"+(i-j)).attr('class','start');
											$("#total0").attr('class','start');
											$("#total"+(i-j)).text(total);						
											$("#total0").text(total);						
										}
										plist = [];
										
										if(j==0&&cnt==1&&i!=0){
											sum += parseInt($("#price"+i).text())
											plist.push(sum)
											$("#no"+(i-j)).attr('class','start');
											$("#no0").attr('class','start');
											$("#id"+(i-j)).attr('class','start');
											$("#id0").attr('class','start');
											$("#status"+(i-j)).attr('class','start');
											$("#status0").attr('class','start');
											$("#total"+(i-j)).attr('class','start');
											$("#total0").attr('class','start');
											$("#total"+(i-j)).text(plist[0]);
											
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
	var sortlist = new Array();
	$(document).ready(function(){
		$("#ordersection").attr('class','desc');
		$("#ordersection").children().attr('id','nosort');
		$("#ordersection").children().attr('class','sort');
		$("#idsection").attr('class','desc');
		$("#idsection").children().attr('id','idsort');
		$("#idsection").children().attr('class','sort');
		$("#totalsection").attr('class','desc');
		$("#totalsection").children().attr('id','totalsort');
		$("#totalsection").children().attr('class','sort');
		sortlist.push()
	})
	
	
 	$(document).on('click','.sort',function(){						
 		if($(this).parent().attr('id')=='ordersection' && $(this).attr('id')=='nosort'){
	 		if($("#ordersection").attr('class')=='desc'){
	 			$.ajax({
	 				url:'sorting',
	 				type:"post",
	 				data:{sort:1},
	 				success : function(desclist){
	 					$('#tbody').empty();
	 					if(desclist.length>=1){	 						
	 						desclist.forEach(function(desclist,index){								
	 							str='<tr>'
	 							if(index==0){
	 								str+="<th id='no"+index+"' clss='start'>"+desclist.orderNo+"</th>"
	 								str+="<th id='id"+index+"' clss='start'>"+desclist.memberId+"</th>"
	 								str+="<td><img width='30px' height='30px' src='"+desclist.productFile+"'>"+desclist.productName+" / "+desclist.productColor+" "+desclist.productSize+"</td>"
		 							str+="<td>"+desclist.orderStack+"</td>"
		 							str+="<td id='price"+index+"'>"+desclist.productPrice+"</td>"
		 							str+="<th id='total"+index+"' clss='start'>1</th>"
		 							str+="<th id='status"+index+"'>"
	 							}else{
	 								str+="<th id='no"+index+"'>"+desclist.orderNo+"</th>"
	 								str+="<th id='id"+index+"'>"+desclist.memberId+"</th>"
	 								str+="<td><img width='30px' height='30px' src='"+desclist.productFile+"'>"+desclist.productName+" / "+desclist.productColor+" "+desclist.productSize+"</td>"
		 							str+="<td>"+desclist.orderStack+"</td>"
		 							str+="<td id='price"+index+"'>"+desclist.productPrice+"</td>"
		 							str+="<th id='total"+index+"'>1</th>"
		 							str+="<th id='status"+index+"'>"
	 							}	 							
	 							
	 							if(desclist.orderStatus ==1){
	 								str+="결제완료<br><button type='button' class='delevery'>배송 시작</button>"
	 							}else if(desclist.orderStatus == 0){
	 								str+="취소중<br><button type='button' onclick='slideClick()'>취소 사유</button>"
	 							}else if(desclist.orderStatus == -1){
	 								str+="취소완료"
	 							}else if(desclist.orderStatus == 2){
	 								str+="배송중<br><button type='button' class='endDelevery'>배송 완료</button>"
	 							}else if(desclist.orderStatus == 3){
	 								str+="배송완료</th>"
	 							}
	 							str+="</tr>"
	 							$('#tbody').append(str);
	 							var alist = new Array();
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
	 											alist.push(sum)					
	 									}			
	 									else if($("#no"+i).text()!=$("#no"+(i+1)).text()){	
	 											if(j!=0){						
	 												sum += parseInt($("#price"+i).text())
	 												alist.push(sum)
	 												var total = alist.reduce(function(a,b){ return a+b;},0);
	 												$("#no"+(i-j)).attr('rowspan',cnt);
	 												$("#no"+(i-j)).attr('class','start');	
	 												$("#no0").attr('class','start');	
	 												$("#id"+(i-j)).attr('rowspan',cnt);
	 												$("#id"+(i-j)).attr('class','start');	
	 												$("#id0").attr('class','start');	
	 												$("#status"+(i-j)).attr('rowspan',cnt);
	 												$("#status"+(i-j)).attr('class','start');
	 												$("#status0").attr('class','start');
	 												$("#total"+(i-j)).attr('rowspan',cnt);
	 												$("#total"+(i-j)).attr('class','start');
	 												$("#total0").attr('class','start');
	 												$("#total"+(i-j)).text(total);						
	 												$("#total0").text(total);						
	 											}
	 											alist = [];
	 											
	 											if(j==0&&cnt==1&&i!=0){
	 												sum += parseInt($("#price"+i).text())
	 												alist.push(sum)
	 												$("#no"+(i-j)).attr('class','start');
	 												$("#no0").attr('class','start');
	 												$("#id"+(i-j)).attr('class','start');
	 												$("#id0").attr('class','start');
	 												$("#status"+(i-j)).attr('class','start');
	 												$("#status0").attr('class','start');
	 												$("#total"+(i-j)).attr('class','start');
	 												$("#total0").attr('class','start');
	 												$("#total"+(i-j)).text(alist[0]);
	 												$("#total0").text(alist[0]);
	 												
	 											}
	 											alist = [];
	 											cnt=1;
	 											if(cnt=1){
	 												j=0;
	 											}
	 										}
	 								}
	 						})
	 					}
	 							$("#ordersection").attr('class','asc');
	 				}
	 		
	 			})
	
	 		}else if($("#ordersection").attr('class') !='desc'){
	 			$.ajax({
	 				url:'sorting',
	 				type:"post",
	 				data:{sort:0},
	 				success : function(asclist){
	 					//테이블 초기화
	 					$('#tbody').empty();
	 					if(asclist.length>=1){
	 						
	 						asclist.forEach(function(asclist,index){
	 							
	 							str='<tr>'
	 							str+="<th id='no"+index+"'>"+asclist.orderNo+"</th>"
	 							str+="<th id='id"+index+"'>"+asclist.memberId+"</th>"
	 							str+="<td><img width='30px' height='30px' src='"+asclist.productFile+"'>"+asclist.productName+" / "+asclist.productColor+" "+asclist.productSize+"</td>"
	 							str+="<td>"+asclist.orderStack+"</td>"
	 							str+="<td id='price"+index+"'>"+asclist.productPrice+"</td>"
	 							str+="<th id='total"+index+"'>1</th>"
	 							str+="<th id='status"+index+"'>"
	 							if(asclist.orderStatus ==1){
	 								str+="결제완료<br><button type='button' class='delevery'>배송 시작</button>"
	 							}else if(asclist.orderStatus == 0){
	 								str+="취소중<br><button type='button' onclick='slideClick()'>취소 사유</button>"
	 							}else if(asclist.orderStatus == -1){
	 								str+="취소완료"
	 							}else if(asclist.orderStatus == 2){
	 								str+="배송중<br><button type='button' class='endDelevery'>배송 완료</button>"
	 							}else if(asclist.orderStatus == 3){
	 								str+="배송완료</th>"
	 							}
	 							str+="</tr>"
	 							$('#tbody').append(str);
	 							var blist = new Array();
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
	 											blist.push(sum)					
	 									}			
	 									else if($("#no"+i).text()!=$("#no"+(i+1)).text()){	
	 											if(j!=0){						
	 												sum += parseInt($("#price"+i).text())
	 												blist.push(sum)
	 												var total = blist.reduce(function(a,b){ return a+b;},0);
	 												$("#no"+(i-j)).attr('rowspan',cnt);
	 												$("#no"+(i-j)).attr('class','start');	
	 												$("#no0").attr('class','start');	
	 												$("#id"+(i-j)).attr('rowspan',cnt);
	 												$("#id"+(i-j)).attr('class','start');	
	 												$("#id0").attr('class','start');	
	 												$("#status"+(i-j)).attr('rowspan',cnt);
	 												$("#status"+(i-j)).attr('class','start');
	 												$("#status0").attr('class','start');
	 												$("#total"+(i-j)).attr('rowspan',cnt);
	 												$("#total"+(i-j)).attr('class','start');
	 												$("#total0").attr('class','start');
	 												$("#total"+(i-j)).text(total);						
	 												$("#total0").text(total);						
	 											}
	 											blist = [];
	 											
	 											if(j==0&&cnt==1&&i!=0){
	 												sum += parseInt($("#price"+i).text())
	 												blist.push(sum)
	 												$("#no"+(i-j)).attr('class','start');
	 												$("#id"+(i-j)).attr('class','start');
	 												$("#status"+(i-j)).attr('class','start');
	 												$("#total"+(i-j)).attr('class','start');
	 												$("#total"+(i-j)).text(blist[0]);
	 												$("#total0").text(blist[0]);
	 												
	 											}
	 											blist = [];
	 											cnt=1;
	 											if(cnt=1){
	 												j=0;
	 											}
	 										}
	 								}
	 						})
	 					}
	 					$("#ordersection").attr('class','desc');		
	 				}
	 		
	 			})
	 		}
	 	}else if($(this).parent().attr('id')=='idsection' && $(this).attr('id')=='idsort'){
	 		if($("#idsection").attr('class')=='desc'){
	 			$.ajax({
	 				url:'sorting',
	 				type:"post",
	 				data:{sort:2},
	 				success : function(desclist){
	 					$('#tbody').empty();
	 					if(desclist.length>=1){	 						
	 						desclist.forEach(function(desclist,index){								
	 							str='<tr>'
	 							str+="<th id='no"+index+"'>"+desclist.orderNo+"</th>"
	 							str+="<th id='id"+index+"'>"+desclist.memberId+"</th>"
	 							str+="<td><img width='30px' height='30px' src='"+desclist.productFile+"'>"+desclist.productName+" / "+desclist.productColor+" "+desclist.productSize+"</td>"
	 							str+="<td>"+desclist.orderStack+"</td>"
	 							str+="<td id='price"+index+"'>"+desclist.productPrice+"</td>"
	 							str+="<th id='total"+index+"'>1</th>"
	 							str+="<th id='status"+index+"'>"
	 							if(desclist.orderStatus ==1){
	 								str+="결제완료<br><button type='button' class='delevery'>배송 시작</button>"
	 							}else if(desclist.orderStatus == 0){
	 								str+="취소중<br><button type='button' onclick='slideClick()'>취소 사유</button>"
	 							}else if(desclist.orderStatus == -1){
	 								str+="취소완료"
	 							}else if(desclist.orderStatus == 2){
	 								str+="배송중<br><button type='button' class='endDelevery'>배송 완료</button>"
	 							}else if(desclist.orderStatus == 3){
	 								str+="배송완료</th>"
	 							}
	 							str+="</tr>"
	 							$('#tbody').append(str);
	 							var clist = new Array();
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
	 											clist.push(sum)					
	 									}			
	 									else if($("#no"+i).text()!=$("#no"+(i+1)).text()){	
	 											if(j!=0){						
	 												sum += parseInt($("#price"+i).text())
	 												clist.push(sum)
	 												var total = clist.reduce(function(a,b){ return a+b;},0);
	 												$("#no"+(i-j)).attr('rowspan',cnt);
	 												$("#no"+(i-j)).attr('class','start');	
	 												$("#no0").attr('class','start');	
	 												$("#id"+(i-j)).attr('rowspan',cnt);
	 												$("#id"+(i-j)).attr('class','start');	
	 												$("#id0").attr('class','start');	
	 												$("#status"+(i-j)).attr('rowspan',cnt);
	 												$("#status"+(i-j)).attr('class','start');
	 												$("#status0").attr('class','start');
	 												$("#total"+(i-j)).attr('rowspan',cnt);
	 												$("#total"+(i-j)).attr('class','start');
	 												$("#total0").attr('class','start');
	 												$("#total"+(i-j)).text(total);						
	 												$("#total0").text(total);						
	 											}
	 											clist = [];
	 											
	 											if(j==0&&cnt==1&&i!=0){
	 												sum += parseInt($("#price"+i).text())
	 												clist.push(sum)
	 												$("#no"+(i-j)).attr('class','start');
	 												$("#no0").attr('class','start');
	 												$("#id"+(i-j)).attr('class','start');
	 												$("#id0").attr('class','start');
	 												$("#status"+(i-j)).attr('class','start');
	 												$("#status0").attr('class','start');
	 												$("#total"+(i-j)).attr('class','start');
	 												$("#total0").attr('class','start');
	 												$("#total"+(i-j)).text(clist[0]);
	 												$("#total0").text(clist[0]);
	 												
	 											}
	 											clist = [];
	 											cnt=1;
	 											if(cnt=1){
	 												j=0;
	 											}
	 										}
	 								}
	 						})
	 					}
	 							$("#idsection").attr('class','asc');
	 				}
	 		
	 			})
	
	 		}else if($("#idsection").attr('class') !='desc'){
	 			$.ajax({
	 				url:'sorting',
	 				type:"post",
	 				data:{sort:3},
	 				success : function(asclist){
	 					//테이블 초기화
	 					$('#tbody').empty();
	 					if(asclist.length>=1){
	 						
	 						asclist.forEach(function(asclist,index){
	 							
	 							str='<tr>'
	 							str+="<th id='no"+index+"'>"+asclist.orderNo+"</th>"
	 							str+="<th id='id"+index+"'>"+asclist.memberId+"</th>"
	 							str+="<td><img width='30px' height='30px' src='"+asclist.productFile+"'>"+asclist.productName+" / "+asclist.productColor+" "+asclist.productSize+"</td>"
	 							str+="<td>"+asclist.orderStack+"</td>"
	 							str+="<td id='price"+index+"'>"+asclist.productPrice+"</td>"
	 							str+="<th id='total"+index+"'>1</th>"
	 							str+="<th id='status"+index+"'>"
	 							if(asclist.orderStatus ==1){
	 								str+="결제완료<br><button type='button' class='delevery'>배송 시작</button>"
	 							}else if(asclist.orderStatus == 0){
	 								str+="취소중<br><button type='button' onclick='slideClick()'>취소 사유</button>"
	 							}else if(asclist.orderStatus == -1){
	 								str+="취소완료"
	 							}else if(asclist.orderStatus == 2){
	 								str+="배송중<br><button type='button' class='endDelevery'>배송 완료</button>"
	 							}else if(asclist.orderStatus == 3){
	 								str+="배송완료</th>"
	 							}
	 							str+="</tr>"
	 							$('#tbody').append(str);
	 							var dlist = new Array();
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
	 											dlist.push(sum)					
	 									}			
	 									else if($("#no"+i).text()!=$("#no"+(i+1)).text()){	
	 											if(j!=0){						
	 												sum += parseInt($("#price"+i).text())
	 												dlist.push(sum)
	 												var total = dlist.reduce(function(a,b){ return a+b;},0);
	 												$("#no"+(i-j)).attr('rowspan',cnt);
	 												$("#no"+(i-j)).attr('class','start');	
	 												$("#no0").attr('class','start');	
	 												$("#id"+(i-j)).attr('rowspan',cnt);
	 												$("#id"+(i-j)).attr('class','start');	
	 												$("#id0").attr('class','start');	
	 												$("#status"+(i-j)).attr('rowspan',cnt);
	 												$("#status"+(i-j)).attr('class','start');
	 												$("#total"+(i-j)).attr('rowspan',cnt);
	 												$("#total"+(i-j)).attr('class','start');
	 												$("#total"+(i-j)).text(total);						
	 												$("#total0").text(total);						
	 											}
	 											dlist = [];
	 											
	 											if(j==0&&cnt==1&&i!=0){
	 												sum += parseInt($("#price"+i).text())
	 												dlist.push(sum)
	 												$("#no"+(i-j)).attr('class','start');
	 												$("#id"+(i-j)).attr('class','start');
	 												$("#id0").attr('class','start');
	 												$("#status"+(i-j)).attr('class','start');
	 												$("#status0").attr('class','start');
	 												$("#total"+(i-j)).attr('class','start');
	 												$("#total0").attr('class','start');
	 												$("#total"+(i-j)).text(dlist[0]);
	 												$("#total0").text(dlist[0]);
	 												
	 											}
	 											dlist = [];
	 											cnt=1;
	 											if(cnt=1){
	 												j=0;
	 											}
	 										}
	 								}
	 						})
	 					}
	 					$("#idsection").attr('class','desc');		
	 				}
	 		
	 			})
	 		}
	 	}else if($(this).parent().attr('id')=='totalsection' && $(this).attr('id')=='totalsort'){
	 		if($("#totalsection").attr('class')=='desc'){
	 			$.ajax({
	 				url:'sorting',
	 				type:"post",
	 				data:{sort:4},
	 				success : function(desclist){
	 					$('#tbody').empty();
	 					if(desclist.length>=1){	 						
	 						desclist.forEach(function(desclist,index){								
	 							str='<tr>'
	 							str+="<th id='no"+index+"'>"+desclist.orderNo+"</th>"
	 							str+="<th id='id"+index+"'>"+desclist.memberId+"</th>"
	 							str+="<td><img width='30px' height='30px' src='"+desclist.productFile+"'>"+desclist.productName+" / "+desclist.productColor+" "+desclist.productSize+"</td>"
	 							str+="<td>"+desclist.orderStack+"</td>"
	 							str+="<td id='price"+index+"'>"+desclist.productPrice+"</td>"
	 							str+="<th id='total"+index+"'>1</th>"
	 							str+="<th id='status"+index+"'>"
	 							if(desclist.orderStatus ==1){
	 								str+="결제완료<br><button type='button' class='delevery'>배송 시작</button>"
	 							}else if(desclist.orderStatus == 0){
	 								str+="취소중<br><button type='button' onclick='slideClick()'>취소 사유</button>"
	 							}else if(desclist.orderStatus == -1){
	 								str+="취소완료"
	 							}else if(desclist.orderStatus == 2){
	 								str+="배송중<br><button type='button' class='endDelevery'>배송 완료</button>"
	 							}else if(desclist.orderStatus == 3){
	 								str+="배송완료</th>"
	 							}
	 							str+="</tr>"
	 							$('#tbody').append(str);
	 							var elist = new Array();
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
	 											elist.push(sum)					
	 									}			
	 									else if($("#no"+i).text()!=$("#no"+(i+1)).text()){	
	 											if(j!=0){						
	 												sum += parseInt($("#price"+i).text())
	 												elist.push(sum)
	 												var total = elist.reduce(function(a,b){ return a+b;},0);
	 												$("#no"+(i-j)).attr('rowspan',cnt);
	 												$("#no"+(i-j)).attr('class','start');	
	 												$("#no0").attr('class','start');	
	 												$("#id"+(i-j)).attr('rowspan',cnt);
	 												$("#id"+(i-j)).attr('class','start');	
	 												$("#id0").attr('class','start');	
	 												$("#status"+(i-j)).attr('rowspan',cnt);
	 												$("#status"+(i-j)).attr('class','start');
	 												$("#status0").attr('class','start');
	 												$("#total"+(i-j)).attr('rowspan',cnt);
	 												$("#total"+(i-j)).attr('class','start');
	 												$("#total0").attr('class','start');
	 												$("#total"+(i-j)).text(total);						
	 												$("#total0").text(total);						
	 											}
	 											elist = [];
	 											
	 											if(j==0&&cnt==1&&i!=0){
	 												sum += parseInt($("#price"+i).text())
	 												elist.push(sum)
	 												$("#no"+(i-j)).attr('class','start');
	 												$("#no0").attr('class','start');
	 												$("#id"+(i-j)).attr('class','start');
	 												$("#id0").attr('class','start');
	 												$("#status"+(i-j)).attr('class','start');
	 												$("#status0").attr('class','start');
	 												$("#total"+(i-j)).attr('class','start');
	 												$("#total0").attr('class','start');
	 												$("#total"+(i-j)).text(elist[0]);
	 												$("#total0").text(elist[0]);
	 												
	 											}
	 											elist = [];
	 											cnt=1;
	 											if(cnt=1){
	 												j=0;
	 											}
	 										}
	 								}
	 						})
	 					}
	 							$("#totalsection").attr('class','asc');
	 				}
	 		
	 			})
	
	 		}else if($("#totalsection").attr('class') !='desc'){
	 			$.ajax({
	 				url:'sorting',
	 				type:"post",
	 				data:{sort:5},
	 				success : function(asclist){
	 					//테이블 초기화
	 					$('#tbody').empty();
	 					if(asclist.length>=1){	 						
	 						asclist.forEach(function(asclist,index){	 							
	 							str='<tr>'
	 							str+="<th id='no"+index+"'>"+asclist.orderNo+"</th>"
	 							str+="<th id='id"+index+"'>"+asclist.memberId+"</th>"
	 							str+="<td><img width='30px' height='30px' src='"+asclist.productFile+"'>"+asclist.productName+" / "+asclist.productColor+" "+asclist.productSize+"</td>"
	 							str+="<td>"+asclist.orderStack+"</td>"
	 							str+="<td id='price"+index+"'>"+asclist.productPrice+"</td>"
	 							str+="<th id='total"+index+"'>1</th>"
	 							str+="<th id='status"+index+"'>"
	 							if(asclist.orderStatus ==1){
	 								str+="결제완료<br><button type='button' class='delevery'>배송 시작</button>"
	 							}else if(asclist.orderStatus == 0){
	 								str+="취소중<br><button type='button' onclick='slideClick()'>취소 사유</button>"
	 							}else if(asclist.orderStatus == -1){
	 								str+="취소완료"
	 							}else if(asclist.orderStatus == 2){
	 								str+="배송중<br><button type='button' class='endDelevery'>배송 완료</button>"
	 							}else if(asclist.orderStatus == 3){
	 								str+="배송완료</th>"
	 							}
	 							str+="</tr>"
	 							$('#tbody').append(str);
	 							var flist = new Array();
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
	 											flist.push(sum)					
	 									}			
	 									else if($("#no"+i).text()!=$("#no"+(i+1)).text()){	
	 											if(j!=0){						
	 												sum += parseInt($("#price"+i).text())
	 												flist.push(sum)
	 												var total = flist.reduce(function(a,b){ return a+b;},0);
	 												$("#no"+(i-j)).attr('rowspan',cnt);
	 												$("#no"+(i-j)).attr('class','start');	
	 												$("#no0").attr('class','start');	
	 												$("#id"+(i-j)).attr('rowspan',cnt);
	 												$("#id"+(i-j)).attr('class','start');	
	 												$("#status"+(i-j)).attr('rowspan',cnt);
	 												$("#status"+(i-j)).attr('class','start');
	 												$("#total"+(i-j)).attr('rowspan',cnt);
	 												$("#total"+(i-j)).attr('class','start');
	 												$("#total"+(i-j)).text(total);						
	 												$("#total0").text(total);						
	 											}
	 											flist = [];
	 											
	 											if(j==0&&cnt==1&&i!=0){
	 												sum += parseInt($("#price"+i).text())
	 												flist.push(sum)
	 												$("#no"+(i-j)).attr('class','start');
	 												$("#id"+(i-j)).attr('class','start');
	 												$("#id0").attr('class','start');
	 												$("#status"+(i-j)).attr('class','start');
	 												$("#status0").attr('class','start');
	 												$("#total"+(i-j)).attr('class','start');
	 												$("#total0").attr('class','start');
	 												$("#total"+(i-j)).text(flist[0]);
	 												$("#total0").text(flist[0]);
	 												
	 											}
	 											flist = [];
	 											cnt=1;
	 											if(cnt=1){
	 												j=0;
	 											}
	 										}
	 								}
	 						})
	 					}
	 					$("#totalsection").attr('class','desc');		
	 				}
	 		
	 			})
	 		}
	 	}
	})