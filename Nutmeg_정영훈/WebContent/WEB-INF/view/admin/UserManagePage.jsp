<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();
%>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
  .user-table {
    display: grid;
    /* 6개의 열을 동일 너비로 */
    grid-template-columns: repeat(6, 1fr);
    background: #fff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
  }
  .user-table .row {
    display: contents; /* grid-item 그대로 행처럼 동작 */
  }

  /* 헤더 */
  .user-table .header > div {
    padding: 16px 0;
    text-align: center;
    font-weight: 600;
    color: #fff;
    background: linear-gradient(to right, #7dcfb6, #80cfa9);
  }

  /* 데이터 셀 */
  .user-table .cell {
    padding: 14px 8px;
    text-align: center;
    border-bottom: 1px solid #ececec;
    font-size: 0.95rem;
  }

  /* 줄무늬 & 호버 */
  .user-table .row:nth-child(even) .cell {
    background: rgba(125,207,182,0.07);
  }
  .user-table .row:hover .cell {
    background: rgba(125,207,182,0.15);
  }

  /* 버튼 셀만 flex 정렬 */
  .user-table .cell.actions {
    display: flex;
    justify-content: center;
    gap: 8px;
  }
  .btn-sm {
    padding: 0.35rem 0.9rem;
    font-size: 0.85rem;
    border-radius: 4px;
  }

</style>

<div class="user-table">
  <!-- 헤더 -->
  <div class="row header">
    <div>이름</div><div>이메일</div><div>전화번호</div>
    <div>닉네임</div><div>상태</div><div>관리</div>
  </div>
  <!-- 반복문 돌면서 rows -->
  <c:forEach var="user" items="${userList}">
    <div class="row">
      <div class="cell">${user.user_name}</div>
      <div class="cell">${user.user_email}</div>
      <div class="cell">${user.user_tel}</div>
      <div class="cell">${user.user_nick_name}</div>
      <div class="cell">
        <c:choose>
          <c:when test="${user.is_banned=='Y'}">
            <span class="text-danger">차단됨</span>
          </c:when>
          <c:otherwise>
            <span class="text-success">정상</span>
          </c:otherwise>
        </c:choose>
      </div>
      <div class="cell actions">
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
    </div>
  </c:forEach>
</div>


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
