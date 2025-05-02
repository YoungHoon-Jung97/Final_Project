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
<title>CheckPassword.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/util/insertForm.css?after">

</head>
<body>
<div class="content" style="width: 400px;">
	<div class="form check-password-container">
		<div class="form__title" style="margin-bottom: 40px;">비밀번호 확인</div>
		
		<form method="post" action="<%=cp %>/CheckPassword.action">
			<div class="form__section">
				<div class="form__field">
					<label for="userPwd" class="form__label required">비밀번호</label>
					
					<div class="form__input--wrapper">
						<input type="password" id="userPwd" name="user_pwd"
						class="form__input" required placeholder="비밀번호를 입력하세요">
					</div>
				</div>
			</div>
			
			<c:if test="${not empty errorMsg}">
				<div class="result">${errorMsg}</div>
			</c:if>
			
			<div class="form__actions">
				<button type="submit" class="btn btn--submit">확인</button>
				<a href="javascript:history.back()" class="btn btn--secondary">취소</a>
			</div>
		</form>
	</div>
</div>
</body>
</html>