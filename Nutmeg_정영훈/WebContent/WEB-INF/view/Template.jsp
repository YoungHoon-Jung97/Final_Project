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
    // (LoginCheck.jsp 등에서 session.setAttribute("user_id", dto.getSid()); 한 값)
    Integer user_id = (Integer) session.getAttribute("user_id");
    String user_name = (String) session.getAttribute("user_name");
    String user_email = (String) session.getAttribute("user_email");
    Integer user_code_id = (Integer) session.getAttribute("user_code_id");
    Integer operator_id = (Integer) session.getAttribute("operator_id");
    
    System.out.println("==========DEBUG==========");
    System.out.println("DEBUG: user_id = " + user_id);
	System.out.println("DEBUG: user_name = " + user_name);
	System.out.println("DEBUG: user_email = " + user_email);
	System.out.println("DEBUG: user_code_id = " + user_code_id);
	System.out.println("DEBUG: operator_id = " + operator_id);
	System.out.println("=========================");
	session.setAttribute("user_code_id", user_code_id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Template.jsp</title>

<link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/Template.css?after">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">

	var user_id = "<%=user_id %>";
	var operator_id = "<%=operator_id %>";

</script>
<script type="text/javascript" src="<%=cp %>/js/Template.js?after"></script>

</head>
<body>
<%	String logoutFlag = (String) session.getAttribute("logoutFlag");

	if ("1".equals(logoutFlag))
	{
		session.removeAttribute("logoutFlag");
%>
	<script>
		swal("로그아웃", "로그아웃 되었습니다.", "success");
	</script>
<%	}
%>
<div class="background-banner"></div>

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
				<div class="nav-sub field_reg">경기장 등록</div>
				<div class="nav-sub stadium_reg">구장 등록</div>
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
		<a href="MainPage.action">
			<img src="images/nutmeg.png" alt="넛맥 로고">
		</a>
	</div>
	
	<div class="right-menu">
		<!-- 로그인 버튼 / 사람 아이콘 -->
<%		if (user_id != null)
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
	
<%	if (user_id != null && operator_id==null)
	{
%>
	<div class="user-menu" style="display: none;">
		<span class="myInformation">내 정보</span>
		<div class="myTeam">내 동호회</div>
		<div class="operatorSignUp">구장 운영자 가입</div>
		<div class="logout">로그아웃</div>
	</div>
<%	}
	else if(user_id != null && operator_id!=null){
%>
	<div class="user-menu" style="display: none;">
		<span class="myInformation">내 정보</span>
		<div class="myTeam">내 동호회</div>
		<div class="myStadium">내 구장</div>
		<div class="logout">로그아웃</div>
	</div>
<%
	}
%>
</header>
</body>
</html>