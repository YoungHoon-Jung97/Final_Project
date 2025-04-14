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

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/insertForm.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/scrollBar.css?after">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

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
		
		$('#image').on('change', function()
		{
			var fileName = this.files.length > 0 ? this.files[0].name : '선택된 파일 없음';
			$('#file-name').text(fileName);
		});
	});

</script>

</head>
<body>
<div class="content">
	<form id="joinForm" class="form form--join" method="post" action="FieldRegInsert.action" enctype="multipart/form-data">
		<input type="hidden" name="stadium_reg_id" value="${stadium_reg_id }">
		
		<h2 class="form__title">경기장 정보 입력</h2>
		
		<!-- 기본 정보 섹션 -->
		<div class="form__section">
			<h3 class="form__section-title">기본 정보</h3>
			
			<!-- 경기장 이름 입력 -->
			<div class="form__group">
				<div class="form__field">
					<label for="name" class="form__label required">경기장이름</label>
					
					<div class="form__input--wrapper">
						<input type="text" class="form__input" id="name"
						placeholder="경기장이름" maxlength="20" name="field_reg_name" required>
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
			
			<!-- 구장 크기 선택-->
			<div class="form__group">
				<div class="form__field">
					<label for="width" class="form__label required">경기장 크기</label>
					
					<div class="form__input--wrapper field-size-wrapper">
						<div class="form__selection">
							<span class="size-label">가로</span>
							
							<input type="number" name="field_reg_garo" min="1" step="1">
							
							<span class="unit-label">m</span>
						</div>
						
						<span class="dash">X</span>
						
						<div class="form__selection">
							<span class="size-label">세로</span>
							
							<input type="number" name="field_reg_sero" min="1" step="1">
							
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
						placeholder="가격을 입력하세요" name="field_reg_price" required>
						
						<span class="unit-label">원</span>
					</div>
				</div>
			</div>
			
			<!-- 첨부파일 -->
			<div class="form__group">
				<div class="form__field">
					<label for="image" class="form__label required">첨부파일</label>
					
					<div class="file-upload-wrapper">
						<input type="file" id="image" name="stadium_reg_image" class="file-upload-input" />
						
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
</div> <!-- .content -->
</body>
</html>