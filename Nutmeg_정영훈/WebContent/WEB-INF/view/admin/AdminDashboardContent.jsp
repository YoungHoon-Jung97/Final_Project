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
<link rel="stylesheet" href="<%=cp%>/css/admin/Admin.css">
<body>
<!-- 통계 카드 -->
<h4 class="mb-4">전체 정보</h4>
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
	<table class="table table-bordered">
	    <thead style="background-color: gray">
	        <tr>
	            <th class="text-center">이름</th>
	            <th class="text-center">이메일</th>
	            <th class="text-center">전화번호</th>
	            <th class="text-center">닉네임</th>
	        </tr>
	    </thead>
	    <tbody>
	        <c:forEach var="user" items="${recentUserList}">
	            <tr>
	                <td class="text-center">${user.user_name}</td>
	                <td class="text-center">${user.user_email}</td>
	                <td class="text-center">${user.user_tel}</td>
	                <td class="text-center">${user.user_nick_name}</td>
	            </tr>
	        </c:forEach>
	    </tbody>
	</table>
</div>
