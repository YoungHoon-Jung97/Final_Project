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
<title>userInserForm.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/insertForm.css">
<style type="text/css">
	#ssn1 {
    	width: 200px;
    	flex: none;
	}
</style>

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
								placeholder="예: example@google.com" maxlength="100" required />
							<button type="button" class="btn btn--check">중복확인</button>
						</div>
					</div>
					<p class="form__error email--error">이메일을 입력하세요</p>
				</div>

				<!-- 비밀번호 입력 -->
				<div class="form__group">
					<div class="form__field">
						<label for="password" class="form__label required">비밀번호</label> 
						<div class="form__input--wrapper">
							<input type="password" class="form__input" id="password" name="user_pwd"
							placeholder="영문, 숫자, 특수문자 조합 8-20자" maxlength="20" minlength="8" required />
						</div>
					</div>
					<p class="form__error pwd1--error">비밀번호는 8-20자의 영문, 숫자, 특수문자 조합이어야 합니다.</p>
				</div>

				<!-- 비밀번호 확인 입력 -->
				<div class="form__group">
					<div class="form__field">
						<label for="passwordConfirm" class="form__label required">비밀번호 확인</label> 
						<div class="form__input--wrapper">
							<input type="password" class="form__input" id="passwordConfirm"
							placeholder="비밀번호 확인" maxlength="20" minlength="8" required />
						</div>
					</div>
					<p class="form__error pwd2--error">비밀번호가 일치하지 않습니다.</p>
				</div>

				<!-- 이름 입력-->
				<div class="form__group">
					<div class="form__field">
						<label for="name" class="form__label required">이름</label> 
						<div class="form__input--wrapper">
							<input type="text" class="form__input" id="name" placeholder="이름을 입력하세요."
							maxlength="10" name="user_name" required />
						</div>
					</div>
					<p class="form__error name--error">이름을 입력해주세요.</p>
				</div>

				<!-- 닉네임 입력 -->
				<div class="form__group">
					<div class="form__field">
						<label for="nickName" class="form__label required" >닉네임</label>
						<div class="form__input--wrapper">
							<input type="text" class="form__input" id="nickName"
								placeholder="닉네임" maxlength="20" name="user_nick_name" required />
							<button type="button" class="btn btn--check">중복확인</button>
						</div>
					</div>
					<p class="form__error nickName--error">이미 존재하는 닉네임 입니다.</p>
				</div>

				<!-- 전화번호 입력 -->
				<div class="form__group">
					<div class="form__field">
						<label for="tel" class="form__label">전화번호</label> 
						<div class="form__input--wrapper">
							<input type="tel" class="form__input" id="tel" placeholder="전화번호"
							name="user_tel" />
						</div>
					</div>
				</div>

				<!-- 주민번호 입력 -->
				<div class="form__group">
					<div class="form__field">
						<label for="ssn1" class="form__label required">주민번호</label>
						<div class="form__input--wrapper jumin-section">
							<input type="text" class="form__input ssn1-input" id="ssn1" maxlength="6"
								placeholder="생년월일(6자리)" required name="user_ssn"/> 
							<span class="dash">-</span>
							<input type="text"
								class="form__input ssn2-input" id="ssn2" maxlength="1" required />
							<span style="padding-left:3px; ">●</span>
							<span style="padding-left:3px; ">●</span>
							<span style="padding-left:3px; ">●</span>
							<span style="padding-left:3px; ">●</span>
							<span style="padding-left:3px; ">●</span>
							<span style="padding-left:3px; ">●</span>
							<input type="hidden" id="ssn" name="ssn">
						</div>
					</div>
					<div class="form__error">올바른 주민등록번호를 입력해주세요.</div>
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
							<input type="text" class="form__input form__input--sm"  id="post" required
							 name="user_postal_addr" />
							<button type="button" class="btn btn--search">우편번호 찾기</button>
						</div>
					</div>
				</div>

				<!-- 상세주소 -->
				<div class="form__group">
					<div class="form__field">
						<label for="address" class="form__label">주소</label>
						<div class="form__input--wrapper">
							<input type="text" class="form__input" id="address1"
							placeholder="상세주소 입력" required name="user_addr" />
						</div>
					</div>
				</div>
				<div class="form__group">
					<div class="form__field">
						<label for="address" class="form__label">상세주소</label>
						<div class="form__input--wrapper">
							<input type="text" class="form__input" id="address2"
							placeholder="상세주소 입력" required name="user_detailed_addr" />
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
		<!-- .form--join-->
	</div>
	<!-- .content -->
</body>
</html>