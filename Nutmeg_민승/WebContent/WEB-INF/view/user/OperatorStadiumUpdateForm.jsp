<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="match-card1">
    <strong>변경할 구장 정보를 입력하세요</strong>
</div>

<c:forEach var="stadium" items="${stadiumSearchList}">
<form class="stadium-update-form" method="post" action="OperatorStadiumUpdate.action" enctype="multipart/form-data">
    <input type="hidden" name="stadium_reg_id" value="${stadium.stadium_reg_id}">
    <input type="hidden" name="user_code_id" value="${sessionScope.user_code_id}">

    <div class="form-group">
        <label>구장 이름</label>
        <div class="d-flex">
            <input type="text" class="form-control stadium-name" value="${stadium.stadium_reg_name}" name="stadium_reg_name" required>
            <button type="button" class="btn btn-outline-secondary check-dup-btn">중복 확인</button>
        </div>
        <span class="name-check-msg text-sm text-danger"></span>
    </div>
    <div class="error">
						<span id="nameCheckMsg" style="font-size: small;"></span>
					</div>

    <!-- 주소 필드들 -->
    <div class="form-group">
        <label>우편번호</label>
        <div class="d-flex">
            <input type="text" class="form-control post" name="stadium_reg_postal_addr" readonly>
            <button type="button" class="btn btn-outline-primary search-post-btn">우편번호 찾기</button>
        </div>
    </div>
    <div class="form-group">
        <label>주소</label>
        <input type="text" class="form-control address1" name="stadium_reg_addr" readonly>
        <input type="text" class="form-control address2" name="stadium_reg_detailed_addr">
    </div>

    <!-- 시간 -->
    <div class="form-group">
        <label>운영 시간</label>
        <select class="form-control time-start" name="stadium_time_id1">
            <option value="">시작 시간</option>
            <c:forEach var="t" items="${stadiumTimeList}">
                <option value="${t.stadium_time_id}">${t.stadium_time_at}</option>
            </c:forEach>
        </select>
        <select class="form-control time-end" name="stadium_time_id2">
            <option value="">종료 시간</option>
            <c:forEach var="t" items="${stadiumTimeList}">
                <option value="${t.stadium_time_id}">${t.stadium_time_at}</option>
            </c:forEach>
        </select>
    </div>

    <!-- 이미지 -->
    <div class="form-group">
        <label>이미지</label>
        <input type="file" class="form-control image" name="stadium_reg_image">
        <span class="file-name text-muted">선택된 파일 없음</span>
    </div>

    <button type="submit" class="btn btn-success submit-btn">저장</button>
</form>
</c:forEach>












<%-- <c:forEach var="stadium" items="${stadiumSearchList}">
    <form class="stadium-update-form" method="post" action="OperatorStadiumUpdateSave.action">
        <div class="match-card mb-3">
            <input type="hidden" name="stadium_reg_id" value="${stadium.stadium_reg_id}">

            <div class="mb-2">
                <label>구장 이름</label>
                <input type="text" class="form-control" name="stadium_reg_name" value="${stadium.stadium_reg_name}">
            </div>

            <div class="mb-2">
                <label>주소</label>
                <input type="text" class="form-control" name="stadium_reg_addr" value="${stadium.stadium_reg_addr}">
            </div>

            <div class="mb-2">
                <label>상세 주소</label>
                <input type="text" class="form-control" name="stadium_reg_detailed_addr" value="${stadium.stadium_reg_detailed_addr}">
            </div>
   
            <div class="mb-2">
			    <label>구장 운영 시간</label>
			    <select name="stadium_time_id1">
			        <option value="">시작시간</option>
			        <c:forEach var="time1" items="${stadiumTimeList}">
			            <option value="${time1.stadium_time_id}">${time1.stadium_time_at}</option>
			        </c:forEach>
			    </select>
			    ~
			    <select name="stadium_time_id2">
			        <option value="">종료시간</option>
			        <c:forEach var="time2" items="${stadiumTimeList}">
			            <option value="${time2.stadium_time_id}">${time2.stadium_time_at}</option>
			        </c:forEach>
			    </select>
			</div>
			
            <button type="submit" class="btn btn-success mt-2">수정 저장</button>
        </div>
    </form>
</c:forEach> --%>

<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
let isNameChecked = false;

$(function() {
    // 초기 설정, 버튼 비활성화
    $('#submitBtn').prop('disabled', true);

    $("#checkDuplicateBtn").click(function() {
        const name = $("#name").val().trim();

        if (!name) {
            $("#nameCheckMsg").text("구장 이름을 입력하세요.").css("color", "red");
            isNameChecked = false;
            updateSubmitButtonState();
            return;
        }

        $.ajax({
            url: "CheckStadiumName.action",
            type: "GET",
            data: { stadium_reg_name: name },
            success: function(result) {
                if (result === "duplicate") {
                    $("#nameCheckMsg").html("이미 있는 이름입니다.").css("color", "red");
                    isNameChecked = false;
                } else {
                    $("#nameCheckMsg").html("사용 가능한 이름입니다.").css("color", "green");
                    isNameChecked = true;
                }
                updateSubmitButtonState();
            },
            error: function() {
                $("#nameCheckMsg").text("오류 발생").css("color", "red");
                isNameChecked = false;
                updateSubmitButtonState();
            }
        });
    });

    $('#image').on('change', function() {
        const fileName = this.files.length > 0 ? this.files[0].name : '선택된 파일 없음';
        $('#file-name').text(fileName);
        updateSubmitButtonState();
    });

    $("input, select").on("change keyup", function() {
        updateSubmitButtonState();
    });
});

function updateSubmitButtonState() {
    if (isNameChecked && isFormFilled())
        $("#submitBtn").prop("disabled", false);
    else
        $("#submitBtn").prop("disabled", true);
}

function isFormFilled() {
    const start = parseInt($("#stadium_time_id1").val());
    const end = parseInt($("#stadium_time_id2").val());

    return $("#name").val().trim() !== "" &&
           $("#post").val().trim() !== "" &&
           $("#address1").val().trim() !== "" &&
           $("#address2").val().trim() !== "" &&
           $("#stadium_time_id1").val() !== "" &&
           $("#stadium_time_id2").val() !== "" &&
           $("#image")[0].files.length > 0 &&
           !isNaN(start) && !isNaN(end) && start <= end;
}
</script>
 -->