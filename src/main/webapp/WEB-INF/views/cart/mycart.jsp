<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="num" value="1"/>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
function cartchk(){
	if(!$('#orderchk1').is(':checked')){
		alert('주문할 상품을 골라주세요!')
	}else{
		alert('주문페이지로 이동합니다')
		location.href='${contextPath}/order/cartorder';
	}
}

$(document).ready(function(){
	$("#orderchk1").on("change keyup paste input",function(){
		if($('#orderchk1').is(':checked')){
			$("#productStack1").on("change keyup paste input",function(){
				const stack1 = $(this).val();
				const price1 = $("tr:eq(1)>td:eq(3)").html();	
				sum1 = price1*stack1
				$("#price1").text(sum1);
				$("#product1").val(sum1);
			});
		}else{
			const nonchkstack = $("#productStack1").val();
			const nonchkprice = $("tr:eq(1)>td:eq(3)").html();
			nonchksum1 = nonchkstack*nonchkprice
			$("#orderchk1").prop('readonly', true);
			$("#price1").text(nonchksum1);
			$("#product1").val(0);
		}
	});

	$("#orderchk2").on("change keyup paste input",function(){
		if($('#orderchk2').is(':checked')){
			$("#productStack2").on("change keyup paste input",function(){
				const stack2 = $(this).val();
				const price2 = $("tr:eq(2)>td:eq(3)").html();	
				sum2 = price2*stack2	
				$("#price2").text(sum2);
				$("#product2").val(sum2);
			});
		}else{
			const nonchkstack = $("#productStack2").val();
			const nonchkprice = $("tr:eq(2)>td:eq(3)").html();
			nonchksum2 = nonchkstack*nonchkprice
			$("#orderchk2").prop('readonly', true);
			$("#price2").text(nonchksum2);
			$("#product2").val(0);
		}
	});	

	$("#orderchk3").on("change keyup paste input",function(){
		if($('#orderchk3').is(':checked')){
			$("#productStack3").on("change keyup paste input",function(){
				const stack3 = $(this).val();
				const price3 = $("tr:eq(3)>td:eq(3)").html();	
				sum3 = price3*stack3	
				$("#price3").text(sum3);
				$("#product3").val(sum3);
			});
		}else{
			const nonchkstack = $("#productStack2").val();
			const nonchkprice = $("tr:eq(2)>td:eq(3)").html();
			nonchksum3 = nonchkstack*nonchkprice
			$("#orderchk3").prop('readonly', true);
			$("#price3").text(nonchksum3);
			$("#product3").val(0);			
		}
	});	
});


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
					alert('ok')
				},
				error:function(){
					alert('no')
				}
			})
		}else{
			alert('삭제가 취소되었습니다.')
		}
});

	var cartlist = new Array();        
$(document).on('click','.chkdel',function(){                     
	var rowData = new Array();         
	var checkbox = $("input[name=orderChkbox]:checked");
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
					console.log(cartlist);
				},
				error:function(data){
					console.log(cartlist);			
				}
			})
		}else{
			alert('삭제가 취소되었습니다.')
		}          		
	  
});



</script>
</head>
<body>

	<div align="center">
		<form action="${contextPath}/order/cartorder" method="post">
			<table id="cartTable" border="1">
				<tr>
					<th>전체 선택<br><input type='checkbox' name='orderAllCheck' id="orderAllCheck" onclick='checkAll()'/></th><th>상품번호</th><th>상품이미지</th><th>상품명</th><th>상품가격</th><th>구매수량</th><th></th>
				</tr>
				<c:if test="${cart.size()==0 }">
					<tr>
						<td colspan="7">등록된 장바구니가 없습니다</td>
					</tr>
				</c:if>
				<c:if test="${cart.size()!=0 }">
					<c:forEach var="cart" items="${cart }" varStatus="status">					
					<tr>
						<th><input type="checkbox" name='orderChkbox' id="orderchk" value="${cart.cartNum }">
							<input type="hidden" name="cartNum${status.index }" id="cartNum${status.index}" value="${cart.cartNum }">
						</th>
						<td id="productnotd${status.count }">${cart.productNo }</td>
						<th>
							<c:if test="${ cart.productFile == 'nan' }">
								<b>등록된 이미지가 없습니다.</b>
							</c:if>
							<c:if test="${ cart.productFile != 'nan' }">
								<img width="100px" height="100px" src="${contextPath}/product/download?productFile=${cart.productFile}">
							</c:if>
						</th>
						<th>${cart.productName }</th>
						<th>${cart.productPrice }</th>
						<th>
							<input type="number" min="0" max="10" name="productStack" id="productStack${status.count }" placeholder="0"><br>
							<span id="price${status.count }">0</span>원
						</th>
						<th><button type="button" class="deletebtn">삭제</button></th>
						</tr>
					</c:forEach>
				</c:if>
			</table>
			<button type="button" class="chkdel">선택 삭제</button> <button type="button" class="alldel">전체 삭제</button>
			<hr>
				총 금액 <span id="orderPrice">0</span>원<br>
				<button type="button" onclick="cartchk()">결제하기</button>
		</form>
	</div>	
</body>
</html>