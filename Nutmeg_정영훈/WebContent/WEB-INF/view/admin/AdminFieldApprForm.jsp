<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>

<style>

  .user-table {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  width: 100%;
  max-width: 100%;
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

<h4 class="mb-4">경기장 승인 요청</h4>

<!-- 동일한 스타일 적용 -->
<div class="user-table">
  <!-- 헤더 -->
  <div class="row header">
    <div>구장명</div><div>등록일</div><div>크기</div>
    <div>바닥/환경</div><div>가격</div><div>관리</div>
  </div>

  <c:forEach var="field" items="${fieldAllList}">
    <div class="row">
      <div class="cell">${field.field_reg_name}</div>
      <div class="cell">${field.field_reg_at}</div>
      <div class="cell">${field.field_reg_garo} x ${field.field_reg_sero}</div>
      <div class="cell">${field.field_type} / ${field.field_environment_type}</div>
      <div class="cell">${field.field_reg_price} 원</div>
      <div class="cell actions">
        <form method="post" action="FieldApprInsert.action" class="d-inline">
          <input type="hidden" name="field_reg_id" value="${field.field_reg_id}" />
          <input type="hidden" name="user_code_id" value="${sessionScope.user_code_id}" />
          <button type="button" class="btn btn-outline-primary btn-sm approve-btn">승인</button>
        </form>
        <form method="post" action="FieldApprCancelForm.action" class="d-inline">
          <input type="hidden" name="field_reg_id" value="${field.field_reg_id}" />
          <input type="hidden" name="user_code_id" value="${sessionScope.user_code_id}" />
          <button type="button" class="btn btn-outline-danger btn-sm reject-btn">반려</button>
        </form>
      </div>
    </div>
  </c:forEach>
</div>

<!-- 반려 모달 -->
<div class="modal fade" id="rejectModal" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <form id="rejectReasonForm">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">반려 사유 입력</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
        </div>
        <div class="modal-body" id="rejectModalBody">
          <!-- Ajax로 삽입될 반려 사유 입력 폼 -->
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-outline-danger btn-sm">반려 처리</button>
        </div>
      </div>
    </form>
  </div>
</div>

<script>
$(function () {
  $('.approve-btn').click(function () {
    const form = $(this).closest('form');
    if (confirm("정말 승인하시겠습니까?")) {
      $.post(form.attr('action'), form.serialize(), function () {
        alert("승인 완료");
        form.closest('.row').fadeOut();
      });
    }
  });

  $('.reject-btn').click(function () {
    const form = $(this).closest('form');
    $.post(form.attr('action'), form.serialize(), function (data) {
      $('#rejectModalBody').html(data);
      new bootstrap.Modal($('#rejectModal')).show();
    }).fail(function () {
      alert("반려 사유 불러오기 실패");
    });
  });

  $(document).on('click', '#rejectModal .btn-outline-danger', function () {
    const type = $('#rejectModal select').val();
    const reason = $('#rejectModal textarea').val();
    const fieldRegId = $('#rejectModal input[name="field_reg_id"]').val();
    const userCodeId = $('#rejectModal input[name="user_code_id"]').val();

    if (!reason) {
      alert("반려 사유를 입력해주세요");
      return;
    }

    $.post('<%=cp%>/FieldApprCancelInsert.action', {
      field_appr_cancel_type_id: type,
      field_appr_cancel_reason: reason,
      field_reg_id: fieldRegId,
      user_code_id: userCodeId
    }, function () {
      alert("반려 완료");
      bootstrap.Modal.getInstance(document.getElementById('rejectModal')).hide();
      $.get('<%=cp%>/AdminFieldApprForm.action', function (data) {
        $('#content-area').html(data);
      });
    });
  });
});
</script>
