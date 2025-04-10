<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	Integer user_code_id = (Integer) session.getAttribute("user_code_id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OperatorSignupForm.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/insertForm.css?after">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	var user_code_id = "<%=user_code_id %>";
	
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
<script type="text/javascript" src="<%=cp %>/js/OperatorSignupForm.js?after"></script>

</head>
<body>
<div class="content">
	<form id="inserForm" class="form form--join" method="post" action="OperatorInsert.action">
		<input type="hidden" id="user_code_id" name="user_code_id" value="">
		
		<h2 class="form__title">구장 운영자 가입</h2>
		
		<!-- 기본 정보 섹션 -->
		<div class="form__section">
			<h3 class="form__section-title">구장 운영자 정보 입력</h3>
			
			<!-- 사용자 이메일 입력(아이디)-->
			<div class="form__group">
				<div class="form__field">
					<label for="email" class="form__label required">구장 운영자 이메일</label>
					
					<div class="form__input--wrapper">
						<input type="email" class="form__input" id="email" name="Operator_email"
						placeholder="예: example@naver.com" maxlength="100" required>
						
						<button type="button" class="btn btn--check" onclick="checkEmail()">중복확인</button>
					</div>
				</div>
				
				<p id="emailCheck" class="result"></p>
			</div>
			
			<!-- 이름 입력-->
			<div class="form__group">
				<div class="form__field">
					<label for="name" class="form__label required">구장 운영자 이름</label>
					
					<div class="form__input--wrapper">
						<input type="text" class="form__input" id="name" placeholder="이름을 입력하세요."
						maxlength="10" name="operator_name" required>
					</div>
				</div>
				
				<p class="form__error name--error"></p>
			</div>
			
			<!-- 전화번호 입력 -->
			<div class="form__group">
				<div class="form__field">
					<label for="tel" class="form__label required">구장 운영자 전화번호</label>
					
					<div class="form__input--wrapper">
						<input type="tel" class="form__input" id="tel" placeholder="전화번호를 입력하세요."
						name="operator_tel" required>
					</div>
				</div>
			</div>
			
			<!-- 은행 -->
			<div class="form__group">
				<div class="form__field">
					<label for="bank" class="form__label required">은행명</label>
					
					<div class="form__input--wrapper">
						<select id="bank" name="bank_id" class="form__input" required>
							<option value="">은행을 선택하세요</option>
							
							<c:forEach var="bank" items="${bankList}">
								<option value="${bank.bank_id}">${bank.bank_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			
			<!-- 예금주 -->
			<div class="form__group">
				<div class="form__field">
					<label for="tel" class="form__label required">예금주</label> 
					
					<div class="form__input--wrapper">
						<input type="tel" class="form__input" id="tel" placeholder="구장 운영자 예금주"
						name="operator_account_holder" required>
					</div>
				</div>
			</div>
			
			<!-- 계좌번호 -->
			<div class="form__group">
				<div class="form__field">
					<label for="accountNo" class="form__label required" >계좌번호</label>
					
					<div class="form__input--wrapper">
						<input type="text" class="form__input" id="accountNo" placeholder="구장 운영자 계좌번호"
						maxlength="20" name="operator_account_no" required>
						
						<button type="button" class="btn btn--check" onclick="checkAccountNo()">중복확인</button>
					</div>
				</div>
				
				<p id="accountNoCheck" class="result"></p>
			</div>
			
			<!-- 버튼 그룹 -->
			<div class="form__actions">
				<button id="submitBtn" type="submit" class="btn btn--submit">구단 운영자 가입</button>
				<button type="button" class="btn btn--back">뒤로가기</button>
			</div>
		</div>
	</form> <!-- .form--join-->
</div> <!-- .content -->
</body>
</html>