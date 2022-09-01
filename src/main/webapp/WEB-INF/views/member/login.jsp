<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);
* { 
 font-family: 'Noto Sans KR', sans-serif;
}
.login {
   text-align: center;
}
#username {
   width: 300px;
   height: 40px;
   border: none;
   border-bottom: 1px solid black;
}
#password {
   width: 300px;
   height: 40px;
   border: none;
   border-bottom: 1px solid black;
}
input:focus {
   border-bottom: solid black;
   outline: none;
}
a {
   text-decoration :none;
   color: gray;
}
input:placeholder {
   font-size: 20px;
}
</style>

</head>
<body>
<header>

</header>

        <h1 style="font-size: 50px; text-align: center;">Login</h1>
        <div class="login">
		<form name="fo" action="<%=request.getContextPath()%>/member/login_check" method="post">
		  <div class="input-box">
			<input id="username" type="text" name="id" placeholder="아이디"><br>
			<input id="password" type="password" name="pw" placeholder="비밀번호">
		  </div>
		  <input type="checkbox" name="autoLogin">로그인 상태 유지 
		  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br> <br>
		  <button type="button" onclick="loginChk()" style="width: 300px; height: 40px; background-color: black; color: white; cursor: pointer; font-size: 18px;">
		      로그인</button>
		  </form>		
			<br>
			<a href="find_form">ID/PW찾기</a>&nbsp;&nbsp; / &nbsp;&nbsp;<a href="register_form">회원가입</a>
		  </div>
		<script type="text/javascript">
		function loginChk() {
		    var form = document.fo;
		    if (!form.id.value) {
		        alert("아이디를 입력해주세요.");
		        form.id.focus();
		        return;
		    }
		 
		    if (!form.pw.value) {
		        alert("비밀번호를 입력해주세요.");
		        form.pw.focus();
		        return;
		    }
		    form.action = "<%=request.getContextPath()%>/member/login_check";
		    form.submit();
		}
		</script>
		
<footer>

</footer>
</body>
</html>













