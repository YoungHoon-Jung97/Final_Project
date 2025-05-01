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
<title>경기장 승인 요청</title>

<!-- Bootstrap & jQuery -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- 관리자 공통 CSS -->
<link rel="stylesheet" href="<%=cp%>/css/admin/Admin.css">
</head>
<body>

  <div class="admin-wrapper">
    <!-- ✅ 메인 콘텐츠 -->
    <div class="admin-content">
      <h4 class="mb-4">경기장 승인 요청</h4>

      <table class="table table-hover text-center user-table">
        <thead class="thead-light">
          <tr>
            <th>구장명</th>
            <th>등록일</th>
            <th>크기</th>
            <th>바닥/환경</th>
            <th>가격</th>
            <th>파일</th>
            <th>관리</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="field" items="${fieldAllList}">
            <tr>
              <td>${field.field_reg_name}</td>
              <td>${field.field_reg_at}</td>
              <td>${field.field_reg_garo} x ${field.field_reg_sero}</td>
              <td>${field.field_type} / ${field.field_environment_type}</td>
              <td>${field.field_reg_price} 원</td>
              <td><button class="btn btn-outline-primary">파일</button></td>
              <td>
                <div class="d-flex justify-content-center gap-2">
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
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
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
        form.closest('tr').fadeOut();  // tr로 바뀌었으므로 여기 수정
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

</body>
</html>
