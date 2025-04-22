<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TeamMain.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/TeamTemplate.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/TeamMain.css?after">

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<c:if test="${not empty sessionScope.message}">
	<script type="text/javascript">
		window.addEventListener("pageshow", function(event)
		{
			if (!event.persisted && performance.navigation.type != 2)
			{
				var message = "${fn:escapeXml(sessionScope.message)}";
				var parts = message.split(":");
				
				if (parts.length > 1)
				{
					var type = parts[0].trim();
					var content = parts[1].trim();
					
					switch (type)
					{
						case "SUCCESS_INSERT":
						case "SUCCESS_APPLY":
							swal("성공", content, "success");
							break;
						
						case "NEED_REGISTER_STADIUM":
							swal("주의", content, "warning");
							break;
							
						case "ERROR_DUPLICATE_JOIN":
						case "ERROR_AUTH_REQUIRED":
						case "ERROR_DUPLICATE_REQUEST":
							swal("에러", content, "error");
							break;
						
						default:
							swal("알림", content, "info");
					}
				}
				
				else
					// fallback: 구분자 없는 일반 메시지
					swal("처리 필요", message, "info");
			}
		});
	</script>
	
	<c:remove var="message" scope="session"></c:remove>
</c:if>

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
							<a href="MyTeamSchedule.action">동호회 매치 일정</a>
						</li>
						
						<li class="teampage-link">
							<a href="MyTeamFee.action">동호회 가계부</a>
						</li>
						
						<li class="teampage-link">
							<a href="MyTeamBoard.action">동호회 게시판</a>
						</li>
					</ul>
					
					<div class="section-header text-center mt-5 mb-5">
						<h1 class="display-5 fw-bold text-success">ℹ️ 동호회 정보</h1>
						
						<p class="text-muted mt-2">동호회 정보부터 회원 현황까지, 한 페이지에서 확인해보세요!</p>
						
						<div class="underline mt-3 mx-auto"></div>
					</div>
					
					<div class="team-info-wrap">
						<div class="left">
							<div class="team_box">
								<div class="team01">
									<div class="team-img">
										<c:choose>
										    <c:when test="${team.emblem != '/'}">
										        <img src="${team.emblem}" alt="${team.temp_team_name} 앰블럼">
										    </c:when>
										    
										    <c:when test="${team.emblem == '/' || team.emblem == null}">
										        <img src="images/noEmblem.png" alt="${team.temp_team_name} 앰블럼">
										    </c:when>
										</c:choose>
									</div>
									
									<div class="team-name">
										<h3>${team.temp_team_name}</h3>
									</div>
								</div>
								
								<div class="team02">
									<p class="comment">
										<c:choose>
											<c:when test="${team.temp_team_desc != null}">
												${team.temp_team_desc}
											</c:when>
											
											<c:when test="${team.temp_team_desc == null}">
												설명 없음
											</c:when>
										</c:choose>
									</p>
								</div>
							</div>
						</div>
						
						<div class="right">
							<table class="team-table">
								<caption>동호회 회원 정보</caption>
								
								<colgroup>
									<col style="width: 16.6%">
									<col style="width: 16.6%">
									<col style="width: 16.6%">
									<col style="width: 16.6%">
									<col style="width: 16.6%">
									<col style="width: 16.6%">
								</colgroup>
								
								<thead>
									<tr class="center">
										<th>이름</th>
										<th>역할</th>
										<th>포지션</th>
										<th>나이</th>
										<th>성별</th>
										<th>관리</th>
									</tr>
								</thead>
								
								<tbody class="center">
									<c:forEach var="teamMember" items="${teamMemberList}">
										<tr>
											<td>${teamMember.user_nick_name}</td>
											<td>${teamMember.member_status}</td>
											<td>${teamMember.position_name}</td>
											<td>${teamMember.age}</td>
											<td>${teamMember.gender}</td>
											
											<c:choose>
												<c:when test="${team.status == 1 && teamMember.member_status != '회장'}">
													<td>
														<a href="DropMember.action?team_member_id=${teamMember.team_member_id}" class="kick-button"
														onclick="return confirm('정말 강퇴하시겠습니까?');">강퇴</a>
													</td>
												</c:when>
												
												<c:when test="${teamMember.member_status == '회장' || teamMember.member_status != '회장'}">
													<td></td>
												</c:when>
											</c:choose>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div> <!-- .team-info-wrap -->
					
					<div class="team-modify">
						<c:if test="${team.status == 1}">
							<a href="TeamUpdate.action">
								<span>동호회 정보 수정</span>
							</a>
							
							<a href="MemberAppr.action">
								<span>동호회 회원 수락</span>
							</a>
						</c:if>
					</div>
				</div> <!-- .main-content  -->
			</div> <!-- .main  -->
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