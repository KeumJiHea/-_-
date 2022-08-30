<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>세상에서 제일 쉬운 옷 쇼핑 시옷</title>    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>" >
	<link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>" >
</head>
<body>
    <div class="wrapper">
	    <div id="header"><tiles:insertAttribute name="header" /></div>
	    <div id="main"><tiles:insertAttribute name="body" /></div>    
	    <div id="footer"><tiles:insertAttribute name="footer" /></div>
    </div>   
</body>
</html>