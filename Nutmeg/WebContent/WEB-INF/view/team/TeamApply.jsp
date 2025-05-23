<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TeamApply.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/team/TeamTemplate.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/team/TeamMain.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/util/modal.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/team/TeamApply.css?after">

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/TeamApply.js?after"></script>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<!-- 팀 참여 모달 -->
<div id="applyModal" class="modal">
	<div class="modal-content">
		<div class="modal-header">
			<h3 class="modal-title">팀 신청</h3>
		</div>
		
		<div class="modal-body">
			<form action="TeamApplyInsert.action" method="post">
				<div class="content-section">
					<h4 class="section-title" style="margin-bottom: 10px;">포지션 선택</h4>
					
					<div class="w-100" role="group" aria-label="Position Selection" style="margin-bottom: 10px;">
						<c:forEach var="position" items="${positionList}">
							<button type="button" class="btn btn-outline-primary position-button w-100" data-position-id="${position.position_id}">
								${position.position_name}
							</button>
						</c:forEach>
					</div>
					
					<h4 class="section-title">신청자 설명</h4>
					
					<textarea id="apply-content" placeholder="자신의 정보를 입력하세요."
					name="team_apply_desc" rows="5" style="width: 100%; overflow: hidden; white-space: pre-wrap; word-wrap: break-word;"></textarea>
						
					<input type="hidden" name="team_id" value="${team_id}">
					<input type="hidden" name="position_id" id="selected-position-id">
				</div>
				
				<div class="modal-footer">
					<button type="submit" id="submit-apply" class="modal-button modal-submit">신청</button>
					<button type="reset" id="reset-apply" class="modal-button modal-cancel">취소</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="main-background">
	<main>
		<div class="container-fluid container">
			<div class="main">
				<div class="main-content">
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
									<col style="width: 20%">
									<col style="width: 20%">
									<col style="width: 20%">
									<col style="width: 20%">
									<col style="width: 20%">
								</colgroup>
								
								<thead>
									<tr class="center">
										<th>이름</th>
										<th>역할</th>
										<th>포지션</th>
										<th>나이</th>
										<th>성별</th>
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
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div> <!-- .team-info-wrap -->
					
					<div class="team-modify">
						<button id="teamApply">팀 가입</button>
					</div>
				</div> <!-- .main-content  -->
			</div> <!-- .main  -->
		</div>
	</main>
	
	<c:import url="/WEB-INF/view/Footer.jsp"></c:import>
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