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
<title>StadiumListForm.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/stadium/StadiumListForm.css?after">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<div class="main-background">
	<main>
		<div class="container mt-4">
			<div class="match-card1">
				<strong>경기장을 등록할 구장을 선택 해주세요</strong>
			</div>
			
			<div class="match-card2">현재 만들어진 전체 구장 : ${stadiumCount}</div>
			
			<c:forEach var="stadium" items="${stadiumSearchList}">
				<form method="post" action="StadiumFieldCheckForm.action">
					<div class="match-card">
						<div class="stadium-card">
							<!-- 이미지 -->
							<div class="stadium-img-wrapper">
								<img src="${stadium.stadium_reg_image}" alt="" class="stadium-img">
			
								<!-- 텍스트 정보 -->
								<div class="stadium-info">
									<strong>${stadium.stadium_reg_name}</strong>
									${stadium.stadium_reg_addr},
									${stadium.stadium_reg_detailed_addr}
								</div>
							</div>
							
							<!-- 버튼 -->
							<input type="hidden" id="stadium_reg_id" name="stadium_reg_id" value="${stadium.stadium_reg_id}">
							
							<button type="submit" class="btn btn-secondary card-action">이 구장 선택</button>
						</div>
					</div>
				</form>
			</c:forEach>
		</div>
	</main>
	
	<c:import url="/WEB-INF/view/Footer.jsp"></c:import>
</div>

<div id="filterPanel" class="filter-panel">
	<h4>필터</h4>
	<hr>
	
	<form method="get" action="">
		<div class="mb-3">
			<label for="regionSelect" class="form-label">지역</label>
			<select id="regionSelect" name="region" class="form-select">
				<option value="">전체</option>
				<option value="서울">서울</option>
				<option value="경기">경기</option>
				<option value="부산">부산</option>
				<option value="대구">대구</option>
			</select>
		</div>
		<button type="submit" class="btn btn-primary w-100 mt-3">검색</button>
	</form>
</div>

<!-- 플로팅 버튼 (Top, 필터) -->
<div class="floatingButton-wrapper">
	<button id="topIconButton" class="top-icon-slide" title="맨 위로 이동">
		<i class="bi bi-caret-up-fill"></i>
	</button>
	
	<button id="leftIconButton" class="left-icon-slide" title="필터">
		<i class="bi bi-funnel-fill"></i>
	</button>
	
	<div id="floatingButton" class="floatingButton">
		<img src="images/soccerball.png" alt="floating" class="floatingButton-img">
	</div>
</div>

<script type="text/javascript">

	document.getElementById("topIconButton").addEventListener("click", function ()
	{
		window.scrollTo(
		{
			top: 0,
			behavior: "smooth"
		});
	});
	
	document.getElementById("leftIconButton").addEventListener("click", function ()
	{
		var panel = document.getElementById("filterPanel");
		panel.classList.toggle("active");
	});

</script>
</body>
</html>