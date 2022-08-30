<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 페이지</title>
<!-- jQuery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
var IMP = window.IMP;
IMP.init("imp11462084"); // 예: imp00000000 

function requestPay() {
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
        name: '${pdto.productName}',
        amount: "1000",                         // '${pdto.productPrice}'숫자타입
        buyer_email: "users@seeot.com",
        buyer_name: "사용자",
        buyer_tel: "010-1111-2222",
        buyer_addr: "시"+"옷"+"프로젝트",
        buyer_postcode: "우편번호"
    }, function (rsp) { // callback
    	if ( rsp.success ) {
    		 // jQuery로 HTTP 요청
            jQuery.ajax({
                url: "orderchk", 
                method: "POST",
                headers: { "Content-Type": "application/json" },
                data: {
                    imp_uid: rsp.imp_uid,            //결제 고유번호     
                    merchant_uid: rsp.merchant_uid , //주문번호
                    name : rsp.name, 		//제품명
                    amount : rsp.paid_amount, 	// 가격
                    buyer_name : rsp.buyer_name, // 구매자
                    buyer_addr : rsp.buyer_addr 	// 구매자주소
                }
            }).done(function (data) {
            	console.log(rsp)
              alert('결제성공!! 주문번호 : '+rsp.merchant_uid+' 제품명 : '+rsp.name+' 가격 : '+rsp.paid_amount+' 구매자 : '+rsp.buyer_name+' 주소 : '+rsp.buyer_addr )
            })
        } else {
        	alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
        }
    });
   
  }
function checkAll() {
	if($("#orderAllCheck").is(':checked')) {
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

		if(total != checked) $("#orderAllCheck").prop("checked", false);
		else $("#orderAllCheck").prop("checked", true); 
	});
});


$("#testOnchange").on("propertychange change keyup paste input",function(){
	alert("changed!");
});



</script>
</head>
<body>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
	<div>
		<form action="#" method="post">
			<input type="hidden" name="productPrice" id ="productPrice" value="${pdto.productPrice }">
			<table border="1">
				<tr>
					<th><input type='checkbox' name='orderAllCheck' id="orderAllCheck" onclick='checkAll()'/><br>전체 선택</th><th>상품번호</th><th>상품이미지</th><th>상품명</th><th>상품가격</th><th>구매수량</th>
				</tr>
				<tr>
					<th><input type="checkbox" name='orderChkbox' id="orderchk1"></th><td>${pdto.productNo }</td>
					<td>
						<c:if test="${ pdto.productFile == 'nan' }">
							<b>등록된 이미지가 없습니다.</b>
						</c:if>
						<c:if test="${ pdto.productFile != 'nan' }">
							<img width="100px" height="100px" src="${contextPath}/product/download?productFile=${pdto.productFile}">
						</c:if>
				</td><td>${pdto.productName }</td><td>${pdto.productPrice }</td><td><input type=button value="▼" onClick="javascript:this.form.productStack.value--;">
				<input type="text" name="productStack" id="productStack" placeholder="1">
				<input type=button value="▲" onClick="javascript:this.form.productStack.value++;"></td>
				</tr>
			</table>
				<hr>
				총 금액 <span id="orderPrice"></span><br>
				<button type="button" onclick="requestPay()">결제하기</button>
				<input id="testOnchange" type="text" value="안녕하세요.">
		</form>
	</div>
</body>
</html>