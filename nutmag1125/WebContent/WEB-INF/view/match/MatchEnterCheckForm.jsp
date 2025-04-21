<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title>FieldReservationCheckForm.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/FieldReservationCheckForm.css?after">

<script type="text/javascript" src="<%=cp %>/js/FieldReservationCheckForm.js?after"></script>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<div class="main-background">
	<main>
		<form action="MatchAwayTeamInsert.action" method="post">
			<h2>예약 내용 확인</h2>
			
			<div class="info-block"><strong>예약 날짜:</strong> ${match_date}</div>
			<div class="info-block"><strong>예약 시간:</strong> ${start_time} ~ ${end_time}</div>
			
			<hr>
			
			<div class="info-block"><strong>홈팀 이름:</strong> ${team.temp_team_name}</div>
			<div class="info-block"><strong>은행명:</strong> ${team.bank_name}</div>
			<div class="info-block"><strong>계좌번호:</strong> ${team.temp_team_account}</div>
			<div class="info-block"><strong>예금주:</strong> ${team.temp_team_account_holder}</div>
			
			<hr>
			<div class="info-block"><strong>요금(2시간당):</strong> <fmt:formatNumber value="${hour_amount}" pattern="#,###" />원</div>
			<div class="info-block"><strong>총 금액:</strong> <fmt:formatNumber value="${pay_amount}" pattern="#,###" />원</div>
			
			<hr>

			<div class="info-block1" style="margin-bottom: 25px;">
				<h3>경기 인원</h3>
				
				<div class="match-toggle-wrapper">
					<div class="toggle-group">
						
							<input type="radio" name="match_inwon_id" id="vs${status.index}"
							value="${inwon.match_inwon_id}" <c:if test="${status.index == 0}">checked</c:if>>
						
							<label for="vs${status.index}">${ match_inwon}</label>
	
					
						<!-- <span class="underline"></span> -->
					</div>
				</div>
			</div>
			
			<hr>
			
			<div class="notice">
				<strong>⚠️ 예약 후 2일 이내 입금 필수!</strong><br>
				입금이 없을 시 예약이 자동 취소될 수 있습니다.
			</div>
			
			<!-- Hidden Fields -->
			<input type="hidden" name="field_code_id" value="${field_code_id}">
			<input type="hidden" name="field_res_id" value="${field_res_id}">
			<input type="hidden" name="pay_amount" value="${pay_amount}">
			
			<div class="btn-group">
				<button id="submitBtn" type="submit" class="btn btn--submit">예약 확정</button>
				<button type="button" class="btn btn--back" onclick="history.back();">뒤로가기</button>
			</div>
		</form>
	</main>
</div>
</body>
</html>