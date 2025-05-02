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

			if (prevPage && prevPage != "null")
				window.location.href = prevPage;
			
			else
		        window.location.href = fallback;
		});
	});

</script>
<script type="text/javascript" src="<%=cp %>/js/StadiumRegInsertForm.js?after"></script>

</head>
<body>
<div class="container my-5">
	<div class="row justify-content-center">
		<div class="col-lg-8">
			<form id="joinForm" class="form" method="post" action="OperatorStadiumHolidayInsert.action">
				<input type="hidden" name="stadium_reg_id" value="${stadium_reg_id}">
				
				<div class="card shadow-sm p-4 mb-4">
					<label class="form-label fw-semibold mb-2">시작 날짜</label>
					
					<input type="date" id="stadium_holiday_start_at" name="stadium_holiday_start_at"
					class="form-control" min="<%=tomorrow %>">
				</div>
				
				<div class="card shadow-sm p-4 mb-4">
					<label class="form-label fw-semibold mb-2">종료 날짜</label>
					
					<input type="date" id="stadium_holiday_end_at" name="stadium_holiday_end_at"
					class="form-control" min="<%=tomorrow %>">
				</div>
				
				<div class="card shadow-sm p-4 mb-4">
					<label class="form-label fw-semibold mb-2">사유 유형</label>
					
					<select name="stadium_holiday_type_id" id="stadium_holiday_type_id" class="form-select">
						<option value="">사유 유형 선택</option>
						
						<c:forEach var="type" items="${HolidayTypeList}">
							<option value="${type.stadium_holiday_type_id}">${type.stadium_holiday_type}</option>
						</c:forEach>
					</select>
				</div>
				
				<div class="card shadow-sm p-4 mb-4">
					<label class="form-label fw-semibold mb-2">상세 사유</label>
					
					<textarea rows="5" name="stadium_holiday_desc" class="form-control"
					placeholder="예 : xx월xx일~xx월xx일까지 공사 합니다"></textarea>
				</div>
				
				<div class="d-flex justify-content-end gap-2">
					<button type="submit" id="submitbtn" class="btn btn-success px-4">휴무 등록</button>
					<button type="button" class="btn btn-outline-secondary btn--back px-4">뒤로가기</button>
				</div>
			</form>
		</div>
	</div>
</div>
</body>