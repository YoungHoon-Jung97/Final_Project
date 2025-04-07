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
<title>userInserForm.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/insertForm.css">
<style type="text/css">
	#ssn1 {
    	width: 200px;
    	flex: none;
	}
	.result {
	    display: none;
	    color: red;
	    font-size: small;
	    margin-top: 5px;
	}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	$('#email').on('input', function(){
		$('#emailCheck').css('display','none');
		$('#submitBtn').prop('disabled', true);
	});
	$('#nickName').on('input', function(){
		$('#nickNameCheck').css('display','none');
		$('#submitBtn').prop('disabled', true);
	});
});

function checkEmail(){
	var email = $('#email').val();
	$.ajax({
		url: 'CheckEmail.action',
		type: 'get',
		data: { email: email },
		dataType: 'text',
		success: function(result){
			if(result == "이미 사용중인 이메일 입니다."){
				$('#emailCheck').text(result).css({'display': 'inline', 'color': 'red'});
				$('#submitBtn').prop('disabled', true);
			} else {
				$('#emailCheck').text(result).css({'display': 'inline', 'color': 'green'});
				$('#submitBtn').prop('disabled', false);
			}
		},
		error: function(){
			$('#emailCheck').text("이메일을 입력하세요").css({'display': 'inline', 'color': 'red'});
			$('#submitBtn').prop('disabled', true);
		}
	});
}

function checkNickName(){
	var nickName = $('#nickName').val();
	$.ajax({
		url: 'CheckNickName.action',
		type: 'get',
		data: { nickName: nickName },
		dataType: 'text',
		success: function(result){
			if(result == "이미 사용중인 닉네임 입니다."){
				$('#nickNameCheck').text(result).css({'display': 'inline', 'color': 'red'});
				$('#submitBtn').prop('disabled', true);
			} else {
				$('#nickNameCheck').text(result).css({'display': 'inline', 'color': 'green'});
				$('#submitBtn').prop('disabled', false);
			}
		},
		error: function(){
			$('#nickNameCheck').text("닉네임을 입력하세요").css({'display':'inline','color':'red'});
			$('#submitBtn').prop('disabled', true);
		}
	});
}

function execPostCode(){
	new daum.Postcode({
		oncomplete: function(data) {
			var addr = data.roadAddress ? data.roadAddress : data.jibunAddress;
			$("#post").val(data.zonecode);
			$('#address1').val(addr);
			$('#address2').focus();
		}
	}).open({
		popupName: 'postPopup',
		width: 400,
		height: 500
	});
}

function checkPassword(){
	var password1 = $('#password').val();
	var password2 = $('#passwordConfirm').val();
	if (password1 === password2) {
		$('#submitBtn').prop('disabled', false);
	} else {
		$('#passwordCheck').css({'display': 'inline', 'color': 'red'});
		$('#submitBtn').prop('disabled', true);
	}
}
</script>
</head>
<body>
	<div class="content">
		<form id="inserForm" class="form form--join" method="post" action="UserInsert.action">
			<h2 class="form__title">회원 정보 입력</h2>
			<div class="form__section">
				<h3 class="form__section-title">기본 정보</h3>

				<!-- 이메일 -->
				<div class="form__group">
					<div class="form__field">
						<label for="email" class="form__label required">이메일</label>
						<div class="form__input--wrapper">
							<input type="email" class="form__input" id="email" name="user_email"
								placeholder="예: example@google.com" maxlength="100" required />
							<button type="button" class="btn btn--check" onclick="checkEmail()">중복확인</button>
						</div>
					</div>
					<p id="emailCheck" class="result"></p>
				</div>

				<!-- 비밀번호 -->
				<div class="form__group">
					<div class="form__field">
						<label for="password" class="form__label required">비밀번호</label>
						<div class="form__input--wrapper">
							<input type="password" class="form__input" id="password" name="user_pwd"
								placeholder="영문, 숫자, 특수문자 조합 8-20자" maxlength="20" minlength="8" required />
						</div>
					</div>
					<p class="form__error pwd1--error"></p>
				</div>

				<!-- 비밀번호 확인 -->
				<div class="form__group">
					<div class="form__field">
						<label for="passwordConfirm" class="form__label required">비밀번호 확인</label>
						<div class="form__input--wrapper">
							<input type="password" class="form__input" id="passwordConfirm"
								placeholder="비밀번호 확인" maxlength="20" minlength="8" required />
						</div>
					</div>
					<p id="passwordCheck" class="result">비밀번호가 일치하지 않습니다.</p>
				</div>

				<!-- 이름 -->
				<div class="form__group">
					<div class="form__field">
						<label for="name" class="form__label required">이름</label>
						<div class="form__input--wrapper">
							<input type="text" class="form__input" id="name" placeholder="이름을 입력하세요."
								maxlength="10" name="user_name" required />
						</div>
					</div>
					<p class="form__error name--error"></p>
				</div>

				<!-- 닉네임 -->
				<div class="form__group">
					<div class="form__field">
						<label for="nickName" class="form__label required">닉네임</label>
						<div class="form__input--wrapper">
							<input type="text" class="form__input" id="nickName"
								placeholder="닉네임" maxlength="20" name="user_nick_name" required />
							<button type="button" class="btn btn--check" onclick="checkNickName()">중복확인</button>
						</div>
					</div>
					<p id="nickNameCheck" class="result"></p>
				</div>

				<!-- 전화번호 -->
				<div class="form__group">
					<div class="form__field">
						<label for="tel" class="form__label">전화번호</label>
						<div class="form__input--wrapper">
							<input type="tel" class="form__input" id="tel" placeholder="전화번호" name="user_tel" />
						</div>
					</div>
				</div>

				<!-- 주민번호 -->
				<div class="form__group">
					<div class="form__field">
						<label for="ssn1" class="form__label required">주민번호</label>
						<div class="form__input--wrapper jumin-section">
							<input type="text" class="form__input ssn1-input" id="ssn1" maxlength="6"
								minlength="6" placeholder="생년월일(6자리)" required name="user_ssn1"/> 
							<span class="dash">-</span>
							<input type="text" class="form__input ssn2-input" id="ssn2" name="user_ssn2" maxlength="1" required />
							<span style="padding-left:3px;">●</span><span style="padding-left:3px;">●</span><span style="padding-left:3px;">●</span>
							<span style="padding-left:3px;">●</span><span style="padding-left:3px;">●</span><span style="padding-left:3px;">●</span>
						</div>
					</div>
					<div class="form__error"></div>
				</div>
			</div>

			<!-- 주소 -->
			<div class="form__section">
				<h3 class="form__section-title">주소 정보</h3>

				<div class="form__group">
					<div class="form__field">
						<label for="post" class="form__label required">우편번호</label>
						<div class="form__input--wrapper">
							<input type="text" class="form__input form__input--sm" readonly id="post" required name="user_postal_addr" />
							<button type="button" class="btn btn--search" onclick="execPostCode()">우편번호 찾기</button>
						</div>
					</div>
				</div>

				<div class="form__group">
					<div class="form__field">
						<label for="address1" class="form__label">주소</label>
						<div class="form__input--wrapper">
							<input type="text" class="form__input" id="address1" placeholder="상세주소 입력" readonly required name="user_addr" />
						</div>
					</div>
				</div>

				<div class="form__group">
					<div class="form__field">
						<label for="address2" class="form__label">상세주소</label>
						<div class="form__input--wrapper">
							<input type="text" class="form__input" id="address2" placeholder="상세주소 입력" required name="user_detailed_addr" />
						</div>
					</div>
				</div>
			</div>

			<!-- 버튼 -->
			<div class="form__actions">
				<button id="submitBtn" type="submit" class="btn btn--submit" onclick="checkPassword()">회원가입</button>
				<button type="reset" class="btn btn--reset">취소</button>
				<button type="button" class="btn btn--back">뒤로가기</button>
			</div>
		</form>
	</div>
</body>
</html>
