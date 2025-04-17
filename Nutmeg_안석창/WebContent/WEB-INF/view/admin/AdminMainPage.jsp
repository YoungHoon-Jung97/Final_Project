<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminMainPage.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<link rel="stylesheet" href="<%=cp %>/css/Template.css?after">
<link rel="stylesheet" href="<%=cp %>/css/AdminMainPage.css?after">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/AdminMainPage.js?after"></script>

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
<div class="container">
	<div class="admin-wrapper d-flex gap-4 mt-5">
		<!-- 콘텐츠 영역 -->
		<div class="admin-content flex-grow-1" id="content-area">
			<h4 class="mb-4">관리자 대시보드</h4>
			
			<p>여기에 관리자용 콘텐츠를 출력합니다.</p>
		</div>
		
		<!-- 사이드바 -->
		<div class="admin-sidebar">
			<div class="profile-box text-center mb-4">
				<h5 class="mb-1">${sessionScope.admin_nickName}</h5>
				
				<div class="text-muted" style="font-size: 13px;">관리자</div>
				
				<div class="mt-2">
					<span class="badge bg-warning text-dark">관리자 로그인</span>
				</div>
			</div>
			
			<div class="fw-bold mb-2">관리 메뉴</div>
			
			<a class="nav-link menu-link" data-url="<%=cp %>/AdminFieldApprForm.action">
				<i class="bi bi-building me-2"></i>경기장 승인관리
			</a>
			
			<a class="nav-link menu-link" data-url="<%=cp %>/UserManage.action">
				<i class="bi bi-people-fill me-2"></i>사용자 관리
			</a>
		</div>
	</div>
</div>
</body>
</html>