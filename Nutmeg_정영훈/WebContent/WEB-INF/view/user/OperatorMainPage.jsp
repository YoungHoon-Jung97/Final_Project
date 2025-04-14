<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta>
<title>사용자 페이지</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
	body {
	    background-color: #f8f9fb;
	}
	.wrapper {
	    max-width: 1400px;
	    margin: 0 auto;
	    padding: 30px 20px;
	}
	.sidebar {
	    width: 250px;
	    min-height: 100%;
	    background-color: #fff;
	    border-left: 1px solid #dee2e6;
	    padding: 20px;
	}
	.sidebar .nav-link {
	    color: #333;
	    padding: 12px 10px;
	}
	.sidebar .nav-link:hover {
	    background-color: #f1f3f5;
	    border-radius: 8px;
	}
	.content-area {
	    padding: 30px;
	    background-color: #fff;
	    border-radius: 10px;
	    min-height: 600px;
	    box-shadow: 0 0 10px rgba(0,0,0,0.03);
	}
	.profile-box {
	    padding: 15px;
	    border: 1px solid #dee2e6;
	    border-radius: 10px;
	    margin-bottom: 30px;
	    background-color: #f9fafc;
	}
</style>

<body>
<div class="wrapper">
    <div class="d-flex flex-row-reverse">
        <!-- 사이드바 -->
        <div class="sidebar">
            <!-- 관리자 로그인 정보 -->
            <div class="profile-box text-center">
            <c:forEach var="info" items="${operatorInfo}">
                <h5 class="mb-1">"${info.operator_name }</h5>님 반갑습니다!
            </c:forEach>    
                <div class="text-muted" style="font-size: 13px;">구장 운영자</div>
                <div class="mt-3">
                    <span class="badge bg-primary text-dark">구장 운영자 로그인</span>
                </div>
            </div>
			<!-- 관리자 메뉴 탭 -->
            <div class="menu-section-title">관리 메뉴</div>
            <nav class="nav flex-column">
                <a class="nav-link" href="#"><i class="bi bi-speedometer2 me-2"></i>구장 예약 승인 처리</a>
               <!--  <a class="nav-link" href="#"><i class="bi bi-people-fill me-2"></i>정보 관리</a>
                <a class="nav-link" href="#"><i class="bi bi-flag-fill me-2"></i>경기 기록</a>
                <a class="nav-link" href="#"><i class="bi bi-building me-2"></i>결제 내역</a>
                <a class="nav-link" href="#"><i class="bi bi-chat-dots-fill me-2"></i>나의 동호회</a>
                <a class="nav-link" href="#"><i class="bi bi-file-earmark-text me-2"></i>동호회 신청 내역</a> -->
            </nav>
			<!-- 사이드바 설정 개인설정 탭 -->
            <div class="menu-section-title">설정</div>
            <nav class="nav flex-column">
                <a class="nav-link" href="#"><i class="bi bi-gear-fill me-2"></i>설정</a>
                <a class="nav-link" href="#"><i class="bi bi-box-arrow-right me-2"></i>로그아웃</a>
            </nav>
        </div>
        <div class="flex-grow-1 me-4">
            <div class="content-area">
                <h4 class="mb-4">관리자 대시보드</h4>
                <p>여기다가 내용 넣을 예정</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
