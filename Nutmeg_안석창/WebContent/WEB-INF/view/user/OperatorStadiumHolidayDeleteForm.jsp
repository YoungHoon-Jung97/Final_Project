<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	Integer user_code_id = (Integer) session.getAttribute("user_code_id");
	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	
	java.util.Calendar cal = java.util.Calendar.getInstance(); // 오늘 날짜 기준
	cal.add(java.util.Calendar.DATE, 1); // 하루 더하기
	String tomorrow = sdf.format(cal.getTime());
	
%>

<link rel="stylesheet" type="text/css" href="<%=cp%>/css/insertForm.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/scrollBar.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	var user_code_id = "<%=user_code_id %>";
	
	var isNameChecked = false;

	$(function()
	{
		// 뒤로 가기
		$('.btn--back').on('click', function()
		{
			var prevPage = "<%=session.getAttribute("prevPage") %>";
			var fallback = "<%=cp %>/MainPage.action";

			if (prevPage && prevPage !== "null")
				window.location.href = prevPage;
			
			else
		        window.location.href = fallback;
		});
	});

</script>

<script>
$(document).on('click', '.delete-btn', function () {
    const $card = $(this).closest('.holiday-card');
    const holidayId = $card.find('.holiday-id').val();

    if (confirm("정말로 이 휴무일을 삭제하시겠습니까?")) {
        $.ajax({
            url: "OperatorStadiumHolidayDelete.action",
            method: "POST",
            data: { stadium_holiday_id: holidayId },
            success: function (response) {
                if (response === "success") {
                    alert("삭제되었습니다.");
                    $card.fadeOut(300, function () {
                        $(this).remove();  // DOM에서도 제거
                    });
                } else {
                    alert("삭제 실패: 서버 응답 오류");
                }
            },
            error: function () {
                alert("서버 통신 오류가 발생했습니다.");
            }
        });
    }
});
</script>
<script type="text/javascript" src="<%=cp %>/js/StadiumRegInsertForm.js?after"></script>

</head>
<body>
<div class="content">
	<c:forEach var="holiday" items="${HolidayList}">
	    <div class="match-card holiday-card">
	        <div class="stadium-card">
	            <div class="stadium-img-wrapper">
	                <div class="stadium-info">
	                    <strong>${holiday.stadium_reg_name}</strong>
	                    휴무 시작일 : ${holiday.stadium_holiday_start_at} <br>
	                    휴무 종료일 : ${holiday.stadium_holiday_end_at} <br>
	                    휴무 종류 : ${holiday.stadium_holiday_type }
	                </div>
	            </div>
	            <input type="hidden" class="holiday-id" value="${holiday.stadium_holiday_id}">
	            <button type="button"
	                    class="btn btn-danger delete-btn">
	                휴무일 삭제
	            </button>
	        </div>
	    </div>
	</c:forEach>
</div>
</body>
