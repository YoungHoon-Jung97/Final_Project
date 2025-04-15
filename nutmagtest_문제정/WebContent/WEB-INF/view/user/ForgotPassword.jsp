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
<title>비밀번호 찾기</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/insertForm.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/Login.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/modal.css">
</head>
<body>
    <div class="content">
        <form id="ForgotPasswordForm" class="form form--join" method="post" action="<%=cp %>/ForgotPassword.action">
            <h2 class="form__title">비밀번호 찾기</h2>

            <!-- 비밀번호 찾기 섹션 -->
            <div class="form__section">
                <h3 class="form__section-title">회원 정보 확인</h3>

                <!-- 이메일 입력 -->
                <div class="form__group">
                    <div class="form__field">
                        <label for="email" class="form__label required">이메일</label>
                        <div class="form__input--wrapper">
                            <input type="email" class="form__input" id="email" name="email"
                                placeholder="예: example@domain.com" maxlength="100" required />
                        </div>
                    </div>
                </div>

                <!-- 전화번호 입력 -->
                <div class="form__group">
                    <div class="form__field">
                        <label for="tel" class="form__label required">전화번호</label>
                        <div class="form__input-wrapper">
                            <input type="tel" class="form__input" id="tel" name="tel"
                                placeholder="예: 010-1234-5678" required />
                        </div>
                    </div>
                </div>
            </div>
            <!-- .form__section -->

            <!-- 버튼 그룹 -->
            <div class="form__actions">
                <button type="submit" class="btn btn--submit">비밀번호 찾기</button>
                <button type="reset" class="btn btn--reset">초기화</button>
                <button type="button" class="btn btn--back" onclick="history.back();">뒤로가기</button>
            </div>
            
            <!-- 모달 구조 -->
			<div id="messageModal" class="modal">
				<div class="modal-content">
					<p id="modalMessageText"></p>
					<button onclick="closeModal()">확인</button>
				</div>
			</div>
			
			<script>
			function closeModal() 
			{
				document.getElementById("messageModal").style.display = "none";
			}
			
			// JSP에서 전달된 메시지를 JavaScript 변수로 가져옴
			const msg = "${message}";
			
			if (msg !== "") {
				document.getElementById("modalMessageText").textContent = msg;
				document.getElementById("messageModal").style.display = "block";
			}
			</script>
        </form>
    </div>
</body>
</html>
