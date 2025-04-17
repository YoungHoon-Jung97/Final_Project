<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MercenaryInsertForm.jsp</title>

<link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/insertForm.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/MercenaryInsertForm.css?after">

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/Time.js?after"></script>
<script type="text/javascript" src="<%=cp %>/js/MercenaryInsertForm.js?after"></script>

</head>
<body>
<div class="content">
	<form action="MercenaryInsert.action" method="POST" class="form">
		<input type="hidden" name="position_id" id="selected-position-id">
		
		<div class="form__title">용병 등록</div>
		
		<div class="form__group">
			<div class="form__field">
				<label class="form__label required">포지션 선택</label>
					
				<div class="btn-group w-100" role="group" aria-label="Position Selection">
					<c:forEach var="position" items="${positionList}">
						<button type="button" class="btn btn-outline-primary position-button w-100"
						data-position-id="${position.position_id}" style="border-radius: 5px;">
							${position.position_name}
						</button>
					</c:forEach>
				</div>
			</div>
		</div>
		
		<!-- 선호 시간 -->
		<div class="form__group">
			<div class="form__field">
				<label class="form__label required">시간</label>
				
				<div class="form__input--wrapper">
					시작시간
					
					<input type="date" class="form__input" id="stardate"
					name="mercenary_time_start_at" required>
					
					종료시간
					
					<input type="date" class="form__input" id="endDate"
					name="mercenary_time_end_at" required>
				</div>
			</div>
		</div>
		
		<!-- 지역 -->
		<div class="form__group">
			<div class="form__field">
				<label class="form__label required">지역</label>
				
				<div class="form__selection">
					<select id="regions" name="region_id" class="form__input" required>
						<option value="">지역을 선택하세요</option>
						
						<c:forEach var="region" items="${regionList}">
							<option value="${region.region_id}">${region.region_name}</option>
						</c:forEach>
					</select>
					
					<select id="citys" name="city_id" class="form__input" required>
						<option value="">구를 선택하세요</option>
					</select>
				</div>
			</div>
		</div>
		
		<!-- 버튼 -->
		<div class="form__actions">
			<button type="submit" class="btn btn--submit">등록하기</button>
		</div>
	</form>
</div>
</body>
</html>