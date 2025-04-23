<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제내역</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<c:import url="/WEB-INF/view/Template.jsp"></c:import>
<style>
/* 기본 HTML 및 바디 설정 */
html, body {
    margin: 0;
    padding: 0;
    background-color: #f5f5f5; /* 연한 회색 배경 */
    color: #333; /* 기본 텍스트 색상 */
    width: 100%;
}

/* 전체 레이아웃 wrapper */
.wrapper {
    display: flex; /* 좌우 나란히 배치 */
    width: 100%;
    min-height: 100vh; /* 화면 전체 높이 */
    margin-top: -200px;
    padding: 200px 350px; /* 안쪽 여백 */
    box-sizing: border-box;
    gap: 40px; /* 사이 간격 */
}

/* 사이드바 영역 */
.sidebar {
    width: 280px;
    background-color: #ffffff; /* 흰 배경 */
    border-radius: 16px; /* 모서리 둥글게 */
    padding: 30px 25px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04); /* 연한 그림자 */
    flex-shrink: 0; /* 사이즈 축소 방지 */
}

/* 사용자 박스 (사진, 이름, 상태) */
.profile-box {
    text-align: center;
    margin-bottom: 30px;
}

/* 사용자 프로필 이미지 */
.profile-box img {
    width: 100px;
    height: 100px;
    border-radius: 50%; /* 원형 */
    border: 2px solid #4CAF50; /* 초록 테두리 */
    object-fit: cover;
    margin-bottom: 12px;
}

/* 사용자 이름 */
.profile-box h5 {
    font-size: 20px;
    margin-bottom: 5px;
}

/* 사용자 역할 텍스트 */
.profile-box .text-muted {
    font-size: 14px;
    color: #777;
}

/* 로그인 뱃지 */
.profile-box .badge {
    background-color: #4CAF50;
    font-size: 12px;
}

/* 사이드 메뉴 타이틀 */
.menu-section-title {
    font-weight: bold;
    margin-top: 24px;
    margin-bottom: 10px;
    color: #2e7d32;
    font-size: 15px;
}

/* 사이드 메뉴 링크 */
.sidebar .nav-link {
    font-size: 15px;
    padding: 10px 12px;
    margin-bottom: 8px;
    color: #333;
    text-decoration: none;
    display: block;
    border-radius: 6px;
}

/* 메뉴 호버 효과 */
.sidebar .nav-link:hover {
    background-color: #e9f5ec;
    color: #000;
}

/* 메인 콘텐츠 */
.content-area {
    flex: 1;
    background-color: #ffffff;
    border-radius: 16px;
    padding: 40px 50px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
}

/* 내 정보 타이틀 */
.content-area h4 {
    font-weight: bold;
    margin-bottom: 30px;
    font-size: 22px;
    color: #2e7d32;
}

/* 사용자 상세 정보 박스 */
.profile-box {
    background-color: #ffffff;
    border: 1px solid #dfece6;
    border-radius: 12px;
    padding: 30px;
    box-shadow: 0 1px 4px rgba(0, 0, 0, 0.02);
}

/* 정보 한 줄씩 나열하는 영역 */
.profile-box .info-row {
    display: flex;
    align-items: center;
    justify-content: flex-start; /* 좌측 정렬 */
    padding: 12px 0;
    border-bottom: 1px solid #efefef;
    font-size: 15px;
    color: #333;
    gap: 40px; /* ✅ 항목 간 여백 */
}

/* 마지막 줄엔 밑줄 없음 */
.profile-box .info-row:last-child {
    border-bottom: none;
}

/* 왼쪽 라벨 */
.profile-box .info-row strong {
    color: #2e7d32;
    font-weight: 600;
    min-width: 140px; /* ✅ 라벨 고정 폭 */
    text-align: left;
}

/* 오른쪽 데이터 */
.profile-box .info-row span {
    flex: 1;
    color: #555;
    word-break: break-word;
    text-align: left; /* ✅ 오른쪽 몰림 방지 */
}

/* 수정 버튼 */
.edit-button {
    background-color: #4CAF50;
    color: white;
    font-weight: bold;
    border: none;
    border-radius: 8px;
    padding: 12px 28px;
    margin-top: 30px;
    font-size: 16px;
    display: inline-block;
    transition: background-color 0.3s ease;
}

/* 수정 버튼 호버 효과 */
.edit-button:hover {
    background-color: #388E3C;
}


/* 메시지 읽음 표시*/
.info-row.unread {
    background-color: #f0f7ff;
}

.info-row.unread a {
    font-weight: bold;
    color: #000;
}

.info-row.read a {
    color: #888;
}

.notification-link {
    text-decoration: none;
    cursor: pointer;
}

/* 테이블 스타일링 */
.fee-table {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
    font-size: 14px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
}

.fee-table thead tr {
    background-color: #f8f9fa;
    border-bottom: 2px solid #e9ecef;
}

.fee-table th {
    padding: 12px 15px;
    text-align: left;
    font-weight: bold;
    color: #495057;
}

.fee-table td {
    padding: 10px 15px;
    border-bottom: 1px solid #e9ecef;
}

.fee-table tbody tr:hover {
    background-color: #f1f3f5;
}

.fee-date {
    white-space: nowrap;
}

/* 정보 없음 메시지 스타일링 */
.no-data-message {
    padding: 30px;
    text-align: center;
    background-color: #f8f9fa;
    border-radius: 5px;
    color: #6c757d;
    font-size: 16px;
    margin: 20px 0;
}
</style>
</head>
<body>
<div class="wrapper">
    <!-- 사이드바 -->
    <div class="sidebar">
        <img src="<%=cp %>/images/profile_default.png" alt="프로필 이미지" class="img-thumbnail rounded-circle mb-3" style="width: 90px; height: 90px; object-fit: cover;">
        <h5 class="mb-1">${userInfo.user_name}</h5>
        <div class="text-muted mb-3">사용자</div>
        <nav>
            <a class="nav-link active" href="UserMainPage.action"><i class="bi bi-person-circle"></i> 마이페이지</a>
            <a class="nav-link" href="#"><i class="bi bi-people"></i> 정보 관리</a>
            <a class="nav-link" href="UserMatch.action"><i class="bi bi-flag"></i> 경기 기록</a>
            <a class="nav-link" href="UserFee.action"><i class="bi bi-cash"></i> 결제 내역</a>
            <a class="nav-link" href="#"><i class="bi bi-chat"></i> 나의 동호회</a>
            <a class="nav-link" href="UserNotification.action"><i class="bi bi-journal-text"></i>알림</a>
            <a class="nav-link" href="#"><i class="bi bi-box-arrow-right"></i> 로그아웃</a>
        </nav>
    </div>

    <!-- 메인 콘텐츠 -->
    <div class="content-area">
	    <table class="fee-table">
	        <thead>
	            <tr>
	                <th>납부 날짜</th>
	                <th>동호회 명</th>
	                <th>종류</th>
	                <th>내용</th>
	                <th>금액</th>
	                <th>납부자</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:choose>
	                <c:when test="${empty feeList}">
	                    <tr>
	                        <td colspan="5" class="no-data-message">정보 없음</td>
	                    </tr>
	                </c:when>
	                <c:otherwise>
	                    <c:forEach var="fee" items="${feeList}">
	                        <tr>
	                            <td class="fee-date">${fee.team_member_fee_pay_at}</td>
	                            <td>${fee.temp_team_name}</td>
	                            <td>회비</td>
	                            <td>납부</td>
	                            <td><fmt:formatNumber value="${fee.team_member_fee_pay_price}" type="number" pattern="#,###" />원</td>
	                            <td>${fee.user_nick_name}</td>
	                        </tr>
	                    </c:forEach>
	                </c:otherwise>
	            </c:choose>
	        </tbody>
	    </table>
	</div>
</div>
</body>
</html>
