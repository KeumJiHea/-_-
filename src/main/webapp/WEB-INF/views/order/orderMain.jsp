<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 페이지</title>
<!-- jQuery -->
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
var IMP = window.IMP;
IMP.init("imp11462084"); // 예: imp00000000 
var tp = 0;
$(document).ready(function(){
	for(i=0;i<$("#tbody tr").length;i++){
		tp = $("#goods_total_price"+i).text();
		console.log(tp);
		$("#total_price").text(tp);	
	}
})

function order(){
	if(($("#postcode").val()=="") || ($("#addr1").val()=="") || ($("#addr2").val()=="")){
		alert('주소는 필수사항입니다')
		$("#postcode").focus();
	}else{
		requestPay();
	}
	
}

var total = 0;
var pricelist = new Array();
function change(){	
	var totallist = new Array();
	if($("#tbody tr").length>=1){
		for(i=0;i<$("#tbody tr").length;i++){
			$("#productStack"+i).on("change keyup paste input",function(){
				$("#productStack"+i).attr("value", $("#productStack"+i).val());
			});
		var stack = $("#productStack"+i).val();
		var price = $("#price"+i).html();
		sum =  price*stack;
		$("#goods_total_price"+i).text(sum);
		console.log('현재 i : '+i);
		console.log('현재 i 의 합 : '+sum);
		
		pricelist[i] = sum;											
		console.log('리스트 : '+pricelist)
		
		total =0;
		for(i =0; i<pricelist.length;i++){
			total+=pricelist[i]
		}
		console.log('총 가격 : '+total)
		$("#total_price").text(total);
			
		}
	}
	
};
function requestPay() {
	var namelist = new Array()
	var stacklist = new Array()
	var nolist = new Array()
	var filelist = new Array()
	var costlist = new Array()
	var colorlist = new Array()
	var sizelist = new Array()
	for(i=0;i<$("#tbody tr").length;i++){
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
	}
	
		var rand = ''
		for (let i = 0; i < 4; i++) {
			rand += Math.floor(Math.random() * 10)
		}
		var date = new Date();
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
	    var day = ("0" + date.getDate()).slice(-2);
	    var num = year+month+day+rand;
    IMP.request_pay({ 
        pg: "html5_inicis",
        pay_method: "card",
        merchant_uid: num,   //주문번호
        name: namelist[0],
        amount: $('#total_price').text(),
        buyer_email: "${info.email}",
        buyer_name: "${info.name}",
        buyer_tel: "{info.phone}",
        buyer_addr: $("#addr1").val()+$("#addr2").val(),
        buyer_postcode: $("#postcode").val()
    }, function (rsp) { // callback
    	if ( rsp.success ) {
    		var form = {
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
                    buyer_postcode: rsp.buyer_postcode
    		}
    		 // jQuery로 HTTP 요청
            jQuery.ajax({
                url: "${contextPath}/order/orderchk", 
                method: "POST",
                headers: { "Content-Type": "application/json" },
                data: JSON.stringify(form)
            }).done(function (data) {
            	console.log(rsp)
              alert('결제성공!! 주문번호 : '+rsp.merchant_uid+' 제품명 : '+rsp.name+' 가격 : '+rsp.paid_amount+' 구매자 : '+rsp.buyer_name+' 주소 : '+rsp.buyer_addr )
              location.href="${contextPath}/order/order";
            })
        } else {
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
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
	<div>
		<form action="#" method="post">
			<input type="hidden" name="productPrice" id ="productPrice" value="${pdto.productPrice }">
			<table id="orderTable" border="1">				
				<tr>
					<th>상품번호</th><th>상품이미지</th><th>상품명</th><th>옵션</th><th>상품가격</th><th>구매수량</th>
				</tr>
				<tbody id="tbody">
				<c:forEach var="pdto" items="${list }" varStatus="status">
					<tr>
						<td id="productnotd${status.index }">${pdto.productNo }</td>
					<td>
						<c:if test="${ pdto.productFile == 'nan' }">
							<b>등록된 이미지가 없습니다.</b>
						</c:if>
						<c:if test="${ pdto.productFile != 'nan' }">
							<img width="100px" height="100px" id="file${status.index }" src="${contextPath}/product/download?productFile=${pdto.productFile}">
						</c:if>
					</td>
					<td id="pname${status.index }">${pdto.productName }</td>
					<td><span id="color${status.index }">${pdto.productColor }</span>/<span id="size${status.index }">${pdto.productSize }</span></td>
					<td>
						<span id="price${status.index }">${pdto.productPrice }</span>						
					</td>
					<td>
						<input type="number" min="0" max="10" name="productStack" id="productStack${status.index }" placeholder="1" onchange="change()" value="${pdto.productStack }"><br>
						<span id="goods_total_price${status.index }">${pdto.productPrice*pdto.productStack }</span>원
					</td>
					</tr>
				</c:forEach>
				</tbody>	
			</table>
				<hr>
				총 금액 <span id="total_price">${pdto.productPrice*pdto.productStack }</span>원<br>
				<hr>
				배송지 입력 (가입시 등록주소)<input type="checkbox" onchange="setaddr()" name="orderaddr" id="orderaddr"><br>
				<input type="text" onclick="daumPost()" id="postcode"><br>
				<input type="text" onclick="daumPost()" id="addr1"><br>
				<input type="text" onclick="daumPost()" id="addr2"><br>
				<button type="button" onclick="order()">결제하기</button>
		</form>
	</div>
</body>
</html>