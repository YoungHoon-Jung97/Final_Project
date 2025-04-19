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

/* 검색 창 */
.search-box {
    display: flex;
    margin-bottom: 20px;
}

.search-box select, 
.search-box input {
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
}

.search-box select {
    margin-right: 10px;
    min-width: 120px;
}

.search-box input {
    flex-grow: 1;
    margin-right: 10px;
}

.search-btn {
    background-color: #a8d5ba;
    color: white;
    border: none;
    border-radius: 4px;
    padding: 0 15px;
    cursor: pointer;
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
                        <div>
                            <button id="exportBtn" class="btn btn-secondary">엑셀 다운로드</button>
                        </div>
                    </div>
                    
                    <div class="fee-summary">
                        <div class="summary-item">
                            <div class="summary-label">총 수입</div>
                            <div class="summary-value income">1,250,000원</div>
                        </div>
                        <div class="summary-item">
                            <div class="summary-label">총 지출</div>
                            <div class="summary-value expense">850,000원</div>
                        </div>
                        <div class="summary-item">
                            <div class="summary-label">잔액</div>
                            <div class="summary-value balance">400,000원</div>
                        </div>
                    </div>
                    
                    <div class="tab-container">
                        <div class="tab-menu">
                            <div class="tab-item active" data-tab="all">전체</div>
                            <div class="tab-item" data-tab="income">수입</div>
                            <div class="tab-item" data-tab="expense">지출</div>
                            <div class="tab-item" data-tab="stats">통계</div>
                            <div class="tab-item" data-tab="members">회비 납부 현황</div>
                        </div>
                    </div>
                    
                    <div class="btn-group">
                        <button id="addIncomeBtn" class="btn">수입 등록</button>
                        <button id="addExpenseBtn" class="btn">지출 등록</button>
                        <button id="collectFeeBtn" class="btn">회비 모으기</button>
                    </div>
                    
                    <div class="search-box">
                        <select id="searchType">
                            <option value="all">전체</option>
                            <option value="date">날짜</option>
                            <option value="category">분류</option>
                            <option value="description">내용</option>
                            <option value="member">작성자</option>
                        </select>
                        <input type="text" id="searchInput" placeholder="검색어를 입력하세요">
                        <button class="search-btn">검색</button>
                    </div>
                    
                    <div id="allTab" class="tab-content active">
                        <table class="fee-table">
                            <thead>
                                <tr>
                                    <th>날짜</th>
                                    <th>구분</th>
                                    <th>분류</th>
                                    <th>내용</th>
                                    <th>금액</th>
                                    <th>작성자</th>
                                    <th>관리</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="fee-date">2025-04-10</td>
                                    <td class="fee-type-income">수입</td>
                                    <td>회비</td>
                                    <td>4월 정기 회비</td>
                                    <td>250,000원</td>
                                    <td>김팀장</td>
                                    <td class="fee-actions">
                                        <a href="#" class="edit-btn">수정</a>
                                        <a href="#" class="delete-btn">삭제</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fee-date">2025-04-05</td>
                                    <td class="fee-type-expense">지출</td>
                                    <td>경기장 대여</td>
                                    <td>4월 첫째 주 장소 대여비</td>
                                    <td>100,000원</td>
                                    <td>김회계</td>
                                    <td class="fee-actions">
                                        <a href="#" class="edit-btn">수정</a>
                                        <a href="#" class="delete-btn">삭제</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fee-date">2025-04-03</td>
                                    <td class="fee-type-expense">지출</td>
                                    <td>장비 구매</td>
                                    <td>공 3개 구매</td>
                                    <td>45,000원</td>
                                    <td>이용품</td>
                                    <td class="fee-actions">
                                        <a href="#" class="edit-btn">수정</a>
                                        <a href="#" class="delete-btn">삭제</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fee-date">2025-03-28</td>
                                    <td class="fee-type-income">수입</td>
                                    <td>회비</td>
                                    <td>3월 정기 회비</td>
                                    <td>250,000원</td>
                                    <td>김팀장</td>
                                    <td class="fee-actions">
                                        <a href="#" class="edit-btn">수정</a>
                                        <a href="#" class="delete-btn">삭제</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fee-date">2025-03-25</td>
                                    <td class="fee-type-expense">지출</td>
                                    <td>회식</td>
                                    <td>3월 월례 회식</td>
                                    <td>150,000원</td>
                                    <td>박총무</td>
                                    <td class="fee-actions">
                                        <a href="#" class="edit-btn">수정</a>
                                        <a href="#" class="delete-btn">삭제</a>
                                    </td>
                                </tr>
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
                    
                    <div id="statsTab" class="tab-content" style="display:none;">
                        <div class="chart-container">
                            <div class="chart-title">월별 수입/지출 현황</div>
                            <div class="monthly-chart">
                                <!-- 여기에 차트가 들어갑니다 -->
                                <div style="text-align: center; color: #666; padding: 100px 0;">
                                    차트 영역: 월별 수입/지출 그래프가 표시됩니다.
                                </div>
                            </div>
                            
                            <div class="chart-title">지출 카테고리 분석</div>
                            <div class="category-chart">
                                <!-- 여기에 차트가 들어갑니다 -->
                                <div style="text-align: center; color: #666; padding: 100px 0;">
                                    차트 영역: 지출 카테고리별 비율이 표시됩니다.
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div id="membersTab" class="tab-content" style="display:none;">
                        <table class="fee-table">
                            <thead>
                                <tr>
                                    <th>회원명</th>
                                    <th>회비 금액</th>
                                    <th>납부 여부</th>
                                    <th>납부일</th>
                                    <th>관리</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>김회원</td>
                                    <td>25,000원</td>
                                    <td><span style="color: #10ac84">납부 완료</span></td>
                                    <td>2025-04-02</td>
                                    <td class="fee-actions">
                                        <a href="#" class="reminder-btn">알림 보내기</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>이회원</td>
                                    <td>25,000원</td>
                                    <td><span style="color: #10ac84">납부 완료</span></td>
                                    <td>2025-04-05</td>
                                    <td class="fee-actions">
                                        <a href="#" class="reminder-btn">알림 보내기</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>박회원</td>
                                    <td>25,000원</td>
                                    <td><span style="color: #ee5253">미납</span></td>
                                    <td>-</td>
                                    <td class="fee-actions">
                                        <a href="#" class="reminder-btn">알림 보내기</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>최회원</td>
                                    <td>25,000원</td>
                                    <td><span style="color: #10ac84">납부 완료</span></td>
                                    <td>2025-04-01</td>
                                    <td class="fee-actions">
                                        <a href="#" class="reminder-btn">알림 보내기</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>정회원</td>
                                    <td>25,000원</td>
                                    <td><span style="color: #ee5253">미납</span></td>
                                    <td>-</td>
                                    <td class="fee-actions">
                                        <a href="#" class="reminder-btn">알림 보내기</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- .fee-container -->
                
                <!-- 수입 등록 모달 -->
                <div id="incomeModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">수입 등록</h3>
                            <span class="close">&times;</span>
                        </div>
                        <form id="incomeForm">
                            <div class="form-group">
                                <label for="incomeDate">날짜</label>
                                <input type="date" id="incomeDate" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="incomeCategory">분류</label>
                                <select id="incomeCategory" class="form-control" required>
                                    <option value="">선택하세요</option>
                                    <option value="membership">회비</option>
                                    <option value="sponsor">후원금</option>
                                    <option value="event">행사 수입</option>
                                    <option value="etc">기타</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="incomeDesc">내용</label>
                                <input type="text" id="incomeDesc" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="incomeAmount">금액</label>
                                <input type="number" id="incomeAmount" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="incomeNote">비고</label>
                                <textarea id="incomeNote" class="form-control" rows="3"></textarea>
                            </div>
                            <div class="form-actions">
                                <button type="button" class="btn btn-secondary modal-close">취소</button>
                                <button type="submit" class="btn">등록</button>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- 지출 등록 모달 -->
                <div id="expenseModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">지출 등록</h3>
                            <span class="close">&times;</span>
                        </div>
                        <form id="expenseForm">
                            <div class="form-group">
                                <label for="expenseDate">날짜</label>
                                <input type="date" id="expenseDate" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="expenseCategory">분류</label>
                                <select id="expenseCategory" class="form-control" required>
                                    <option value="">선택하세요</option>
                                    <option value="rental">장소 대여비</option>
                                    <option value="equipment">장비 구매</option>
                                    <option value="food">회식/음식</option>
                                    <option value="transportation">교통비</option>
                                    <option value="competition">대회 참가비</option>
                                    <option value="etc">기타</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="expenseDesc">내용</label>
                                <input type="text" id="expenseDesc" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="expenseAmount">금액</label>
                                <input type="number" id="expenseAmount" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="expenseReceipt">영수증 첨부</label>
                                <input type="file" id="expenseReceipt" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="expenseNote">비고</label>
                                <textarea id="expenseNote" class="form-control" rows="3"></textarea>
                            </div>
                            <div class="form-actions">
                                <button type="button" class="btn btn-secondary modal-close">취소</button>
                                <button type="submit" class="btn">등록</button>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- 회비 모으기 모달 -->
                <div id="feeCollectionModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">회비 모으기</h3>
                            <span class="close">&times;</span>
                        </div>
                        <form id="feeCollectionForm">
                            <div class="form-group">
                                <label for="feeMonth">납부 월</label>
                                <input type="month" id="feeMonth" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="feeAmount">1인당 회비</label>
                                <input type="number" id="feeAmount" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="feeDeadline">납부 기한</label>
                                <input type="date" id="feeDeadline" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="feeDescription">설명</label>
                                <textarea id="feeDescription" class="form-control" rows="3"></textarea>
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

// 이벤트 리스너 등록
document.addEventListener('DOMContentLoaded', function() {
    // 수입 등록 버튼
    document.getElementById('addIncomeBtn').addEventListener('click', function() {
        openModal('incomeModal');
    });
    
    // 지출 등록 버튼
    document.getElementById('addExpenseBtn').addEventListener('click', function() {
        openModal('expenseModal');
    });
    
    // 회비 모으기 버튼
    document.getElementById('collectFeeBtn').addEventListener('click', function() {
        openModal('feeCollectionModal');
    });
    
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
    
    // 탭 전환
    document.querySelectorAll('.tab-item').forEach(tab => {
        tab.addEventListener('click', function() {
            const tabId = this.getAttribute('data-tab');
            switchTab(tabId);
        });
    });
    
    // 폼 제출 이벤트 방지 (실제 구현 시 AJAX로 처리)
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            alert('저장되었습니다.');
            closeModal(this.closest('.modal').id);
        });
    });
});
</script>
</body>
</html>