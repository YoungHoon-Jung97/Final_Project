<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fieldInsertForm.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/insertForm.css">
</head>
<body>

	<div class="content">
		<form id="joinForm" class="form form--join" method="post" action="FieldRegInsert.action">
			<h2 class="form__title">구장 휴무 정보 입력</h2>

			<!-- 구장 휴무 시작 일시 -->
			<div class="form__group">
				<div class="form__field">
					<label for="holiday_start" class="form__label">구장 휴무 시작 일시</label>
					<div class="form__input--wrapper">
						<input type="datetime-local" class="form__input" name="holiday_start" required />
					</div>
				</div>
			</div>

			<!-- 구장 휴무 종료 일시 -->
			<div class="form__group">
				<div class="form__field">
					<label for="holiday_end" class="form__label">구장 휴무 종료 일시</label>
					<div class="form__input--wrapper">
						<input type="datetime-local" class="form__input" name="holiday_end" required />
					</div>
				</div>
			</div>

			<!-- 구장 휴무 상세 설명 -->
			<div class="form__group">
				<div class="form__field">
					<label for="holiday_description" class="form__label">구장 휴무 상세 설명</label>
					<div class="form__input--wrapper">
						<textarea class="form__input" name="holiday_description" placeholder="휴무에 대한 상세 설명을 입력하세요" required></textarea>
					</div>
				</div>
			</div>

			<!-- 버튼 그룹 -->
			<div class="form__actions">
				<button type="submit" class="btn btn--submit">등록</button>
				<button type="reset" class="btn btn--reset">취소</button>
				<button type="button" class="btn btn--back">뒤로가기</button>
			</div>

		</form>
	</div>

</body>
</html>