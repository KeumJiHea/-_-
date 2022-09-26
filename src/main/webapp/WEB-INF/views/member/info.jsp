<%@page import="com.kg.seeot.member.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="<c:url value='/resources/css/members.css'/>"rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/daum_post.js"></script>
</head>
<body>


<script>
    jQuery( document ).ready( function ( $ ) {
        var wrapper = $( '.members-wrapper.myaccount' );
        var navigation = $( '.navigation', wrapper );

        $( '.myaccount-title', wrapper ).on( 'click', function() {
            $( 'li', navigation ).removeClass('active');
            $( '.contents', wrapper ).removeClass('active');
            $( '.main', wrapper ).addClass('active');
        } )

        $( 'li', navigation ).on( 'click', function() {
            var activeTab = $(this).find("a").attr("href");

            $( 'li', navigation ).removeClass('active');
            $(this).addClass('active');

            $( '.contents', wrapper ).removeClass('active');
            $( activeTab, wrapper ).addClass('active');

        } );

    } );
  
</script>

<script type="text/javascript">
window.onload = function(){
	var phoneList    = "${info.phone}";
	var Phone		 = phoneList.split("-");
	var emailList    = "${info.email}";
	var Email        = emailList.split("@");
	
	if ( 0 != phoneList.length ) {
		document.getElementById('phone0').value = Phone[0];
		document.getElementById('phone1').value = Phone[1];
		document.getElementById('phone2').value = Phone[2];
	}
	
	if ( 0 != emailList.length ) {
		document.getElementById('email1').value = Email[0];
		document.getElementById('email2').value = Email[1];
	}
	
}
</script>

<script type="text/javascript">

//필수 입력 체크

function modiChk(){
	
	var form = document.form;
	var pw = $('.pw_input').val();
	var pwchk = $('.pw_confirm').val();
	var pwRegex =  /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	var passWordTest = pwRegex.test($('.pw_input').val());
	
	if(pw == ""){
		alert('비밀번호 입력은 필수입니다');
		form.pw.focus();
		return;
	}
	else if(pwchk == ""){
		alert('비밀번호 확인은 필수입니다');
		form.pwchk.focus();
		return;
	}
	else if(pw != pwchk){
		alert('비밀번호가 일치하지 않습니다');
		form.pwchk.focus();
		return;
	}
	else if(!passWordTest){
		alert('비밀번호는 8~16 영문자 숫자, 특수문자 포함하여 입력해주세요');
		form.pw.value = "";
		form.pwchk.value = "";
		form.pw.focus();
		return;
	}
	else{
	form.method="post";
	form.action="<%=request.getContextPath()%>/member/modify";
	form.submit();
	}
}

function delete_chk(){
	var form = document.delete_fo;
	var pw = $('.delete_input_pw').val();
	
	form.method = "post";
	form.action = "<%=request.getContextPath()%>/member/member_delete";
	form.submit();
}
</script> 

<div class="members-wrapper myaccount">
    <h1 class="myaccount-title">마이페이지</h1>
    <div class="navigation">
        <ul>
            <li class=""><a href="#orders">주문 내역</a></li>
            <li class=""><a href="#profile">회원 정보</a></li>
            <li class=""><a href="#address">주소 관리</a></li>
            <li class=""><a href="#review">나의 후기</a></li>
            <li class=""><a href="#delete">회원 탈퇴</a></li>
        </ul>
    </div>

    <!-- 메인 -->
    <div class="contents main active" id="main">
        <div class="membership">
            <div class="left">
                <div class="membership-info">
                    <strong>${info.name}</strong> 고객님 환영합니다<br>
                    <strong>[VIP 회원]</strong>
                </div>
                <div class="membership-contents">
                    <span></span>
                    <a href="">많은 상품 보러가기</a>
                </div>
            </div>
            <div class="right">
                <div class="point">
                    <div class="icon"><img src="<c:url value='/resources/images/navigation/point.png'/>" width="40px"></div>
                    <a href="#" style="color: white;">문의 하기</a>
                </div>
                <div class="coupon">
                    <div class="icon"><img src="<c:url value='/resources/images/navigation/review.png'/>" width="40px"></div>
                    <a href="#" style="color: white;">나의 후기</a>
                </div>
            </div>
        </div>

        <div class="contents-item columns">
            <div class="column">
                <h3 class="item-title">메뉴 바로가기</h3>
                <div class="menu-wrapper">
                    <a href="#orders">
                        <div class="menu">
                            <div class="icon"><img src="<c:url value='/resources/images/navigation/shipped.png'/>" width="50px"></div>
                            주문 배송
                        </div>
                    </a>
                    <a href="#profile" class="infotab">
                        <div class="menu">
                            <div class="icon"><img src="<c:url value='/resources/images/navigation/profile.png'/>" width="50px"></div>
                            회원 정보
                        </div>
                    </a>
                    <a href="#address">
                        <div class="menu">
                            <div class="icon"><img src="<c:url value='/resources/images/navigation/address.png'/>" width="50px"></div>
                            주소 관리
                        </div>
                    </a>
                </div>
            </div>
            <div class="column">
                <h3 class="item-title">문의 내역</h3>
                <div class="message">문의하신 내역이 없습니다.</div>
            </div>
        </div>

        <div class="contents-item">
            <h3 class="item-title">최근 주문 내역</h3>
            <table class="order-table">
                <thead>
                    <tr>
                        <th class="date">주문일자</th>
                        <th class="product-title">상품명</th>
                        <th class="price">결제금액</th>
                        <th class="action">후기작성</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>2022.09.03</td>
                        <td>엑스프리즈마 알파 패디드 크롭탑 썬더네이비</td>
                        <td>17,000원</td>
                        <td><a href="">작성</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 주문 내역 -->
    <div class="contents orders" id="orders">
        <div class="contents-item">
            <h3 class="item-title">주문 내역</h3>
            <table class="order-table">
                <thead>
                    <tr>
                        <th class="date">주문일자</th>
                        <th class="product-title">상품명</th>
                        <th class="price">결제금액</th>
                        <th class="action">후기작성</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>2022.09.03</td>
                        <td>엑스프리즈마 알파 패디드 크롭탑 썬더네이비</td>
                        <td>17,000원</td>
                        <td><a href="">작성</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 회원 정보 -->
    <div class="contents profile" id="profile">
        <form class="columns" name="form" method="post" action="<%=request.getContextPath()%>/member/modify">
            <div class="column">
              	 <div class="field input_name">
                    <span>이름</span>
                    <input type="text" name="name" value="${info.name}">
                </div>
                <div class="field input_id">
                    <span>아이디</span>
                    <input type="text" name="id" value="${info.id}" readonly>
                </div>
                <div class="field input_birth">
                    <span>생년월일</span>
                    <input type="text" name="birth" placeholder="ex)2000.01.01" value="${info.birth}">
                </div>
                <div class="field input_phone">
                    <span>전화번호</span>
                    <input type="text" name="phone1" maxlength="3" id="phone0">  
                    <input type="text" name="phone2" maxlength="4" id="phone1">
                    <input type="text" name="phone3" maxlength="4" id="phone2">
                </div>
                <div class="field input_email">
                    <span>이메일</span>
                    <input type="text" name="email1" placeholder="이메일 주소 입력" id="email1">
                    @
                    <input type="text" name="email2" id="email2">
                    <select name="domain">
                        <option value="naver.com" selected>naver.com</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="daum.net">daum.net</option>
                        <option value="nate.com">nate.com</option>
                        <option value="kakao.com">kakao.com</option>
                        <option value="1" selected>직접입력</option>
                    </select>
                </div>
            </div>
            <div class="column">
                <div class="field input_pw">
                    <span>비밀번호 변경</span>
                    <span style="color:#888;">회원 정보 수정시 비밀번호는 필수 입력 사항입니다.</span><br>
                    <input type="password" name="pw" placeholder="최소 8자 최대 16자 영문자 숫자, 특수문자 포함" class="pw_input">
                    <div class="passwordchk-message"></div>
                    <input type="password" placeholder="비밀번호 확인" name="pwchk" id="confirm_pw" class="pw_confirm">
                    <div class="password-message"></div>
                </div>
                <div>
            	  	 <button type="button" class="button" onclick="modiChk()">회원정보 수정</button>
                </div>
            </div>
        </form>
    </div>

    <!-- 주소 관리 -->
    <div class="contents address" id="address">
        <form action="<%=request.getContextPath()%>/member/edit_addr" method="post" class="columns">
            <div class="column">
                <div class="field input_addr">
                    <span>기본 주소</span>
                    <div class="address">
                       ${info.name }<br>
                       ${info.addr1}&nbsp;${info.addr2}&nbsp;${info.addr3}
                    </div>
                </div>
            </div>
            <div class="column">
                <div class="field input_addr">
                <input type="hidden" value="${info.id}" name="id">
                    <span>배송지 변경</span>
                    <input type="text" readonly id="addr1" name="addr1" placeholder="우편번호">
                    <button type="button" onclick="daumPost()">주소 검색</button>
                    <input type="text" readonly id="addr2" name="addr2" placeholder="주소">
                    <input type="text" id="addr3" name="addr3" placeholder="상세주소">
                </div>
                <div>
                    <input type="submit" class="button" value="주소 변경">
                </div>
            </div>
        </form>
    </div>

    <!-- 나의 후기 -->
    <div class="contents review" id="review">
    	리뷰
    </div>

    <!-- 회원 탈퇴 -->
    <div class="contents delete" id="delete">
    	<div class="field input_pw">
    		<form name="delete_fo">
    			<input type="hidden" name="id" value="${info.id}">
    			<span class="delete_span">비밀번호를 입력해주세요</span>
    			<input type="password" name="pw" class="delete_input_pw">
    			<button type="button" class="delete_button" onclick="delete_chk()" style="cursor: pointer;">회원 탈퇴하기</button>
    		</form>
    	</div>
    </div>

</div>

</body>
</html>