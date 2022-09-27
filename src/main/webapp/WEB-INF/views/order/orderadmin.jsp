<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#tbody th:not(.start){
		display: none;
	}
	#modal_wrap{position: fixed; z-index: 9;margin: auto; display:none;
	 top:0; left: 0; right: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.4)
	}
	#first{position: fixed; z-index: 10;margin: auto; display:none;
	 top:30px; left: 0; right: 0; width: 350px; height: 450px; background-color: white;
	}
	#ordersection :hover {cursor: pointer;}
	#totalsection :hover {cursor: pointer;}
	#idsection :hover {cursor: pointer;}
</style>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

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
						$("#id"+(i-j)).attr('rowspan',cnt);
						$("#id"+(i-j)).attr('class','start');	
						$("#status"+(i-j)).attr('rowspan',cnt);
						$("#status"+(i-j)).attr('class','start');
						$("#total"+(i-j)).attr('rowspan',cnt);
						$("#total"+(i-j)).attr('class','start');
						$("#total"+(i-j)).text(total);						
					}
					pricelist = [];
					
					if(j==0&&cnt==1&&i!=0){
						sum += parseInt($("#price"+i).text())
						pricelist.push(sum)
						$("#no"+(i-j)).attr('class','start');
						$("#id"+(i-j)).attr('class','start');
						$("#status"+(i-j)).attr('class','start');
						$("#total"+(i-j)).attr('class','start');
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
				url : "delevery",
				type : "POST",
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(form)
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
						
						console.log(list)
						console.log(list.orderNo)
						console.log(typeof list)
						
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
								else if($("#no"+i).text()!=$("#no"+(i+1)).text()){	
										if(j!=0){						
											sum += parseInt($("#price"+i).text())
											plist.push(sum)
											var total = plist.reduce(function(a,b){ return a+b;},0);
											$("#no"+(i-j)).attr('rowspan',cnt);
											$("#no"+(i-j)).attr('class','start');	
											$("#id"+(i-j)).attr('rowspan',cnt);
											$("#id"+(i-j)).attr('class','start');	
											$("#status"+(i-j)).attr('rowspan',cnt);
											$("#status"+(i-j)).attr('class','start');
											$("#total"+(i-j)).attr('rowspan',cnt);
											$("#total"+(i-j)).attr('class','start');
											$("#total"+(i-j)).text(total);						
										}
										plist = [];
										
										if(j==0&&cnt==1&&i!=0){
											sum += parseInt($("#price"+i).text())
											plist.push(sum)
											$("#no"+(i-j)).attr('class','start');
											$("#id"+(i-j)).attr('class','start');
											$("#status"+(i-j)).attr('class','start');
											$("#total"+(i-j)).attr('class','start');
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
	
	
	$("#ordersection").attr('class','desc');
 	$(document).on('click','#ordersection',function(){
 		if($("#ordersection").attr('class')=='desc'){
 			$.ajax({
 				url:'sorting',
 				type:"post",
 				data:{sort:1},
 				success : function(desclist){
 					//테이블 초기화
 					$('#tbody').empty();
 					if(desclist.length>=1){
 						
 						desclist.forEach(function(desclist,index){
 							
 							console.log(desclist)
 							console.log(desclist.orderNo)
 							console.log(typeof desclist)
 							
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
 											}
 											alist = [];
 											
 											if(j==0&&cnt==1&&i!=0){
 												sum += parseInt($("#price"+i).text())
 												alist.push(sum)
 												$("#no"+(i-j)).attr('class','start');
 												$("#id"+(i-j)).attr('class','start');
 												$("#status"+(i-j)).attr('class','start');
 												$("#total"+(i-j)).attr('class','start');
 												$("#total0").attr('class','start');
 												$("#total"+(i-j)).text(alist[0]);
 												
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
 							
 							console.log(asclist)
 							console.log(asclist.orderNo)
 							console.log(typeof asclist)
 							
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
 												$("#status"+(i-j)).attr('rowspan',cnt);
 												$("#status"+(i-j)).attr('class','start');
 												$("#total"+(i-j)).attr('rowspan',cnt);
 												$("#total"+(i-j)).attr('class','start');
 												$("#total"+(i-j)).text(total);						
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
	}) 
	
</script>
</head>
<body>
	<div id="modal_wrap">
	<div id="first">
		<div style="width: 250px; margin: auto; padding-top: 20px;">
			<form>
				아이디 : <input type="text" name="memberId" id="memberId" value="${cdto.memberId }" readonly="readonly"><br>
				주문번호 : <input type="text" name="orderNo" id="orderNo" value="${cdto.orderNo }" readonly="readonly"><br>
				<b>취소 사유</b><br>
				<textarea rows="5" cols="30" name="reason" id="reason" readonly="readonly">${cdto.reason }</textarea>
				<hr>
				<button type="button" class="cancelOk">주문취소 승인</button>
				<button type="button" class="cancelNone">주문취소 거절</button>
				<button type="button" onclick="slide_hide()">접기</button>
			</form>
		</div>
	</div>
</div>
	<h2>현재 접속자 : ${sessionScope.loginUser }</h2>
	<form id="searchform">
		<select name="type"><option value="orderNo">주문번호</option><option value="memberId">아이디</option></select><input type="text" name="keyword"><button type="button" onclick="getSearchList()">검색</button>
	</form>
	<table border="1">
		<tr>
			<td id="ordersection">주문번호<img src="http://localhost:8085/seeot/images/sortingarrow.png" width="13px;" height=13px;"></td><td id="idsection" class="desc">아이디<img src="http://localhost:8085/seeot/images/sortingarrow.png" width="13px;" height=13px;"></td><td>주문상품/옵션</td><td>구매수량</td><td>가격</td><td id="totalsection" class="desc">총 주문 금액<img src="http://localhost:8085/seeot/images/sortingarrow.png" width="13px;" height=13px;"></td><td class="status">주문상태</td>
		</tr>
		<tbody id="tbody">
			<c:forEach var="odto" items="${list }" varStatus="status">				
				<tr>
					<th id="no${status.index }">${odto.orderNo }</th>
					<th id="id${status.index }">${odto.memberId }</th>
					<td> <img width="30px" height="30px" src="${odto.productFile}">${odto.productName } / ${odto.productColor } ${odto.productSize }</td>
					<td>${odto.orderStack }</td>
					<td id="price${status.index }">${odto.productPrice }</td>
					<th id="total${status.index }">1</th>
					<th id="status${status.index }">
						<c:if test="${odto.orderStatus == 1}">결제완료<br><button type="button" class="delevery">배송 시작</button></c:if>
						<c:if test="${odto.orderStatus == 0}">취소중<br><button type="button" onclick="slideClick()">취소 사유</button></c:if>
						<c:if test="${odto.orderStatus == -1}">취소완료</c:if>
						<c:if test="${odto.orderStatus == 2}">배송중<br><button type="button" class="endDelevery">배송 완료</button></c:if>
						<c:if test="${odto.orderStatus == 3}">배송완료</c:if></th>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>