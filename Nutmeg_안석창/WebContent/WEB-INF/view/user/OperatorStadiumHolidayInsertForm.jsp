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
<script type="text/javascript" src="<%=cp %>/js/StadiumRegInsertForm.js?after"></script>

</head>
<body>
<div class="content">
	<form id="joinForm" class="form form--join" method="post" action="OperatorStadiumHolidayInsert.action" >
		<input type="hidden" name="stadium_reg_id" value="${stadium_reg_id }">
		<h2 class="form__title">구장 휴무일 등록</h2>
		
		<div class="form__section">
			<h3 class="form__section-title">구장 휴무일</h3>
			<!-- 구장 이름 입력 -->
			<div class="form__group">
				<div class="form__field">
					<label for="name" class="form__label required">구장 휴무일</label>
					
					<div class="card p-3 shadow-sm mb-4">
							<label for="matchDateInput" class="form-label fw-bold">시작 날짜 선택</label>
							<input type="date" id="stadium_holiday_start_at" name="stadium_holiday_start_at" class="form-control" value="" min="<%=tomorrow%>">
					</div>
					
					<div class="card p-3 shadow-sm mb-4">
							<label for="matchDateInput" class="form-label fw-bold">종료 날짜 선택</label>
							<input type="date" id="stadium_holiday_end_at" name="stadium_holiday_end_at" class="form-control" value="" min="<%=tomorrow%>">
					</div>
					
					
					<div class="card p-3 shadow-sm mb-4">
						<label for="operateTime" class="form__label required">운영시간</label>
					
						<div class="form__selection">
							<select name="stadium_holiday_type_id" id="stadium_holiday_type_id"
							class=" form__input select-size" style="width: 150px;">
								<option value="">사유 유형 선택</option>
								
								<c:forEach var="type" items="${HolidayTypeList }">
									<option value="${type.stadium_holiday_type_id }">${type.stadium_holiday_type }</option>
								</c:forEach>
							</select>
						</div>
					</div>
					
					<br>
					
					<div class="card p-3 shadow-sm mb-4">
						<label for="matchDateInput" class="form-label fw-bold">상세 사유 입력</label>
						<textarea rows="5" cols="50" name="stadium_holiday_desc"
						placeholder="예 : xx월xx일~xx월xx일까지 공사 합니다"></textarea>
					</div>
					
					
					<div class="form__actions">
						<button type="submit" id="submitbtn" class="btn btn--submit">휴무 등록</button>
						<button type="button" class="btn btn--back">뒤로가기</button>
					</div>
				</div>
			</div>
		</div>	
	</form>
</div>
</body>
