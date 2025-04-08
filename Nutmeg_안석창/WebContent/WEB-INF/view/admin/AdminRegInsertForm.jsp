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
			<h2 class="form__title">관리자 정보 입력</h2>
		
			<!-- 기본 정보 섹션 -->
			<div class="form__section">
				<h3 class="form__section-title">기본 정보</h3>

				<!-- 관리자 이메일 입력(아이디)-->
				<div class="form__group">
					<div class="form__field">
						<label for="email" class="form__label required">이메일</label>
						<div class="form__input--wrapper">
							<input type="email" class="form__input" id="email"
							placeholder="예: example@google.com" maxlength="100" required />
						</div>
					</div>
				</div>

				<!-- 닉네임 입력 -->
				<div class="form__group">
					<div class="form__field">
						<label for="nickName" class="form__label required">닉네임</label>
						<div class="form__input--wrapper">
							<input type="text" class="form__input" id="nickName"
								placeholder="닉네임" maxlength="20" name="nickName" required />
							<button type="button" class="btn btn--check">중복확인</button>
						</div>
					</div>
					<p class="form__error nickName--error">이미 존재하는 닉네임 입니다.</p>
				</div>

				<!-- 전화번호 입력 -->
				<div class="form__group">
					<div class="form__field">
						<label for="tel" class="form__label">전화번호</label> 
						<div class="form__input-wrapper">
							<input type="tel" class="form__input" id="tel" placeholder="전화번호"
							name="tel" data-type="tel" />
						</div>
					</div>
				</div>

			</div>
			<!-- .form__section -->

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