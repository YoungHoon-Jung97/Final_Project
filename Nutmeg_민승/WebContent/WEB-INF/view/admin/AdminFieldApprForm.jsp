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
    const fieldRegId = $('#rejectModal input[name="field_reg_id"]').val(); // form에 숨겨진 input 필요
    const userCodeId = $('#rejectModal input[name="user_code_id"]').val(); // form에 숨겨진 input 필요

    if (!reason) {
        alert("반려 사유를 선택해주세요");
        return;
    }

    $.post('<%=cp%>/FieldApprCancelInsert.action', {
    	field_appr_cancel_type_id: type,
    	field_appr_cancel_reason: reason,
        field_reg_id: fieldRegId,
        user_code_id: userCodeId
    }, function () {
        alert("반려 처리 완료");
        const modal = bootstrap.Modal.getInstance(document.getElementById('rejectModal'));
        modal.hide();
        // 목록 갱신
        $.get('<%=cp%>/AdminFieldApprForm.action', function (data) {
            $('#content-area').html(data);
        });
    });
});
</script>


<h4 class="mb-4">경기장 승인 요청</h4>

<c:forEach var="field" items="${fieldAllList}">
    <div class="match-card border rounded p-3 mb-3">
        <div class="d-flex justify-content-between align-items-center">
            <!-- 왼쪽: 경기장 정보 -->
            <div>
                <strong>${field.field_reg_name}</strong><br>
                등록일 : ${field.field_reg_at} <br>
                크기 : ${field.field_reg_garo} x ${field.field_reg_sero} <br>
                바닥 : ${field.field_type}, 환경 : ${field.field_environment_type} <br>
                가격 : ${field.field_reg_price} 원
            </div>

            <!-- 오른쪽: 승인/반려 버튼 -->
            <div class="text-end">
                <!-- 승인 form -->
                <form class="approve-form d-inline" method="post" action="FieldApprInsert.action">
                    <input type="hidden" name="field_reg_id" value="${field.field_reg_id}" />
                    <input type="hidden" name="user_code_id" value="${sessionScope.user_code_id}" />
                    <button type="button" class="btn btn-primary approve-btn">승인</button>
                </form>

                <!-- 반려 form -->
                <form class="reject-form d-inline" method="post" action="FieldApprCancelForm.action">
                    <input type="hidden" name="field_reg_id" value="${field.field_reg_id}" />
                    <input type="hidden" name="user_code_id" value="${sessionScope.user_code_id}" />
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



<%-- <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
    Integer user_code_id = (Integer) session.getAttribute("user_code_id");
%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function () {
    
	const form = $(this).closest('form');
	var user_code_id = "<%= user_code_id %>";
	form.find('input[name="user_code_id"]').val(user_code_id);	
	// 승인 버튼
    $('.approve-btn').click(function () {
        const form = $(this).closest('form');
        if (confirm("정말 승인하시겠습니까?"+user_code_id)) {
            $.post(form.attr('action'), form.serialize(), function () {
                alert("승인되었습니다.");
                form.closest('.match-card').fadeOut(); // 성공 후 제거
            });
        }
    });

    // 반려 버튼
    $('.reject-btn').click(function () {
        const form = $(this).closest('form');
        if (confirm("정말 반려하시겠습니까?")) {
            $.post(form.attr('action'), form.serialize(), function (data) {
                $('#content-area').html(data); // 페이지 불러옴
            }).fail(function () {
                alert("반려 페이지 불러오기 실패");
            });
        }
    });
});
</script>

<h4 class="mb-4">경기장 승인 요청</h4>

<c:forEach var="field" items="${fieldAllList}">
    <div class="match-card border rounded p-3 mb-3">
        <div class="d-flex justify-content-between align-items-center">
            <!-- 왼쪽: 경기장 정보 -->
            <div>
                <strong>${field.field_reg_name}</strong><br>
                등록일 : ${field.field_reg_at} <br>
                크기 : ${field.field_reg_garo} x ${field.field_reg_sero} <br>
                바닥 : ${field.field_type}, 환경 : ${field.field_environment_type} <br>
                가격 : ${field.field_reg_price} 원
            </div>

            <!-- 오른쪽: 승인/반려 버튼 -->
            <div class="text-end">
                <!-- 승인 form -->
                <form class="approve-form d-inline" method="post" action="FieldApprInsert.action">
                    <input type="hidden" name="field_reg_id" value="${field.field_reg_id}" />
                    <input type="hidden" name="user_code_id" value="${sessionScope.user_code_id}" />
                    <button type="button" class="btn btn-primary approve-btn">승인</button>
                </form>

                <!-- 반려 form -->
                <form class="reject-form d-inline" method="post" action="FieldApprCancelForm.action">
                    <input type="hidden" name="field_reg_id" value="${field.field_reg_id}" />
                    <input type="hidden" name="user_code_id" value="${sessionScope.user_code_id}" />
                    <button type="button" class="btn btn-danger reject-btn">반려</button>
                </form>
            </div>
        </div>
    </div>
</c:forEach>
 --%>