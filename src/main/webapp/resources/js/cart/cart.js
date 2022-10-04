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
		
		total =0;
		for(i =0; i<pricelist.length;i++){
			total+=pricelist[i]
		}
		$("#total_price").text(total);
	});
};
$(document).ready(function(){
	var first = 0
	for(i =0; i<$("#tbody tr").length;i++){		
		first+= parseInt($("#goods_total_price"+i).text());
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
	                       
		var str = ""            
		var tdArr = new Array();    // 배열 선언            
		var checkBtn = $(this);
		var tr = checkBtn.parent().parent();    
		var td = tr.children();   
		var no = td.eq(1).text();
		var num = $(this).attr('id');
		console.log(num);
		if(confirm(td.eq(3).text()+' 상품을 장바구니에서 삭제 하시겠습니까?')){
			$.ajax({
				url: "cartdeleteOne?cartNum="+num+"&memberId="+$("#hiid").val(),
				type:"get",
				data: {cartNum:num},
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
	var cartlist = new Array();        
$(document).on('click','.chkdel',function(){                     
		$("input:checkbox[name=orderChkbox]:checked").each(function(i) {
			var no = $(this).val();
			cartlist.push(no);
		});			
		                             
		if(confirm('선택된 상품을 장바구니에서 삭제하시겠습니까?')){
			$.ajax({
				url: "cartchkdel",
				type:"POST",
				traditional :true,
				data: {
					cartlist: cartlist,
					memberId : $("#hiid").val()
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
	
	function alldel(){
		if(confirm('장바구니를 비우시겠습니까?')){
			$.ajax({
				url : "cartAlldel",
				type : "POST",
				data:{
					memberId : $("#hiid").val()
				},
				success: function(data){
					alert($("#hiid").val()+'님의 장바구니를 비웠습니다!');
					location.reload();
				},error:function(data){
					alert('장바구니를 비우는데 실패했습니다!\n잠시후에 시도해주세요.')
				}
			})
		}else{
			alert('취소했습니다.')
		}
	}
	
	
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
		var rand = ''
		for (let j = 0; j < 4; j++) {
			rand += Math.floor(Math.random() * 10)
		}
		var date = new Date();
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
	    var day = ("0" + date.getDate()).slice(-2);
	    var num = year+month+day+rand;
	    let pricet = $("#hiprize").val();
    IMP.request_pay({ 
        pg: "html5_inicis",
        pay_method: "card",
        merchant_uid: num,   //주문번호
        name: namelist[0]+'외 '+(namelist.length-1)+'종',
        amount: $("#total_price").text(),
        buyer_email: $("#hiemail").val(),
        buyer_name: $("#hiname").val(),
        buyer_tel: $("#hiphone").val(),
        buyer_addr: $("#hiaddr1").val()+$("#hiaddr2").val(),
        buyer_postcode: $("#hipostcode").val()
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
                url: $("#hipath").val()+"/order/orderchk", 
                method: "POST",
                contentType : "application/json; charset=utf-8",
                data:    
                	JSON.stringify(form)
                
            }).done(function (data) {
              location.href=$("#hipath").val()+"/order/order";
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