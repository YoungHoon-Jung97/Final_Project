<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
/* 기본 스타일 */
* {
   font-family: 맑은 고딕;
   color: #343;
   cursor: url('../images/soccerballcursor.png') 2 2, auto !important;
}
body, p, div, span, input, table, th, td, select {
   font-size: 18px;
}
body {
    background-color: #f8f9fb;
}

/* 버튼 스타일 */
.btn {
   font-weight: bold;
}
.btn:hover {
   color: white;
   background-color: #787;
}
.btn:active {
   color: orange;
}
.btn.btn-primary:hover {
    color: white;
    background-color: #787 !important;
}

/* 레이아웃 */
.wrapper {
    max-width: 1400px;
    margin: 0 auto;
    padding: 30px 20px;
}

/* 사이드바 */
.sidebar {
    width: 250px;
    min-height: 100%;
    background-color: #fff;
    border-left: 1px solid #dee2e6;
    padding: 20px;
}
.sidebar .nav-link {
    color: #343 !important;
    padding: 12px 10px;
}
.sidebar .nav-link:hover {
    background-color: #f1f3f5;
    border-radius: 8px;
}
.menu-section-title {
    margin-top: 15px;
    margin-bottom: 8px;
    font-weight: bold;
    color: #343;
}

/* 콘텐츠 영역 */
.content-area {
    padding: 30px;
    background-color: #fff;
    border-radius: 10px;
    min-height: 600px;
    box-shadow: 0 0 10px rgba(0,0,0,0.03);
}

/* 프로필 박스 */
.profile-box {
    padding: 15px;
    border: 1px solid #dee2e6;
    border-radius: 10px;
    margin-bottom: 30px;
    background-color: #f9fafc;
}
.profile-box strong {
    min-width: 100px;
    color: #343 !important;
}
.profile-box span {
    color: #343 !important;
}

/* 기타 요소 */
.badge {
    color: #343 !important;
}
h4, h5 {
    color: #343;
}

/* 내 정보 수정 버튼 스타일 */
.edit-button {
    background-color: #f1f3f5; 
    border: 1px solid #dee2e6;
    color: #343;
    padding: 10px 20px;
    margin-top: 15px;
    transition: all 0.3s ease;
}
.edit-button:hover {
    background-color: #787;
    color: white;
}
</style>
</head>
<body>
<div class="wrapper">
    <div class="d-flex flex-row-reverse">
        <!-- 사이드바 -->
        <div class="sidebar">
            <!-- 사용자 로그인 정보 -->
            <div class="profile-box text-center">
                <h5 class="mb-1">${userInfo.user_name}</h5>
                <div class="text-muted" style="font-size: 13px;">사용자</div>
                <div class="mt-3">
                    <span class="badge bg-primary">사용자 로그인</span>
                </div>
            </div>
            <!-- 관리자 메뉴 탭 -->
            <div class="menu-section-title">관리 메뉴</div>
            <nav class="nav flex-column">
                <a class="nav-link" href="#"><i class="bi bi-speedometer2 me-2"></i>내 정보</a>
                <a class="nav-link" href="#"><i class="bi bi-people-fill me-2"></i>정보 관리</a>
                <a class="nav-link" href="#"><i class="bi bi-flag-fill me-2"></i>경기 기록</a>
                <a class="nav-link" href="#"><i class="bi bi-building me-2"></i>결제 내역</a>
                <a class="nav-link" href="#"><i class="bi bi-chat-dots-fill me-2"></i>나의 동호회</a>
                <a class="nav-link" href="#"><i class="bi bi-file-earmark-text me-2"></i>동호회 신청 내역</a>
            </nav>
            <!-- 사이드바 설정 개인설정 탭 -->
            <div class="menu-section-title">설정</div>
            <nav class="nav flex-column">
                <a class="nav-link" href="#"><i class="bi bi-gear-fill me-2"></i>설정</a>
                <a class="nav-link" href="#"><i class="bi bi-box-arrow-right me-2"></i>로그아웃</a>
            </nav>
        </div>

        <!-- 메인 콘텐츠 -->
        <div class="flex-grow-1 me-4">
            <div class="content-area">
                <h4 class="mb-4">내 정보</h4>

                <div class="profile-box">
                    <div class="table-responsive">
                        <div class="d-flex flex-column gap-2">
                            <div class="d-flex justify-content-between border-bottom pb-2">
                                <strong>아이디</strong>
                                <span>${userInfo.user_code_id}</span>
                            </div>
                            <div class="d-flex justify-content-between border-bottom pb-2">
                                <strong>이름</strong>
                                <span>${userInfo.user_name}</span>
                            </div>
                            <div class="d-flex justify-content-between border-bottom pb-2">
                                <strong>이메일</strong>
                                <span>${userInfo.user_email}</span>
                            </div>
                            <div class="d-flex justify-content-between border-bottom pb-2">
                                <strong>전화번호</strong>
                                <span>${userInfo.user_tel}</span>
                            </div>
                            <div class="d-flex justify-content-between border-bottom pb-2">
                                <strong>닉네임</strong>
                                <span>${userInfo.user_nick_name}</span>
                            </div>
                            <div class="d-flex justify-content-between border-bottom pb-2">
							    <strong>주민등록번호</strong>
							    <span>${fn:substring(userInfo.user_ssn1, 0, 6)}-${fn:substring(userInfo.user_ssn2, 0, 1)}●●●●●●</span>
							</div>
							<!-- 우편번호 -->
							<div class="d-flex justify-content-between border-bottom pb-2">
							    <strong>우편번호</strong>
							    <span>${userInfo.user_postal_addr}</span>
							</div>
							
							<!-- 기본 주소 -->
							<div class="d-flex justify-content-between border-bottom pb-2">
							    <strong>기본 주소</strong>
							    <span>${userInfo.user_addr}</span>
							</div>
							
							<!-- 상세 주소 -->
							<div class="d-flex justify-content-between border-bottom pb-2">
							    <strong>상세 주소</strong>
							    <span>${userInfo.user_detailed_addr}</span>
							</div>
							
                        </div>
                    </div>
                    
                    <!-- 내 정보 수정 버튼 추가 -->
                    <div class="nav-link">
					    <a href="${pageContext.request.contextPath}/UserInfoEdit.action" class="btn edit-button">
					        <i class="bi bi-pencil-square me-2"></i>내 정보 수정
					    </a>
					</div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>