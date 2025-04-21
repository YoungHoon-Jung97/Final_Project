<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회사 소개</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/Template.css?after">

<!-- Template 불러오기 -->
<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>

<body>

<div class="about-section">
	<div class="container">
		<div class="text-center mb-5">
			<h1 class="about-title">NUTMEG — Managing Futsal, Empowering Teams</h1>
			<p class="mt-3">
				넛맥의 동호회 관리와 매칭 시스템은 <span class="highlight">더 나은 동호회를 위한 약속</span>입니다.
			</p>
			<p class="text-muted">로그인, 회원가입 / 동호회 관리 / 구장 관리 / 경기장 관리 / 매칭 시스템 / 용병 시스템</p>
		</div>

		<div class="row align-items-center bg-white p-4 rounded shadow-sm">
			<div class="col-md-6 intro-text">
				<h4 class="mb-3 fw-bold text-dark">넛맥(Nutmeg) 홈페이지에 방문하신 것을 진심으로 환영합니다.</h4>
				<p>
					넛맥(Nutmeg)은 풋살 동호회를 보다 편리하게 관리할 수 있도록 돕는 통합 웹 플랫폼입니다. <br>
					동호회 운영자는 손쉽게 팀을 관리하고, 경기 일정과 구성원을 효율적으로 관리할 수 있습니다.<br><br>
					경기장 및 구장 관리자 역시 자신들의 시설을 등록하여 더 많은 예약과 노출을 기대할 수 있으며, <br>
					동호회 간의 매칭 시스템을 통해 원활한 경기 매칭이 가능하고, <br>
					용병 시스템을 통해 개인 사용자도 쉽게 경기에 참여할 수 있는 환경을 제공합니다.<br><br>
					넛맥은 항상 고객의 입장에서 새로운 기능을 연구하고 발전시키는 서비스를 지향합니다.
				</p>
			</div>
			<div class="col-md-6 d-flex justify-content-center">
				<img src="<%=cp%>/images/young.png" alt="사이트 대표 이미지" class="img-float-right">
			</div>
		</div>
	</div>
</div>

<!-- 푸터 전체 너비 -->
<div class="footer">
	<div class="container d-flex justify-content-between">
		<div>고객문의 : 정영훈 팀장 010-2762-1916</div>
		<div class="text-end">
			기술지원 : 3443-7262<br>
			도입문의 : <a href="mailto:kms7262@naver.com">kms7262@naver.com</a><br>
			팀번호 : 2team<br>
			COPYRIGHT ⓒ 2025. SSANGYOUNG
		</div>
	</div>
</div>

<!-- 플로팅 버튼 -->
<div class="floatingButton-wrapper">
	<button id="topIconButton" class="top-icon-slide" title="맨 위로 이동">
		<i class="bi bi-caret-up-fill"></i>
	</button>
	<div class="floatingButton">
		<img src="<%=cp%>/images/soccerball.png" alt="floating" class="floatingButton-img">
	</div>
</div>

<script>
	document.getElementById("topIconButton").addEventListener("click", function () {
		window.scrollTo({ top: 0, behavior: "smooth" });
	});
</script>

</body>
</html>
