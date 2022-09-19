<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
var IMP = window.IMP;
IMP.init("imp11462084"); // 예: imp00000000 
function cartchk(){
	if(!$("input:checkbox[name=orderChkbox]").is(':checked')){
		alert('주문할 상품을 골라주세요!')
	}else{
		if(($("#postcode").val()=="") || ($("#addr1").val()=="") || ($("#addr2").val()=="")){
			alert('주소는 필수사항입니다')
			$("#postcode").focus();
		}else{
			requestPay();
		}
	}
}
var total = 0;
var pricelist = new Array();
function change(){	
	var totallist = new Array();
	$("input:checkbox[name=orderChkbox]").each(function(i){
			$("#productStack"+i).on("change keyup paste input",function(){
				$("#productStack"+i).attr("value", $("#productStack"+i).val());
			});
		var stack = $("#productStack"+i).val();
		var price = $("#price"+i).html();
		sum =  price*stack;
		$("#goods_total_price"+i).text(sum);
		console.log('현재 i : '+i);
		console.log('현재 i 의 합 : '+sum);
		
		if ($("#orderchk"+i).is(":checked") == false){
			pricelist[i] = 0;
		}else{
			pricelist[i] = sum;					
		}						
		console.log('리스트 : '+pricelist)
		
		total =0;
		for(i =0; i<pricelist.length;i++){
			total+=pricelist[i]
		}
		console.log('총 가격 : '+total)
		$("#total_price").text(total);
	});
};
$(document).ready(function(){
	console.log('tbody길이 : '+$("#tbody tr").length)
	var first = 0
	for(i =0; i<$("#tbody tr").length;i++){		
		first+= parseInt($("#goods_total_price"+i).text());
		console.log('각 값'+$("#goods_total_price"+i).text())
	}
		$("#total_price").text(first);
})

function checkAll() {
	if($("#orderAllCheck").on("change")[0].checked) {
		$("input[name=orderChkbox]").prop("checked", true);
	} else {
		$("input[name=orderChkbox]").prop("checked", false);
	}
}

$(document).ready(function() {
	$("#orderAllCheck").click(function() {
		if($("#orderAllCheck").is(":checked")) $("input[name=orderChkbox]").prop("checked", true);
		else $("input[name=orderChkbox]").prop("checked", false);
	});

	$("input[name=orderChkbox]").click(function() {
		var total = $("input[name=orderChkbox]").length;
		var checked = $("input[name=orderChkbox]:checked").length;

		if(total != checked){
			$("#orderAllCheck").prop("checked", false);
		}
		else{ 
			$("#orderAllCheck").prop("checked", true); 
		}
	});
});
	 
    $(document).on('click',".deletebtn",function(){ 
	                       
		var str = ""            
		var tdArr = new Array();    // 배열 선언            
		var checkBtn = $(this);
		// checkBtn.parent() : checkBtn의 부모는 <td>이다.    
		// checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.    
		var tr = checkBtn.parent().parent();    
		var td = tr.children(); 

		// td.eq(index)를 통해 값을 가져올 수도 있다.    
		var no = td.eq(1).text();    
		console.log(no);
		if(confirm(td.eq(3).text()+' 상품을 장바구니에서 삭제 하시겠습니까?')){
			$.ajax({
				url: "cartdeleteOne?productNo="+no+"&memberId=${sessionScope.loginUser}",
				type:"get",
				data: no,
				contentType : "application/json; charset=utf-8",
				success: function(data){
					alert('삭제 되었습니다!'); 
					location.reload();
				},
				error:function(){
					alert('삭제에 실패했습니다!')
				}
			})
		}else{
			alert('삭제가 취소되었습니다.')
		}
});

	var cartlist = new Array();        
$(document).on('click','.chkdel',function(){                     
	    // 체크된 체크박스 값을 가져온다            
/* 		// checkbox.parent() : checkbox의 부모는 <td>이다.        
		// checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.        
		var tr = checkbox.parent().parent().eq(i);        
		var td = tr.children();                       
		// 체크된 row의 모든 값을 배열에 담는다.        
		rowData.push(tr.text());                        
		// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
		        
		var no = td.eq(1).text();  */     
		
		$("input:checkbox[name=orderChkbox]:checked").each(function(i) {
			var no = $(this).val();
			console.log(no)
			cartlist.push(no);
		});
/* 		for(i=1; i<=${cart.size()}; i++){	
				var no = $("input:checkbox[name='orderChkbox']:checked").val()                      
		// 가져온 값을 배열에 담는다.        
				
		} */
			
		                             
		if(confirm('선택된 상품을 장바구니에서 삭제하시겠습니까?')){
			$.ajax({
				url: "cartchkdel",
				type:"POST",
				traditional :true,
				data: {
					cartlist: cartlist,
					memberId : "${sessionScope.loginUser}"
				},
				success: function(data){
					alert('선택한 항목이 장바구니에서 삭제되었습니다!'); 
					location.reload();
				},
				error:function(data){
					console.log(cartlist);			
				}
			})
		}else{
			alert('삭제가 취소되었습니다.')
		}          		
	  
});
	
	function requestPay() {
		var namelist = new Array()
		var stacklist = new Array()
		var nolist = new Array()
		var filelist = new Array()
		var costlist = new Array()
		var colorlist = new Array()
		var sizelist = new Array()
 		$("input:checkbox[name=orderChkbox]:checked").each(function(i) {
			var pname = $("#pname"+i).text()
			var pstack = $("#productStack"+i).val()
			var pno = $("#productnotd"+i).text()
			var pfile =$("#file"+i).attr('src')
			var pcost = $("#goods_total_price"+i).text()
			var psize = $("#size"+i).text()
			var pcolor = $("#color"+i).text()
			namelist.push(pname)
			stacklist.push(pstack)
			nolist.push(pno)
			filelist.push(pfile)
			costlist.push(pcost)
			colorlist.push(pcolor)
			sizelist.push(psize)
		}); 
			console.log(namelist)
		var rand = ''
		for (let j = 0; j < 4; j++) {
			rand += Math.floor(Math.random() * 10)
		}
		var date = new Date();
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
	    var day = ("0" + date.getDate()).slice(-2);
	    var num = year+month+day+rand;
	    let pricet = ${pdto.productPrice }
    IMP.request_pay({ 
        pg: "html5_inicis",
        pay_method: "card",
        merchant_uid: num,   //주문번호
        name: namelist[0]+'외 '+(namelist.length-1)+'종',
        amount: 100, // $("#total_price").text()
        buyer_email: "${info.email}",
        buyer_name: "${info.name}",
        buyer_tel: "${info.phone}",
        buyer_addr: $("#addr1").val()+$("#addr2").val(),
        buyer_postcode: $("#postcode").val()
    }, function (rsp) { // callback
    	if ( rsp.success ) {
    		var form ={
    				gno : nolist,
    				glist : namelist,
    				gstack : stacklist,
    				gfile : filelist,
    				gcost : costlist,
    				gcolor : colorlist,
    				gsize : sizelist,
    				merchant_uid: rsp.merchant_uid , 
                    name : rsp.name, 		
                    amount : rsp.paid_amount, 	
                    buyer_name : rsp.buyer_name, 
                    buyer_addr : rsp.buyer_addr, 	
                    buyer_postcode: rsp.buyer_postcode }
    		 // jQuery로 HTTP 요청
            jQuery.ajax({
                url: "${contextPath}/order/orderchk", 
                method: "POST",
                contentType : "application/json; charset=utf-8",
                data:    
                	JSON.stringify(form)
                
            }).done(function (data) {
              location.href="${contextPath}/order/order";
            }).fail(function(request,status,error){
            	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n error : "+error)
            })
        }else{
        	alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg); 
        	
        }
    });
   
  }
function daumPost(){
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
           console.log(data.zonecode) 
           console.log(data.userSelectedType)           
           console.log(data.jibunAddress) 
           console.log(data.roadAddress)
           
           document.getElementById("postcode").value = data.zonecode
           if(data.userSelectedType== 'R'){
        	   var addr = data.roadAddress
           }else{
        	   var addr = data.jibunAddress        	   
           }
           document.getElementById("addr1").value = addr;
           document.getElementById("addr2").focus();
        }
    }).open();
}
function setaddr(){
	if($("input:checkbox[name=orderaddr]").is(":checked")){
		$("#postcode").val('${info.addr1}');
		$("#addr1").val('${info.addr2}');
		$("#addr2").val('${info.addr3}');
	}else{
		$("#postcode").val('');
		$("#addr1").val('');
		$("#addr2").val('');		
	}
}
</script>
</head>
<body>

	<div align="center">
		<form action="${contextPath}/order/cartorder" method="post">
			<table id="cartTable" border="1">
			<thead>
				<tr>
					<th>전체 선택<br><input type='checkbox' name='orderAllCheck' id="orderAllCheck" checked="checked" onchange="change()" onclick='checkAll()'/></th><th>상품번호</th><th>상품이미지</th><th>상품명</th><th>옵션</th><th>상품가격</th><th>구매수량</th><th></th>
				</tr>
				<c:if test="${cart.size()==0 }">
					<tr>
						<td colspan="7">등록된 장바구니가 없습니다</td>
					</tr>
				</c:if>
			</thead>
				<c:if test="${cart.size()!=0 }">
				<tbody id="tbody">
					<c:forEach var="cart" items="${cart }" varStatus="status">					
					<tr>
						<th><input type="checkbox" name='orderChkbox' id="orderchk${status.index }" onchange="change()" checked="checked" value="${cart.cartNum }">
							<input type="hidden" name="cartNum${status.index }" id="cartNum${status.index}" value="${cart.cartNum }">
						</th>
						<td id="productnotd${status.index }">${cart.productNo }</td>
						<th>
							<c:if test="${ cart.productFile == 'nan' }">
								<b>등록된 이미지가 없습니다.</b>
							</c:if>
							<c:if test="${ cart.productFile != 'nan' }">
								<img id="file${status.index }" width="100px" height="100px" src="${contextPath}/product/download?productFile=${cart.productFile}">
							</c:if>
						</th>
						<th id="pname${status.index }">${cart.productName }</th>
						<th><span id="color${status.index }">${cart.productColor }</span><br> 
							<span id="size${status.index }">${cart.productSize }</span>
						</th>
						<th id="price${status.index }">${cart.productPrice }</th>
						<th>
							<input type="number" min="1" max="10" name="productStack" id="productStack${status.index }" onchange="change()" value="${cart.productStack }" placeholder="${cart.productStack }"><br>
							<span id="goods_total_price${status.index }">${cart.productPrice*cart.productStack }</span>원
						</th>
						<th><button type="button" class="deletebtn">삭제</button></th>
						</tr>
					</c:forEach>
				</tbody>
				</c:if>
			</table>
			<button type="button" class="chkdel">선택 삭제</button> <button type="button" class="alldel">전체 삭제</button>
			<hr>
				총 금액<span id="total_price"></span>원<br>
			<hr>
				배송지 입력 (가입시 등록주소)<input type="checkbox" onchange="setaddr()" name="orderaddr" id="orderaddr"><br>
				<input type="text" onclick="daumPost()" id="postcode"><br>
				<input type="text" onclick="daumPost()" id="addr1"><br>
				<input type="text" onclick="daumPost()" id="addr2"><br>
				<button type="button" onclick="cartchk()">결제하기</button>
		</form>
	</div>	
	
	
</body>
</html>