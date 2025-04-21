<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TeamFee.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/TeamTemplate.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/modal.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/TeamFee.css?after">

<script type="text/javascript" src="<%=cp %>/js/TeamFee.js?after"></script>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<div class="main-background">
	<main>
		<div class="container">
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
						<h1 class="display-5 fw-bold text-success">📒 동호회 가계부</h1>
						
						<p class="text-muted mt-2">우리 팀의 소중한 회비, 꼼꼼하게 기록하고 함께 나눠요!</p>
						
						<div class="underline mt-3 mx-auto"></div>
					</div>
					
					<div class="fee-container">
						<div class="fee-summary">
							<div class="summary-item">
								<div class="summary-label">총 수입</div>
								
								<div class="summary-value income">
									<fmt:formatNumber value="${income}" type="number" pattern="#,###"></fmt:formatNumber>
									원
								</div>
							</div>
							
							<div class="summary-item">
								<div class="summary-label">총 지출</div>
								
								<div class="summary-value expense">
									<fmt:formatNumber value="${expense}" type="number" pattern="#,###"></fmt:formatNumber>
									원
								</div>
							</div>
							
							<div class="summary-item">
								<div class="summary-label">잔액</div>
								
								<div class="summary-value balance">
									<fmt:formatNumber value="${tot}" type="number" pattern="#,###"></fmt:formatNumber>
									원
								</div>
							</div>
						</div>
						
						<div class="tab-container">
							<div class="tab-menu">
								<div class="tab-item active" data-tab="all">전체</div>
								<div class="tab-item" data-tab="income">수입</div>
								<div class="tab-item" data-tab="expense">지출</div>
								<div class="tab-item" data-tab="members">회비 납부 현황</div>
							</div>
						</div>
						
						<div class="btn-group">
							<button id="collectFeeBtn" class="btn">회비 모으기</button>
						</div>
						
						<!-- 전체 내용 추가  -->
						<div id="allTab" class="tab-content active">
							<table class="fee-table">
								<thead>
									<tr>
										<th>번호</th>
										<th>종류</th>
										<th>날짜</th>
										<th>내용</th>
										<th>금액</th>
										<th>작성자</th>
									</tr>
								</thead>
								
								<tbody>
									<c:forEach var="teamFee" items="${teamFeeList}">
										<tr>
											<td>${teamFee.rnum }</td>
											<td>${teamFee.transaction_type}</td>
											<td class="fee-date">${teamFee.transaction_date}</td>
											<td>${teamFee.description}</td>
											<td><fmt:formatNumber value="${teamFee.net_amount}" type="number" pattern="#,###"></fmt:formatNumber>원</td>
											<td>${team.user_nick_name}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							
							<!-- 페이징 -->
							<div class="pagination">${pageHtml}</div>
						</div>
						
						<!-- 수입 출력 -->
						<div id="incomeTab" class="tab-content" style="display: none;">
							<table class="fee-table">
								<thead>
									<tr>
										<th>종류</th>
										<th>날짜</th>
										<th>내용</th>
										<th>금액</th>
										<th>작성자</th>
										<th>관리</th>
									</tr>
								</thead>
								
								<tbody>
									<c:forEach var="teamFee" items="${teamFeeList}">
										<c:if test="${teamFee.transaction_type eq '수입'}">
											<tr>
												<td class="fee-type-income">${teamFee.transaction_type}</td>
												<td class="fee-date">${teamFee.transaction_date}</td>
												<td>${teamFee.description}</td>
												<td><fmt:formatNumber value="${teamFee.net_amount}" type="number" pattern="#,###"></fmt:formatNumber>원</td>
												<td>${team.user_nick_name}</td>
												<td class="fee-actions">
													<a href="#" class="edit-btn">수정</a>
													<a href="#" class="delete-btn">삭제</a>
												</td>
											</tr>
										</c:if>
									</c:forEach>
								</tbody>
							</table>
							
							<div class="fee-paging">
								<a href="#" class="active">1</a>
								<a href="#">2</a>
								<a href="#">3</a>
								<a href="#">4</a>
								<a href="#">5</a>
								<a href="#">&gt;</a>
							</div>
						</div>
						
						<!-- 지출 출력 -->
						<div id="expenseTab" class="tab-content" style="display: none;">
							<table class="fee-table">
								<thead>
									<tr>
										<th>종류</th>
										<th>날짜</th>
										<th>내용</th>
										<th>금액</th>
										<th>작성자</th>
										<th>관리</th>
									</tr>
								</thead>
								
								<tbody>
									<c:forEach var="teamFee" items="${teamFeeList}">
										<c:if test="${teamFee.transaction_type eq '지출'}">
											<tr>
												<td class="fee-type-expense">${teamFee.transaction_type}</td>
												<td class="fee-date">${teamFee.transaction_date}</td>
												<td>${teamFee.description}</td>
												<td><fmt:formatNumber value="${teamFee.net_amount}" type="number" pattern="#,###"></fmt:formatNumber>원</td>
												<td>${team.user_nick_name}</td>
												<td class="fee-actions"><a href="#" class="edit-btn">수정</a>
													<a href="#" class="delete-btn">삭제</a></td>
											</tr>
										</c:if>
									</c:forEach>
								</tbody>
							</table>
							
							<div class="fee-paging">
								<a href="#" class="active">1</a>
								<a href="#">2</a>
								<a href="#">3</a>
								<a href="#">4</a>
								<a href="#">5</a>
								<a href="#">&gt;</a>
							</div>
						</div>
						
						<div id="membersTab" class="tab-content" style="display: none;">
							<table class="fee-table">
								<thead>
									<tr>
										<th>회비 날짜</th>
										<th>회비 마감일</th>
										<th>납부 설명</th>
										<th>납부 금액</th>
										<th>관리자</th>
										<th>관리</th>
									</tr>
								</thead>
								
								<tbody>
									<c:forEach var="teamMonthFee" items="${teamMonthFeeList}">
										<tr>
											<td class="fee-date">${teamMonthFee.team_fee_pay_start_at}</td>
											<td class="fee-date">${teamMonthFee.team_fee_pay_end_at}</td>
											<td>${teamMonthFee.team_fee_desc}</td>
											<td><fmt:formatNumber value="${teamMonthFee.team_fee_price}" type="number" pattern="#,###"></fmt:formatNumber>원</td>
											<td>${team.user_nick_name}</td>
											<td class="fee-actions">
												<button id="monthFeeBtn" class="btn btn-primary">회비 납부</button>
												
												<a href="TeamMonthFeeMember.action?team_fee_id=${teamMonthFee.team_fee_id}"
												class="btn btn-primary">회비 납부자 목록</a>
											</td>
										</tr>
										
										<div id="monthFeeModal" class="modal">
											<div class="modal-content">
												<div class="modal-header">
													<h3 class="modal-title">회비 납부</h3>
												</div>
												
												<div class="modal_body">
													<div>
														<span>예금주 : </span><span>${team.temp_team_account_holder}</span>
													</div>
													
													<div>
														<span>은행 : </span><span>${team.bank_name}</span>
													</div>
													
													<div>
														<span>계좌번호 : </span><span>${team.temp_team_account}</span>
													</div>
												</div>
												
												<div class="form-actions">
													<a href="TeamMonthFee.action?team_fee_id=${teamMonthFee.team_fee_id}&team_fee_price=${teamMonthFee.team_fee_price}"
													class="btn btn-primary" onclick="return confirm('회비를 납부하시겠습니까?');">회비 납부</a>
													
													<button type="button" class="btn btn-secondary modal-close">취소</button>
												</div>
											</div>
										</div>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					
					<!-- 회비 모으기 모달 -->
					<div id="feeCollectionModal" class="modal">
						<div class="modal-content">
							<div class="modal-header">
								<h3 class="modal-title">회비 모으기</h3>
							</div>
							
							<form id="feeCollectionForm" action="AddFeeInfo.action">
								<div class="form-group">
									<label for="feeMonth">납부 월</label>
									
									<input type="month" id="feeMonth" class="form-control"
									name="team_fee_pay_start_at" required>
								</div>
								
								<div class="form-group">
									<label for="feeAmount">1인당 회비</label>
									
									<input type="number" id="feeAmount" class="form-control"
									name="team_fee_price" required>
								</div>
								
								<div class="form-group">
									<label for="feeDeadline">납부 기한</label>
									
									<input type="date" id="feeDeadline" class="form-control"
									name="team_fee_pay_end_at" required>
								</div>
								
								<div class="form-group">
									<label for="feeDescription">설명</label>
									
									<input type="text" id="feeDescription" class="form-control"
									name="team_fee_desc">
								</div>
								
								<div class="form-actions">
									<button type="submit" class="btn">등록</button>
									<button type="button" class="btn btn-secondary modal-close">취소</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
</div>
</body>
</html>