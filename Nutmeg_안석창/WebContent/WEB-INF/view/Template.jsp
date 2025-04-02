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

<style type="text/css">

@charset "UTF-8";

@import url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700,800,900');

/* 기본 스타일 */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Poppins', sans-serif;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	width: 100%;
	min-height: 100vh;
	overflow-y: overlay;
	background-color: #ebedec;
}

/* 메뉴바와 중앙 컨텐츠의 공통 스타일 */
.menu-bar, main {
	width: 90%;
	max-width: 1200px;
	margin: 0 auto;
}

/* 메뉴바 스타일 */
.menu-bar {
	background-color: #5ea152;
	padding: 10px 20px;
	position: fixed;
	top: 10px;
	left: 50%;
	transform: translateX(-50%);
	z-index: 100;
	display: flex;
	align-items: center;
	justify-content: space-between;
	border-radius: 10px;
}

/* 왼쪽 메뉴 그룹 (햄버거 + 네비) */
.left-menu {
	display: flex;
	align-items: center;
	gap: 15px;
}

/* 네비게이션 메뉴 */
.nav-menu {
	display: flex;
	align-items: center;
	gap: 15px;
}

.nav-menu a {
	color: black;
	text-decoration: none;
	font-size: 16px;
	font-weight: bold;
}

/* 넛맥 로고 (중앙 고정) */
.logo {
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
	display: flex;
	align-items: center;
	justify-content: center;
}

.logo a {
	display: flex;
	align-items: center;
	justify-content: center;
}

.logo img {
	height: 75px;
	width: auto;
	cursor: pointer;
}

/* 오른쪽 메뉴 (로그인 & 검색) */
.right-menu {
	display: flex;
	align-items: center;
	gap: 10px;
}

.login-btn {
	padding: 5px 10px;
	border: 1px solid black;
	border-radius: 5px;
	background: white;
	cursor: pointer;
}

.search-icon {
	font-size: 18px;
	cursor: pointer;
}

/* 중앙 컨텐츠 */
main {
	padding: 100px 0 0;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
}

/* 컨텐츠 박스 */
.center {
	width: 100%;
	background: white;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
	text-align: center;
}

/* 햄버거 메뉴 아이콘 (30px로 축소) */
.menu-icon {
    width: 30px; /* 기존 50px → 30px */
    height: auto;
    cursor: pointer;
    z-index: 50;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.menu-icon .line-1,
.menu-icon .line-2,
.menu-icon .line-3 {
    height: 5px; /* 기존 8px → 4px */
    width: 100%;
    background-color: #fff;
    border-radius: 3px;
    box-shadow: 0 2px 10px 0 rgba(0, 0, 0, 0.3);
    transition: background-color 0.2s ease-in-out;
}

.menu-icon .line-2 {
    margin: 5px 0; /* 기존 14px → 8px */
}

/* Hover 효과 */
.menu-icon:hover .line-1,
.menu-icon:hover .line-2,
.menu-icon:hover .line-3 {
    background-color: #888;
}

/* ✅ Active 상태 - 애니메이션 적용 */
.menu-icon.active .line-1 {
    animation: animate-line-1 0.7s cubic-bezier(0.3, 1, 0.7, 1) forwards;
}
.menu-icon.active .line-2 {
    animation: animate-line-2 0.7s cubic-bezier(0.3, 1, 0.7, 1) forwards;
}
.menu-icon.active .line-3 {
    animation: animate-line-3 0.7s cubic-bezier(0.3, 1, 0.7, 1) forwards;
}

/* ✅ Inactive 상태 - 역방향 애니메이션 적용 */
.menu-icon.inactive .line-1 {
    animation: animate-line-1-rev 0.7s cubic-bezier(0.3, 1, 0.7, 1) forwards;
}
.menu-icon.inactive .line-2 {
    animation: animate-line-2-rev 0.7s cubic-bezier(0.3, 1, 0.7, 1) forwards;
}
.menu-icon.inactive .line-3 {
    animation: animate-line-3-rev 0.7s cubic-bezier(0.3, 1, 0.7, 1) forwards;
}

/* Keyframes */
@keyframes animate-line-1 {
    0% { transform: translate3d(0, 0, 0) rotate(0deg); }
    50% { transform: translate3d(0, 10px, 0) rotate(0); } /* 기존 15px → 10px */
    100% { transform: translate3d(0, 10px, 0) rotate(45deg); }
}

@keyframes animate-line-2 {
    0% { transform: scale(1); opacity: 1; }
    100% { transform: scale(0); opacity: 0; }
}

@keyframes animate-line-3 {
    0% { transform: translate3d(0, 0, 0) rotate(0deg); }
    50% { transform: translate3d(0, -10px, 0) rotate(0); } /* 기존 15px → 10px */
    100% { transform: translate3d(0, -10px, 0) rotate(135deg); }
}

/* 역방향 애니메이션 */
@keyframes animate-line-1-rev {
    0% { transform: translate3d(0, 10px, 0) rotate(45deg); }
    50% { transform: translate3d(0, 10px, 0) rotate(0); }
    100% { transform: translate3d(0, 0, 0) rotate(0deg); }
}

@keyframes animate-line-2-rev {
    0% { transform: scale(0); opacity: 0; }
    100% { transform: scale(1); opacity: 1); }
}

@keyframes animate-line-3-rev {
    0% { transform: translate3d(0, -10px, 0) rotate(135deg); }
    50% { transform: translate3d(0, -10px, 0) rotate(0); }
    100% { transform: translate3d(0, 0, 0) rotate(0deg); }
}

@media (max-width: 799px) {
    .nav-menu {
        display: none;
    }
    
    .logo {
        left: 50px;
        transform: none;
    }
}

::-webkit-scrollbar {
    width: 14px;
    height: 14px;
}

::-webkit-scrollbar-thumb {
    outline: none;
    border-radius: 10px;
    border: 4px solid transparent;
    box-shadow: inset 6px 6px 0 rgba(34, 34, 34, 0.15);
}

::-webkit-scrollbar-thumb:hover {
    border: 4px solid transparent;
    box-shadow: inset 6px 6px 0 rgba(34, 34, 34, 0.3);
}

::-webkit-scrollbar-track {
    box-shadow: none;
    background-color: transparent;
}

</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function()
	{
		$(".menu-icon").click(function()
		{
			if ($(this).hasClass("active"))
			{
				$(this).removeClass("active");
				$(this).addClass("inactive");
			}

			else
			{
				$(this).removeClass("inactive");
				$(this).addClass("active");
			}
			
			if ($(window).width() >= 800)
				$(".nav-menu").toggle();
		});
		
		$(window).resize(function() {
	        if ($(window).width() >= 800) {
	            // 화면 크기가 800px 이상이면
	            if ($(".menu-icon").hasClass("active")) {
	                // active 상태일 때 네비게이션 메뉴 숨김
	                $(".nav-menu").hide();
	            } else {
	                // inactive 상태일 때 네비게이션 메뉴 보임
	                $(".nav-menu").show();
	            }
	        }
	    });
	});
</script>

</head>
<body>
	<header class="menu-bar">
		<!-- 왼쪽 메뉴 (햄버거 + 네비게이션) -->
		<div class="left-menu">
			<div class="menu-icon">
		        <div class="line-1"></div>
		        <div class="line-2"></div>
		        <div class="line-3"></div>
			</div>

			<nav class="nav-menu">
				<a href="#">동호회</a>
				<a href="#">용병</a>
				<a href="#">매치</a>
			</nav>
		</div>

		<!-- 중앙 고정 로고 -->
		<div class="logo">
			<a href="Main.jsp"> <img src="images/nutmeg.png" alt="넛맥 로고">
			</a>
		</div>

		<!-- 오른쪽 메뉴 (로그인 + 검색) -->
		<div class="right-menu">
			<button class="login-btn">로그인</button>

			<span class="search-icon">🔍</span>
		</div>
	</header>

	<main>
		<div class="center">
			여기에 중앙 컨텐츠가 들어갑니다.
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		</div>
	</main>
</body>
</html>