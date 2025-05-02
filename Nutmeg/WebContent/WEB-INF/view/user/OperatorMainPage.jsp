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
<title>OperatorMainPage.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/util/UserTemplate.css?after">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript" src="<%=cp %>/js/OperatorMainPage.js?after"></script>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<div class="main-background">
	<main>
		<div class="container wrapper">
			<section class="content-area" id="content-area">
				<h4 class="mb-4">구장 운영자 대시보드</h4>
				
				<!-- 요약 카드 섹션 -->
				<div class="dashboard-summary row mb-5">
					<div class="col-md-3">
						<div class="summary-card">
							<div class="icon-box pastel-green">
								<i class="bi bi-building"></i>
							</div>
							
							<div class="summary-text">
								<div class="label">총 구장 수</div>
								<div class="value">${totalStadiumCount}개</div>
							</div>
						</div>
					</div>
					
					<div class="col-md-3">
						<div class="summary-card">
							<div class="icon-box pastel-blue">
								<i class="bi bi-calendar-event"></i>
							</div>
							
							<div class="summary-text">
								<div class="label">오늘 예약 수</div>
								<div class="value">${todayReservationCount}건</div>
							</div>
						</div>
					</div>
					
					<div class="col-md-3">
						<div class="summary-card">
							<div class="icon-box pastel-purple">
								<i class="bi bi-currency-dollar"></i>
							</div>
							
							<div class="summary-text">
								<div class="label">이번 달 매출</div>
								<div class="value">${monthlyRevenue}원</div>
							</div>
						</div>
					</div>
					
					<div class="col-md-3">
						<div class="summary-card">
							<div class="icon-box pastel-orange">
								<i class="bi bi-clock-history"></i>
							</div>
							<div class="summary-text">
								<div class="label">대기 중 승인</div>
								<div class="value">${pendingApprovals}건</div>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 최근 예약 테이블 -->
				<h5 class="mb-3">최근 예약 내역</h5>
				
				<div class="table-container">
					<table class="table table-hover align-middle shadow-sm">
						<thead class="table-light">
							<tr>
								<th>예약일</th>
								<th>경기장명</th>
								<th>시간</th>
								<th>결제 금액</th>
								<th>상태</th>
							</tr>
						</thead>
						
						<tbody>
							<c:forEach var="r" items="${recentReservations}">
								<tr>
									<td>${r.match_date}</td>
									<td>${r.field_name}</td>
									<td>${r.start_time}~${r.end_time}</td>
									<td>${r.pay_amount}원</td>
									<td>${r.match_status}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</section>
			
			<!-- 사이드바 -->
			<aside class="sidebar">
				<nav>
					<a class="nav-link menu-link active" onclick="location.reload();">
						<i class="bi bi-house-door me-2"></i> 구장 운영자 대시보드
					</a>
					
					<a class="nav-link menu-link" data-url="OperatorStadiumListForm.action">
						<i class="bi bi-house-door me-2"></i> 나의 구장 목록
					</a>
					
					<a class="nav-link menu-link" data-url="OperatorStadiumUpdateList.action">
						<i class="bi bi-pencil-square me-2"></i> 구장 정보 수정
					</a>
					
					<a class="nav-link menu-link" data-url="OperatorFieldUpdateListForm.action">
						<i class="bi bi-gear me-2"></i> 경기장 정보 수정
					</a>
					
					<a class="nav-link menu-link" data-url="OperatorStadiumHolidayInsertListForm.action">
						<i class="bi bi-calendar-plus me-2"></i> 구장 휴무일 입력
					</a>
					
					<a class="nav-link menu-link" data-url="OperatorStadiumHolidayDeleteListForm.action">
						<i class="bi bi-calendar-check me-2"></i> 구장 휴무일 삭제
					</a>
					
					<a class="nav-link menu-link" data-url="OperatorFieldResApprForm.action">
						<i class="bi bi-check-circle me-2"></i> 경기장 예약 승인 관리
					</a>
					
					<a class="nav-link menu-link" data-url="OperatorFieldApprList.action">
						<i class="bi bi-list-check me-2"></i> 경기장 승인, 취소 내역
					</a>
					
					<a class="nav-link menu-link" data-url="OperatorFieldResHistory.action">
						<i class="bi bi-credit-card me-2"></i> 결제 내역
					</a>
				</nav>
			</aside>
		</div>
	</main>
	
	<c:import url="/WEB-INF/view/Footer.jsp"></c:import>
</div>
</body>
</html>