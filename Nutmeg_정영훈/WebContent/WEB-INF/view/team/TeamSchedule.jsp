<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	int team_status = Integer.parseInt(session.getAttribute("team_status").toString());
	System.out.println("\n===============[동호회장 확인]===============");
	System.out.println("동호회장 확인 : " + team_status);
	System.out.println("=============================================");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TeamSchedule.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/modal.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/TeamTemplate.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/TeamSchedule.css?after">

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales-all.min.js"></script>
<script type="text/javascript">

	var contextPath = "${pageContext.request.contextPath}";

</script>
<script type="text/javascript" src="<%=cp %>/js/Modal.js?after"></script>
<script type="text/javascript" src="<%=cp %>/js/TeamSchedule.js?after"></script>

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
					swal("처리 필요", message, "info");
			}
		});
	</script>

	<c:remove var="message" scope="session"></c:remove>
</c:if>

<!-- 경기 상세 정보 모달 -->
<div id="matchDetailsModal" class="modal">
	<div class="modal-content">
		<div class="modal-header">
			<h3 class="modal-title">경기 상세 정보</h3>
		</div>
		
		<div id="matchDetailsContent">
			<!-- 상세 정보가 여기에 표시됩니다 -->
		</div>
		
		<div class="modal-footer">
			<button type="button" class="btn btn-secondary" onclick="closeDetailsModal()">닫기</button>
		</div>
	</div>
</div>

<div class="main-background">
	<main>
		<div class="container-fluid container1">
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
						<h1 class="display-5 fw-bold text-success">📅 동호회 매치 일정</h1>
						
						<p class="text-muted mt-2">우리 동호회의 매치 스케줄을 한눈에 확인해보세요!</p>
						
						<div class="underline mt-3 mx-auto"></div>
					</div>
					
					<!-- 캘린더 보기 -->
					<div id="calendarView" style="display: none;">
						<div id="calendar"></div>
					</div>
					
					<!-- 목록 보기 -->
					<div id="listView" class="match-list">
						<!-- 일정 항목들이 동적으로 추가됩니다 -->
					</div>
				</div>
			</div>
		</div>
	</main>
</div>

<div id="filterPanel" class="filter-panel">
	<h4>필터</h4>
	<hr>
	
	<div class="view-buttons">
		<button id="listViewBtn" class="active">목록 보기</button>
		<button id="calendarViewBtn">캘린더 보기</button>
	</div>
	
	<div class="mb-3">
		<label class="form-label">상태</label>
		
		<div class="status-filter-container">
			<button class="status-filter-btn" data-status="all">전체</button>
			<button class="status-filter-btn" data-status="예정됨">예정됨</button>
			<button class="status-filter-btn" data-status="완료됨">완료됨</button>
			<button class="status-filter-btn" data-status="취소됨">취소됨</button>
			<button class="status-filter-btn" data-status="결제대기">결제대기</button>
			<button class="status-filter-btn" data-status="상대미정">상대미정</button>
			<button class="status-filter-btn" data-status="결과입력대기">결과입력대기</button>
		</div>
	</div>
</div>

<!-- 플로팅 버튼 (Top, 필터) -->
<div class="floatingButton-wrapper" id="floatingButton-wrapper">
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