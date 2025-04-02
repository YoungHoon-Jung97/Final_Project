<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Template.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/Template.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/Template.js"></script>

</head>
<body>
<header class="menu-bar">
	<div class="left-menu">
		<!-- 햄버거 메뉴 -->
		<div class="menu-icon">
			<div class="line-1"></div>
			<div class="line-2"></div>
			<div class="line-3"></div>
		</div>
		
		<!-- 네비게이션 메뉴 -->
		<nav class="nav-menu">
			<div class="nav-item">
				<span class="nav-title team">동호회</span>
				<div class="nav-sub team">동호회 모집</div>
				<div class="nav-sub temp-team">동호회 개설</div>
			</div>
			
			<div class="nav-item">
				<span class="nav-title field">경기장</span>
				<div class="nav-sub field">경기장 예약</div>
				<div class="nav-sub stadium">경기장 등록</div>
			</div>
			
			<div class="nav-item">
				<span class="nav-title mercenary-offer">용병</span>
				<div class="nav-sub mercenary-offer">용병 게시판</div>
				<div class="nav-sub mercenary">용병 등록</div>
			</div>
			
			<div class="nav-item">
				<span class="nav-title match">매치</span>
				<div class="nav-sub match">매치 참가</div>
				<div class="nav-sub field">매치 생성</div>
			</div>
		</nav>
	</div>
	
	<!-- 로고 -->
	<div class="logo">
		<a href="Team.action">
			<img src="images/nutmeg.png" alt="넛맥 로고">
		</a>
	</div>
	
	<div class="right-menu">
		<!-- 로그인 버튼 -->
		<form action="Login.action" method="get" class="login-form">
			<button type="submit" class="login-btn">로그인</button>
		</form>
		
		<!-- 검색 -->
		<span class="search-icon">🔍</span>
		
		<!-- 검색창 -->
		<div class="search-box">
			<input type="text" class="search" placeholder="검색어를 입력하세요...">
		</div>
	</div>
</header>
</body>
</html>