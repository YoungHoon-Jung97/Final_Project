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
    const $targetDiv = $('#stadium-list-' + stadiumId);

    // 이미 열려 있으면 -> 닫기
    if ($targetDiv.is(':visible') && $targetDiv.children().length > 0) {
        $targetDiv.slideUp(200, function () {
            $targetDiv.empty(); // 내용도 비움
        });
        $btn.text('구장의 휴무일 설정');
        return;
    }

    // 아직 안 열렸으면 -> Ajax로 불러오기
    $.ajax({
        url: 'OperatorStadiumHolidayDeleteForm.action',
        method: 'POST',
        data: { stadium_reg_id: stadiumId },
        success: function (html) {
            $targetDiv.html(html).hide().slideDown(200);
            $btn.text('정보 닫기');
        },
        error: function () {
            alert("경기장 정보를 불러오는 데 실패했습니다.");
        }
    });
});
</script>




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
                구장의 휴무일 보기
            </button>
        </div>

        <!-- 여기에 경기장 리스트 삽입될 영역 -->
        <div class="stadium-list mt-3" id="stadium-list-${stadium.stadium_reg_id}"></div>
    </div>
</c:forEach>
