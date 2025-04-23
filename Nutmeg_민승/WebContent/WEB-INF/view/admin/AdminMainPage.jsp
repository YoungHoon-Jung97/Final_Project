<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="stylesheet" href="<%=cp%>/css/util/Template.css">
 <style>
    /* 전체 바디 */
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background: #f0f3f5;
      margin: 0;
      padding: 0;
    }
    .container {
      max-width: 1200px;
      padding: 0 15px;
      margin: 50px auto;
    }

    /* 사이드바 & 레이아웃 */
    .admin-wrapper { display: flex; gap: 30px; }
    .admin-sidebar {
      width: 260px;
      background: #fff;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }

    /* 세련된 프로필 박스 */
    .profile-box {
      position: relative;
      background: linear-gradient(135deg, #7dcfb6 0%, #80cfa9 100%);
      color: #fff;
      text-align: center;
      padding: 36px 24px;
      border-radius: 16px;
      box-shadow: 0 10px 25px rgba(0,0,0,0.1);
      overflow: hidden;
    }
    .profile-box::before,
    .profile-box::after {
      content: "";
      position: absolute;
      border-radius: 50%;
      background: rgba(255,255,255,0.15);
      transform: rotate(45deg);
    }
    .profile-box::before {
      width: 120px; height: 120px;
      top: -40px; left: -40px;
    }
    .profile-box::after {
      width: 180px; height: 180px;
      bottom: -60px; right: -60px;
    }
    .profile-box h5 {
      margin: 0 0 8px;
      font-size: 1.35rem;
      font-weight: 600;
      letter-spacing: 0.5px;
      text-shadow: 0 1px 2px rgba(0,0,0,0.2);
    }
    .profile-box .text-muted {
      font-size: 0.85rem;
    }
    .profile-box .badge {
      background: rgba(255,255,255,0.25);
      color: #fff;
      font-size: 0.75rem;
      padding: 6px 14px;
      border-radius: 12px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      display: inline-block;
      margin-top: 6px;
    }

    /* 메뉴 타이틀 */
    .admin-sidebar .fw-bold {
      padding: 16px 20px 8px;
      font-size: 0.9rem;
      color: #444;
    }
    /* 메뉴 링크 */
    .admin-sidebar .nav-link {
      display: flex;
      align-items: center;
      padding: 12px 20px;
      color: #555;
      transition: background 0.2s, color 0.2s;
      border-left: 4px solid transparent;
    }
    .admin-sidebar .nav-link .bi {
      font-size: 1.2rem;
      margin-right: 10px;
    }
    .admin-sidebar .nav-link:hover {
      background: rgba(125,207,182,0.1);
      color: #333;
      border-left-color: #7dcfb6;
      text-decoration: none;
    }
    .admin-sidebar .nav-link.active {
      background: linear-gradient(135deg, #7dcfb6, #80cfa9);
      color: #fff !important;
      border-left-color: #7dcfb6;
    }

    /* 콘텐츠 영역 */
    .admin-content {
      flex: 1;
      background: #fff;
      border-radius: 12px;
      box-shadow: 0 4px 16px rgba(0,0,0,0.04);
      padding: 32px;
      min-height: 600px;
    }
    .admin-content p {
      color: #666;
      font-size: 1rem;
    }

    /* 모달 헤더 */
    .modal-header {
      background: linear-gradient(135deg, #7dcfb6, #80cfa9);
      color: #fff;
      border-bottom: none;
    }
    .modal-content {
      border-radius: 8px;
      overflow: hidden;
    }

    /* 반응형 */
    @media (max-width: 992px) {
      .admin-wrapper { flex-direction: column; }
      .admin-sidebar { width: 100%; }
    }
  </style>
    <script>
 // 현재 스크립트에 추가
    $(document).ready(function () {
        // 첫 진입 시 대시보드 자동 로딩
        $.get("<%=cp%>/AdminDashboardContent.action", function (result) {
            $('#content-area').html(result);
        });

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
                    /* alert("콘텐츠를 불러오는 데 실패했습니다."); */
                }
            });
        });
    });

    </script>
</head>
<body>
<div class="container">
    <div class="admin-wrapper">
        <!-- 사이드바 -->
        <div class="admin-sidebar">
            <div class="profile-box text-center mb-4">
                <h5 class="mb-1">${sessionScope.admin_nickName}</h5>
                <div class="text-muted" style="font-size: 13px;">관리자</div>
                <div class="mt-2"><span class="badge bg-warning text-dark">관리자 로그인</span></div>
            </div>
            <div class="fw-bold mb-2">관리 메뉴</div>
            <a class="nav-link menu-link" data-url="<%=cp%>/AdminDashboardContent.action
">
                <i class="bi bi-house-door me-2"></i>대시보드
            </a>
            <a class="nav-link menu-link" data-url="<%=cp%>/AdminFieldApprForm.action">
                <i class="bi bi-building me-2"></i>경기장 승인관리
            </a>
            <a class="nav-link menu-link" data-url="<%=cp%>/UserManagePage.action">
                <i class="bi bi-people-fill me-2"></i>사용자 관리
            </a>
        </div>

        <!-- 콘텐츠 영역 -->
        <div class="admin-content" id="content-area">
            <p>관리 메뉴를 선택해주세요.</p>
        </div>
    </div>
    

</div>
</body>
</html>
