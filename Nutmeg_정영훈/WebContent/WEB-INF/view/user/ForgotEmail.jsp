<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForgotEmail.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/insertForm.css?after">

</head>
<body>
<div class="content" style="display: flex; justify-content: center;">
	<form method="post" action="<%=cp %>/ForgotEmail.action" class="form form--join" style="width: 400px;">
		<h2 class="form__title">이메일 찾기</h2>
		
		<div class="form__section" style="margin-bottom: 50px; padding-left: 25px;">
			<!-- 생년월일 입력 -->
			<div class="form__group">
				<label for="birth" class="form__label required"
				pattern="\d{6}" style="margin-right: 10px;">생년월일</label>
				
				<input type="text" class="form__input" id="birth"
				placeholder="YYMMDD" name="birth" required>
			</div>
			
			<!-- 휴대폰 번호 입력 -->
			<div class="form__group">
				<label for="tel" class="form__label required"
				style="margin-right: 10px;">전화번호</label>
				
				<input type="tel" class="form__input" id="tel" name="tel"
				placeholder="010-0000-0000" pattern="^\d{3}-\d{3,4}-\d{4}$" required>
			</div>
		</div>
		
		<div class="form__actions">
			<button type="submit" class="btn btn--submit">이메일 찾기</button>
			<button type="button" class="btn btn--back" onclick="location.href='<%=cp %>/Login.action'">뒤로가기</button>
		</div>
	</form>
</div>
</body>
</html>