<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

<link rel="stylesheet" type="text/css" href="<%=cp%>/css/modal.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/MainPage.css?after">

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/MainPage.js?after"></script>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

<style>
/* 이미지 배너 공통 스타일 */
.side-banner {
    position: fixed;
    bottom: 200px;
    width: 150px;
    z-index: 999;
}

/* 왼쪽 배너 위치 */
.left-banner {
    left: 50px;
}

/* 오른쪽 배너 위치 */
.right-banner {
    right: 150px;
}

/* 이미지 스타일 */
.side-banner img {
    width: 180%;
    height: 150%;
    border-radius: 15px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
}
.music-banner {
    position: fixed;
    top: 30px;
    right: 30px;
    background: #fff;
    border-radius: 12px;
    padding: 10px 15px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    z-index: 1000;
    display: flex;
    align-items: center;
    gap: 10px;
}

.music-banner button {
    border: none;
    background: none;
    font-size: 20px;
    cursor: pointer;
}

.music-banner img {
    width: 30px;
    height: 30px;
}

/* 모바일에서는 배너 숨김 */
@media screen and (max-width: 992px) {
    .side-banner {
        display: none;
    }
    .music-banner {
        display: none;
    }
    .weather-widget {
        display: none;
    }
}
#mainCarousel {
    width: 80%;
    margin: 30px auto;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: #00000040;
}
#mainCarousel img {
    height: auto;
    max-height: 350px;
    width: 100%;
    object-fit: contain;
    background-color: #E2E2E2; /* 혹시 이미지가 작을 경우 배경 */
}
</style>
</head>
<body>
	<c:if test="${not empty sessionScope.message}">
		<script type="text/javascript">
			window.addEventListener("pageshow", function(event)
			{
				if (!event.persisted && performance.navigation.type !== 2)
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

	<!-- 상세설명 모달 -->
	<div id="descModal" class="modal">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">
					<span id="descTeamStaus"></span> 동호회 정보
				</h4>
			</div>
			<div class="modal_body">
				<div class="modal-img">
					<img id="descTeamEmblem" alt="${team.temp_team_name} 앰블럼" class="circle-img">
				</div>
				<p id="descTeamName"></p>
				<p id="descTeamReion"></p>
				<p id="descTeamCity"></p>
				<p id="descTeamMemberCount"></p>
				<p id="descTeamDesc"></p>
			</div>
			<div class="modal-footer">
				<a class="btn modal-submit" id="teamApply">동호회 참여</a>
				<button type="button" id="cancel-desc" class="btn modal-cancel cancel-btn">취소</button>
			</div>
		</div>
	</div>
	
	<!-- 슬라이드 이미지 배너 -->
	<div id="mainCarousel" class="carousel slide" data-bs-ride="carousel">
	  <div class="carousel-inner">
	    <div class="carousel-item active">
	      <img src="<%=cp%>/images/pic1.jpg" class="d-block w-100" alt="축구 이미지 1">
	    </div>
	    <div class="carousel-item">
	      <img src="<%=cp%>/images/pic4.jpg" class="d-block w-100" alt="축구 이미지 2">
	    </div>
	    <div class="carousel-item">
	      <img src="<%=cp%>/images/pic2.jpg" class="d-block w-100" alt="축구 이미지3">
	    </div>
	    <div class="carousel-item">
	      <img src="<%=cp%>/images/pic5.jpg" class="d-block w-100" alt="축구 이미지4">
	    </div>
	  </div>
	  <button class="carousel-control-prev" type="button" data-bs-target="#mainCarousel" data-bs-slide="prev">
	    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">이전</span>
	  </button>
	  <button class="carousel-control-next" type="button" data-bs-target="#mainCarousel" data-bs-slide="next">
	    <span class="carousel-control-next-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">다음</span>
	  </button>
	</div>

	<div class="main-background">
		<main>
			<!-- 동호회 리스트 -->
			<div class="container mt-4">
				<div class="section-header text-center mt-3 mb-3">
					<h1 class="display-5 fw-bold text-success">⚽ 동호회 찾기</h1>
					<p class="text-muted mt-2">지역별 풋살 동호회를 살펴보고, 함께 뛰어볼 팀을 찾아보세요!</p>
					<div class="underline mt-3 mx-auto"></div>
				</div>

				<div class="row justify-content-center">
					<c:forEach var="team" items="${teamList}">
						<div class="col-md-4 d-flex justify-content-center">
							<div class="card">
								<div class="card-img">
									<div class="temp-icon">
										<c:if test="${team.team_id == 0}">🌱</c:if>
									</div>
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
									<p>${team.region_name}/ ${team.city_name}</p>
									<input id="teamName" type="hidden" value="${team.temp_team_name}">
									<input id="teamDesc" type="hidden" value="${team.temp_team_desc}">
									<input id="teamRegion" type="hidden" value="${team.region_name}">
									<input id="teamCity" type="hidden" value="${team.city_name}">
									<input id="teamMemberCount" type="hidden" value="${team.member_count}">
									<input id="teamEmblem" type="hidden" value="${team.emblem}" />
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

	<!-- 플로팅 버튼 -->
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

	<%-- <!-- 왼쪽 광고 배너 -->
	<div class="side-banner left-banner">
	    <img src="<%=cp%>/images/messi1.jpg" alt="왼쪽 배너" />
	</div>
	
	<!-- 오른쪽 광고 배너 -->
	<div class="side-banner right-banner">
	    <img src="<%=cp%>/images/ronaldo.jpg" alt="오른쪽 배너" />
	</div> --%>
	
	<!-- 음악 배너 -->
	<div class="music-banner">
	    <img src="<%=cp%>/images/musicphoto.jpg" alt="노래 아이콘" />
	    <span id="musicStatus">재생 중지</span>
	    <button id="toggleMusicBtn" title="음악 재생/정지">🎵</button>
	    <audio id="bgMusic" loop>
	        <source src="<%=cp%>/audio/champions.mp3" type="audio/mpeg">
	    </audio>
	</div>

	<!-- 스크립트 영역 -->
	<script>
		document.getElementById("topIconButton").addEventListener("click", function () {
			window.scrollTo({ top: 0, behavior: "smooth" });
		});

		document.getElementById("leftIconButton").addEventListener("click", function () {
			var panel = document.getElementById("filterPanel");
			panel.classList.toggle("active");
		});

		document.getElementById("toggleMusicBtn").addEventListener("click", function () {
		    var music = document.getElementById("bgMusic");
		    var statusText = document.getElementById("musicStatus");

		    if (music.paused) {
		        music.play();
		        statusText.textContent = "재생 중";
		    } else {
		        music.pause();
		        statusText.textContent = "재생 중지";
		    }
		});
	</script>
</body>
</html>