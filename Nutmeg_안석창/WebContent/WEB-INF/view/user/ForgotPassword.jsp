<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	session.setAttribute("previousPage", "/Nutmeg/WEB-INF/view/main/MainPage.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForgotPassword.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/insertForm.css?after">
<style type="text/css">

/* 모달 배경 */
.modal
{
	display: none;
	position: fixed;
	z-index: 9999;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.4);
	backdrop-filter: blur(2px);
}

/* 모달 박스 */
.modal-content
{
	background-color: #fff;
	margin: 15% auto;
	padding: 30px 25px;
	border-radius: 12px;
	width: 320px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
	text-align: center;
	font-family: 'Noto Sans KR', sans-serif;
	animation: fadeIn 0.3s ease-in-out;
}

/* 모달 텍스트 */
#modalMessageText
{
	font-size: 16px;
	color: #333;
	margin-bottom: 20px;
	line-height: 1.6;
	word-break: keep-all;
	white-space: pre-wrap;
}

/* 확인 버튼 */
.modal-content button
{
	background-color: #2e8bff;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 6px;
	cursor: pointer;
	font-size: 14px;
	transition: background-color 0.2s ease;
}

.modal-content button:hover
{
	background-color: #1a6ed8;
}

@
keyframes fadeIn
{
	from
	{
		opacity:0;
		transform: scale(0.95);
	}
	
	to
	{
		opacity: 1;
		transform: scale(1);
	}
}

</style>

</head>
<body>
<div class="content" style="width: 400px;">
	<form id="ForgotPasswordForm" class="form form--join" method="post" action="<%=cp %>/ForgotPassword.action">
		<h2 class="form__title">비밀번호 찾기</h2>
		
		<!-- 비밀번호 찾기 섹션 -->
		<div class="form__section" style="margin-bottom: 40px;">
			<h3 class="form__section-title">회원 정보 확인</h3>
			
			<!-- 이메일 입력 -->
			<div class="form__group">
				<div class="form__field">
					<label for="email" class="form__label required">이메일</label>
					<div class="form__input--wrapper">
						<input type="email" class="form__input" id="email" name="email"
						placeholder="예: example@domain.com" maxlength="100" required value="${user_email}">
						
						<script>
						
							// user_email 값이 있으면 readonly 속성 추가
							if ("${user_email}" != "")
							{
								document.getElementById("email").setAttribute("readonly", "readonly");
							}
						
						</script>
					</div>
				</div>
			</div>
			
			<!-- 전화번호 입력 -->
			<div class="form__group">
				<div class="form__field">
					<label for="tel" class="form__label required">전화번호</label>
					
					<div class="form__input-wrapper">
						<input type="tel" class="form__input" id="tel" name="tel"
						placeholder="010-0000-0000" pattern="^$|^\d{3}-\d{3,4}-\d{4}$" required>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 버튼 그룹 -->
		<div class="form__actions">
			<button type="submit" class="btn btn--submit">비밀번호 찾기</button>
			<button type="button" class="btn btn--back" onclick="location.href='<%=cp %>/Login.action'">뒤로가기</button>
		</div>
		
		<!-- 모달 구조 -->
		<div id="messageModal" class="modal">
			<div class="modal-content">
				<p id="modalMessageText"></p>
				
				<button onclick="closeModal()">로그인하기</button>
			</div>
		</div>
		
		<script>
		
			function closeModal()
			{
				document.getElementById("messageModal").style.display = "none";
				
				window.location.href = "Login.action";
			}
			
			// JSP에서 전달된 메시지를 JavaScript 변수로 가져옴
			var msg = "${message}";
			
			if (msg != "")
			{
				document.getElementById("modalMessageText").textContent = msg;
				document.getElementById("messageModal").style.display = "block";
			}
		
		</script>
	</form>
</div>
</body>
</html>