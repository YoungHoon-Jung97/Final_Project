<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>회원 정보 수정</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/insertForm.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	// 기존 값 저장 (EL로 초기값 가져오기)
	const original =
	{
		email : "${userInfo.user_email}",
		tel : "${userInfo.user_tel}",
		nick : "${userInfo.user_nick_name}",
		postal : "${userInfo.user_postal_addr}",
		addr : "${userInfo.user_addr}",
		detailed : "${userInfo.user_detailed_addr}"
	};

	function execPostCode()
	{
		new daum.Postcode(
		{
			oncomplete : function(data)
			{
				var addr = data.roadAddress ? data.roadAddress
						: data.jibunAddress;
				$("#post").val(data.zonecode);
				$('#address1').val(addr);
				$('#address2').focus();
			}
		}).open();
	}

	$(function()
	{
		$('#updateForm')
				.on(
						'submit',
						function(e)
						{
							const current =
							{
								email : $('input[name="user_email"]').val()
										.trim(),
								tel : $('input[name="user_tel"]').val().trim(),
								nick : $('input[name="user_nick_name"]').val()
										.trim(),
								postal : $('input[name="user_postal_addr"]')
										.val().trim(),
								addr : $('input[name="user_addr"]').val()
										.trim(),
								detailed : $('input[name="user_detailed_addr"]')
										.val().trim(),
								pwd : $('input[name="user_pwd"]').val().trim()
							};

							const allSame = (current.email === original.email
									&& current.tel === original.tel
									&& current.nick === original.nick
									&& current.postal === original.postal
									&& current.addr === original.addr
									&& current.detailed === original.detailed && current.pwd === "");

							if (allSame)
							{
								alert("변경된 내용이 없습니다.");
								e.preventDefault();
							}
						});
	});

	function execPostCode(){
		new daum.Postcode({
			
			//oncomplete : 주소를 선택하면 팝업이 닫히고 값이 입력 필드에 설정
			oncomplete: function(data) {
				//도로명 주소와 지번 주소 중 하나를 선택하여 출력
				var addr = data.roadAddress ? data.roadAddress : data.jibunAddress;
				
				//우편번호와 주소를 입력란에 넣기
				$("#post").val(data.zonecode);  //우편번호
				$('#address1').val(addr);		//기본 주소
				
				//상세주소 입력창 포커스 이동
				$('#address2').focus();
			},

			
		}).open({
			popupName: 'postPopup', // 팝업 이름 지정(중복 방지)
			width: 400,
            height: 500
			
		});
		
	}
</script>
</head>
<body>
	<div class="content">
		<form id="updateForm" class="form form--join" method="post"
			action="${pageContext.request.contextPath}/UserUpdate.action">
			<h2 class="form__title">회원 정보 수정</h2>

			<input type="hidden" name="user_code_id"
				value="${userInfo.user_code_id}" />

			<div class="form__section">
				<h3 class="form__section-title">기본 정보</h3>

				<div class="form__group">
					<label for="email" class="form__label required">이메일</label>
					<p class="form__text">${userInfo.user_email}</p>
					<input type="hidden" name="user_email"
						value="${userInfo.user_email}" />
				</div>

				<div class="form__group">
					<label class="form__label required">비밀번호</label> <input
						type="password" class="form__input" name="user_pwd" minlength="8"
						maxlength="20" placeholder="새 비밀번호 입력" />
				</div>
				<div class="form__group">
					<label class="form__label required">비밀번호 다시 입력</label> <input
						type="password" class="form__input" name="password2" minlength="8"
						maxlength="20" placeholder="새 비밀번호 다시 입력" />
				</div>

				<!-- 이름 -->
				<div class="form__group">
					<label class="form__label required">이름</label>
					<p class="form__text">${userInfo.user_name}</p>
					<input type="hidden" name="user_name" value="${userInfo.user_name}" />
				</div>

				<!-- 닉네임 -->
				<div class="form__group">
					<label class="form__label">닉네임</label>
					<p class="form__text">${userInfo.user_nick_name}</p>
					<input type="hidden" name="user_nick_name"
						value="${userInfo.user_nick_name}" />
				</div>

				<div class="form__group">
					<label class="form__label required">전화번호</label> <input type="text"
						class="form__input" name="user_tel" value="${userInfo.user_tel}"
						required />
				</div>

				<!-- 주민등록번호 -->
				<div class="form__group">
					<label class="form__label required">주민등록번호</label>
					<p class="form__text">${fn:substring(userInfo.user_ssn1, 0, 6)}-${fn:substring(userInfo.user_ssn2, 0, 1)}●●●●●●</p>
				</div>

				<div class="form__group">
					<div class="form__field">
						<label for="post" class="form__label required">우편번호</label>
						<div class="form__input--wrapper">
							<input type="text" id="address" class="form__input" name="user_postal_addr" value="${userInfo.user_postal_addr}" required />
							<button type="button" class="btn btn--search" onclick="execPostCode()">우편번호 찾기</button>
						</div>
					</div>
				</div>
	
	            <!-- 기본 주소 -->
				<div class="form__group">
				    <label class="form__label required">기본 주소</label>
				    <input type="text" id="address1" class="form__input" name="user_addr" value="${userInfo.user_addr}" required />
				</div>
	
	            <div class="form__group">
	                <label class="form__label required">상세 주소</label>
	                <input type="text" id="address2" class="form__input" name="user_detailed_addr" value="${userInfo.user_detailed_addr}" required />
	            </div>
	        </div>

			<div class="form__actions">
				<button type="submit" class="btn btn--submit">수정완료</button>
				<button type="reset" class="btn btn--reset">취소</button>
				<button type="button" class="btn btn--back" onclick="history.back()">뒤로가기</button>
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

				const msg = "${message}";

				if (msg !== "")
				{
					document.getElementById("modalMessageText").textContent = msg;
					document.getElementById("messageModal").style.display = "block";
				}
			</script>
		</form>
	</div>
</body>
</html>