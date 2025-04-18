<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	Integer user_code_id = (Integer) session.getAttribute("user_code_id");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MercenaryOffer.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/modal.css?after">

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/MercenaryOffer.css?after">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/Time.js?after"></script>
<script type="text/javascript">

	var contextPath = "${pageContext.request.contextPath}";

</script>
<script type="text/javascript" src="<%=cp %>/js/MercenaryOffer.js?after"></script>

</head>
<body>
<div class="main-background">
	<main>
		<div class="board-container">
			<div class="header-container">
				<div class="section-header text-center mt-3 mb-3">
					<h1 class="display-5 fw-bold text-success">🏃‍♂️ 용병 게시판</h1>
					
					<p class="text-muted mt-2">원하는 용병을 찾아 고용해보세요!</p>
					
				    <div class="underline mt-3 mx-auto"></div>
				</div>
			</div>
			
			<!-- 리스트 출력 -->
			<div class="table">
				<div class="table-header table-row">
					<div class="table-cell">닉네임</div>
					<div class="table-cell">포지션</div>
					<div class="table-cell">지역</div>
					<div class="table-cell">도시</div>
					<div class="table-cell">고용</div>
				</div>
				
				<div id="mercenaryList">
					<c:choose>
						<c:when test="${not empty mercenaryList}">
							<c:forEach var="mercenary" items="${mercenaryList}">
								<div class="table-row">
									<div class="table-cell">${mercenary.user_nick_name}</div>
									<div class="table-cell">${mercenary.position_name}</div>
									<div class="table-cell">${mercenary.region_name}</div>
									<div class="table-cell">${mercenary.city_name}</div>
									<div class="table-cell">
										<form action="hireMercenary.action" method="POST">
											<input type="hidden" name="mercenary_id" value="${mercenary.mercenary_id}">
											
											<button type="submit" class="btn-hire">고용</button>
										</form>
									</div>
								</div>
							</c:forEach>
						</c:when>
						
						<c:otherwise>
							<div class="table-row">
								<div class="table-cell">해당 날짜에 등록된 용병이 없습니다.</div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</main>
</div>

<div id="filterPanel" class="filter-panel">
	<h4>필터</h4>
	<hr>
	
	<div class="mb-3">
		<label for="regionSelect" class="form-label">지역</label>
		
		<select id="regionSelect" name="region" class="form-select">
			<option value="">전체</option>
			
			<c:forEach var="region" items="${regionList}">
				<option value="${region.region_id}">${region.region_name}</option>
			</c:forEach>
		</select>
	</div>
	
	<div class="mb-3">
		<label for="citySelect" class="form-label">도시</label>
		
		<select id="citySelect" name="city" class="form-select">
			<option value="">전체</option>
		</select>
	</div>
	
	<div class="mb-3">
		<div class="search-container">
			<label for="searchDate" class="form-label">날짜</label>
			
			<form class="search-form" id="dateSearchForm" action="mercenary.action" method="GET">
				<div class="input-group">
					<input type="date" class="date-input form-control" id="searchDate" name="searchDate" required>
					<button id="searchBtn" type="submit" class="btn-search btn btn-success">검색</button>
				</div>
			</form>
		</div>
	</div>
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