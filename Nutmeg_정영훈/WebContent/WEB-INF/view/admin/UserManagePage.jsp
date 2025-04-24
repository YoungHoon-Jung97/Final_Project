<%@ page contentType="text/html; charset=UTF-8" language="java"%>
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


<!-- Bootstrap & jQuery -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" href="<%=cp%>/css/admin/Admin.css">
</head>
<body>
<h4 class="mb-4">사용자 관리</h4>
<table class="table table-hover text-center user-list">
	<thead class="thead-light">
		<tr>
			<th>이름</th>
			<th>이메일</th>
			<th>전화번호</th>
			<th>닉네임</th>
			<th>상태</th>
			<th>관리</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="user" items="${userList}">
			<tr>
				<td>${user.user_name}</td>
				<td>${user.user_email}</td>
				<td>${user.user_tel}</td>
				<td>${user.user_nick_name}</td>
				<td>
					<c:choose>
						<c:when test="${user.is_banned=='Y'}">
							<span class="text-danger">차단됨</span>
						</c:when>
						<c:otherwise>
							<span class="text-success">정상</span>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
			    	<div class="d-flex justify-content-center gap-2">
						<c:choose>
							<c:when test="${user.is_banned=='Y'}">
							  <button class="btn btn-outline-secondary btn-sm unban-btn"
							          data-user-id="${user.user_code_id}">해제</button>
							</c:when>
							<c:otherwise>
								<button class="btn btn-outline-danger btn-sm ban-btn"
								        data-user-id="${user.user_code_id}">차단</button>
							</c:otherwise>
						</c:choose>
			      		<button class="btn btn-outline-dark btn-sm delete-btn"
			              data-user-id="${user.user_id}">삭제</button>
			    	</div>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<!-- 페이징 -->
<div class="pagination">${pageHtml}</div>

<!-- 차단 모달 -->
<div class="modal fade" id="banModal" tabindex="-1"
	aria-labelledby="banModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<form id="banForm" method="post">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">사용자 차단</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="닫기"></button>
				</div>
				<div class="modal-body">
					<input type="hidden" name="userCodeId1" id="banUserId">
					<div class="mb-3">
						<label class="form-label">차단 기한</label> <select
							name="banDeadlineId" class="form-select" required>
							<option value="7">7일 차단</option>
							<option value="30">30일 차단</option>
							<option value="60">60일 차단</option>
							<option value="90">90일 차단</option>
						</select>
					</div>
					<div class="mb-3">
						<label class="form-label">차단 사유</label>
						<textarea name="userBanReason" class="form-control" rows="3"
							required></textarea>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-danger">차단하기</button>
				</div>
			</div>
		</form>
	</div>
</div>
</body>
<script>
$(function(){

	// 차단 버튼 클릭 
	$('.ban-btn').on('click', function(){
		$('#banUserId').val($(this).data('user-id'));
		new bootstrap.Modal($('#banModal')).show();
	});
	
	// 차단 폼 
	$('#banForm').on('submit', function(e){
		e.preventDefault();
		$.post(
			'<%=cp%>/UserBanInsert.action',
			$(this).serialize(),
			function(){
			  alert("사용자가 차단되었습니다.");
			  location.reload();
			}
		).fail(function(xhr){
			alert("차단 처리 중 오류가 발생했습니다: " + xhr.status);
		});
	});
	
	// 차단 해제 버튼
	$('.unban-btn').on('click', function(){
		if (!confirm("정말 차단을 해제하시겠습니까?")) return;
		var uid = $(this).data('user-id');
		$.post(
			'<%=cp%>/UserUnban.action',
			{ user_id: uid },                // 컨트롤러가 받는 파라미터 이름(user_id)으로 맞춤
			function(){
				alert("차단이 해제되었습니다.");
				location.reload();
			}
		).fail(function(xhr){
			alert("차단 해제 중 오류가 발생했습니다: " + xhr.status);
		});
	});
	
	// 삭제 버튼
	$('.delete-btn').on('click', function(){
		if (!confirm("정말 사용자를 삭제하시겠습니까?")) return;
		var uid = $(this).data('user-id');
			$.post(
			'<%=cp%>/UserDelete.action',     
			 { user_id: uid },                
			 function(){
				alert("사용자가 삭제되었습니다.");
				location.reload();
			 }
		).fail(function(xhr){
			alert("삭제 중 오류 발생: " + xhr.status);
		});
	});

});
</script>