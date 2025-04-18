<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	
	java.util.Calendar cal = java.util.Calendar.getInstance(); // 오늘 날짜 기준
	cal.add(java.util.Calendar.DATE, 1); // 하루 더하기
	String tomorrow = sdf.format(cal.getTime());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FieldReservationForm.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/FieldReservationForm.css?after">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6474375f344948f35b988948291eb5f2&libraries=services"></script>
<script type="text/javascript">

	var fullAddress = "${field_addr}";

</script>
<script type="text/javascript" src="<%=cp %>/js/FieldReservationForm.js?after"></script>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<div class="main-background">
	<main>
		<div class="container mt-4">
			<form action="FieldReservationCheckForm.action" method="post">
				<div class="main">
					<c:forEach var="field" items="${fieldApprOkSearchList}">
						<div class="row mb-4 align-items-stretch">
							<div class="col-12">
								<img src="${field.field_reg_image}" class="img-fluid rounded shadow-sm mb-3 mx-auto d-block"
								alt="경기장 이미지" style="max-height: 500px;">
								
								<ul class="list-group list-group-flush shadow-sm rounded">
									<li class="list-group-item"><strong>이름:</strong> ${field.field_reg_name}</li>
									<li class="list-group-item"><strong>위치:</strong> ${field.stadium_reg_addr}, ${field.stadium_reg_detailed_addr}</li>
									<li class="list-group-item"><strong>크기:</strong> ${field.field_reg_garo}m × ${field.field_reg_sero}m</li>
									<li class="list-group-item"><strong>가격:</strong> ${field.field_reg_price}원</li>
								</ul>
							</div>
						</div>
						
						<input type="hidden" name="field_code_id" id="field_code_id" value="${field.field_code_id}">
						<input type="hidden" name="field_reg_price" id="field_reg_price" value="${field.field_reg_price}">
						<input type="hidden" id="timeStartLimit" value="${field.stadium_time_id1}">
						<input type="hidden" id="timeEndLimit" value="${field.stadium_time_id2}">
					
						<div class="card p-3 shadow-sm mb-4">
							<label for="matchDateInput" class="form-label fw-bold">예약 날짜 선택</label>
							<input type="date" id="matchDateInput" name="match_date" class="form-control" value="" min="<%=tomorrow%>">
						</div>
						
						<div class="time-table card p-3 shadow-sm mb-4" style="display: none;">
							<div class="time-bar">
								<div class="time-container" data-time-id="1">
									<div class="time-title">06:00 ~ 07:50</div>
								</div>
								<div class="time-container" data-time-id="2">
									<div class="time-title">08:00 ~ 09:50</div>
								</div>
								<div class="time-container" data-time-id="3">
									<div class="time-title">10:00 ~ 11:50</div>
								</div>
								<div class="time-container" data-time-id="4">
									<div class="time-title">12:00 ~ 13:50</div>
								</div>
								<div class="time-container" data-time-id="5">
									<div class="time-title">14:00 ~ 15:50</div>
								</div>
								<div class="time-container" data-time-id="6">
									<div class="time-title">16:00 ~ 17:50</div>
								</div>
								<div class="time-container" data-time-id="7">
									<div class="time-title">18:00 ~ 19:50</div>
								</div>
								<div class="time-container" data-time-id="8">
									<div class="time-title">20:00 ~ 21:50</div>
								</div>
								<div class="time-container" data-time-id="9">
									<div class="time-title">22:00 ~ 23:50</div>
								</div>
							</div>
						</div>
						
						<input type="hidden" name="start_time_id" id="start_time_id" value="">
						<input type="hidden" name="end_time_id" id="end_time_id" value="">
						<input type="hidden" name="start_time_text" id="start_time_text" value="">
						<input type="hidden" name="end_time_text" id="end_time_text" value="">
						
						<div class="d-flex justify-content-end mt-3">
							<button type="button" id="submit-button" class="btn btn-primary" disabled>예약하기</button>
							<button type="button" id="reset-button" class="btn btn-outline-secondary ms-2">초기화</button>
						</div>
						
						<div class="card p-3 shadow-sm mb-4">
							<h5 class="fw-bold">위치 지도</h5>
							
							<div id="map" class="map"></div>
							
							<div class="text-end mt-2">
								<button type="button" onclick="initialize()" class="btn btn-outline-secondary">지도 되돌리기</button>
							</div>
						</div>
						
						<div class="card p-3 shadow-sm mb-4">
							<h5 class="fw-bold">설명</h5>
							
							<div class="row">
								<c:forEach var="entry" items="${field.facilitiesMap}" varStatus="status">
									<div class="col-md-4 mb-3">
										<div class="border rounded p-3 d-flex justify-content-between align-items-center">
											<div>
												<c:choose>
													<c:when test="${entry.key == '샤워실'}">
														<i class="bi bi-droplet me-2"></i>
													</c:when>
													
													<c:when test="${entry.key == '탈의실'}">
														<i class="bi bi-person-lines-fill me-2"></i>
													</c:when>
													
													<c:when test="${entry.key == '주차장'}">
														<i class="bi bi-car-front-fill me-2"></i>
													</c:when>
													
													<c:when test="${entry.key == '음료판매'}">
														<i class="bi bi-cup-straw me-2"></i>
													</c:when>
													
													<c:when test="${entry.key == '풋살화대여'}">
														<i class="bi bi-bag-check-fill me-2"></i>
													</c:when>
													
													<c:when test="${entry.key == '조끼대여'}">
														<i class="bi bi-backpack me-2"></i>
													</c:when>
													
													<c:otherwise>
														<i class="bi bi-question-circle me-2"></i>
													</c:otherwise>
												</c:choose>
												
												${entry.key}
											</div>
										
											<div>
												<c:choose>
													<c:when test="${entry.value}">
														<span class="text-success">사용 가능</span>
													</c:when>
													
													<c:otherwise>
														<span class="text-danger">없음</span>
													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</div>
									
									<c:if test="${(status.index + 1) % 3 == 0}">
										<div class="row">
										
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
						
						<div class="card p-3 shadow-sm mb-5">
							<h5 class="fw-bold">주의 사항</h5>
							
							<p>${field.field_reg_notice}</p>
						</div>
					</c:forEach>
				</div>
			</form>
		</div>
	</main>
</div>
</body>
</html>