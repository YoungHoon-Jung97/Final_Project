<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserSignupForm.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/insertForm.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/scrollBar.css?after">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
	});

</script>

<script type="text/javascript" src="<%=cp %>/js/UserSignupForm.js?after"></script>

</head>
<body>
<div class="content">
	<form id="inserForm" class="form form--join" method="post" action="UserInsert.action">
		<h2 class="form__title">회원 정보 입력</h2>
	
		<!-- 기본 정보 섹션 -->
		<div class="form__section">
			<h3 class="form__section-title">기본 정보</h3>

			<!-- 사용자 이메일 입력(아이디)-->
			<div class="form__group">
				<div class="form__field">
					<label for="email" class="form__label required">이메일</label>
					
					<div class="form__input--wrapper">
						<input type="email" class="form__input" id="email" name="user_email"
							placeholder="예: example@google.com" maxlength="100" required autocomplete="email">
						
						<button type="button" class="btn btn--check" onclick="checkEmail()">중복확인</button>
					</div>
				</div>
				
				<div class="error">
					<p id="emailCheck" class="result"></p>
				</div>
			</div>

			<!-- 비밀번호 입력 -->
			<div class="form__group">
				<div class="form__field">
					<label for="password" class="form__label required">비밀번호</label> 
					
					<div class="form__input--wrapper">
						<input type="password" class="form__input" id="password" name="user_pwd" placeholder="영문, 숫자, 특수문자 조합 8-20자"
						maxlength="20" minlength="8" required autocomplete="new-password">
					</div>
				</div>
				
				<div class="error">
					<p class="form__error pwd1--error"></p>
				</div>
			</div>

			<!-- 비밀번호 확인 입력 -->
			<div class="form__group">
				<div class="form__field">
					<label for="passwordConfirm" class="form__label required">비밀번호 확인</label>
					 
					<div class="form__input--wrapper">
						<input type="password" class="form__input" id="passwordConfirm"
						placeholder="비밀번호 확인" maxlength="20" minlength="8" required>
					</div>
				</div>
				
				<div class="error">
					<p id="passwordCheck" class="result" style="display: none;">비밀번호가 일치하지 않습니다.</p>
				</div>
			</div>

			<!-- 이름 입력-->
			<div class="form__group">
				<div class="form__field">
					<label for="name" class="form__label required">이름</label> 
					
					<div class="form__input--wrapper">
						<input type="text" class="form__input" id="name" placeholder="이름을 입력하세요."
						maxlength="10" name="user_name" required autocomplete="name">
					</div>
				</div>
				
				<div class="error">
					<p class="form__error name--error"></p>
				</div>
			</div>

			<!-- 닉네임 입력 -->
			<div class="form__group">
				<div class="form__field">
					<label for="nickName" class="form__label required">닉네임</label>
					
					<div class="form__input--wrapper">
						<input type="text" class="form__input" id="nickName"
							placeholder="닉네임을 입력하세요." maxlength="20" name="user_nick_name" required>
						
						<button type="button" class="btn btn--check" onclick="checkNickName()">중복확인</button>
					</div>
				</div>
				
				<div class="error">
					<p id="nickNameCheck" class="result"></p>
				</div>
			</div>

			<!-- 전화번호 입력 -->
			<div class="form__group">
				<div class="form__field">
					<label for="tel" class="form__label required">전화번호</label> 
					
					<div class="form__input--wrapper">
						<input type="tel" class="form__input" id="tel" placeholder="전화번호를 입력하세요."
						name="user_tel" pattern="^\d{3}-\d{3,4}-\d{4}$" required>
					</div>
				</div>
				
				<div class="error"></div>
			</div>

			<!-- 주민번호 입력 -->
			<div class="form__group">
				<div class="form__field">
					<label for="ssn1" class="form__label required">주민번호</label>
					
					<div class="form__input--wrapper jumin-section">
						<input type="number" class="form__input ssn1-input no-spinner" id="ssn1" maxlength="6"
						placeholder="생년월일(6자리)" required name="user_ssn1"> 
						
						<span class="dash">-</span>
						
						<input type="text" class="form__input ssn2-input no-spinner" id="ssn2"
						name="user_ssn2" maxlength="1" inputmode="numeric" required>
						
						<span style="padding-left:3px; ">●</span>
						<span style="padding-left:3px; ">●</span>
						<span style="padding-left:3px; ">●</span>
						<span style="padding-left:3px; ">●</span>
						<span style="padding-left:3px; ">●</span>
						<span style="padding-left:3px; ">●</span>
					</div>
				</div>
				
				<div class="error">
					<div class="form__error"></div>
				</div>
			</div>
		</div>
		
		<!-- 주소 정보 섹션 -->
     	<div class="form__section">
       		<h3 class="form__section-title">주소 정보</h3>

			<!-- 우편번호 -->
			<div class="form__group">
				<div class="form__field">
					<label for="post" class="form__label required">우편번호</label>
					
					<div class="form__input--wrapper">
						<input type="text" class="form__input form__input--sm" readonly id="post" required name="user_postal_addr">
						
						<button type="button" class="btn btn--search" onclick="execPostCode()">우편번호 찾기</button>
					</div>
				</div>
			</div>

			<!-- 주소 -->
			<div class="form__group">
				<div class="form__field">
					<label for="address" class="form__label required">주소</label>
					
					<div class="form__input--wrapper">
						<input type="text" class="form__input" id="address1"
						placeholder="주소 입력" readonly required name="user_addr">
					</div>
				</div>
			</div>
			
			<!-- 상세 주소 -->
			<div class="form__group">
				<div class="form__field">
					<label for="address" class="form__label required">상세주소</label>
					
					<div class="form__input--wrapper">
						<input type="text" class="form__input" id="address2"
						placeholder="상세주소 입력" required name="user_detailed_addr">
					</div>
				</div>
			</div>
		</div>

		<!-- 버튼 그룹 -->
		<div class="form__actions">
			<button id="submitBtn" type="submit" class="btn btn--submit" onclick="checkPassword()">회원가입</button>
			<button type="button" class="btn btn--back">뒤로가기</button>
		</div>
	</form> <!-- .form--join-->
</div> <!-- .content -->
</body>
</html>