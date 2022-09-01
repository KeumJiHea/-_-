<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style type="text/css">
a {
   font-size: 18px; color: gray; text-decoration: none;
}
</style>
</head>
<body>
<h1>마이페이지</h1>

<form action="modify_form">
<div class="fst_line">
<a href="#">주문목록</a> <a></a> <a></a> <a href="#">회원정보</a>
</div>
<div class="sec_line">
<a href="#">찜리스트</a> <a></a> <a></a> <a href="modify_form">정보수정</a>
</div>
<div class="trd_line">
<a href="#">장바구니</a> <a></a> <a></a> <a href="#">회원탈퇴</a>
</div>
<hr>
<p>
<input class="id_info" id="id" name="id" readonly placeholder="${info.id }"
style="border: none;">
님 환영합니다
</p>
<hr>
</form>

</body>
</html>