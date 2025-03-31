<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>stadiumInsertForm.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/insertForm.css">
<style type="text/css">

</style>

</head>
<body>
	<div class="content">
		<form id="joinForm" class="form form--join" method="get" action="">
			<h2 class="form__title">구장 정보 입력</h2>
			
			<div class="form__section">
				<h3 class="form__section-title">기본 정보</h3>

				<!-- 구장 이름 입력 -->
				<div class="form__group">
					<div class="form__field">
						<label for="name" class="form__label required">구장이름</label>
						<div class="form__input-wrapper">
							<input type="text" class="form__input" id="name"
								placeholder="구장이름" maxlength="20" name="name" required
								data-type="name" />
						</div>
					</div>
				</div>

				<!-- 우편번호 -->
				<div class="form__group">
					<div class="form__field">
						<label for="post" class="form__label required">우편번호</label>
						<div class="form__input--wrapper">
							<input type="text" class="form__input form__input--sm"  id="post" required
							readonly name="post" />
							<button type="button" class="btn btn--search">우편번호 찾기</button>
						</div>
					</div>
				</div>

				<!-- 상세 주소일력-->
				<div class="form__group">
					<div class="form__field">
						<label for="address" class="form__label required">상세주소</label>
						<div class="form__input-wrapper">
							<input type="text" class="form__input" id="address"
								placeholder="상세주소" required name="address" />
						</div>
					</div>
				</div>

				<!-- 구장운영시간 선택-->
				<div class="form__group">
					<div class="form__field">
						<label for="operateTime" class="form__label required" >운영시간</label>
						<div class="form__selection">
				        	<span class="size-label">시각 시간</span> 
							<select name="openTime" id="openTime" class="form__input select-size">
								<option value="1">06:00 </option>
								<option value="2">08:00 </option>
								<option value="3">10:00 </option>
								<option value="4">12:00 </option>
								<option value="5">14:00 </option>
								<option value="6">16:00 </option>
								<option value="7">18:00 </option>
								<option value="8">20:00 </option>
								<option value="9">22:00 </option>
							</select> 
							<span class="size-label">종료 시간</span> 
							<select name="closeTime" id="closeTime" class="form__input select-size">
								<option value="1">07:50</option>
								<option value="2">09:50</option>
								<option value="3">11:50</option>
								<option value="4">13:50</option>
								<option value="5">15:50</option>
								<option value="6">17:50</option>
								<option value="7">19:50</option>
								<option value="8">21:50</option>
								<option value="9">23:50</option>
							</select>
						</div>
					</div>
				</div>
				
				<!-- 첨부파일 -->
				<div class="form__group">
					<div class="form__field">
						<label for="image" class="form__label ">첨부파일</label>
						<div class="form__input-wrapper file-upload">
							<input type="file"  class="form__input file-upload-input" id="image" style="border: 0;"/>
						</div>
					</div>
				</div>
			</div>

				<!-- 버튼 그룹 -->
				<div class="form__actions">
					<button type="submit" class="btn btn--submit">회원가입</button>
					<button type="reset" class="btn btn--reset">취소</button>
					<button type="button" class="btn btn--back">뒤로가기</button>
				</div>
		</form>
		<!-- .form -->
	</div>
	<!-- .content -->
</body>
</html>