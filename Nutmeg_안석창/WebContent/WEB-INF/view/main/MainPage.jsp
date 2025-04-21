<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/modal.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/MainPage.css?after">

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/MainPage.js?after"></script>

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
						case "ERROR":
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

<!-- 상세설명 모달 -->
<div id="descModal" class="modal">
	<div class="modal-content">
		<div class="modal-header">
			<h4 class="modal-title">
				<span id="descTeamStaus"></span>
				동호회 정보
			</h4>
		</div>
		
		<!-- 동호회 정보 폼 -->
		<!-- 내용 입력 섹션 -->
		<div class="modal_body">
			<div class ="modal-img">
				<img id="descTeamEmblem" alt="${team.temp_team_name} 앰블럼" class="circle-img">
			</div>
			
			<p id="descTeamName"></p>
			<p id="descTeamReion"></p>
			<p id="descTeamCity"></p>
			<p id="descTeamMemberCount"></p>
			<p id="descTeamDesc"></p>
		</div>

		<!-- 버튼 -->
		<div class="modal-footer">
			<a class="btn modal-submit" id="teamApply">동호회 참여</a>
			<button type="button" id="cancel-desc" class="btn modal-cancel cancel-btn">취소</button>
		</div>
	</div>
</div>

<div class="main-background">
	<main>
		<!-- 동호회 리스트 -->
		<div class="container mt-4">
			<div class="section-header text-center mt-3 mb-3">
			    <h1 class="display-5 fw-bold text-success">🥅 동호회 찾기</h1>
			    
			    <p class="text-muted mt-2">지역별 풋살 동호회를 살펴보고, 함께 뛰어볼 팀을 찾아보세요!</p>
			    
			    <div class="underline mt-3 mx-auto"></div>
			</div>
			
			<div class="row justify-content-center">
				<c:forEach var="team" items="${teamList}">
					<div class="col-md-4 d-flex justify-content-center">
						<div class="card">
							<div class="card-img">
								<div class="temp-icon">
									<c:if test="${team.team_id == 0}">
										🌱
									</c:if>
								</div>
								
								<!-- 동호회 앰블럼 -->
								<c:choose>
								    <c:when test="${team.emblem != '/'}">
								        <img src="${team.emblem}" alt="${team.temp_team_name} 앰블럼">
								    </c:when>
								    
								    <c:when test="${team.emblem == '/' || team.emblem == null}">
								        <img src="images/noEmblem.png" alt="${team.temp_team_name} 앰블럼">
								    </c:when>
								</c:choose>
							</div>
							
							<div class="card-content">
								<h2 value="${team.temp_team_name}">${team.temp_team_name}</h2>
								<!-- 동호회 이름 -->
								<p>${team.region_name} / ${team.city_name}</p>
								<!-- 동호회 지역 -->
								<input id="teamName" type="hidden" value="${team.temp_team_name}">
								<input id="teamDesc" type="hidden" value="${team.temp_team_desc}">
								<input id="teamRegion" type="hidden" value="${team.region_name}">
								<input id="teamCity" type="hidden" value="${team.city_name}">
								<input id="teamMemberCount" type="hidden" value="${team.member_count}">
								<input id="teamEmblem" type="hidden"  value="${team.emblem}"/>
								<input id="teamStaus" type="hidden" value="${team.team_id}">
								<input id="teamId" type="hidden" value="${team.temp_team_id}">
								<button class="card-action">자세히 보기</button>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</main>
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