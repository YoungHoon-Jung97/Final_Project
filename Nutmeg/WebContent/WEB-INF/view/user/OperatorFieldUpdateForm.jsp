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
<title>FieldRegInsertForm.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/util/insertForm.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/util/scrollBar.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

$(function() {
	// 뒤로 가기 버튼 처리
	$('.btn--back').on('click', function() {
		var prevPage = "<%=session.getAttribute("prevPage") %>";
		var fallback = "<%=cp %>/MainPage.action";

		if (prevPage && prevPage !== "null")
			window.location.href = prevPage;
		else
			window.location.href = fallback;
	});

	// 파일명 표시
	$('#image').on('change', function() {
		var fileName = this.files.length > 0 ? this.files[0].name : '선택된 파일 없음';
		$('#file-name').text(fileName);
	});

	// ✅ 여기 안에 넣어야 합니다!
	$('#joinForm').on('submit', function() {
		const facilities = {
			"샤워실": $("#shower").is(":checked"),
			"탈의실": $("#dressing").is(":checked"),
			"주차장": $("#parking").is(":checked"),
			"음료판매": $("#drink").is(":checked"),
			"풋살화대여": $("#shoesrent").is(":checked"),
			"조끼대여": $("#vestrent").is(":checked")
		};

		console.log("선택된 시설:", facilities); // 디버깅용
		$("#facilitiesJson").val(JSON.stringify(facilities));
	});
});
	
	
</script>

</head>
<body>

<div class="content">
	<c:forEach var="field1" items="${fieldList }">
	<form id="joinForm" class="form form--join" method="post" action="OperatorFieldUpate.action" enctype="multipart/form-data">
		<input type="hidden" name="oldFieldImage" value="${field1.field_reg_image}">
		<input type="hidden" name="field_reg_id" value="${field1.field_reg_id}">
		<h2 class="form__title">경기장 정보 수정</h2>

		<!-- 기본 정보 섹션 -->
		<div class="form__section">
			<h3 class="form__section-title">수정 정보 입력</h3>
			
			<!-- 경기장 이름 입력 -->
			<div class="form__group">
				<div class="form__field">
					<label for="name" class="form__label required">경기장이름</label>
					
					<div class="form__input--wrapper">
						<input type="text" class="form__input" id="name"
						placeholder="경기장이름" maxlength="20" name="field_reg_name" value="${field1.field_reg_name }" required>
					</div>
				</div>
			</div>	
			
			<div class="form__group">
				<div class="form__field">
					<label for="fieldType" class="form__label required">경기장 필드</label>
					
					<div class="form__selection">
						<select id="fieldType" name="field_type_id" class="required form__input" required>
							<option value="">--필드 상태--</option>
							
							<c:forEach var="field" items="${fieldTypeList}">
								<option value="${field.field_type_id}">${field.field_type}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			
			<div class="form__group">
				<div class="form__field">
					<label for="fieldEnvironment" class="form__label required">경기장 환경</label>
					
					<div class="form__selection">
						<select id="fieldEnvironment" name="field_environment_id" class="required form__input" required>
							<option value="">--경기장 환경 선택--</option>
							
							<c:forEach var="field" items="${fieldEnviromentList}">
								<option value="${field.field_environment_id}">${field.field_environment_type}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			
			<!-- 경기장 수용 인원 -->
			<div class="form__group">
				<div class="form__field">
					<label for="personCount" class="form__label required">경기장 주의사항</label>
					
					<div class="form__input--wrapper">
						<!-- <input type="text" class="form__input" id="name"
						placeholder="경기장수용인원" maxlength="20" name="personCount" required> -->
						<textarea rows="5" cols="150" name="field_reg_notice"
						placeholder="예 : 발을 털고 들어와주세요, 주차가 불가해요">${field1.field_reg_notice }</textarea>
					</div>
				</div>
			</div>
			
			<!-- 경기장 수용 인원 -->
			<div class="form__group">
				<div class="form__field">
					<label for="personCount" class="form__label required">경기장 시설<small>(해당되는 사항을 선택 해주세요)</small></label>
					<div class="form__input--wrapper">
						<label><input type="checkbox" id="shower">샤워실</label>
						<label><input type="checkbox" id="dressing">탈의실</label>
						<label><input type="checkbox" id="parking">주차장</label>
						<label><input type="checkbox" id="drink">음료판매</label>
						<label><input type="checkbox" id="shoesrent">풋살화대여</label>
						<label><input type="checkbox" id="vestrent">조끼대여</label>
					</div>
				</div>
			</div>
			<input type="hidden" id="facilitiesJson" name="field_reg_facilities" value="">
			<!-- 구장 크기 선택-->
			<div class="form__group">
				<div class="form__field">
					<label for="width" class="form__label required">경기장 크기</label>
					
					<div class="form__input--wrapper field-size-wrapper">
						<div class="form__selection">
							<span class="size-label">가로</span>
							
							<input type="number" name="field_reg_garo" min="1" step="1" value="${field1.field_reg_garo }">
							
							<span class="unit-label">m</span>
						</div>
						
						<span class="dash">X</span>
						
						<div class="form__selection">
							<span class="size-label">세로</span>
							
							<input type="number" name="field_reg_sero" min="1" step="1" value="${field1.field_reg_sero }">
							
							<span class="unit-label">m</span>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 경기장 수용 인원 -->
			<div class="form__group">
				<div class="form__field">
					<label for="personCount" class="form__label required">수용인원</label>
					
					<div class="form__input--wrapper">
						<input type="text" class="form__input" id="name"
						placeholder="경기장수용인원" maxlength="20" name="personCount" required>
					</div>
				</div>
			</div>
			
			<!-- 구장 금액-->
			<div class="form__group">
				<div class="form__field">
					<label for="price" class="form__label required">가격(2시간당)</label>
					
					<div class="form__input--wrapper">
						<input type="text" class="form__input" id="price"
						placeholder="가격을 입력하세요" name="field_reg_price" value="${field1.field_reg_price }" required>
						
						<span class="unit-label">원</span>
					</div>
				</div>
			</div>
			
			<!-- 첨부파일 -->
			<div class="form__group">
				<div class="form__field">
					<label for="image" class="form__label required">첨부파일</label>
					
					<div class="file-upload-wrapper">
						<input type="file" id="image" name="field_reg_image" class="file-upload-input" />
						
						<button type="button" class="file-upload-btn" onclick="document.getElementById('image').click();">파일 선택</button>
						
						<span id="file-name" class="file-upload-filename">선택된 파일 없음</span>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 버튼 그룹 -->
		<div class="form__actions">
			<button type="submit" class="btn btn--submit">경기장 등록</button>
			<button type="button" class="btn btn--back">뒤로가기</button>
		</div>
	</form> <!-- .form -->
	</c:forEach>
</div> <!-- .content -->


</body>
</html>