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
</body>
</html>