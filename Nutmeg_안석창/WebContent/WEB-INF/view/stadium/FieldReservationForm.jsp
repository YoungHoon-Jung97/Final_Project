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
						<div class="row mb-4">
							<div class="col-md-6">
								<img src="${field.field_reg_image}" class="img-fluid rounded shadow-sm" alt="경기장 이미지">
							</div>
							<div class="col-md-6">
								<ul class="list-group list-group-flush shadow-sm rounded">
									<li class="list-group-item"><strong>이름:</strong> ${field.field_reg_name}</li>
									<li class="list-group-item"><strong>경기장 코드:</strong> ${field.field_code_id}</li>
									<li class="list-group-item"><strong>위치:</strong> ${field.stadium_reg_addr}, ${field.stadium_reg_detailed_addr}</li>
									<li class="list-group-item"><strong>가격:</strong> ${field.field_reg_price}원</li>
									<li class="list-group-item"><strong>크기:</strong> ${field.field_reg_garo}m × ${field.field_reg_sero}m</li>
								</ul>
							</div>
						</div>
						
						<input type="hidden" name="field_code_id" id="field_code_id" value="${field.field_code_id}">
						<input type="hidden" name="field_reg_price" id="field_reg_price" value="${field.field_reg_price}">
						<input type="hidden" id="timeStartLimit" value="${field.stadium_time_id1}">
						<input type="hidden" id="timeEndLimit" value="${field.stadium_time_id2}">
					</c:forEach>

					<div class="card p-3 shadow-sm mb-4">
						<label for="matchDateInput" class="form-label fw-bold">예약 날짜 선택</label>
						<input type="date" id="matchDateInput" name="match_date" class="form-control" value="" min="<%=tomorrow%>">
					</div>

					<div class="time-table card p-3 shadow-sm mb-4">
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
						<h5 class="fw-bold">설명</h5>
						<p>천연 잔디 구장, 야간 조명 시설 완비. 인조잔디 구장도 있음. 샤워실, 주차장 등 부대시설 완비.</p>
					</div>

					<div class="card p-3 shadow-sm mb-4">
						<h5 class="fw-bold">위치 지도</h5>
						<div id="map" class="map"></div>
						<div class="text-end mt-2">
							<button type="button" onclick="mapload()" class="btn btn-outline-secondary">지도 되돌리기</button>
						</div>
					</div>

					<div class="card p-3 shadow-sm mb-5">
						<h5 class="fw-bold">주의 사항</h5>
						<p>
							- 대여 시간보다 적게 사용 하더라도 대관비는 환불되지 않습니다.<br>
							- 무료 주차 가능하나, 주차 대수 제한이 있으니 미리 가능 여부를 필히 확인하시기 바랍니다.<br>
							- 시설 훼손 및 기물 파손 시 손해액을 호스트에게 배상하여야 합니다.<br>
							- 외부신발(특히 비, 눈 오는날) 은 밖에서 발바닥면을 닦고 입장부탁드리며, 체육관 내부에서는 꼭 실내용 신발을 착용해주세요.<br>
							- 대관하신 체육관(대체육관, 소체육관)만 사용부탁드립니다. 해당사항을 위반할 시, 추가요금이 청구됩니다.<br>
							- 퇴실시, 화장실을 포함한 모든 불은 소등부탁드리며, 사용하신 냉난방기도 꼭 꺼주세요.<br>
							- 사용하신 물건은 제자리에 정리정돈 부탁드리며, 쓰레기는 쓰레기통에 분리하여 버려주세요.<br>
							- 화장실(남자, 여자)은 체육관과 같은 2층에 있습니다.<br>
							- 시간 초과시, 추가 요금은 현장 결제로 진행됩니다. (1시간 마다 발생)<br>
							- 체육관 내 주류는 반입불가이며, 금연구역입니다. 적발시, 즉시 퇴실조치되며, 환불되지않습니다.<br>
							- 냉난방기 이용시, 온도가 자동으로 설정되어있으니 꼭 전원버튼만 눌러서 사용해주세요.
						</p>
					</div>
				</div>
			</form>
		</div>
	</main>
</div>
</body>
</html>