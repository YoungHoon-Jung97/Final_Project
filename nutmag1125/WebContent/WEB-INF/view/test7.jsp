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

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/test.css">

</head>
<body>
	<header class="menu-bar">
		<!-- 왼쪽 메뉴 (햄버거 + 네비게이션) -->
		<div class="left-menu">
			<div class="menu-icon">☰</div>
			<nav class="nav-menu">
				<a href="#">동호회</a> <a href="#">커뮤니티</a> <a href="#">매칭</a>
			</nav>
		</div>

		<!-- 중앙 고정 로고 -->
		<div class="logo">넛맥</div>

		<!-- 오른쪽 메뉴 (로그인 + 검색) -->
		<div class="right-menu">
			<button class="login-btn">로그인</button>
			<span class="search-icon">🔍</span>
		</div>
	</header>
</body>
</html>