var IMP = window.IMP;
IMP.init("imp11462084"); // 예: imp00000000 
var p =0;
var tp = 0;
$(document).ready(function(){
	for(i=0;i<$("#tbody tr").length;i++){
		p = parseInt($("#goods_total_price"+i).text());
		tp+=p;
	}
		$("#total_price").text(tp);	
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
		
		pricelist[i] = sum;
		
		total =0;
		for(j =0; j<pricelist.length;j++){
			total+=pricelist[j]
		}
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
        buyer_email: $("#hiemail").val(),
        buyer_name: $("#hiname").val(),
        buyer_tel: $("#hiphone").val(),
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
                url: $("#hipath").val()+"/order/orderchk", 
                method: "POST",
                headers: { "Content-Type": "application/json" },
                data: JSON.stringify(form)
            }).done(function (data) {
            	console.log(rsp)
              alert('결제성공!! 주문번호 : '+rsp.merchant_uid+' 제품명 : '+rsp.name+' 가격 : '+rsp.paid_amount+' 구매자 : '+rsp.buyer_name+' 주소 : '+rsp.buyer_addr )
              location.href=$("#hipath").val()+"/order/order";
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
		$("#postcode").val($("#hipostcode").val());
		$("#addr1").val($("#hiaddr1").val());
		$("#addr2").val($("#hiaddr2").val());
	}else{
		$("#postcode").val('');
		$("#addr1").val('');
		$("#addr2").val('');		
	}
}