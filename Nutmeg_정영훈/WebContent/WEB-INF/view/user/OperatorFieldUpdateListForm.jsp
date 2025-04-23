<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- <script type="text/javascript">
$(document).on('click', '.show-fields-btn', function () {
    const $btn = $(this);
    const fieldId = $btn.data('field-id');
    const $targetDiv = $('#field-list-' + fieldId);
	
    console.log("경기장 아이디 :",fieldId);
    // 이미 열려 있으면 -> 닫기
    if ($targetDiv.is(':visible') && $targetDiv.children().length > 0) {
        $targetDiv.slideUp(200, function () {
            $targetDiv.empty(); // 내용도 비움
        });
        $btn.text('정보 수정하기');
        return;
    }

    // 아직 안 열렸으면 -> Ajax로 불러오기
    $.ajax({
        url: 'OperatorFieldUpdateForm.action',
        method: 'POST',
        data: { field_reg_id: fieldId },
        success: function (html) {
            $targetDiv.html(html).hide().slideDown(200);
            $btn.text('정보 닫기');
        },
        error: function () {
            alert("경기장 정보를 불러오는 데 실패했습니다.");
        }
    });
});
</script> -->

<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/stadium/StadiumFieldCheckForm.css?after">
	
	<div class="section-title">
	  <i class="bi bi-gear me-2"></i> 경기장 정보 수정
	</div>
	<c:forEach var="field" items="${fieldList}">
	<form action="OperatorFieldUpdateForm.action" method="post">
		<div class="match-card">
			<div class="field-card">
				<div class="field-img-wrapper">
					<img src="${field.field_reg_image}" alt="" class="field-img" style="width: 100%;height: 300px;">
	
					<div class="field-info">
						<strong>이름 : ${field.field_reg_name}</strong><br>
						등록일 : ${field.field_reg_at} <br> 
						가로 : ${field.field_reg_garo}, 세로 : ${field.field_reg_sero} <br> 
						바닥 종류 : ${field.field_type}, 환경: ${field.field_environment_type}<br>
						2시간당 가격 : ${field.field_reg_price}
					</div>
				</div>
	
				<!-- 버튼 -->
				<input type="hidden" name="field_code_id" value="${field.field_code_id}">
				<div style="display: flex; justify-content: flex-end;">
				<button type="submit" class="btn btn-secondary card-action " >
                정보 수정하기
            	</button>
            	</div>
			</div>
		</div>
	</form>
	</c:forEach>
