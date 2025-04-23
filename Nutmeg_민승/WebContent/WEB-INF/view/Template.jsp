<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	// 현재 페이지 URL을 세션에 저장
	String previousPage = request.getRequestURI();
	String queryString = request.getQueryString();
	
	if (queryString != null)
		previousPage += "?" + queryString;
	
	session.setAttribute("previousPage", previousPage);
	
	// 세션에서 로그인 정보를 확인
	String user_name      = (session.getAttribute("user_name") != null)
							? session.getAttribute("user_name").toString() : "";
	String user_email     = (session.getAttribute("user_email") != null)
							? session.getAttribute("user_email").toString() : "";
	Integer user_code_id  = (session.getAttribute("user_code_id") != null)
							? Integer.parseInt(session.getAttribute("user_code_id").toString()) : -1;
	Integer operator_id   = (session.getAttribute("operator_id") != null)
							? Integer.parseInt(session.getAttribute("operator_id").toString()) : -1;
	String user_nick_name   = (session.getAttribute("user_nick_name") != null)
							? session.getAttribute("user_nick_name").toString() : "";
	Integer team_id       = (session.getAttribute("team_id") != null)
							? Integer.parseInt(session.getAttribute("team_id").toString()) : -1;
	Integer notification_count     = (session.getAttribute("notification_count") != null)
			? Integer.parseInt(session.getAttribute("notification_count").toString()) : -1;
							
			
	
	System.out.println("==========DEBUG==========");
	System.out.println("DEBUG: user_name = " + user_name);
	System.out.println("DEBUG: user_email = " + user_email);
	System.out.println("DEBUG: user_code_id = " + user_code_id);
	System.out.println("DEBUG: operator_id = " + operator_id);
	System.out.println("DEBUG: user_nick_name = " + user_nick_name);
	System.out.println("DEBUG: temp_team_id = " + team_id);
	System.out.println("=========================");
	
	session.setAttribute("user_code_id", user_code_id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Template.jsp</title>

<link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/util/Template.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/util/scrollBar.css?after">

<!-- Bootstrap Icons CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- alert 대신 사용 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">

	var user_code_id = "<%=user_code_id %>";
	var user_name = "<%=user_name %>";
	var operator_id = "<%=operator_id %>";

</script>
<script type="text/javascript" src="<%=cp %>/js/Template.js?after"></script>

</head>
<body>
<%	String logoutFlag = (String) session.getAttribute("logoutFlag");
	String loginFlag = (String) session.getAttribute("loginFlag");

	if ("1".equals(logoutFlag))
	{
		session.removeAttribute("logoutFlag");
%>
	<!-- alert 대신 사용 -->
	<script>
		window.addEventListener("pageshow", function(event)
		{
			if (!event.persisted && performance.navigation.type != 2)
				// 캐시된 페이지에서 불린 게 아니라면 알림 띄우기
				swal("로그아웃", "로그아웃 되었습니다.", "success");
		});
	</script>
<%	}
	
	if ("1".equals(loginFlag))
	{
		session.removeAttribute("loginFlag");
%>
	<script>
		window.addEventListener("pageshow", function(event)
		{
			if (!event.persisted && performance.navigation.type != 2)
				swal("로그인", user_name + "님 환영합니다!", "success");
		});
	</script>
<%	}
%>
<div class="background-banner"></div>

<header class="menu-bar" id="menu-bar">
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
				<span class="nav-title teamRecruit">동호회</span>
				<div class="nav-sub teamRecruit">동호회 모집</div>
				
<%				if (team_id == 0)
				{
%>
					<div class="nav-sub temp-team">동호회 개설</div>
<%				}
%>
			</div>
			
			<div class="nav-item">
				<span class="nav-title field">경기장</span>
				<div class="nav-sub field">경기장 예약</div>
				
<%				if (operator_id != -1)
				{
%>
					<div class="nav-sub field_reg">경기장 등록</div>
					<div class="nav-sub stadium_reg">구장 등록</div>
<%				}
%>
			</div>
			
			<div class="nav-item">
				<span class="nav-title mercenary-offer">용병</span>
				<div class="nav-sub mercenary-offer">용병 게시판</div>
				
<%				if (user_code_id != -1)
				{
%>
					<div class="nav-sub mercenary">용병 등록</div>
<%				}
%>
			</div>
			
			<div class="nav-item">
				<span class="nav-title match">매치</span>
				<div class="nav-sub match">매치 참가</div>
				<div class="nav-sub field">매치 생성</div>
			</div>
			
			<!-- 회사소개 항목 추가 -->
			<div class="nav-item">
				<span class="nav-title company">회사소개</span>
				<div class="nav-sub company">회사 개요</div>
			</div>
		</nav>
	</div>
	
	<!-- 로고 -->
	<div class="logo">
		<a href="MainPage.action">
			<img src="images/nutmeg.png" alt="넛맥 로고">
		</a>
	</div>
	
<%	if (user_code_id != -1)
	{
%>
		<div class="nav-title notification-nick-name">
			<div class="position-relative d-inline-block">
			  <button class="notification-bell">
<%					if (notification_count > 0)
					{
%>
						<i class="bi bi-bell-fill"></i>
						
						<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
							<%= notification_count %>
							
							<span class="visually-hidden">unread messages</span>
						</span>
<%					}
					
					else
					{
%>
						<i class="bi bi-bell"></i>
<%					}
%>
				</button>
			</div>
			
			<div class="login-nick-name">
				<%=user_nick_name %> 님
			</div>
		</div>
<%	}
%>
	
	<div class="right-menu">
		<!-- 로그인 버튼 / 사람 아이콘 -->
<%		if (user_code_id != -1)
		{
%>
			<div class="line-4"></div>
			<div class="user-icon login-form">
				<i class="uil uil-user"></i>
			</div>
			<div class="line-5"></div>
<%		}
		
		else
		{
%>
			<form action="Login.action" method="get" class="login-form">
				<button type="submit" class="login-btn">로그인</button>
			</form>
<%		}
%>
	</div>
	
<%	if (user_code_id != -1)
	{
%>
		<div class="user-menu" style="display: none;">
			<span class="myInformation">내 정보</span>
			
<%			if (team_id != 0)
			{
%>
				<div class="myTeam">내 동호회</div>
<%			}
			
			if (operator_id == -1)
			{
%>
				<div class="operatorSignUp">구장 운영자 가입</div>
<%			}
			
			else
			{
%>
				<div class="myStadium">내 구장</div>
<%			}
%>
			<div class="logout">로그아웃</div>
		</div>
<%	}
%>
</header>
</body>
</html>