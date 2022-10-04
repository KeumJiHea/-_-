	$(document).on('click','.cancelbtn',function(){
		var cancelbtn = $(this);
		var m = cancelbtn.parent().parent();
		var memberId = m.children().eq(1).text();
		var orderNo = m.children().eq(0).text();
		var cost = m.children().eq(5).text();
		var url = "ordercancel?orderNo="+orderNo+"&memberId="+memberId+"&cost="+cost;
		var name = "test";
		var option = "width = 400, height = 400, top = 100, left = 200, location = no"
		
				
		$.ajax({
			url : url,
			type : "get",
			contentType : "application/json; charset=utf-8",
			data : {
			memberId : memberId,
			orderNo : orderNo,
			cost : cost
			}
			}).done(function(){
				window.open(url,name,option);
			}).fail(function(data){
				alert('실패'+data)
			});
		})

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
						console.log(sum)
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
						$("#no"+(i-j)).attr('rowspan',cnt);						
					}
					pricelist = [];
					
					if(j==0&&cnt==1&&i==0){
						sum += parseInt($("#price"+i).text())
						console.log(sum)
						pricelist.push(sum)
						console.log(pricelist[0]);
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
						
					}else if(j==0&&cnt==1&&i!=0){
						sum += parseInt($("#price"+i).text())
						console.log(sum)
						pricelist.push(sum)
						console.log(pricelist);
						$("#no"+(i-j)).attr('class','start');
						$("#no0").attr('class','start');
						$("#id"+(i-j)).attr('class','start');
						$("#id0").attr('class','start');
						$("#status"+(i-j)).attr('class','start');
						$("#status0").attr('class','start');
						$("#total"+(i-j)).attr('class','start');
						$("#total0").attr('class','start');
						$("#total"+(i-j)).text(pricelist[0]);
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