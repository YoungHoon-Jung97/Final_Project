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
    // (LoginCheck.jsp 등에서 session.setAttribute("userSid", dto.getSid()); 한 값)
    Integer userSid = (Integer) session.getAttribute("userSid");
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
    
    /* System.out.println("DEBUG: userSid = " + userSid);
	System.out.println("DEBUG: userName = " + userName);
	System.out.println("DEBUG: userEmail = " + userEmail); */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Template.jsp</title>

<link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/Template.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">

	var userSid = "<%=userSid %>";

</script>
<script type="text/javascript" src="<%=cp %>/js/Template.js"></script>

</head>
<body>
<%
	String logoutFlag = (String) session.getAttribute("logoutFlag");

	if ("1".equals(logoutFlag))
	{
		session.removeAttribute("logoutFlag");
%>
	<script>
		swal("로그아웃", "로그아웃 되었습니다.", "success");
	</script>
<%
	}
%>

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
		<!-- 로그인 버튼 / 사람 아이콘 -->
<%		if (userSid != null)
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
	
	<div class="user-menu" style="display: none;">
		<span class="myInformation">내 정보</span>
		<div class="myTeam">내 동호회</div>
		<div class="logout">로그아웃</div>
	</div>
</header>
</body>
</html>