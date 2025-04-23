<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserInfoEdit.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/util/insertForm.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/util/scrollBar.css?after">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript" src="<%=cp %>/js/UserInfoEdit.js?after"></script>

</head>
<body>
<c:if test="${not empty sessionScope.message}">
	<script type="text/javascript">
		window.addEventListener("pageshow", function(event)
		{
			if (!event.persisted && performance.navigation.type != 2)
			{
				var message = "${fn:escapeXml(sessionScope.message)}";
				var parts = message.split(":");
				
				if (parts.length > 1)
				{
					var type = parts[0].trim();
					var content = parts[1].trim();
					
					switch (type)
					{
						case "WARNING":
							swal("주의", content, "warning");
							break;
						
						default:
							swal("알림", content, "info");
					}
				}
				
				else
					swal("처리 필요", message, "info");
			}
		});
	</script>
	
	<c:remove var="message" scope="session"></c:remove>
</c:if>

<div class="content">
	<form id="updateForm" class="form form--join" method="post" action="${pageContext.request.contextPath}/UserUpdate.action">
		<input type="hidden" name="user_code_id" value="${userInfo.user_code_id}">
		<input type="hidden" name="current_pwd" value="${userInfo.user_pwd}">
		
		<h2 class="form__title">회원 정보 수정</h2>
		
		<div class="form__section">
			<h3 class="form__section-title">기본 정보</h3>
			
			<div class="form__group">
				<label class="form__label">이메일</label>
				
				<p class="form__text">${userInfo.user_email}</p>
				
				<input type="hidden" name="user_email" value="${userInfo.user_email}">
			</div>
			
			<div class="form__group">
				<label class="form__label">이름</label>
				
				<p class="form__text">${userInfo.user_name}</p>
				
				<input type="hidden" name="user_name" value="${userInfo.user_name}">
			</div>
			
			<div class="form__group">
				<label class="form__label">닉네임</label>
				
				<p class="form__text">${userInfo.user_nick_name}</p>
				
				<input type="hidden" name="user_nick_name"
				value="${param.user_nick_name != null ? param.user_nick_name : userInfo.user_nick_name}">
			</div>
			
			<div class="form__group">
				<label class="form__label">비밀번호</label>
				
				<div class="form__input--wrapper">
					<input type="password" class="form__input" name="user_pwd"
					placeholder="새 비밀번호 입력 (변경하지 않으면 빈칸)">
				</div>
			</div>
			
			<c:if test="${not empty errorMsg}">
				<div style="color: red; margin-top: 5px;">${errorMsg}</div>
			</c:if>
			
			<div class="form__group">
				<label class="form__label">비밀번호 다시 입력</label>
				
				<div class="form__input--wrapper">
					<input type="password" class="form__input" name="password2"
					placeholder="새 비밀번호 다시 입력">
				</div>
			</div>
			
			<!-- 전화번호 -->
			<div class="form__group">
				<label class="form__label required">전화번호</label>
				
				<div class="form__input--wrapper">
					<input type="text" class="form__input" name="user_tel" required
					value="${param.user_tel != null ? param.user_tel : userInfo.user_tel}">
				</div>
			</div>
			
			<!-- 우편번호 -->
			<div class="form__group">
				<label class="form__label required">우편번호</label>
				
				<div class="form__input--wrapper">
					<input type="text" id="post" class="form__input" name="user_postal_addr" required
					value="${param.user_postal_addr != null ? param.user_postal_addr : userInfo.user_postal_addr}">
					
					<button type="button" class="btn btn--search" onclick="execPostCode()">우편번호 찾기</button>
				</div>
			</div>
			
			<!-- 주소 -->
			<div class="form__group">
				<label class="form__label required">주소</label>
				
				<div class="form__input--wrapper">
					<input type="text" id="address1" class="form__input" name="user_addr"
					value="${param.user_addr != null ? param.user_addr : userInfo.user_addr}" required>
				</div>
			</div>
			
			<!-- 상세 주소 -->
			<div class="form__group">
				<label class="form__label required">상세 주소</label>
				
				<div class="form__input--wrapper">
					<input type="text" id="address2" class="form__input" name="user_detailed_addr"
					value="${param.user_detailed_addr != null ? param.user_detailed_addr : userInfo.user_detailed_addr}" required>
				</div>
			</div>
		</div>
		
		<div class="form__actions">
			<button type="button" class="btn btn--submit" onclick="handleSubmit()">수정</button>
			<button type="button" class="btn btn--back" onclick="history.back()">뒤로가기</button>
		</div>
	</form>
</div>
</body>
</html>