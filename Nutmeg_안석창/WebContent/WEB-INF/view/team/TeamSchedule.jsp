<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TeamSchedule.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/TeamMain.css?after">
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
					// fallback: 구분자 없는 일반 메시지
					swal("처리 필요", message, "info");
			}
		});
	</script>

	<c:remove var="message" scope="session"></c:remove>
</c:if>

<div class="main-background">
	<main>
		<div class="container-fluid container1">
			<div class="main">
				<div class="main-content">
					<ul class="team-menu">
						<li class="teampage-link"><a href="MyTeam.action">팀 정보</a></li>
						<li class="teampage-link"><a href="MyTeamSchedule.action">팀
								매치</a></li>
						<li class="teampage-link"><a href="MyTeamFee.action">팀 가계부</a></li>
						<li class="teampage-link"><a href="MyTeamBoard.action">팀
								게시판</a></li>
					</ul>
	
					<div class="header-container">
						<h1>팀 경기 일정</h1>
					</div>
	
					<!-- 보기 전환 버튼 -->
					<div class="view-buttons">
						<button id="listViewBtn" class="active">목록 보기</button>
						<button id="calendarViewBtn">캘린더 보기</button>
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
	
		<!-- 경기 상세 정보 모달 -->
		<div id="matchDetailsModal" class="modal">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title">경기 상세 정보</h3>
					<button class="close-modal" onclick="closeDetailsModal()">&times;</button>
				</div>
				<div id="matchDetailsContent">
					<!-- 상세 정보가 여기에 표시됩니다 -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						onclick="closeDetailsModal()">닫기</button>
				</div>
			</div>
		</div>
	</main>
</div>
</body>
</html>