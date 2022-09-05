<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="<c:url value='/resources/css/members.css'/>" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="<%=request.getContextPath() %>/resources/js/daum_post.js"></script>
	<div class="members-wrapper register">
		<div class="user-login">
			<h2 class="title">회원가입</h2>
			<p class="text">
				간단한 정보 입력 후 가입해보세요.<br>
				<a href="login">로그인 페이지로 돌아가기</a>
			</p>
			<form action="register" method="post" name="form" class="columns">
				<div class="column">
					<div class="tag-title">필수 입력</div>
					<div class="field input_id required">
						<span>아이디</span> 
						<input class="id_input" type="text" name="id">
						<div class="id-message message"></div>
					</div>
					<div class="field input_pw required">
						<span>비밀번호</span>
						<input class="pw_input" type="password" name="pw" id="password" >
						<div class="passwordchk-message message"></div>
					</div>
					<div class="field input_pw2 required">
						<span>비밀번호 확인</span>
						<input class="pw_confirm" type="password" id="confirm_pw">
						<div class="password-message message"></div>
					</div>
					<div class="login-checkbox agreement">
						<input type="checkbox" id="agreement01" checked>
						<a href="#" class="required">쇼핑몰 이용약관에 동의합니다.</a>
					</div>
					<div class="login-checkbox agreement">
						<input type="checkbox" id="agreement02" checked>
						<a href="#" class="required">만 14세 이상입니다.</a>
						<ul>
							<li>만 14세 미만의 아동은 회원가입 시 법적대리인의 동의가 필요합니다.</li>
							<li>회원가입에 필요한 최소한의 정보만 입력 받음으로써 고객님의 개인정보 수집을 최소화하고 편리한 회원가입을 제공합니다.</li>
						</ul>
					</div>
					<div class="event-wrap">
						<div class="event-column">
							<img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGQ9Ik0yMi41MiAxMi45MzhjLTEuMDEgMi4xMDEtMi45MTEgMy42NzctNS40MjUgMy4zMDFsLS4wOTYgMS4yMjItMS4yMzktLjY0OS44OTQtLjc5MWMtLjI5My0uMjk3LTEuMTU2LS45NjItMS4zNy0yLjg3NSAxLjQzMS0xLjMxIDIuNTU1LTMuMzQ1IDIuNjg3LTUuOTEuOTYxLS40ODUgMi4wNTgtLjUwOSAzLjExLjA0MSAyLjI5NCAxLjIwMiAyLjM3NiAzLjcwOSAxLjQzOSA1LjY2MW0tMTAuMzIzLjg0bC42ODIuOTIzaC0xLjc4bC42NzktLjkxOGMtNC43My0xLjQwOC00Ljg0LTYuNjQ3LTQuODQtNy4xNTQgMC0yLjg2MyAxLjU1Ny01LjY5MSA1LjAzNC01LjY5MSAzLjQ3OCAwIDUuMDM0IDIuNzk2IDUuMDM0IDUuNjYgMCAuNDk1LS4xNzQgNS44NTUtNC44MDkgNy4xOG0tNC44NjggMi4yNDNsLjg5Mi43OTEtMS4yNC42NDktLjA5NS0xLjIyMmMtMi4yMi41MjUtNC40MzUtMS4yNC01LjQyNC0zLjMwMS0uOTM4LTEuOTUyLS44NTYtNC40NTkgMS40MzgtNS42NjEgMS4wMzctLjU0MyAyLjEyLS41MyAzLjA3Mi0uMDY2LjEyNSAyLjYyNCAxLjI2NyA0LjY4NSAyLjcyMSA1Ljk5MS0uMDUuNDA5LS4yNDUgMS45MjItMS4zNjQgMi44MTltMTQuMTY5LTkuNTQxYy0xLjE2OS0uNjExLTIuNDAxLS42NDEtMy41MTItLjIxMS0uMTk1LTMuNzEzLTIuNjEtNi4yNjktNi4wMTQtNi4yNjktMy4zODUgMC01Ljc5MSAyLjUyNS02LjAxMSA2LjIwMy0uNDUxLS4xNjctLjkyNC0uMjU2LTEuNDA5LS4yNTYtLjY5NyAwLTEuMzkyLjE3OS0yLjA2OC41MzMtMS42MTMuODQ1LTIuNDg0IDIuMzg2LTIuNDg0IDQuMTQ0IDAgLjg2OC4yMTIgMS43ODkuNjUyIDIuNzA0IDEuMzA2IDIuNzE4IDMuNjMxIDMuOTIgNS40MSAzLjkxbC4xMjkgMS42NTIgMS40MjgtLjc0N2MuODQ0IDEuNTUgMS4xMDQgMy4yMzMuODA3IDUuMjg1LS4wNDEuMjc4LjE2NS41NzMuNDk0LjU3My4yNDUgMCAuNDU3LS4xOC40OTQtLjQyOC4zMjQtMi4yNC4wMjMtNC4xNjgtLjkxMS01Ljg5M2wxLjI5MS0uNjc3LTEuMTgzLTEuMDQ3Yy40MjItLjU1My43MjgtMS4yODguOS0yLjExOC4yNjYuMTc4LjUzNi4zMzUuODA4LjQ2NmwtLjk1OCAxLjM5N2gyLjE4M2MtLjY5MSAyLjA2NS0uMzU4IDMuMjcyLS4wMDQgNC4xNTQuMzQyLjg1My42MzkgMS41ODktLjEzMiAzLjQ1NS0uMTM3LjMzMS4xMDguNjkxLjQ2MS42OTEuMTk2IDAgLjM4MS0uMTE3LjQ2MS0uMzA5LjkyNi0yLjI0My41MDctMy4yODguMTM2LTQuMjEtLjMzNi0uODM2LS41OTItMS44NTcuMTMtMy43ODFoMi4wMmwtLjk2OS0xLjQxOGMuMjczLS4xMzcuNTQ4LS4yOTguODE2LS40ODMuMTY5Ljg0Ni40NzggMS41OTQuOTA3IDIuMTU2bC0xLjE4NCAxLjA0NyAxLjI5Mi42NzdjLS45MzQgMS43MjQtMS4yMzUgMy42NTQtLjkxIDUuODkzLjAzNS4yNDguMjQ5LjQyOC40OTMuNDI4LjMzIDAgLjUzNS0uMjk1LjQ5NS0uNTczLS4yOTgtMi4wNTItLjAzOS0zLjczNi44MDYtNS4yODVsMS40MjguNzQ3LjEyOS0xLjY1MmMzLjEyOS0uMDE1IDYuMDYyLTMuMzk5IDYuMDYyLTYuNjE0IDAtMS43NTgtLjg3LTMuMjk5LTIuNDgzLTQuMTQ0bS0uNDE1LTMuMTY4bC40ODEuMjcyLjA5MS41NDUuNDA2LS4zNzMuNTQ4LjA4MS0uMjMxLS41MDMuMjQ3LS40OTQtLjU0OS4wNjMtLjM5My0uMzg3LS4xMDkuNTQxLS40OTEuMjU1em0uMDI2IDIuNDA1bC0uMjcxLTEuNjI1LTEuNDMyLS44MDkgMS40Ni0uNzU5LjMyNi0xLjYxNSAxLjE3MyAxLjE1NiAxLjYzNS0uMTg5LS43MzYgMS40NzQuNjg1IDEuNDk4LTEuNjI4LS4yNDUtMS4yMTIgMS4xMTR6bS0xOC44MTggMTQuNDlsLjUxNi4zNjkuMDI3LS42MzQuNTEtLjM3Ny0uNTk1LS4yMjMtLjItLjYwMS0uMzk0LjQ5Ny0uNjM0LjAwNS4zNTEuNTI5LS4xOTEuNjA0LjYxLS4xNjl6bTEuMjUxIDEuODc3bC0xLjQwNC0xLjAwNS0xLjY2My40NjQuNTItMS42NDgtLjk1NS0xLjQzOSAxLjcyNy0uMDE1IDEuMDczLTEuMzU0LjU0NiAxLjY0IDEuNjE4LjYwNC0xLjM4OCAxLjAyNy0uMDc0IDEuNzI2em0uNjMyLTIxLjE3OGMtLjUyIDAtLjk0Mi40MjMtLjk0Mi45NDQgMCAuNTIuNDIyLjk0Mi45NDIuOTQycy45NDItLjQyMi45NDItLjk0MmMwLS41MjEtLjQyMi0uOTQ0LS45NDItLjk0NG0wIDIuNzg3Yy0xLjAxNSAwLTEuODQxLS44MjctMS44NDEtMS44NDNzLjgyNi0xLjg0NCAxLjg0MS0xLjg0NGMxLjAxNSAwIDEuODQxLjgyOCAxLjg0MSAxLjg0NHMtLjgyNiAxLjg0My0xLjg0MSAxLjg0M20tMi42OTUuNDk4Yy0uMzAzIDAtLjU0OS4yNDctLjU0OS41NSAwIC4zMDMuMjQ2LjU1LjU0OS41NS4zMDMgMCAuNTQ5LS4yNDcuNTQ5LS41NSAwLS4zMDMtLjI0Ni0uNTUtLjU0OS0uNTVtMCAyYy0uNzk4IDAtMS40NDgtLjY1MS0xLjQ0OC0xLjQ1IDAtLjc5OS42NS0xLjQ0OSAxLjQ0OC0xLjQ0OS43OTggMCAxLjQ0OS42NSAxLjQ0OSAxLjQ0OXMtLjY1MSAxLjQ1LTEuNDQ5IDEuNDVtMTcuMDgtNS4zOTFjLS4yNjIgMC0uNDc0LjIxNC0uNDc0LjQ3NSAwIC4yNjIuMjEyLjQ3NS40NzQuNDc1cy40NzQtLjIxMy40NzQtLjQ3NWMwLS4yNjEtLjIxMi0uNDc1LS40NzQtLjQ3NW0wIDEuNzQ5Yy0uNzAyIDAtMS4yNzMtLjU3MS0xLjI3My0xLjI3NCAwLS43MDMuNTcxLTEuMjc1IDEuMjczLTEuMjc1czEuMjczLjU3MiAxLjI3MyAxLjI3NS0uNTcxIDEuMjc0LTEuMjczIDEuMjc0bTIuNDM1IDE2LjAyM2MtLjU3OCAwLTEuMDQ5LjQ3LTEuMDQ5IDEuMDUgMCAuNTc5LjQ3MSAxLjA0OSAxLjA0OSAxLjA0OXMxLjA0Ny0uNDcgMS4wNDctMS4wNDljMC0uNTgtLjQ2OS0xLjA1LTEuMDQ3LTEuMDVtMCAyLjk5OWMtMS4wNzUgMC0xLjk0OS0uODc0LTEuOTQ5LTEuOTQ5IDAtMS4wNzYuODc0LTEuOTUgMS45NDktMS45NSAxLjA3MyAwIDEuOTQ3Ljg3NCAxLjk0NyAxLjk1IDAgMS4wNzUtLjg3NCAxLjk0OS0xLjk0NyAxLjk0OSIvPjwvc3ZnPg==">
							매달 진행하는<br>다양한 이벤트
						</div>
						<div class="event-column">
							<img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGQ9Ik0wIDIzdi0xMC42NjhjMC0uOTkuMDgyLTEuOTUyIDEuMzI0LTIuMjIzIDEuNDMzLS4zMTIgMi43NjgtLjU4NiAyLjEyMS0xLjczNi0xLjk2Ni0zLjUwMS0uNTIxLTUuMzczIDEuNTU1LTUuMzczIDIuMTE3IDAgMy41MjcgMS45NDQgMS41NTYgNS4zNzMtLjMxMS41NDEtLjE3NS44ODguMjAxIDEuMTM2LjIyNS0uMjA4LjUyOC0uMzY3LjkzNC0uNDYxIDEuNjg0LS4zODkgMy4zNDQtLjczNiAyLjU0NS0yLjIwOS0yLjM2Ni00LjM2NC0uNjc0LTYuODM5IDEuODY2LTYuODM5IDIuNDkxIDAgNC4yMjYgMi4zODMgMS44NjYgNi44MzktLjc3NSAxLjQ2NC44MjYgMS44MTIgMi41NDUgMi4yMDkuMzUyLjA4MS42MjcuMjEyLjg0LjM4LjI5LS4yNDIuMzY5LS41NzEuMDkxLTEuMDU1LTEuOTcxLTMuNDI5LS41NjEtNS4zNzMgMS41NTYtNS4zNzMgMi4wNzYgMCAzLjUyMSAxLjg3MiAxLjU1NSA1LjM3My0uNjQ3IDEuMTUuNjg4IDEuNDI0IDIuMTIxIDEuNzM2IDEuMjQyLjI3MSAxLjMyNCAxLjIzMyAxLjMyNCAyLjIyM3YxMC42NjhjMCAuNTUyLS40NDggMS0xIDFoLTIyYy0uNTUyIDAtMS0uNDQ4LTEtMXptMjMtOGgtMjJ2OGgyMnYtOHptLTE4LjE5MyAxbC0uOTc2IDIuMDE0LTIuMjE3LjMwNSAxLjYxNSAxLjU1Mi0uMzk1IDIuMjA0IDEuOTczLTEuMDU3IDEuOTczIDEuMDU2LS4zOTMtMi4yMDMgMS42MTMtMS41NTItMi4yMTctLjMwNS0uOTc2LTIuMDE0em03LjE5MyAwbC0uOTc2IDIuMDE0LTIuMjE3LjMwNSAxLjYxNSAxLjU1Mi0uMzk1IDIuMjA0IDEuOTczLTEuMDU3IDEuOTczIDEuMDU2LS4zOTMtMi4yMDMgMS42MTMtMS41NTItMi4yMTctLjMwNS0uOTc2LTIuMDE0em03LjE5MyAwbC0uOTc2IDIuMDE0LTIuMjE3LjMwNSAxLjYxNSAxLjU1Mi0uMzk1IDIuMjA0IDEuOTczLTEuMDU3IDEuOTczIDEuMDU2LS4zOTMtMi4yMDMgMS42MTMtMS41NTItMi4yMTctLjMwNS0uOTc2LTIuMDE0em0tMTQuODg2IDMuNTJsLS41MTItLjQ5MS43MDItLjA5Ny4zMS0uNjM5LjMxLjYzOS43MDMuMDk3LS41MTEuNDkxLjEyNS42OTktLjYyNy0uMzM1LS42MjUuMzM0LjEyNS0uNjk4em03LjE5MyAwbC0uNTEyLS40OTEuNzAyLS4wOTcuMzEtLjYzOS4zMS42MzkuNzAzLjA5Ny0uNTExLjQ5MS4xMjUuNjk5LS42MjctLjMzNS0uNjI1LjMzNC4xMjUtLjY5OHptNy4xOTMgMGwtLjUxMi0uNDkxLjcwMi0uMDk3LjMxLS42MzkuMzEuNjM5LjcwMy4wOTctLjUxMS40OTEuMTI1LjY5OS0uNjI3LS4zMzUtLjYyNS4zMzQuMTI1LS42OTh6bS0xMi41ODktNS41MmwtLjAwMS0yLjEyNmMwLS41MjYuMDE4LTEuMDQ2LjE0Ny0xLjQ5OC0uMzE5LS4xOTktLjU3My0uNDU4LS43MjktLjgxMS0uMTYtLjM2LS4yNjEtLjk0NS4xNjgtMS42OS43OTItMS4zNzkgMS4wMTktMi41NjQuNjIyLTMuMjUxLS40ODctLjg0LTIuMTMtLjgzMS0yLjYwOC0uMDE0LS4zOTcuNjc5LS4xNzQgMS44NzEuNjE0IDMuMjczLjQxOS43NDcuMzE2IDEuMzMuMTU2IDEuNjg4LS4yMjkuNTA5LS41MzUuOTg3LTIuOTM2IDEuNTE2LS4zNjkuMDgtLjUzNy4xMTYtLjUzNyAxLjI0NWwuMDAxIDEuNjY4aDUuMTAzem0xMC45OTggMHYtMi4xMjJjMC0xLjQzOC0uMTkzLTEuNzEzLS44MTMtMS44NTYtMi43NDYtLjYzMy0zLjA5OC0xLjE3Mi0zLjM1OS0xLjc0NC0uMTgxLS4zOTUtLjMwMS0xLjA0OC4xNTQtMS45MDcgMS4wMjItMS45MjkgMS4yNzgtMy41ODIuNzAzLTQuNTM4LS42NzItMS4xMTUtMi43MDQtMS4xMjUtMy4zODQuMDE3LS41NzcuOTY5LS4zMTggMi42MTMuNzEyIDQuNTEyLjQ2NS44NTcuMzQ4IDEuNTEuMTY5IDEuOTA5LS40OTEgMS4wODgtMS44MzggMS4zOTktMy4yNjUgMS43MjctLjgyOS4xOTYtLjkxNi41ODctLjkxNiAxLjg3NmwuMDAxIDIuMTI2aDkuOTk4em01Ljg5NyAwbC4wMDEtMS42NjhjMC0xLjEyOS0uMTY4LTEuMTY1LS41MzctMS4yNDUtMi40MDEtLjUyOS0yLjcwNy0xLjAwNy0yLjkzNi0xLjUxNi0uMTYtLjM1OC0uMjYzLS45NDEuMTU2LTEuNjg4Ljc4OC0xLjQwMiAxLjAxMS0yLjU5NC42MTQtMy4yNzMtLjQ3OC0uODE3LTIuMTIxLS44MjYtMi42MDguMDE0LS4zOTcuNjg3LS4xNyAxLjg3Mi42MjIgMy4yNTEuNDI5Ljc0NS4zMjggMS4zMy4xNjggMS42OS0uMTI3LjI4OC0uMzIuNTEzLS41NTkuNjk1LjE2Mi40NzguMTgyIDEuMDQ0LjE4MiAxLjYxOHYyLjEyMmg0Ljg5N3oiLz48L3N2Zz4=">
							멤버쉽 등급 별<br>할인 제공
						</div>
						<div class="event-column">
							<img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGQ9Ik03IDI0aC01di05aDV2MS43MzVjLjYzOC0uMTk4IDEuMzIyLS40OTUgMS43NjUtLjY4OS42NDItLjI4IDEuMjU5LS40MTcgMS44ODctLjQxNyAxLjIxNCAwIDIuMjA1LjQ5OSA0LjMwMyAxLjIwNS42NC4yMTQgMS4wNzYuNzE2IDEuMTc1IDEuMzA2IDEuMTI0LS44NjMgMi45Mi0yLjI1NyAyLjkzNy0yLjI3LjM1Ny0uMjg0Ljc3My0uNDM0IDEuMi0uNDM0Ljk1MiAwIDEuNzUxLjc2MyAxLjc1MSAxLjcwOCAwIC40OS0uMjE5Ljk3Ny0uNjI3IDEuMzU2LTEuMzc4IDEuMjgtMi40NDUgMi4yMzMtMy4zODcgMy4wNzQtLjU2LjUwMS0xLjA2Ni45NTItMS41NDggMS4zOTMtLjc0OS42ODctMS41MTggMS4wMDYtMi40MjEgMS4wMDYtLjQwNSAwLS44MzItLjA2NS0xLjMwOC0uMi0yLjc3My0uNzgzLTQuNDg0LTEuMDM2LTUuNzI3LTEuMTA1djEuMzMyem0tMS04aC0zdjdoM3YtN3ptMSA1LjY2NGMyLjA5Mi4xMTggNC40MDUuNjk2IDUuOTk5IDEuMTQ3LjgxNy4yMzEgMS43NjEuMzU0IDIuNzgyLS41ODEgMS4yNzktMS4xNzIgMi43MjItMi40MTMgNC45MjktNC40NjMuODI0LS43NjUtLjE3OC0xLjc4My0xLjAyMi0xLjExMyAwIDAtMi45NjEgMi4yOTktMy42ODkgMi44NDMtLjM3OS4yODUtLjY5NS41MTktMS4xNDguNTE5LS4xMDcgMC0uMjIzLS4wMTMtLjM0OS0uMDQyLS42NTUtLjE1MS0xLjg4My0uNDI1LTIuNzU1LS43MDEtLjU3NS0uMTgzLS4zNzEtLjk5My4yNjgtLjg1OC40NDcuMDkzIDEuNTk0LjM1IDIuMjAxLjUyIDEuMDE3LjI4MSAxLjI3Ni0uODY3LjQyMi0xLjE1Mi0uNTYyLS4xOS0uNTM3LS4xOTgtMS44ODktLjY2NS0xLjMwMS0uNDUxLTIuMjE0LS43NTMtMy41ODUtLjE1Ni0uNjM5LjI3OC0xLjQzMi42MTYtMi4xNjQuODE0djMuODg4em0zLjc5LTE5LjkxM2wzLjIxLTEuNzUxIDcgMy44NnY3LjY3N2wtNyAzLjczNS03LTMuNzM1di03LjcxOWwzLjc4NC0yLjA2NC4wMDItLjAwNS4wMDQuMDAyem0yLjcxIDYuMDE1bC01LjUtMi44NjR2Ni4wMzVsNS41IDIuOTM1di02LjEwNnptMSAuMDAxdjYuMTA1bDUuNS0yLjkzNXYtNmwtNS41IDIuODN6bTEuNzctMi4wMzVsLTUuNDctMi44NDgtMi4yMDIgMS4yMDIgNS40MDQgMi44MTMgMi4yNjgtMS4xNjd6bS00LjQxMi0zLjQyNWw1LjUwMSAyLjg2NCAyLjA0Mi0xLjA1MS01LjQwNC0yLjk3OS0yLjEzOSAxLjE2NnoiLz48L3N2Zz4=">
							주말마다<br>무료배송
						</div>
						<div class="event-column">
							<img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij48cGF0aCBkPSJNMjAgOS4zNTJjMC00Ljg1Mi00Ljc1LTguMzUyLTEwLTguMzUyLTUuMjgxIDAtMTAgMy41MjctMTAgOC4zNTIgMCAxLjcxLjYxNSAzLjM5IDEuNzA1IDQuNjk1LjA0NyAxLjUyNy0uODUgMy43MTktMS42NiA1LjMxMiAyLjE2OC0uMzkxIDUuMjUyLTEuMjU4IDYuNjQ4LTIuMTE1IDcuNjk4IDEuODc3IDEzLjMwNy0yLjg0MiAxMy4zMDctNy44OTJ6bS0xMy45MiAyLjIxYy0uMzQ3LjI3NS0uODMuNDEzLTEuNDUuNDEzLS41MyAwLTEuMDAxLS4xMDItMS40MDgtLjMwNmwuMjI4LS45MDJjLjQxMi4yMDguODI4LjMxMiAxLjI1MS4zMTIuMjQ0IDAgLjQzNS0uMDQ2LjU3MS0uMTM5LjI2Mi0uMTc5LjI3OC0uNTM5LjAyLS43NDMtLjEyNS0uMDk3LS4zMzctLjE5Ny0uNjQxLS4yOTgtLjkxNS0uMzA1LTEuMzcxLS43ODEtMS4zNzEtMS40MyAwLS40Mi4xNjctLjc2NS41MDMtMS4wMzYuMzM3LS4yNzEuNzg2LS40MDcgMS4zNDQtLjQwNy40ODggMCAuOTEzLjA4MyAxLjI3OS4yNDlsLS4yNDguODczYy0uMzM0LS4xNTYtLjY4NC0uMjMzLTEuMDQ1LS4yMzMtLjIyMSAwLS4zOTYuMDQzLS41MjIuMTI4LS4yNS4xNjktLjI0NS40NzUtLjAzLjY1NS4xMDYuMDg5LjM1Ni4yMDUuNzU5LjM0Ny40NDIuMTU2Ljc2Ny4zNS45NzMuNTgxLjIwNS4yMzEuMzA4LjUxOC4zMDguODYxIDAgLjQ0MS0uMTc1Ljc5OS0uNTIxIDEuMDc1em01LjUzMS4zMzRjLS4wNzYtMS45MDEtLjExMy0zLjE5MS0uMTEzLTMuODY4aC0uMDIzYy0uMTE0LjUwOS0uNTAzIDEuNzczLTEuMTY1IDMuNzg5aC0uODU5Yy0uMzk3LTEuMzkxLS45ODEtMy43ODktLjk4MS0zLjc4OWgtLjAxNWwtLjE2OSAzLjg2OGgtMS4wMjVsLjMwNS00Ljc5MmgxLjQ5MmwuODQ1IDMuMzA2IDEuMDI0LTMuMzA2aDEuNTA5bC4yNTcgNC43OTJoLTEuMDgyem00LjYzNy0uMzE0Yy0uMzQ4LjI3Ny0uODQyLjQxOC0xLjQ2NS40MTgtLjUwNiAwLS45ODMtLjA4OS0xLjQzOS0uMzE3bC4yNDEtLjk1NmMuNC4yMDUuODExLjMyNSAxLjI2OS4zMjUuMjM3IDAgLjQyNS0uMDQ0LjU1NS0uMTM1LjI1Mi0uMTY5LjI2Mi0uNTA4LjAyLS43LS4xMjItLjA5NS0uMzM0LS4xOTMtLjYzMi0uMjk0LS45MjMtLjMwNi0xLjM5Mi0uNzk0LTEuMzkyLTEuNDU0IDAtLjQyNS4xNzQtLjc4MS41MTYtMS4wNTYuMzM4LS4yNzUuNzk2LS40MTMgMS4zNTgtLjQxMy40OSAwIC45MjQuMDg0IDEuMjkxLjI1bC4wMi4wMS0uMjY0LjkyNmMtLjMzNy0uMTU5LS42NzQtLjI0Ni0xLjA2MS0uMjQ2LS4yMTUgMC0uMzg3LjA0Mi0uNTA5LjEyNC0uMjM0LjE2MS0uMjI5LjQ0NC0uMDI2LjYxNS4xMDMuMDg1LjM1NC4yMDEuNzUuMzQyLjQ0NS4xNTYuNzc1LjM1NS45ODIuNTg4LjIwOS4yMzYuMzE2LjUzLjMxNi44NzkuMDAxLjQ0Ny0uMTc4LjgxNS0uNTMgMS4wOTR6bTYuNjM2IDcuOTM5Yy0uMDI5IDEuMDAxLjU1OCAyLjQzNSAxLjA4OCAzLjQ3OS0xLjQxOS0uMjU4LTMuNDM4LS44MjQtNC4zNTItMS4zODUtMy4yNzkuNzk4LTYuMDY0LS4yMjMtNy41NzctMi4xLjU5Ni0uMDg2IDEuMTc4LS4yMDUgMS43NC0uMzY0IDEuODI0IDEuNTUyIDMuOTYyIDEuMzc0IDYuMDg5Ljg1NS42ODcuNDIyLjc3My41MDcgMS42NjUuODEzLS4xODctLjgxNi0uMTU4LTEuMTItLjEzOC0xLjg2NSAxLjc5My0yLjE0IDEuMjEzLTQuMTA0LS40NjQtNS4zNjUuMjM5LS40NTUuNDM5LS45MjguNjAxLTEuNDE2IDIuODkxIDEuOTEzIDMuMTAzIDUuMjUxIDEuMzQ4IDcuMzQ4eiIvPjwvc3ZnPg==">
							SNS 공유 시<br>리워드 지급
						</div>
					</div>
					<div>
						<button type="button" class="button" onclick="regichk()">회원가입</button>
					</div>
				</div>

				<div class="column">
					<div class="tag-title members-info-tag">
						추가 정보 입력
						<div class="arrow arrowdown"></div>
					</div>

					<div class="members-info-message">
						이름 및 전화번호, 주소 등 추가 정보를 입력하시면, 상품 주문 시 편리하게 이용 가능합니다.
					</div>

					<div class="members-info close">
						<div class="field input_name">
							<span>이름</span>
							<input type="text" name="name">
						</div>
						<div class="field input_phone">
							<span>전화번호</span>
							<select name="phone1">
								<option value="010" selected>010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="019">019</option>
								<option value="070">070</option>
							</select>
							<input type="text" name="phone2" maxlength="4"> 
							<input type="text" name="phone3" maxlength="4">
						</div>
						<div class="field input_email">
							<span>이메일</span>
							<input type="text" name="email1" placeholder="이메일 주소 입력">
							@
							<input type="text" name="email2" >
							<select id="domain">
								<option value="naver.com">naver.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="daum.net">daum.net</option>
								<option value="nate.com">nate.com</option>
								<option value="kakao.com">kakao.com</option>
								<option value="1" selected>직접입력</option>
							</select>
						</div>
						<div class="field input_birth">
							<span>생년월일</span>
							<input type="text" name="birth" placeholder="ex)2000.01.01">
						</div>
						<div class="field input_addr">
							<span>주소</span>
							<input type="text" readonly id="addr1" name="addr1" placeholder="우편번호">
							<button type="button" onclick="daumPost()">주소 검색</button>
							<input type="text" readonly id="addr2" name="addr2" placeholder="주소">
							<input type="text" id="addr3" name="addr3" placeholder="상세주소">
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
	
		jQuery( document ).ready( function ( $ ) {
		    var wrapper      = $(".members-wrapper.register");
		    var members_info = $(".members-info", wrapper );
		    
		    $('select[id=domain]', wrapper).on( 'change', function() {
		    	var domain = $('select[id=domain] option:selected', wrapper).val(); //naver
		         console.log(domain);
		    	if(domain == 1){
		    		$('input[name=email2]',wrapper).val('');
		    		$('input[name=email2]',wrapper).attr('readonly', false);
		    	}else{
		    		$('input[name=email2]',wrapper).val(domain);
		    		$('input[name=email2]',wrapper).attr('readonly', true);
		    	}
		     });

		    //비밀번호 일치여부
		    $("input[type=password]", wrapper).on( 'keyup', function() { //키보드 입력 이벤트
		        var password = $("input[name=pw]", wrapper).val(); //비밀번호 값
		        var confirm_password = $("input[id=confirm_pw]", wrapper).val();
		        var pwRegex =  /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
				var passWordTest = pwRegex.test($("input[name=pw]").val());
				
				if( 0 == password.length){
					$('.passwordchk-message').html('');
				}else{
					if(!passWordTest){
						$('.passwordchk-message').html('최소 8자 최대 16자 영문자 숫자, 특수문자 포함');
						$('.passwordchk-message').css('color','red');
					}else{
						$('.passwordchk-message').html('사용 가능한 비밀번호입니다');
						$('.passwordchk-message').css('color','green');
					}
				}
				
		        if( 0 == confirm_password.length ){ 
		        	$('.password-message').html('');
		        } else {
		        	if( password == confirm_password ) { //비밀번호가 같을 경우
			            $('.password-message').css( 'color', 'green' ); //<div class="password-message"> 태그에 CSS 추가
			            $('.password-message').html( '비밀번호가 일치합니다.' ); //<div class="password-message"> 태그 안에 html 추가
			        } else {
			            $('.password-message').css( 'color', 'red' ); //<div class="password-message"> 태그에 CSS 추가
			            $('.password-message').html( '비밀번호가 일치하지 않습니다.' ); //<div class="password-message"> 태그 안에 html 추가
			        }
		        }
		        
		    });

		    //추가 정보 입력 태그 클릭 이벤트
		    $(".members-info-tag", wrapper).on( 'click', function() {
		        if ( members_info.hasClass( 'close' ) ) { //<div class="members-info"> 태그에 close라는 클래스가 있는지 여부
		            $( ".members-info", wrapper ).removeClass( 'close' ); //close 클래스 삭제
		            $( ".members-info", wrapper ).addClass( 'open' ); //open 클래스 추가
		            $( ".members-info-message", wrapper ).css( 'display', 'none' );
		            // => <div class="members-info"> 태그에 close라는 클래스가 있을 경우, 추가정보입력 폼을 숨김처리(CSS)한다
		            // => <div class="members-info"> 태그에 open이라는 클래스가 있을 경우, 추가정보입력 폼을 표시(CSS)한다

		            $( ".members-info-tag .arrow", wrapper ).removeClass( 'arrowdown' ); //<div class="arrow"> 태그에 arrowdown 클래스 삭제
		            $( ".members-info-tag .arrow", wrapper ).addClass( 'arrowup' ); //<div class="arrow"> 태그에 arrowup 클래스 추가
		        } else {
		            $( ".members-info", wrapper ).removeClass( 'open' ); //open 클래스 삭제
		            $( ".members-info", wrapper ).addClass( 'close' ); //close 클래스 추가
		            $( ".members-info-message", wrapper ).css( 'display', 'block' );
		            $( ".members-info-tag .arrow", wrapper ).removeClass( 'arrowup' ); //<div class="arrow"> 태그에 arrowup 클래스 삭제
		            $( ".members-info-tag .arrow", wrapper ).addClass( 'arrowdown' ); //<div class="arrow"> 태그에 arrowdown 클래스 추가
		        }
		    } )

		});
   
      function regichk(){ 
	   var form = document.form;
	   var id = $('.id_input').val();
	   var pw = $('.pw_input').val();
	   var pwchk = $('.pw_confirm').val();
	   if(!form.id.value){
		   alert("아이디는 필수 사항입니다");
		   form.id.focus();
		   return false;
	   }else if(!form.pw.value){
		   alert("비밀번호는 필수 사항입니다");
		   form.pw.focus();
		   return;
	   }else if( pw != pwchk){
		   alert("비밀번호가 일치하지 않습니다");
		   form.pwchk.focus();
		   return;
	   }
	   else if(id.length < 5 || id.length > 12){
		   alert("아이디는 5자리 ~ 12자리로 입력해주세요");
		   form.id.focus();
		   return;
	   }
	   
	   else{
		   alert("회원가입이 완료되었습니다");
	       form.action = "<%=request.getContextPath()%>/member/register";
	       form.submit();
     	}
      }
      
      //아이디 중복 체크
      $('.id_input').on("propertychange change keyup paste input", function(){
    	  var memberId = $('.id_input').val();		
	      var data = { id : memberId };
	      
	      if(0 < data['id'].length){
	    	  var idRegex =  /^.*(?=^.{5,12}$)(?=.*[a-zA-Z]).*$/;
	    	  var idTest = idRegex.test($("input[name=id]").val());
	    	  if(!idTest){
	    		  $('.id-message').css('color','red');
	    		  $('.id-message').html('최소 5자 최대 12자 영문자, 숫자');
	    	  }else{
		    	  $.ajax({
						url : "memberIdChk.do",
						data : data,
						dataType : "json",
						success : function(data){
							if( 1 == data['result'] ){
								$('.id-message').css('color','red');
								$('.id-message').html('이미 사용중인 아이디입니다');
							} else if( 0 == data['result'] ){
								$('.id-message').html('사용 가능한 아이디입니다');
								$('.id-message').css('color','green');
							}
						}
				   }); 
	    	  } 
	         } else {
	    	 	$('.id-message').html('');
	         }

 		});
      
</script>


</body>
</html>







