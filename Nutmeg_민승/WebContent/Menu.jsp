<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
<<<<<<< HEAD
String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>구장 등록하기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
body {
	background-color: #f9f9f9;
	margin: 0;
	padding: 0;
}

.filter-bar button {
	margin: 0 5px;
}

</style>
</head>
<body>
	<div>배너 넣을 공간</div>
	<!-- 상단 정보 영역 -->
	<div class="container my-4">
			<div class="border rounded p-3 bg-white">
				<h5 class="mb-3 text-center">동호회 개설 신청 양식</h5>
				<form method="post" action="">
					<div class="mb-2">
						<div>동호회 이름</div>
						<input type="text" name="temp_team_name" class="form-control" placeholder="동호회 이름" required="required">
					</div>
					<div class="mb-2">
						<div>동호회 회원 수</div>
						<input type="text" name="temp_team_person_count" class="form-control" placeholder="동호회 회원 수" required="required">
					</div>
					<div class="mb-2">
					    <div style="display: flex; style=width: 48%;">
					    <div>
					        <label for="city">시</label>
					        <select id="regions" name="city_id" class="form-control"  required="required">
					            <option value="">시를 선택하세요</option>
					            <c:forEach var="city" items="${regions}">
					                <option value="${region.region_id}">${city.city_name}</option>
					            </c:forEach>
					        </select>
					    </div>
					
					    <div>
					        <label for="district">구</label>
					        <select id="district" name="district_id" class="form-control"  required="required">
					            <option value="">구를 선택하세요</option>
					            <c:forEach var="district" items="${districts}">
					                <option value="${district.district_id}">${district.district_name}</option>
					            </c:forEach>
					        </select>
						    </div>
						    </div>
					</div>
					<div class="mb-2">
						<div>동호회 설명</div>
						<!-- <input type="text" name="temp_team_desc" class="form-control" placeholder="동호회 설명" required="required"> -->
						<textarea rows="5" cols="" class="form-control" placeholder="동호회의 방향성 혹은 동호회 설명 등.."></textarea>
					</div>
					<div class="mb-2">
						<div>동호회 앰블럼 생성</div>
						<input type="file" name="temp_team_emblem" class="form-control" placeholder="동호회 앰블럼 경로" required="required">
					</div>
					<div class="mb-2">
					    <div style="display: flex; style=width: 48%;">
					    <div>
					        <label for="city">은행명</label>
					        <select id="regions" name="city_id" class="form-control"  required="required">
					            <option value="">은행을 선택하세요</option>
					            <c:forEach var="ba" items="${regions}">
					                <option value="${region.region_id}">${city.city_name}</option>
					            </c:forEach>
					        </select>
					    </div>
					</div>
					</div>
					<div class="mb-2">
						<div>동호회 예금주</div>
						<input type="text" name="temp_team_account_holder" class="form-control" placeholder="동호회 예금주">
					</div>
					<div class="mb-2">
						<div>동호회 계좌 번호</div>
						<input type="text" name="temp_team_account" class="form-control" placeholder="동호회 계좌 번호">
					</div>
					
					
					<div class="text-center">
					<button type="submit" class="btn btn-primary" style="width: 30%;">동호회 개설하기</button>
					<button type="submit" class="btn btn-primary" style="width: 30%;">뒤로가기</button>
					</div>
					<!-- <div class="text-center mt-2">
						<a href="register.jsp">회원가입</a> · <a href="forgot.jsp">비밀번호 찾기</a>
					</div> -->
				</form>
			</div>
	</div>

=======
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Template.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/Template.css">

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
>>>>>>> c6073aca0348adfe2fdf1a94e187a96ae165c74b
</body>
</html>