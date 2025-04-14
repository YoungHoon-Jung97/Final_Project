<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 찾기</title>
<link rel="stylesheet" href="<%=cp %>/css/insertForm.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/Login.css">

</head>
<body>
<div class="content">
    <form method="post" action="<%=cp %>/ForgotEmail.action" class="form form--join">
        <h2 class="form__title">이메일 찾기</h2>

        <div class="form__section">
            <!-- 생년월일 입력 -->
            <div class="form__group">
                <label for="birth" class="form__label required">생년월일</label>
                <input type="text" class="form__input" id="birth" placeholder="000000" name="birth" required />
            </div>

            <!-- 휴대폰 번호 입력 -->
            <div class="form__group">
                <label for="tel" class="form__label required">전화번호</label>
                <input type="tel" class="form__input" id="tel" name="tel" placeholder="010-0000-0000" required />
            </div>
        </div>

        <div class="form__actions">
            <button type="submit" class="btn btn--submit">이메일 찾기</button>
            <button type="reset" class="btn btn--reset">초기화</button>
            <button type="button" class="btn btn--back" onclick="history.back();">뒤로가기</button>
        </div>

        <c:if test="${not empty message}">
            <p class="form__message">${message}</p>
        </c:if>
    </form>
</div>
</body>
</html>
