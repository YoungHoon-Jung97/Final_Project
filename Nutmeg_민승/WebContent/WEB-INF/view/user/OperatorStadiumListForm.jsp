<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).on('click', '.show-fields-btn', function () {
    const $btn = $(this);
    const stadiumId = $btn.data('stadium-id');
    const $targetDiv = $('#field-list-' + stadiumId);

    // 이미 열려 있으면 -> 닫기
    if ($targetDiv.is(':visible') && $targetDiv.children().length > 0) {
        $targetDiv.slideUp(200, function () {
            $targetDiv.empty(); // 내용도 비움
        });
        $btn.text('구장의 경기장 보기');
        return;
    }

    // 아직 안 열렸으면 -> Ajax로 불러오기
    $.ajax({
        url: 'OperatorFieldListForm.action',
        method: 'POST',
        data: { stadium_reg_id: stadiumId },
        success: function (html) {
            $targetDiv.html(html).hide().slideDown(200);
            $btn.text('경기장 닫기');
        },
        error: function () {
            alert("경기장 정보를 불러오는 데 실패했습니다.");
        }
    });
});
</script>

<h4 class="mb-4">구장 목록</h4>

<div class="match-card2">보유한 구장 전체 갯수 : ${stadiumCount} 개 </div>

<c:forEach var="stadium" items="${stadiumSearchList}">
    <div class="match-card">
        <div class="stadium-card">
            <div class="stadium-img-wrapper">
                <img src="${stadium.stadium_reg_image}" alt="" class="stadium-img">
                <div class="stadium-info">
                    <strong>${stadium.stadium_reg_name}</strong>
                    ${stadium.stadium_reg_addr}, ${stadium.stadium_reg_detailed_addr}
                </div>
            </div>

            <button type="button"
                    class="btn btn-secondary card-action show-fields-btn"
                    data-stadium-id="${stadium.stadium_reg_id}">
                구장의 경기장 보기
            </button>
        </div>

        <!-- 여기에 경기장 리스트 삽입될 영역 -->
        <div class="field-list mt-3" id="field-list-${stadium.stadium_reg_id}"></div>
    </div>
</c:forEach>
