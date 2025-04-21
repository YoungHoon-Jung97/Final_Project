<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 가계부</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/TeamMain.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/modal.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/TeamTemplate.css?after">
<style type="text/css">
/*팀 메뉴 넘어갔을 때 표시*/
.teampage-link:nth-child(3) a {
    color: #a8d5ba;
    border-bottom: 2px solid #a8d5ba;
}

/* 가계부 스타일 */
.fee-container {
    width: 100%;
    max-width: 1000px;
    margin: 20px auto;
    background-color: #fff;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
}

.fee-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    border-bottom: 1px solid #eee;
    padding-bottom: 10px;
}

.fee-title {
    font-size: 24px;
    font-weight: bold;
    color: #333;
}

.fee-summary {
    background-color: #f8f9fa;
    border-radius: 8px;
    padding: 15px;
    margin-bottom: 20px;
    display: flex;
    justify-content: space-between;
}

.summary-item {
    text-align: center;
    padding: 0 20px;
}

.summary-item:not(:last-child) {
    border-right: 1px solid #ddd;
}

.summary-label {
    font-size: 14px;
    color: #666;
    margin-bottom: 5px;
}

.summary-value {
    font-size: 22px;
    font-weight: bold;
}

.income { color: #2e86de; }
.expense { color: #ee5253; }
.balance { color: #10ac84; }

.btn-group {
    margin-bottom: 20px;
}

.btn {
    background-color: #a8d5ba;
    color: white;
    border: none;
    padding: 8px 15px;
    border-radius: 5px;
    cursor: pointer;
    margin-right: 10px;
    font-size: 14px;
}

.btn:hover {
    background-color: #8bc6a4;
}

.btn-secondary {
    background-color: #6c757d;
}

.btn-secondary:hover {
    background-color: #5a6268;
}

.fee-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

.fee-table th {
    background-color: #f8f9fa;
    padding: 12px 15px;
    text-align: left;
    border-bottom: 2px solid #ddd;
    font-weight: 600;
}

.fee-table td {
    padding: 10px 15px;
    border-bottom: 1px solid #eee;
}

.fee-table tr:hover {
    background-color: #f5f5f5;
}

.fee-type-income {
    color: #2e86de;
    font-weight: bold;
}

.fee-type-expense {
    color: #ee5253;
    font-weight: bold;
}

.fee-date {
    color: #666;
    font-size: 14px;
}

.fee-actions a {
    color: #666;
    margin-right: 10px;
    text-decoration: none;
}

.fee-actions a:hover {
    color: #333;
}

.fee-paging {
    margin-top: 20px;
    text-align: center;
}

.fee-paging a {
    display: inline-block;
    padding: 5px 10px;
    margin: 0 3px;
    border: 1px solid #ddd;
    border-radius: 3px;
    color: #333;
    text-decoration: none;
}

.fee-paging a.active {
    background-color: #a8d5ba;
    color: white;
    border-color: #a8d5ba;
}

.fee-paging a:hover:not(.active) {
    background-color: #f5f5f5;
}

/* 모달 스타일 */
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.4);
}

.modal-content {
    background-color: #fff;
    margin: 10% auto;
    padding: 20px;
    border-radius: 10px;
    width: 50%;
    max-width: 500px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #eee;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

.modal-title {
    font-size: 20px;
    font-weight: bold;
}

.close {
    color: #aaa;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.close:hover {
    color: #333;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: 600;
}

.form-control {
    width: 100%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box;
}

.form-control:focus {
    border-color: #a8d5ba;
    outline: none;
}

.form-actions {
    text-align: right;
    margin-top: 20px;
}

/* 탭 스타일 */
.tab-container {
    margin-bottom: 20px;
}

.tab-menu {
    display: flex;
    border-bottom: 1px solid #ddd;
    margin-bottom: 15px;
}

.tab-item {
    padding: 10px 20px;
    cursor: pointer;
    border-bottom: 3px solid transparent;
    margin-right: 10px;
}

.tab-item.active {
    border-bottom: 3px solid #a8d5ba;
    color: #a8d5ba;
    font-weight: bold;
}

/* 통계 차트 영역 */
.chart-container {
    margin-top: 30px;
    background-color: #f8f9fa;
    border-radius: 8px;
    padding: 20px;
}

.chart-title {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 15px;
    color: #333;
}

.monthly-chart, .category-chart {
    height: 300px;
    margin-bottom: 30px;
}
.pagination {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}

.pagination a {
    color: #333;
    padding: 8px 12px;
    text-decoration: none;
    border: 1px solid #ddd;
    margin: 0 4px;
}

.pagination a.active {
    background-color: #a8d5ba;
    color: white;
    border: 1px solid #a8d5ba;
}

.pagination a:hover:not(.active) {
    background-color: #f5f5f5;
}

.page-info {
    text-align: right;
    margin-bottom: 10px;
    font-size: 14px;
    color: #666;
}

@media (max-width: 768px) {
    .fee-summary {
        flex-direction: column;
    }
    
    .summary-item {
        padding: 10px 0;
        border-right: none;
    }
    
    .summary-item:not(:last-child) {
        border-bottom: 1px solid #ddd;
    }
    
    .modal-content {
        width: 90%;
    }
}
</style>
</head>
<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>
<div class="container">
    <section>
        <div class="main">
            <div class="main-content">
                <ul class="team-menu">
                    <li class="teampage-link"><a href="MyTeam.action">팀 정보</a></li>
                    <li class="teampage-link"><a href="MyTeamSchedule.action">팀 매치</a></li>
                    <li class="teampage-link"><a href="MyTeamFee.action">팀 가계부</a></li>
                    <li class="teampage-link"><a href="MyTeamBoard.action">팀 게시판</a></li>
                </ul>
                <!-- .tean-menu -->
                
                <div class="fee-container">
                    <div class="fee-header">
                        <h2 class="fee-title">팀 가계부</h2>
                    </div>
                    
                    <div class="fee-summary">
                        <div class="summary-item">
                            <div class="summary-label">총 수입</div>
                            <div class="summary-value income"><fmt:formatNumber value="${income}" type="number" pattern="#,###" />원</div>
                        </div>
                        <div class="summary-item">
                            <div class="summary-label">총 지출</div>
                            <div class="summary-value expense"><fmt:formatNumber value="${expense}" type="number" pattern="#,###" />원</div>
                        </div>
                        <div class="summary-item">
                            <div class="summary-label">잔액</div>
                            <div class="summary-value balance"><fmt:formatNumber value="${tot}" type="number" pattern="#,###" />원</div>
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
                                    <th>날짜</th>
                                    <th>종류</th>
                                    <th>내용</th>
                                    <th>금액</th>
                                    <th>작성자</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach var="teamFee" items="${teamFeeList}">
	                                <tr>
	                                    <td>
	                                        ${teamFee.rnum }
	                                    </td>
	                                    <td class="fee-date">${teamFee.transaction_date}</td>
	                                    <td>${teamFee.transaction_type }</td>
	                                    <td>${teamFee.description}</td>
	                                    <td><fmt:formatNumber value="${teamFee.net_amount}" type="number" pattern="#,###" />원</td>
	                                    <td>${team.user_nick_name}</td>
	                                </tr>
	                               </c:forEach>
                            </tbody>
                        </table>
                        
                        <!-- 페이징 -->
	                    <div class="pagination">
	                        ${pageHtml}
	                    </div>
                    </div>
                    <!-- 수입 출력 -->
					<div id="incomeTab" class="tab-content" style="display:none;">
					    <table class="fee-table">
					        <thead>
					            <tr>
					                <th>날짜</th>
					                <th>종류</th>
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
					                        <td class="fee-date">${teamFee.transaction_date}</td>
					                        <td class="fee-type-income">${teamFee.transaction_type}</td>
					                        <td>${teamFee.description}</td>
					                        <td><fmt:formatNumber value="${teamFee.net_amount}" type="number" pattern="#,###" />원</td>
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
					<div id="expenseTab" class="tab-content" style="display:none;">
					    <table class="fee-table">
					        <thead>
					            <tr>
					                <th>날짜</th>
					                <th>종류</th>
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
					                        <td class="fee-date">${teamFee.transaction_date}</td>
					                        <td class="fee-type-expense">${teamFee.transaction_type}</td>
					                        <td>${teamFee.description}</td>
					                        <td><fmt:formatNumber value="${teamFee.net_amount}" type="number" pattern="#,###" />원</td>
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

                    <div id="membersTab" class="tab-content" style="display:none;">
                        <table class="fee-table">
                            <thead>
                                <tr>
                                    <th>회비 날짜</th>
                                    <th>회비 마감일</th>
                                    <th>남부 금액</th>
                                    <th>관리자</th>
                                    <th>납부 설명</th>
                     				<th>납부</th>
                                    <th>납무자 명단</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="teamMonthFee" items="${teamMonthFeeList}">
				                    <tr>
				                        <td class="fee-date">${teamMonthFee.team_fee_pay_start_at}</td>
				                        <td class="fee-date">${teamMonthFee.team_fee_pay_end_at}</td>
				                        <td><fmt:formatNumber value="${teamMonthFee.team_fee_price}" type="number" pattern="#,###" />원</td>
				                        <td>${team.user_nick_name}</td>
				                        <td>${teamMonthFee.team_fee_desc}</td>
				                        <td class="fee-actions">
				                        	<fmt:parseDate value="${teamMonthFee.team_fee_pay_end_at}" pattern="yyyy-MM-dd" var="endDate" />

											<c:choose>
											    <c:when test="${endDate > today}">
											        <button id="monthFeeBtn" class="btn btn-primary">회비 납부</button>
											    </c:when>
											    <c:otherwise>
											        <button id="monthFeeEnd" class="btn btn-secondary" disabled>납부 마감</button>
											    </c:otherwise>
											</c:choose>
				                        </td>
				                        <td class="fee-actions">
				                            <a href="TeamMonthFeeMember.action?team_fee_id=${teamMonthFee.team_fee_id}" class="btn btn-primary">회비 납부자 목록</a>
				                        </td>
				                    </tr>
				                     <div id="monthFeeModal" class="modal">
					                    <div class="modal-content">
					                        <div class="modal-header">
					                            <h3 class="modal-title">회비 납부</h3>
					                            <span class="close">&times;</span>
					                        </div>
					                        <div class="modal_body">
					                        	<div><span>예금주 : </span><span>${team.temp_team_account_holder}</span></div>
					                        	<div><span>은행 : </span><span>${team.bank_name}</span></div>
					                        	<div><span>계좌번호 : </span><span>${team.temp_team_account}</span></div>
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
                <!-- .fee-container -->
                
                <!-- 회비 모으기 모달 -->
                <div id="feeCollectionModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">회비 모으기</h3>
                            <span class="close">&times;</span>
                        </div>
                        <form id="feeCollectionForm" action="AddFeeInfo.action">
                            <div class="form-group">
                                <label for="feeMonth">납부 월</label>
                                <input type="month" id="feeMonth" class="form-control" name="team_fee_pay_start_at" required>
                            </div>
                            <div class="form-group">
                                <label for="feeAmount">1인당 회비</label>
                                <input type="number" id="feeAmount" class="form-control" name="team_fee_price" required>
                            </div>
                            <div class="form-group">
                                <label for="feeDeadline">납부 기한</label>
                                <input type="date" id="feeDeadline" class="form-control" name="team_fee_pay_end_at" required>
                            </div>
                            <div class="form-group">
                                <label for="feeDescription">설명</label>
                                <input type="text" id="feeDescription" class="form-control" name="team_fee_desc" >
                            </div>
                            <div class="form-actions">
                                <button type="button" class="btn btn-secondary modal-close">취소</button>
                                <button type="submit" class="btn">등록</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- .main-content  -->
        </div>
        <!-- .main  -->
    </section>
</div>

<script>
// 모달 제어
function openModal(modalId) {
    document.getElementById(modalId).style.display = 'block';
}

function closeModal(modalId) {
    document.getElementById(modalId).style.display = 'none';
}

// 탭 전환
function switchTab(tabId) {
    // 모든 탭 내용 숨김
    document.querySelectorAll('.tab-content').forEach(tab => {
        tab.style.display = 'none';
    });
    // 선택한 탭 보이기
    document.getElementById(tabId + 'Tab').style.display = 'block';
    
    // 탭 메뉴 활성화 상태 변경
    document.querySelectorAll('.tab-item').forEach(item => {
        item.classList.remove('active');
    });
    
    // 선택한 탭 메뉴 활성화
    document.querySelector(`.tab-item[data-tab="${tabId}"]`).classList.add('active');
}

//이벤트 리스너 등록 함수
function initializeEventListeners() {
    // 회비 모으기 버튼
    const collectFeeBtn = document.getElementById('collectFeeBtn');
    if (collectFeeBtn) {
        collectFeeBtn.addEventListener('click', function() {
            openModal('feeCollectionModal');
        });
    }
    
    const monthFeeBtn = document.getElementById('monthFeeBtn');
    if (monthFeeBtn) {
        monthFeeBtn.addEventListener('click', function() {
            openModal('monthFeeModal');
        });
    }
    
    // 모달 닫기 버튼
    document.querySelectorAll('.close, .modal-close').forEach(button => {
        button.addEventListener('click', function() {
            const modal = this.closest('.modal');
            closeModal(modal.id);
        });
    });
    
    // 모달 외부 클릭 시 닫기
    window.addEventListener('click', function(event) {
        document.querySelectorAll('.modal').forEach(modal => {
            if (event.target === modal) {
                closeModal(modal.id);
            }
        });
    });
    
    // 탭 전환 - 이벤트 위임 방식으로 변경
    const tabMenu = document.querySelector('.tab-menu');
    if (tabMenu) {
        tabMenu.addEventListener('click', function(event) {
            const tabItem = event.target.closest('.tab-item');
            if (tabItem) {
                const tabId = tabItem.getAttribute('data-tab');
                switchTab(tabId);
            }
        });
    }
    
    // 처음 로드 시 전체 탭 활성화
    switchTab('all');
}

// DOM이 완전히 로드된 후 초기화 함수 호출
document.addEventListener('DOMContentLoaded', initializeEventListeners);

// 모달이 닫힐 때마다 이벤트 리스너 재초기화
function closeModal(modalId) {
    document.getElementById(modalId).style.display = 'none';
    // 모달이 닫힌 후 이벤트 리스너 재초기화
    initializeEventListeners();
}


</script>
</body>
</html>