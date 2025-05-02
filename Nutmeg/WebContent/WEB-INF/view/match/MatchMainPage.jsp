<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MatchMainPage.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/team/TeamSchedule.css?after">

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<div class="main-background">
	<main>
		<div class="container">
			<div class="section-header text-center mt-5 mb-5">
				<h1 class="display-5 fw-bold text-success">⚔️ 매치</h1>
				
				<p class="text-muted mt-2">열정 넘치는 경기가 기다리고 있어요! 지금 바로 매치에 참여해보세요!</p>
				
				<div class="underline mt-3 mx-auto"></div>
			</div>
			
			<c:forEach var="match" items="${matchRoomList}">
				<form action="MatchEnterCheckForm.action" method="post">
					<div class="match-item">
						<div class="match-header">
							<span class="match-date">${match.match_date} ${match.start_time}~${match.end_time}</span>
							
							<span class="match-status" style="background-color: #e8f5e9; color: #388e3c; border-radius: 10px; padding: 5px 10px;">
								${match.match_status}
							</span>
						</div>
						
						<div class="match-teams">
							<div class="team">
								<div class="team-name">매치 개최팀 (Home Team)</div>
								<img id="descTeamEmblem" src="${match.home_team_emblem}" alt="팀 앰블럼" class="circle-img">

								<div class="team-score">${match.home_team_name}</div>
							</div>
							
							<div class="vs">VS</div>
							
							<div class="team">
								<div class="team-name">참가팀 (Away Team)</div>
								
								<div class="team-score">참가자 모집중</div>
							</div>
						</div>
						
						<div class="match-details">
							<div class="detail-item">
								<div>
									<span class="detail-label">경기장 이름:</span>
									
									<span>${match.field_name}</span>
								</div>
								
								<div>
									<span class="detail-label">경기장 주소:</span>
									
									<span>${match.stadium_addr}, ${match.stadium_detailed_addr}</span>
								</div>
								
								<div>
									<span class="detail-label">참석 인원:</span>
									
									<span>${match.match_inwon}</span>
								</div>
								
								<div>
									<span class="detail-label">가격:</span>
									
									<span>
										<fmt:formatNumber value="${match.pay_amount / 2}" pattern="#,###"></fmt:formatNumber>원
									</span>
								</div>
							</div>
							
							<div class="buttons-container">
								<input type="hidden" name="match_date" value="${match.match_date}">
								<input type="hidden" name="start_time" value="${match.start_time}">
								<input type="hidden" name="end_time" value="${match.end_time}">
								<input type="hidden" name="home_team_id" value="${match.home_team_id}">
								<input type="hidden" name="pay_amount" value="${match.pay_amount}">
								<input type="hidden" name="match_inwon" value="${match.match_inwon}">
								<input type="hidden" name="field_res_id" value="${match.field_res_id}">
								<input type="hidden" name="field_code_id" value="${match.field_code_id}">
								
								<button type="submit" class="btn btn-success" style="height: 35px; margin-top: 25px;">참여하기</button>
							</div>
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