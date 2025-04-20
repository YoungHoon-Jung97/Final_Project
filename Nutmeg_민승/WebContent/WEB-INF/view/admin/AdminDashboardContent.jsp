<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 대시보드</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

   <style>
    /* 카드 그리드 */
    .stats-container {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
      gap: 1rem;
      margin-bottom: 2rem;
    }
    .stats-card {
      background: #fff;
      border-radius: 8px;
      padding: 1.5rem;
      position: relative;
      overflow: hidden;
      transition: transform .2s, box-shadow .2s;
    }
    .stats-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 4px;
      height: 100%;
      background: linear-gradient(180deg, #7dcfb6, #80cfa9);
    }
    .stats-card:hover {
      transform: translateY(-4px);
      box-shadow: 0 8px 20px rgba(0,0,0,0.07);
    }
    .stats-card h6 {
      margin-bottom: .75rem;
      font-size: 0.9rem;
      letter-spacing: .5px;
      text-transform: uppercase;
      color: #666;
    }
    .stats-card .value {
      font-size: 2rem;
      font-weight: 700;
      color: #444;
    }

    /* 최근 등록 리스트 */
    .recent-list {
      display: flex;
      flex-direction: column;
      gap: .75rem;
      margin-bottom: 2rem;
    }
    .recent-item {
      background: #fff;
      border-radius: 8px;
      padding: 1rem 1.25rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
      transition: background .2s;
    }
    .recent-item:hover {
      background: rgba(125,207,182,0.05);
    }
    .recent-item .info {
      display: flex;
      flex-direction: column;
    }
    .recent-item .info .name {
      font-size: 1rem;
      font-weight: 600;
      color: #333;
    }
    .recent-item .info .date {
      font-size: .85rem;
      color: #888;
    }
    .recent-item .price {
      font-size: .95rem;
      font-weight: 500;
      color: #555;
    }

    /* 사용자 목록 */
    .user-list {
      background: #fff;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 4px 12px rgba(0,0,0,0.04);
    }
    .user-list .header,
    .user-list .row {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      text-align: center;
    }
    .user-list .header {
      background: #eaf9f3;
      padding: .75rem 1rem;
      font-weight: 600;
      color: #444;
    }
    .user-list .row {
      padding: .85rem 1rem;
      border-top: 1px solid #f0f0f0;
      transition: background .2s;
    }
    .user-list .row:nth-child(even) {
      background: rgba(125,207,182,0.03);
    }
    .user-list .row:hover {
      background: rgba(125,207,182,0.1);
    }
  </style>

<!-- 통계 카드 -->
<div class="d-flex flex-wrap gap-4 mb-5">
	<div class="p-3 border rounded flex-fill text-center bg-light"
		style="min-width: 200px;">
		<h6 class="text-muted mb-1">총 사용자 수</h6>
		<div class="fs-4 fw-bold text-primary">${totalUserCount}</div>
	</div>
	<div class="p-3 border rounded flex-fill text-center bg-light"
		style="min-width: 200px;">
		<h6 class="text-muted mb-1">총 경기장 수</h6>
		<div class="fs-4 fw-bold text-success">${totalFieldCount}</div>
	</div>
	<div class="p-3 border rounded flex-fill text-center bg-light"
		style="min-width: 200px;">
		<h6 class="text-muted mb-1">미승인 경기장</h6>
		<div class="fs-4 fw-bold text-danger">${pendingFieldCount}</div>
	</div>
</div>

<!-- 최근 경기장 등록 요청 -->
<h5 class="mt-4 mb-3">최근 경기장 등록 요청</h5>
<div class="d-flex flex-column gap-3 mb-5">
	<c:forEach var="field" items="${recentFieldRegList}">
		<div
			class="d-flex justify-content-between align-items-center p-3 border rounded bg-white">
			<div>
				<div class="fw-bold">${field.field_reg_name}</div>
				<div class="text-muted small">${field.field_reg_at}</div>
			</div>
			<div class="text-end text-secondary fw-semibold">${field.field_reg_price}
				원</div>
		</div>
	</c:forEach>
</div>

<!-- 최근 가입한 사용자 목록 -->
<h5 class="mb-3">최근 가입한 사용자</h5>
<div class="border rounded">
	<div class="d-flex bg-light fw-bold p-2 border-bottom">
		<div class="flex-fill text-center">이름</div>
		<div class="flex-fill text-center">이메일</div>
		<div class="flex-fill text-center">전화번호</div>
		<div class="flex-fill text-center">닉네임</div>
	</div>
	<c:forEach var="user" items="${recentUserList}">
		<div class="d-flex p-2 border-bottom align-items-center">
			<div class="flex-fill text-center">${user.user_name}</div>
			<div class="flex-fill text-center">${user.user_email}</div>
			<div class="flex-fill text-center">${user.user_tel}</div>
			<div class="flex-fill text-center">${user.user_nick_name}</div>
		</div>
	</c:forEach>
</div>
</div>
