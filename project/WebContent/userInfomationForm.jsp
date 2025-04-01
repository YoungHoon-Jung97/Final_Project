<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userInformationForm.jsp</title>
<style>

	.member_wrapper{
		width: 100%;
		max_width: 500px;
		margin: 0 auto;
	}

	.member_input{
		margin-bottom: 15px;
		padding-bottom: 5px;
		border-bottom: 1px solid #eee;
	}

	.member_input > div{
		display: flex;
	}

	.member_input span{
		width:110px;
		text-align: left;
		font-weight: 500;
	}

	.member_input input[type="email"],
	.member_input input[type="password"],
	.member_input input[type="text"],
	.member_input input[type="tel"] {
    	flex: 1;
    	min-width: 90px;
    	padding: 8px;
    	border: 1px solid #ccc;
    	border-radius: 4px;
		
	}	


	.content {
		border: 1px solid gray;
		padding: 10px;
		width: 100%;
		max-width: 550px; /* 최대 너비 제한 */
		margin: 0 auto;
		border-radius: 10px;
	}

	.form{
		text-align: center;
	}

	.email_error{
		display: none;
		color: red;
		font-size: small;
	}

	.password1_error{
		display: none;
		color: red;
		font-size: small;
	}

	.password2_error{
		display: none;
		color: red;
		font-size: small;
	}

	.nickname_error{
		display: none;
		color: red;
		font-size: small;
	}

	.name_error{
		display: none;
		color: red;
		font-size: small;
	}

	.btn{
		display: inline-block;
		border: none;
		font-weight: 500;
		padding: 8px 12px;
		border-radius: 4px;
		background-color: #ddd;
		color: black;
		cursor: pointer;
	}
	.btn:hover{
		background-color: gray;
		box-shadow: 0 4px 8px rgb(66, 99, 235, 0.3);
	}

	.ssn_input {
		display: flex;
		gap: 5px;
	}
	
	.ssn_input input{
		width:auto;
	}

	#ssn1 {
		min-width: 100px;
		flex: 0 0 100px;
	}

	#ssn2 {
		min-width: 15px;
		flex: 0 0 15px;
		text-align: center;
	}


	.member_input .email_error,
	.member_input .password1_error,
	.member_input .password2_error,
	.member_input .nickname_error,
	.member_input .name_error {
		margin-left: 110px;
		color: red;
		font-size: 12px;
		display: none;
	}



	.btn-block {
		display: block;
		width: 100%;
		padding: 10px;
		margin-top: 5px;
	}

</style>
</head>
<body>

<div class="content">
	<form id="join_form" class="join_form" method="get" action="">
		<div class="member_wrapper">

			<div class="member_email_wrapper member_input">
				<div class="email_input">
					<span>이메일</span>
					<input type="email" class="email_input_form" id="email"
					placeholder="아이디(이메일)" maxlength="100" 
					required="required"/>
					<button type="button" class="btn">이메일 중복확인</button>
				</div><!-- .email_input (이메일/아이디) -->
				<div class="email_error">
					<p>이메일을 입력하세요</p>
				</div><!-- .email_error  -->
			</div><!-- .member_email_wrapper-->

			<div class="member_password1_wrapper member_input">
				<div class="password1_input">
					<span>비밀번호</span>
					<input type="password" class="password_input_form" id="pwd1" name="pwd"
							placeholder="비밀번호" maxlength="20" minlength="8"
							required="required"/>
				</div><!-- .password1_input-->
				<div class="password1_error">
					<p>영문/숫자/특수문자 2가지 이상 조합 (8~20)</p>
					<p>아이디 제외</p>
				</div><!-- .password1_error  -->	
			</div><!-- .member_password1_wrapper (패스워드)  -->

			<div class="member_password2_wrapper member_input">
				<div class="password2_input">
					<span>비밀번호 확인</span>
					<input type="password" class="password_input_form" id="pwd2"
							placeholder="비밀번호 확인" maxlength="20" minlength="8"
							required="required"/>
				</div><!-- .password2_input-->
				<div class="password2_error">
					<p>비밀번호가 일치하지 않습니다.</p>
				</div><!-- .password2_error  -->	
			</div><!-- .member_password2_wrapper (패스워드 확인)  -->

			<div class="member_name_wrapper member_input">
				<div class="name_input">
					<span>이름</span>
						<input type="text" class="name_input_form" id="name"
						placeholder="이름" maxlength="10" name="name"
						required="required"/>
				</div><!-- .name_input-->
				<div class="name_error">
					<p>이름을 정확히 입력하세요</p>
				</div><!-- .name_error  -->	
			</div><!-- .member_name_wrapper (이름)  -->

			<div class="member_nickname_input member_input">
				<div class="nickname_input">
					<span>닉네임</span>
					<input type="text" class="nickname_input_form" id="nickname"
					placeholder="닉네임" maxlength="20" name="nickname"
					required="required"/>
					<button type="button" class="btn">닉네임 중복확인</button>
				</div><!-- .nickname_input-->
				<div class="nickname_error">
					<p>이미 존재하는 닉네임 입니다.</p>
				</div>
			</div><!-- .member_nickname_input(닉네임)-->
			
			<div class="member_tel_input member_input">
				<div class="tel_input">
					<span>전화번호</span>
					<input type="tel" class="tel_input_form" id="tel"
					placeholder="전화번호" name="tel" />
				</div><!-- .tel_input-->
			</div><!-- .mamber_tel_input (전화번호)-->

			<div class="member_ssn_input member_input">
				<div class="ssn_input">
					<span>주민번호</span>
					<input type="text" class="ssn_input_form" id="ssn1"
					maxlength="6" placeholder="생년월일(6자리)" required="required"/>
					-
					<input type="text" class="ssn_input_form" id="ssn2"
					maxlength="1" required="required" style="width: 15px;"/>
					<span>●●●●●●</span>

					<input type="hidden" id="ssn" name="ssn">
				</div>
			</div><!-- .member_ssn_input (주민번호 앞)-->
			
			<div class="member_post_address_input member_input">
				<div class="post_address_input">
					<span>우편주소</span>
					<button type="button" class="btn">우편번호 검색</button>
					<input type="text" class="post_address_input_form" id="post_address"
					required="required" readonly="readonly" name="post_address"/>
				</div><!-- .post_address_input-->
			</div>

			<div class="member_detail_address_input member_input">
				<div class="detail_address_input">
					<span>상세주소</span>
					<input type="text" class="detail_address_input_form" id="detail_address"
					placeholder="상세주소 입력" required="required" name="detail_address"/>
				</div><!-- .detail_address_input-->
			</div><!-- .member_detail_address_input-->

		</div><!-- .member_wrapper-->
		<div class="submin_btn">
			<button type="submit" class="btn submit btn-block">회원가입</button>
		</div><!-- .submin_btn-->

		<div class="reset_btn">
			<button type="reset" class="btn reset btn-block">취소</button>
		</div><!-- .reset_btn-->

		<div class="back_btn">
			<button type="button" class="btn back btn-block">뒤로가기</button>
		</div><!-- .back_btn-->

	</form><!-- .join_form-->
</div> <!-- .content -->



</body>
</html>