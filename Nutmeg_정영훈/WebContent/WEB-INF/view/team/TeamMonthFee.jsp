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
                        <h2 class="fee-title">팀 회비 납부</h2>
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
                                        
                    <div class="btn-group">
                        <button id="collectFeeBtn" class="btn">회비 모으기</button>
                    </div>
                    
                    <!-- 전체 내용 추가  -->
                    <div id="allTab" class="tab-content active">
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
	                                <tr>
	                                    <td class="fee-date">${teamFee.transaction_date}</td>
	                                    <td>${teamFee.transaction_type }</td>
	                                    <td>${teamFee.description}</td>
	                                    <td><fmt:formatNumber value="${teamFee.net_amount}" type="number" pattern="#,###" />원</td>
	                                    <td>${userNickName}</td>
	                                    <td class="fee-actions">
	                                        <a href="#" class="edit-btn">수정</a>
	                                        <a href="#" class="delete-btn">삭제</a>
	                                    </td>
	                                </tr>
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
            	</div>
            </div>
            <!-- .main-content  -->
        </div>
        <!-- .main  -->
    </section>
</div>
</body>
</html>