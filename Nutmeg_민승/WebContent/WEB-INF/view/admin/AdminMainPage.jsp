<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=cp %>/css/Template.css">
</head>

<!-- Ajax 로딩 스크립트 -->
<script>
$(document).ready(function () {
    $('.menu-link').click(function (e) {
        e.preventDefault();
        const url = $(this).data('url');

        $.ajax({
            url: url,
            method: 'GET',
            success: function (result) {
                $('#content-area').html(result);
            },
            error: function () {
                alert("콘텐츠를 불러오는 데 실패했습니다.");
            }
        });
    });
});
</script>

<style>
    .admin-wrapper {
        display: flex;
        width: 100%;
        max-width: 1200px;
        margin-top: 100px; /* 상단 메뉴 높이 고려 */
        gap: 30px;
    }

    .admin-sidebar {
        width: 250px;
        min-height: 600px;
        background: #ffffff;
        border: 1px solid #ddd;
        padding: 20px;
        border-radius: 10px;
    }

    .admin-sidebar .nav-link {
        color: #333;
        padding: 10px;
        display: block;
        border-radius: 6px;
        margin-bottom: 5px;
    }

    .admin-sidebar .nav-link:hover {
        background-color: #f1f3f5;
        text-decoration: none;
    }

    .admin-content {
        flex-grow: 1;
        background: #ffffff;
        border: 1px solid #ddd;
        border-radius: 10px;
        padding: 30px;
        min-height: 600px;
        box-shadow: 0 0 10px rgba(0,0,0,0.03);
    }

    .profile-box {
        padding: 15px;
        border: 1px solid #dee2e6;
        border-radius: 10px;
        margin-bottom: 30px;
        background-color: #f9fafc;
        text-align: center;
    }
    
    .match-card {
	background: #gray;
	border-radius: 8px;
	padding: 1rem;
	box-shadow: 0 0 5px rgba(0, 0, 0, 0.5);
	margin-bottom: 1rem;
	}
</style>


<body>
<div class="container">
    <div class="admin-wrapper d-flex gap-4 mt-5">
        <!-- 콘텐츠 영역 -->
        <div class="admin-content flex-grow-1" id="content-area">
            <h4 class="mb-4">관리자 대시보드</h4>
            <p>여기에 관리자용 콘텐츠를 출력합니다.</p>
        </div>

        <!-- 사이드바 -->
        <div class="admin-sidebar">
            <div class="profile-box text-center mb-4">
                <h5 class="mb-1">${sessionScope.admin_nickName}</h5>
                <div class="text-muted" style="font-size: 13px;">관리자</div>
                <div class="mt-2"><span class="badge bg-warning text-dark">관리자 로그인</span></div>
            </div>

            <div class="fw-bold mb-2">관리 메뉴</div>
            <a class="nav-link menu-link" data-url="<%=cp%>/AdminFieldApprForm.action">
                <i class="bi bi-building me-2"></i>경기장 승인관리
            </a>
            <a class="nav-link menu-link" data-url="<%=cp%>/UserManage.action">
                <i class="bi bi-people-fill me-2"></i>사용자 관리
            </a>
            <!-- 다른 메뉴도 동일하게 추가 -->
        </div>
    </div>
</div>

</body>
</html>




<%-- <%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=cp %>/css/Template.css">
    <style>
        .admin-wrapper {
            display: flex;
            width: 100%;
            max-width: 1200px;
            margin-top: 100px; /* 상단 메뉴 높이 고려 */
            gap: 30px;
        }

        .admin-sidebar {
            width: 250px;
            min-height: 600px;
            background: #ffffff;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 10px;
        }

        .admin-sidebar .nav-link {
            color: #333;
            padding: 10px;
            display: block;
            border-radius: 6px;
            margin-bottom: 5px;
        }

        .admin-sidebar .nav-link:hover {
            background-color: #f1f3f5;
            text-decoration: none;
        }

        .admin-content {
            flex-grow: 1;
            background: #ffffff;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 30px;
            min-height: 600px;
            box-shadow: 0 0 10px rgba(0,0,0,0.03);
        }

        .profile-box {
            padding: 15px;
            border: 1px solid #dee2e6;
            border-radius: 10px;
            margin-bottom: 30px;
            background-color: #f9fafc;
            text-align: center;
        }
    </style>

<body>
<div class="container">
<!-- 여기서 임포트한 메뉴는 템플릿에 있는 메뉴바 -->
    <div class="admin-wrapper">
        <div class="admin-content">
            <h4 class="mb-4">관리자 대시보드</h4>
            <p>여기에 관리자용 콘텐츠를 출력합니다.</p>
        </div>

        <!-- 오른쪽 바 메뉴  -->
        <div class="admin-sidebar">
            <div class="profile-box">
            	<c:forEach var="info" items="${adminLoginInfo }">
                <h5 class="mb-1">${info.admin_nickName }</h5>
                <div class="text-muted" style="font-size: 13px;">관리자</div>
                <div class="mt-2">
                    <span class="badge bg-warning text-dark">관리자 로그인</span>
                </div>
                </c:forEach>
            </div>

            <div class="fw-bold mb-2">관리 메뉴</div>
            <a class="nav-link" href="#"><i class="bi bi-speedometer2 me-2"></i>대시보드</a>
            <a class="nav-link" href="#"><i class="bi bi-people-fill me-2"></i>사용자 관리</a>
            <a class="nav-link" href="#"><i class="bi bi-flag-fill me-2"></i>신고 관리</a>
            <a class="nav-link" href="#"><i class="bi bi-building me-2"></i>구장 관리</a>
            <a class="nav-link" href="AdminFieldApprForm.action"><i class="bi bi-building me-2"></i>경기장 승인관리</a>
            <a class="nav-link" href="#"><i class="bi bi-chat-dots-fill me-2"></i>동호회 관리</a>
            <a class="nav-link" href="#"><i class="bi bi-file-earmark-text me-2"></i>게시판 관리</a>

            <hr>
            <div class="fw-bold mb-2">설정</div>
            <a class="nav-link" href="#"><i class="bi bi-gear-fill me-2"></i>설정</a>
            <a class="nav-link" href="#"><i class="bi bi-box-arrow-right me-2"></i>로그아웃</a>
        </div>
    </div>
</div>

</body>
</html>
 --%>