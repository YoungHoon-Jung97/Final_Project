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
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/modal.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style type="text/css">

/* 기본 배경 */
body
{
	background-color: #f9f9f9;
	background-image: url("background.png");
	background-size: cover;
	background-attachment: fixed;
	background-position: center;
	margin-top: 1rem;
	font-family: 'Poppins', sans-serif;
	color: #2e3d3d;
}

/* 카드 박스 */
.card
{
	width: 300px;
	background: rgba(255, 255, 255, 0.85);
	border-radius: 16px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	text-align: center;
	transition: transform 0.2s, box-shadow 0.3s ease-in-out;
	margin-top: 30px;
	backdrop-filter: blur(2px);
	border: 1px solid #d7f0e2;
}

.card:hover
{
	transform: translateY(-5px);
	box-shadow: 0 12px 28px rgba(0, 0, 0, 0.15);
}

/* 카드 이미지 영역 */
.card-img
{
	background-color: #cdece2;
	padding-top: 10px;
	padding-bottom: 30px;
	z-index: 1;
}

/* 이미지 원형 처리 */
.card-img img
{
	width: 80px;
	height: 80px;
	object-fit: cover;
	border-radius: 50%;
	border: 3px solid white;
	box-shadow: 0 0 6px rgba(0, 0, 0, 0.2);
}

/* 콘텐츠 텍스트 */
.card-content
{
	padding: 20px;
}

.card-content h2
{
	margin: 0;
	font-size: 1.5em;
	font-weight: bold;
	color: #356859;
}

.card-content p
{
	margin: 8px 0 0;
	font-size: 0.9em;
	color: #607466;
}

/* 버튼 스타일 */
.card-action
{
	margin-top: 16px;
	background: linear-gradient(to right, #7dcfb6, #80cfa9);
	color: white;
	border: none;
	padding: 10px 24px;
	border-radius: 8px;
	font-weight: bold;
	cursor: pointer;
	transition: background 0.3s ease;
}

.card-action:hover
{
	background: linear-gradient(to right, #65bda2, #6ab797);
}

/* 새싹 아이콘 */
.temp-icon
{
	margin-right: 250px;
	height: 30px;
}

/* 플로팅 버튼 */
.floatingButton-wrapper
{
	position: fixed;
	bottom: 30px;
	right: 40px;
	z-index: 1000;
	display: flex;
	flex-direction: column;
	align-items: flex-end;
}

.floatingButton-wrapper:hover
{
	width: 120px;
}

.floatingButton
{
	background-color: #a8d5ba;
	color: white;
	border: none;
	border-radius: 50%;
	width: 50px;
	height: 50px;
	font-size: 20px;
	box-shadow: 0 6px 18px rgba(0, 0, 0, 0.2);
	padding: 0;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
	transition: background-color 0.3s;
}

.floatingButton:hover {
	background-color: #94c9ab;
}

.floatingButton-img
{
	width: 70%;
	height: 70%;
	object-fit: contain;
	transition: transform 0.2s ease;
}

/* 서브 아이콘들 */
.top-icon-slide, .left-icon-slide
{
	background-color: rgba(128, 128, 128, 0.7);
	color: white;
	font-size: 24px;
	border: none;
	border-radius: 50%;
	width: 40px;
	height: 40px;
	display: flex;
	justify-content: center;
	align-items: center;
	opacity: 0;
	transition: opacity 0.3s ease, transform 0.3s ease, background-color 0.4s ease;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
	pointer-events: none;
}

.top-icon-slide
{
	transform: translateY(10px);
	margin-bottom: 10px;
	margin-right: 5px;
}

.top-icon-slide:hover
{
	background-color: #84b6f4;
}

.left-icon-slide
{
	position: absolute;
	transform: translateX(10px);
	right: 60px;
	bottom: 5px;
}

.left-icon-slide:hover
{
	background-color: #f48989;
}

.floatingButton-wrapper:hover .top-icon-slide
{
	opacity: 1;
	transform: translateY(0);
	pointer-events: auto;
}

.floatingButton-wrapper:hover .left-icon-slide
{
	opacity: 1;
	transform: translateX(0);
	pointer-events: auto;
}

.bi-funnel-fill
{
	margin-top: 5px;
}

/* 필터 패널 */
.filter-panel
{
	position: fixed;
	top: 0;
	left: -300px;
	width: 260px;
	height: 100%;
	background-color: rgba(255, 255, 255, 0.9);
	box-shadow: 4px 0 12px rgba(0, 0, 0, 0.2);
	padding: 20px;
	z-index: 1100;
	transition: left 0.3s ease;
	overflow-y: auto;
	backdrop-filter: blur(4px);
}

/* 활성화 시 왼쪽으로 슬라이드 인 */
.filter-panel.active
{
	left: 0;
}

/* 필터 안에 있는 텍스트 기본 스타일 보정 */
.filter-panel label, .filter-panel input, .filter-panel select {
	color: #355e3b;
	font-weight: 500;
	font-size: 0.95em;
}


</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#descModal").css('display','none');
		
	    $(".card-action").on("click",function(){
	    	
	    	var card = $(this).closest('.card');
	    	var teamId = card.find('#teamId').val();
	    	
	    	$('#descTeamName').text(card.find('#teamName').val());
	    	$('#descTeamDesc').text(card.find('#teamDesc').val());
	    	$('#descTeamReion').text(card.find('#teamRegion').val());
	    	$('#descTeamCity').text(card.find('#teamCity').val());
	    	$('#descTeamMemberCount').text(card.find('#teamMemberCount').val());
	    	$('#descTeamEmblem').attr('src',card.find('#teamEmblem').val());
	    	if (teamStaus == 'TEMP_TEAM') {
	    	    $('#descTeamStaus').text('임시');
	    	    $('#teamApply').attr('href', 'TeamApply.action?teamId=' + teamId);
	    	} else {
	    	    $('#descTeamStaus').text('정식');
	    	    $('#teamApply').attr('href', 'TeamApply.action?teamId=' + teamId);
	    	}

	    	
	    	$("#descModal").show();
	    	
	    	$("body").css("overflow", "hidden"); // 페이지 스크롤 방지
	    	
	    });
	    
	
	    // 모달 닫기 버튼
	    $("#cancel, #cancel-desc").on("click", function() {
	        $("#descModal").hide(); // 모달 숨기기
	        $("body").css("overflow", "auto"); // 페이지 스크롤 복원
	    });
	    
	    
	});

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>
</head>
<body>

<!-- 상세설명 모달 -->
<div id="descModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">동호회</h3>
            <span id="cancel" class="close-modal">&times;</span>
        </div>
        
        <!-- 동호회 정보 폼 -->
            <!-- 내용 입력 섹션 -->
            <div class="vote-section content-section">
                <h4 class="section-title"><span id="descTeamStaus"></span>동호회 정보</h4>
                <div class ="modal-img">
                	<img id="descTeamEmblem"  alt="${team.temp_team_name} 앰블럼">
                </div>
                <p id="descTeamName"></p>
                <p id="descTeamReion"></p>
                <p id="descTeamCity"></p>
                <p id="descTeamMemberCount"></p>
                <p id="descTeamDesc"></p>
            </div>

            <!-- 버튼 -->
            <div class="modal-buttons">
                <!-- <button type="button" id="submit-desc" class="modal-button submit-btn">동호회 참여</button> -->
                <a class="btn btn-primary" id="teamApply">동호회 참여</a>
                <button type="button" id="cancel-desc" class="btn btn-reset cancel-btn">취소</button>
            </div>
        </div>
    </div>
</div>

<main>
	
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
							<img src="${team.emblem}" alt="${team.temp_team_name} 앰블럼">
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
							<input id="teamMemberCount" type="hidden" value="${team.temp_team_person_count}">
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

<% if(request.getParameter("message") != null) { %>
          <script type="text/javascript">
              alert("<%= request.getParameter("message") %>");
              window.location.href = "MainPage.action";
          </script>
<% } %>
</main>
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