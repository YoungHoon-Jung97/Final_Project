<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	Integer team_id = (Integer) session.getAttribute("team_id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberAppr.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/TeamTemplate.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/MemberAppr.css?after">

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<div class="main-background">
	<main>
		<div class="container-fluid container">
			<div class="main">
				<div class="main-content">
					<ul class="team-menu">
						<li class="teampage-link">
							<a href="MyTeam.action">동호회 정보</a>
						</li>
						
						<li class="teampage-link">
							<a href="MyTeamSchedule.action">동호회 매치</a>
						</li>
						
						<li class="teampage-link">
							<a href="MyTeamFee.action">동호회 가계부</a>
						</li>
						
						<li class="teampage-link">
							<a href="MyTeamBoard.action">동호회 게시판</a>
						</li>
					</ul>
					
					<div class="member-card-container">
						<h1>동호회 신청 수락 관리</h1>
						
						<table>
							<thead>
								<tr>
									<th>닉네임</th>
									<th>포지션</th>
									<th>가입 이유</th>
									<th>신청일</th>
									<th>승인 / 거절</th>
								</tr>
							</thead>
							
							<tbody>
								<c:forEach var="teamApply" items="${teamApplyList}">
									<tr>
										<td>${teamApply.user_nick_name}</td>
										<td>${teamApply.position_name}</td>
										<td>${teamApply.team_apply_desc}</td>
										<td>${teamApply.team_apply_at}</td>
										<td>
											<a href="AddMember.action?team_apply_id=${teamApply.team_apply_id}&user_code_id=${teamApply.user_code_id}&team_id=${team.temp_team_id}"
											class="approve-btn" style="text-decoration:none;">승인</a>
											
											<a href="CancelApply.action?team_apply_id=${teamApply.team_apply_id}&user_code_id=${teamApply.user_code_id}&team_id=${team.temp_team_id}"
											class="reject-btn" style="text-decoration:none;" onclick="return confirm('정말 거절하시겠습니까?');">거절</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</main>
</div>

<!-- 플로팅 버튼 (Top) -->
<div class="floatingButton-wrapper">
	<button id="topIconButton" class="top-icon-slide" title="맨 위로 이동">
		<i class="bi bi-caret-up-fill"></i>
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

</script>
</body>
</html>