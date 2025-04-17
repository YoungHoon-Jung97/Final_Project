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
<title>StadiumMainPage.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/StadiumMainPage.css?after">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	var contextPath = "${pageContext.request.contextPath}";

</script>
<script type="text/javascript" src="<%=cp %>/js/StadiumMainPage.js?after"></script>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<div class="main-background">
	<main>
		<section class="container py-5">
			<div class="section-header text-center mt-3 mb-3">
			    <h1 class="display-5 fw-bold text-success">⚽ 경기장 예약하기</h1>
			    
			    <p class="text-muted mt-2">원하는 풋살장을 선택하고, 빠르게 예약해보세요!</p>
			    
			    <div class="underline mt-3 mx-auto"></div>
			</div>
			
			<!-- 경기장 리스트 -->
			<div class="row g-4">
				<c:forEach var="field" items="${fieldApprOkList}">
					<div class="col-6">
						<form action="FieldReservationForm.action" method="POST" class="card h-100">
							<div class="row g-0 h-100">
								<!-- 이미지 영역 -->
								<div class="col-5 field-img">
									<img src="${field.field_reg_image}" class="img-fluid rounded-start"
									style="height: 250px; width: 250px; object-fit: cover;">
								</div>
								
								<!-- 내용 + 버튼 -->
								<div class="col-7 d-flex flex-column justify-content-between">
									<div class="card-body">
										<h4 class="card-title">구장: ${field.stadium_reg_name}</h4>
										
										<h5 class="card-title">경기장: ${field.field_reg_name}</h5>
										
										<p class="card-text">주소: ${field.stadium_reg_addr}, ${field.stadium_reg_detailed_addr}</p>
										
										<p class="card-text">이용요금: ${field.field_reg_price}원</p>
										
										<p class="card-text">이용시간: ${field.stadium_time_name1}시 ~ ${field.stadium_time_name2}시</p>
									</div>
									
									<!-- 예약 버튼 + field_code_id 전달 -->
									<div class="px-3 pb-3 d-flex justify-content-end align-items-end mt-auto">
										<input type="hidden" name="field_code_id" value="${field.field_code_id}">
										
										<button type="submit" class="btn btn-outline-primary">경기장 예약하기</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</c:forEach>
			</div>
		</section>
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
		<form class="row g-2 align-items-center">
			<label for="title" class="form-label">경기장 검색</label>
			
			<div class="input-group">
				<input type="text" class="form-control" name="title" id="title" placeholder="검색어 입력">
				
				<button type="submit" class="btn btn-success" id="searchBtn">검색</button>
			</div>
		</form>
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