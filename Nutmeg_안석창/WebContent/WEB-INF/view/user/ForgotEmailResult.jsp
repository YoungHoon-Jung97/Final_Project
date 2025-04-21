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
<title>ForgotEmallResult.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/insertForm.css?after">

</head>
<body>
<div class="content" style="width: 400px;">
	<div class="form form--join">
		<h2 class="form__title">이메일 찾기 결과</h2>
		
		<form action="ForgotPassword.action">
			<c:if test="${not empty requestScope.emailList}">
				<div class="email-result-container" style="margin-bottom: 40px;">
					<c:forEach var="email" items="${requestScope.emailList}">
						<div class="email-item" style="padding: 12px; border: 1px solid #ddd;
						border-radius: 6px; margin-bottom: 10px;">
							<input type="radio" id="${email}" name="user_email" value=" ${email}">
							
							<label for="${email}">${email}</label>
						</div>
					</c:forEach>
				</div>
				
				<div class="form__actions" style="margin-top: 20px;">
					<button type="submit" class="btn btn--submit" onclick="location.href='<%=cp %>/ForgotPassword.action'">비밀번호 찾기</button>
					<button type="button" class="btn btn--back" onclick="location.href='<%=cp %>/Login.action'">로그인하기</button>
				</div>
			</c:if>
			
			<c:if test="${empty requestScope.emailList}">
				<div style="justify-items: center;">
					<p class="form__message" style="margin-bottom: 30px;">입력하신 정보와 일치하는 이메일이 없습니다.</p>
					<button type="button" class="btn btn--back" onclick="location.href='<%=cp %>/ForgotEmail.action'">뒤로가기</button>
				</div>
			</c:if>
		</form>
	</div>
</div>
</body>
</html>