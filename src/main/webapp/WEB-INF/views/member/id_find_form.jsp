<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

</head>
<body>

<form name="form">
	<div class="field input_email">
		<h3>이메일 본인확인</h3>
			<span class="span">이름</span>
			<input type="text" class="name" name="name"><br>
			<span class="span">이메일</span>
			<input type="text" class="email1" name="email1">@<input type="text" class="email2" name="email2" ><br>
				<input type="text" disabled class="input_mail_check" style="width: 300px; margin-top: 12px; background-color: white;" maxlength="6" placeholder="인증번호 입력"><br>
				<input type="button" class="btn_mail_check" style="margin-top: 15px; cursor: pointer; border: 1px solid #888; background-color: white;" value="인증번호 전송">
				<input type="button" class="btn_mail_check2" style="display:none; margin-top: 15px; border: 1px solid #888; background-color: white; cursor: pointer;" value="인증번호 확인">
			<div class="mail-message message"></div>
	</div>
	<br><button type="button" class="sub_btn" onclick="chk()">ID찾기</button><br>
	<div class="id_find_message"></div>
</form>
	<a href="pw_find_form"><button type="button">PW찾기</button></a><a href="login"><button type="button">취소</button></a>

<script type="text/javascript">
	       //이메일 인증번호 확인
	       var code = "973";
	       
	       $('.btn_mail_check').click(function(){
	    	   var email1 = $('.email1').val()+"@";
	    	   var check = $('.email1').val();
	    	   var domain = $('.email2').val();
	    	   var email  = email1 + domain ;
	    	   var inputChk = $('.input_mail_check');
	    	   var btnChk = $('.btn_mail_check');
	    	   var btnChk2 = $('.btn_mail_check2');
	    	   if(check != "" && domain != ""){ 
	    	   $.ajax({
	    		   type : "GET",
	    	       url : "mailCheck?email="+email,
	    	       success:function(data){
	    	    	   inputChk.attr("disabled",false);
	    	    	   inputChk.focus();
	    	    	   alert("인증번호가 전송되었습니다");
	    	    	   btnChk.attr("value","인증번호 재전송");
	    	    	   btnChk2.attr("style","display:inline; background-color:white; cursor:pointer; border:1px solid #888;");
	    	    	   code = data;
	    	       }
	    	   
	    	     });
	    	   }
	    	   else{
	    		   alert("이메일을 입력해주세요");
	    	   }
	       });
	       
    	   $('.btn_mail_check2').click(function(){
    		   var inputCode = $('.input_mail_check').val();
	    	   
	    	   if(inputCode == code){
	    		   alert("인증번호가 확인되었습니다");
	    	   }
	    	   else{
	    		   alert("인증번호가 일치하지 않습니다");
	    	   }
	    	   
	       });
	</script>
	<script type="text/javascript">
		function chk(){
			var form = document.form;
			var inputCode = $('.input_mail_check').val();
			var name = $('.name').val();
			var email1 = $('.email1').val();
			var email2 = $('.email2').val();
			var email = email1+"@"+email2;
			
			console.log("이름 : " + name);
			console.log("이메일 : " + email);
			
	    	   if(inputCode != code){
	    		   alert("인증번호가 일치하지 않습니다");
	    	   }
	    	   else{
	    		   $.ajax({
	    			   type : "POST",
	    			   url : "id_find",
	    			   data : {"name":name , "email":email},
	    			   success:function(data){
	    				   if(data == 0){
	    					   $('.id_find_message').css('color','red');
	    					   $('.id_find_message').html('회원 정보를 확인해주세요');
	    				   }else{
	    					   $('.id_find_message').css('color','black');
	    					   $('.id_find_message').html('회원님의 아이디는 '+data+"입니다");
	    				   }
	    			   },
	    			   error:function(){
	    				   alert("에러입니다");
	    			   }
	    			   
	    		   });
	    	   }
		}
	</script>
</body>
</html>