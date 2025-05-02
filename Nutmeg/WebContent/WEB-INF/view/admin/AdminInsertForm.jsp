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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/util/insertForm.css">
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
<script type="text/javascript">

$(document).ready(function(){
	$('#email').on('input', function(){
		$('#emailCheck').css('display','none');
		$('#submitBtn').prop('disabled', true);
	});
	$('#admin_nickName').on('input', function(){
		$('#nickNameCheck').css('display','none');
		$('#submitBtn').prop('disabled', true);
	});
});

function checkEmail(){
    var email = $('#email').val();
    $.ajax({
        url: 'AdminCheckEmail.action',  
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
		url: 'AdminCheckNickName.action',
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
			$('#nickNameCheck').text("닉네임을 입력하세요").css({'display': 'inline', 'color': 'red'});
			$('#submitBtn').prop('disabled', true);
		}
	});
}

function checkPassword(){
	var password1 = $('#password').val();
	var password2 = $('#passwordConfirm').val();
	if (!password1 || !password2) {
		$('#passwordCheck').hide();
		$('#submitBtn').prop('disabled', true);
		return;
	}
	if (password1 === password2) {
		$('#submitBtn').prop('disabled', false);
	} else {
		$('#passwordCheck').text("비밀번호가 일치하지 않습니다.").css({'display': 'inline', 'color': 'red'});
		$('#submitBtn').prop('disabled', true);
	}
}
</script>
</head>
<body>
	<div class="content">
		<form id="joinForm" class="form form--join" method="post" action="AdminInsert.action">
			<h2 class="form__title">관리자 정보 입력</h2>
		
			<!-- 기본 정보 섹션 -->
			<div class="form__section">
				<h3 class="form__section-title">기본 정보</h3>

				<!-- 관리자 이메일 입력 -->
				<div class="form__group">
					<div class="form__field">
						<label for="email" class="form__label required">이메일</label>
						<div class="form__input--wrapper">
							<input type="email" class="form__input" id="email" name="admin_email"
							       placeholder="예: example@google.com" maxlength="100" required />
							<button type="button" class="btn btn--check" onclick="checkEmail()">중복확인</button>
						</div>
					</div>
					<p id="emailCheck" class="result"></p>
				</div>
				
				<!-- 비밀번호 입력 -->
				<div class="form__group">
					<div class="form__field">
						<label for="password" class="form__label required">비밀번호</label> 
						<div class="form__input--wrapper">
							<input type="password" class="form__input" id="password" name="admin_pwd"
							       placeholder="영문, 숫자, 특수문자 조합 8-20자" maxlength="20" minlength="8" required />
						</div>
					</div>
					<p class="form__error pwd1--error"></p>
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
					<p id="passwordCheck" class="result"></p>
				</div>

				<!-- 닉네임 입력 -->
				<div class="form__group">
					<div class="form__field">
						<label for="nickName" class="form__label required">닉네임</label>
						<div class="form__input--wrapper">
							<input type="text" class="form__input" id="nickName"
							       placeholder="닉네임" maxlength="20" name="admin_nickName" required />
							<button type="button" class="btn btn--check" onclick="checkNickName()">중복확인</button>
						</div>
					</div>
					<p id="nickNameCheck" class="result"></p>
				</div>

				<!-- 전화번호 입력 -->
				<div class="form__group">
					<div class="form__field">
						<label for="tel" class="form__label">전화번호</label> 
						<div class="form__input-wrapper">
							<input type="tel" class="form__input" id="tel"
							       placeholder="전화번호" name="admin_tel" data-type="tel" />
						</div>
					</div>
				</div>
			</div>

			<!-- 버튼 그룹 -->
			<div class="form__actions">
				<button id="submitBtn" type="submit" class="btn btn--submit">회원가입</button>
				<button type="reset" class="btn btn--reset">취소</button>
				<button type="button" class="btn btn--back">뒤로가기</button>
			</div>
		</form>
	</div>
</body>
</html>
