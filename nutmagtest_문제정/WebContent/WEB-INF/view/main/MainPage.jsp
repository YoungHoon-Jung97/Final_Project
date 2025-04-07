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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>풋살 매칭 서비스</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
body {
	background-color: #f9f9f9;
	margin-top: 1rem;
	padding: 0;
}

.navbar {
	background-color: #fff;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
	padding: 1rem 2rem;
}

.nav-link {
	margin-right: 20px;
	color: #333;
	font-weight: 500;
}

.filter-bar button {
	margin: 0 5px;
}

.match-card {
	background: #fff;
	border-radius: 8px;
	padding: 1rem;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
	margin-bottom: 1rem;
}

.footer {
	padding: 2rem;
	text-align: center;
	background-color: #f1f1f1;
	margin-top: 2rem;
}

</style>
</head>
<body>
	<c:import url="/WEB-INF/view/Template.jsp"></c:import>
	<!-- 상단 정보 영역 -->
	<div class="container">
		<div class="row">
			<!-- 날씨 정보 -->
			<div class="col-md-4 mb-3">
				<div class="border rounded p-3 bg-white">
					<h5 class="mb-2">현재 날씨</h5>
					<p class="mb-0">서울, 맑음 🌤️</p>
					<p class="mb-0">온도: 22°C</p>
				</div>
				<div class="border rounded p-3 bg-white">
					<h5 class="mb-2">내일 날씨</h5>
					<p class="mb-0">서울, 비옴 </p>
					<p class="mb-0">온도: 22°C</p>
				</div>
				<div class="border rounded p-3 bg-white">
					<h5 class="mb-2">내일 날씨</h5>
					<p class="mb-0">서울, 비옴 </p>
					<p class="mb-0">온도: 22°C</p>
				</div>
			</div>
			
			
			<!-- 공지사항 -->
			<div class="col-md-4 mb-3">
				<div class="border rounded p-3 bg-white">
					<h5 class="mb-2">공지사항</h5>
					<ul class="mb-0">
						<li><a href="">[공지] 예시요</a></li>
						<li><a href="">[공지] 예시요</a></li>
						<li><a href="">[공지] 예시요</a></li>
						<li><a href="">[공지] 예시요</a></li>
						<li><a href="">[공지] 예시요</a></li>
						<li><a href="">[공지] 예시요</a></li>
					</ul>
				</div>
				<div class="border rounded p-3 bg-white">
					<h5 class="mb-2">공지사항</h5>
					<ul class="mb-0">
						<li><a href="OperatorSignupForm.action">구단 운영자 가입하기</a></li>
					</ul>
				</div>
			</div>

			<!-- 로그인 폼 -->
			<div class="col-md-4 mb-3">
				<div class="border rounded p-3 bg-white">
					<h5 class="mb-3">로그인</h5>
					<form method="post" action="login.jsp">
						<div class="mb-2">
							<input type="text" name="email" class="form-control" placeholder="이메일">
						</div>
						<div class="mb-2">
							<input type="password" name="password" class="form-control" placeholder="비밀번호">
						</div>
						<button type="submit" class="btn btn-primary w-100">로그인</button>
						<div class="text-center mt-2">
							<a href="UserSignupForm.action">회원가입</a> · <a href="forgot.jsp">비밀번호 찾기</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- 필터 바 -->
	<div class="container text-center mt-3">
		<form method="get" action="" class="filter-bar d-flex flex-wrap justify-content-center gap-2 mt-3">
			<select name="region" class="form-select" style="width: 150px;">
				<option value="">모든 지역</option>
				<option value="서울">서울</option>
				<option value="경기">경기</option>
				<option value="부산">부산</option>
				<option value="대구">대구</option>
			</select>

			<select name="gender" class="form-select" style="width: 150px;">
				<option value="">성별 선택</option>
				<option value="man">남성</option>
				<option value="woman">여성</option>
			</select>

			<select name="age" class="form-select" style="width: 150px;">
				<option value="">나이 대</option>
				<option value="10">10대</option>
				<option value="20">20대</option>
				<option value="30">30대</option>
				<option value="40">40대</option>
				<option value="50">50대</option>
			</select>

			<select name="" class="form-select" style="width: 150px;">
				<option value="">뭐 넣지</option>
				<option value="">뭐 넣지</option>
				<option value="">뭐 넣지</option>
				<option value="">뭐 넣지</option>
			</select>

			<button type="submit" class="btn btn-primary">검색</button>
		</form>
	</div>

	<!-- 매칭 리스트 -->
	<div class="container mt-4">
		<div class="match-card">
			<div class="d-flex justify-content-between align-items-center">
				<div>
					<strong>동호회명</strong> 여기에 위치 정보<br> <small>동호회 정보</small>
				</div>
				<button class="btn btn-secondary" disabled>마감</button>
			</div>
		</div>
		<div class="match-card">
			<div class="d-flex justify-content-between align-items-center">
				<div>
					<strong>동호회명</strong> 서울 마포구 홍대 xx 축구장 <br> <small>남성,초급, 기타 등등</small>
				</div>
				<button class="btn btn-danger">가입하기</button>
			</div>
		</div>
	</div>

	<!-- 푸터(맨 아래 부분) -->
	<div class="footer">문구 적을 공간</div>


</body>
</html>