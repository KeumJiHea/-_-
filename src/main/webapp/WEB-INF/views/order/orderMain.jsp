<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 페이지</title>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
var IMP = window.IMP;
IMP.init("imp11462084"); // 예: imp00000000 

function requestPay() {
    IMP.request_pay({ 
        pg: "html5_inicis",
        pay_method: "card",
        merchant_uid: "ORD20180131-0000017",   //주문번호
        name: "테스트물품7",
        amount: 1000,                         // 숫자타입
        buyer_email: "gildong@gmail.com",
        buyer_name: "고길동",
        buyer_tel: "010-4242-4242",
        buyer_addr: "서울특별시 종로구 단성사",
        buyer_postcode: "01181"
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
</script>
</head>
<body>
	<button type="button" onclick="requestPay()">결제하기</button>
</body>
</html>