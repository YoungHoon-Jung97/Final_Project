<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>이메일 찾기 결과</title>
<link rel="stylesheet" href="<%=cp%>/css/insertForm.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/Login.css">
</head>
<body>
	<div class="content">
		<div class="form form--join">
			<h2 class="form__title">이메일 찾기 결과</h2>
		
<c:if test="${not empty requestScope.emailList}">
    <div class="email-result-container">
        <c:forEach var="email" items="${requestScope.emailList}">
            <div class="email-item" style="padding: 12px; border: 1px solid #ddd; border-radius: 6px; margin-bottom: 10px;">
                ${email}
            </div>
        </c:forEach>
    </div>
    <div class="form__actions" style="margin-top: 20px;">
        <button type="button" class="btn btn--submit" onclick="location.href='<%=cp %>/Login.action'">로그인하기</button>
        <button type="button" class="btn btn--reset" onclick="location.href='<%=cp %>/ForgotPassword.action'">비밀번호 찾기</button>
    </div>
</c:if>

<c:if test="${empty requestScope.emailList}">
    <p class="form__message">입력하신 정보와 일치하는 이메일이 없습니다.</p>
</c:if>

		</div>
	</div>
</body>
</html>
