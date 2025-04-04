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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/insertForm.css">
</head>
<body>
	<div class="content">
		<form id="joinForm" class="form form--join" method="get" action="">
			<h2 class="form__title">구장운영자 정보 입력</h2>
		
			<!-- 기본 정보 섹션 -->
			<div class="form__section">
				<h3 class="form__section-title">기본 정보</h3>
			

				<!-- 사용자 이메일 입력(아이디)-->
				<div class="form__group">
					<div class="form__field">
						<label for="email" class="form__label required">이메일</label>
						<div class="form__input--wrapper">
							<input type="email" class="form__input" id="email"
								placeholder="예: example@google.com" maxlength="100" required />
						</div>
					</div>
				</div>
				
				<!-- 이름 입력 -->
				<div class="form__group">
					<div class="form__field">
						<label for="name" class="form__label required">이름</label>
						<div class="form__input-wrapper">
							<input type="text" class="form__input" id="name" placeholder="이름"
							maxlength="20" name="name" required data-type="name" />
						</div>
					</div>
				</div>

				<!-- 전화번호 입력 -->
				<div class="form__group">
					<div class="form__field">
						<label for="tel" class="form__label required">전화번호</label>
						<div class="form__input-wrapper"> 
							<input type="tel" class="form__input" id="tel" placeholder="전화번호"
							name="tel" data-type="tel" />
						</div>
					</div>
				</div>

				<!-- 은행 선택-->
				<div class="form__group">
					<div class="form__field">
						<label for="bank" class="form__label required">은행</label>
						<div class="form__selection"> 
							<select name="bank" id="bank" class="form__input" style="width: 10rem;">
								<option value="1">기업은행</option>
								<option value="2">농협은행</option>
								<option value="3">카카오뱅크</option>
								<option value="4">토스</option>
							</select>
						</div>
					</div>
				</div>

				<!-- 계좌번호 입력-->
				<div class="form__group">
					<div class="form__field">
						<label for="account" class="form__label required">계좌번호</label> 
						<div class="form__input-wrapper">
							<input type="text" class="form__input" id="account" placeholder="계좌번호"
							name="account" required />
						</div>
					</div>
				</div>

				<!-- 예금주 입력-->
				<div class="form__group">
					<div class="form__field">
						<label for="depositor" class="form__label">예금주</label>
						<div class="form__input-wrapper"> 
							<input type="text" class="form__input" id="depositor" placeholder="예금주"
							name="depositor" required />
						</div>
					</div>
				</div>

			</div>
			<!-- .form__section -->

			<!-- 버튼 그룹 -->
			<div class="form__actions">
				<button type="submit" class="btn btn--submit">등록</button>
				<button type="reset" class="btn btn--reset">취소</button>
				<button type="button" class="btn btn--back">뒤로가기</button>
			</div>

		</form>
		<!-- .form -->
	</div>
	<!-- .content -->


</body>
</html>