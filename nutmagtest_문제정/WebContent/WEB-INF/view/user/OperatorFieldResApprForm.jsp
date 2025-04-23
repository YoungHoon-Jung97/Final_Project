<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
    Integer user_code_id = (Integer) session.getAttribute("user_code_id");
%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function () {
    $('.approve-btn').click(function () {
        const form = $(this).closest('form');
        if (confirm("정말 승인하시겠습니까?")) {
            $.post(form.attr('action'), form.serialize(), function () {
                alert("승인되었습니다.");
                form.closest('.match-card').fadeOut();
            });
        }
    });

    $('.reject-btn').click(function () {
        const form = $(this).closest('form');

        $.post(form.attr('action'), form.serialize(), function (data) {
            // JSP로부터 받아온 HTML을 모달에 출력
            $('#rejectModalBody').html(data);
            const modal = new bootstrap.Modal(document.getElementById('rejectModal'));
            modal.show();
        }).fail(function () {
            alert("반려 사유 페이지 로딩 실패");
        });
    });
});

</script>

<script>
$(document).on("click", "#rejectModal .btn-danger", function () {
    const type = $('#rejectModal select').val();
    const reason = $('#rejectModal textarea').val();
    const fieldResId = $('#rejectModal input[name="field_res_id"]').val(); // form에 숨겨진 input 필요

    if (!reason) {
        alert("반려 사유를 선택해주세요");
        return;
    }

    $.post('<%=cp%>/FieldResApprCancelInsert.action', {
        field_pay_cancel_reason: reason,
        field_res_id: fieldResId,
    })
    .done(function () {
        alert("반려 처리 완료");
        const modal = bootstrap.Modal.getInstance(document.getElementById('rejectModal'));
        console.log("모달 닫기 시작");
        modal.hide();
        console.log("모달 닫기 완료");
        $.post('<%=cp%>/OperatorFieldResApprForm.action', function (data) {
            $('#content-area').html(data);
        });
    })
    .fail(function (xhr, status, error) {
        console.error("반려 처리 실패:", status, error);
        console.error("응답 내용:", xhr.responseText);
        alert("서버 오류로 반려에 실패했습니다.");
    });
 
    
    
});
</script>


<div class="section-title">
  <i class="bi bi-check-circle me-2"></i>
  경기장 승인 요청
</div>

<c:forEach var="field" items="${fieldBeforeResApprList}">
    <div class="match-card border rounded p-3 mb-3">
        <div class="d-flex justify-content-between align-items-center">
            <!-- 왼쪽: 경기장 정보 -->
            <div>
                <strong>${field.field_reg_name}</strong><br>
                예약 신청 일시 : ${field.field_res_at} <br>
             	시작 시간 : ${field.stadium_time_at1 } 종료 시간 : ${field.stadium_time_at2 }
            </div>

            <!-- 오른쪽: 승인/반려 버튼 -->
            <div class="text-end">
                <!-- 승인 form -->
                <form class="approve-form d-inline" method="post" action="FieldResApprInsert.action">
                    <input type="hidden" name="field_res_id" value="${field.field_res_id }" />
                    <button type="button" class="btn btn-primary approve-btn">승인</button>
                </form>

                <!-- 반려 form -->
                <form class="reject-form d-inline" method="post" action="FieldResApprCancelForm.action">
                	<input type="hidden" name="field_res_id" value="${field.field_res_id}" />
                    <button type="button" class="btn btn-danger reject-btn">반려</button>
                </form>
            </div>
        </div>
    </div>
    
    
    
<!-- 모달: 반려 사유 입력용 -->
<div class="modal fade" id="rejectModal" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="rejectModalLabel">반려 사유 입력</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body" id="rejectModalBody">
        <!-- Ajax로 불러온 JSP가 여기에 들어옴 -->
      </div>
    </div>
  </div>
</div>
    
    
</c:forEach>