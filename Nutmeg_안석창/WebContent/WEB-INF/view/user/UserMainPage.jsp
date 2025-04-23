<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserMainPage.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/util/UserTemplate.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/util/UserMainPage.css?after">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<div class="main-background">
	<main>
		<div class="container wrapper">
			<!-- 메인 콘텐츠 -->
			<section class="content-area">
				<h4 class="mb-4">내 정보</h4>
				
				<div class="profile-box">
					<div class="info-row">
						<strong>이름</strong>
						
						<span>${userInfo.user_name}</span>
					</div>
					
					<div class="info-row">
						<strong>이메일</strong>
						
						<span>${userInfo.user_email}</span>
					</div>
					
					<div class="info-row">
						<strong>전화번호</strong>
						
						<span>${userInfo.user_tel}</span>
					</div>
					
					<div class="info-row">
						<strong>닉네임</strong>
						
						<span>${userInfo.user_nick_name}</span>
					</div>
					
					<div class="info-row">
						<strong>주민등록번호</strong>
						 
						<span>${fn:substring(userInfo.user_ssn1, 0, 6)}-${fn:substring(userInfo.user_ssn2, 0, 1)}●●●●●●</span>
					</div>
					
					<div class="info-row">
						<strong>우편번호</strong>
						
						<span>${userInfo.user_postal_addr}</span>
					</div>
					
					<div class="info-row">
						<strong>기본 주소</strong>
						
						<span>${userInfo.user_addr}</span>
					</div>
					
					<div class="info-row">
						<strong>상세 주소</strong>
						
						<span>${userInfo.user_detailed_addr}</span>
					</div>
					
					<a href="${pageContext.request.contextPath}/CheckPassword.action" class="btn btn-outline-primary edit-button">
						<i class="bi bi-pencil-square me-2"></i>내 정보 수정
					</a>
				</div>
			</section>
			
			<!-- 사이드바 -->
			<aside class="sidebar">
				<nav>
					<a class="nav-link active" href="UserMainPage.action">
						<i class="bi bi-person-circle"></i> 마이페이지
					</a>
					
					<a class="nav-link" href="UserMatch.action">
						<i class="bi bi-flag"></i> 경기 기록
					</a>
					
					<a class="nav-link" href="UserFee.action">
						<i class="bi bi-cash"></i> 결제 내역
					</a>
					
					<a class="nav-link" href="UserNotification.action">
						<i class="bi bi-journal-text"></i> 알림
					</a>
				</nav>
			</aside>
		</div>
	</main>
	
	<c:import url="/WEB-INF/view/Footer.jsp"></c:import>
</div>
</body>
</html>