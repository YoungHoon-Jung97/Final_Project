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
<style type="text/css">

body
{
	background-color: #f9f9f9;
	margin-top: 1rem;
}

main
{
	width: 86.5%;
	display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    margin-top: 75px;
}

.filter-bar button
{
	margin: 0 5px;
}

.card
{
	width: 300px;
	background: #fff;
	border-radius: 16px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	text-align: center;
	transition: transform 0.2s;
	margin-top: 30px;
}

.card:hover
{
	transform: translateY(-5px);
}

.card-img
{
	background-color: #b2dfdb;
	padding-top: 10px;
	padding-bottom: 30px;
	z-index: 1;
}

.card-img img
{
	width: 80px;
	height: 80px;
	object-fit: cover;
	border-radius: 50%;
	border: 3px solid white;
}

.card-content
{
	padding: 20px;
}

.card-content h2
{
	margin: 0;
	font-size: 1.5em;
	font-weight: bold;
	color: #333;
}

.card-content p
{
	margin: 8px 0 0;
	font-size: 0.9em;
	color: #777;
}

.card-action
{
	margin-top: 16px;
	background: linear-gradient(to right, #4f80ff, #6a9eff);
	color: white;
	border: none;
	padding: 10px 24px;
	border-radius: 8px;
	font-weight: bold;
	cursor: pointer;
}

.card-action:hover
{
	background: linear-gradient(to right, #3f70e0, #588dee);
}

.temp
{
	margin-right: 250px;
	height: 30px;
}

</style>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<main>
	<!-- 필터 바 -->
	<div class="container text-center mt-3">
		<form method="get" action="" class="filter-bar d-flex flex-wrap justify-content-center gap-2 mt-3">
			<select name="region" class="form-select">
				<option value="">지역</option>
				<option value="서울">서울</option>
				<option value="경기">경기</option>
				<option value="부산">부산</option>
				<option value="대구">대구</option>
			</select>

			<button type="submit" class="btn btn-primary">검색</button>
		</form>
	</div>

	<!-- 동호회 리스트 -->
	<div class="container mt-4">
		<div class="row justify-content-center">
			<c:forEach var="team" items="${teamList}">
				<div class="col-md-4 d-flex justify-content-center">
					<div class="card">
						<div class="card-img">
							<div class="temp">
								<c:if test="${team.team_id == 'TEMP_TEAM'}">
									🌱
								</c:if>
							</div>
							
							
							<!-- 동호회 앰블럼 (이미지 경로는 동적으로 바꿀 수 있음) -->
							<img src="${pageContext.request.contextPath}/${team.emblem}" alt="${team.temp_team_name} 앰블럼">
						</div>
						
						<div class="card-content">
							<h2>${team.temp_team_name}</h2>
							<!-- 동호회 이름 -->
							<p>${team.region_name} / ${team.city_name}</p>
							<!-- 동호회 지역 -->
							<button class="card-action">자세히 보기</button>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<br><br><br><br><br><br><br><br><br><br>
	<br><br><br><br><br><br><br><br><br><br>
</main>
</body>
</html>