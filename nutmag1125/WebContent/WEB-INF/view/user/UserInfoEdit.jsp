<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
    // 기존 값 저장 (EL로 초기값 가져오기)
    const original = {
        email: "${userInfo.user_email}",
        tel: "${userInfo.user_tel}",
        nick: "${userInfo.user_nick_name}",
        postal: "${userInfo.user_postal_addr}",
        addr: "${userInfo.user_addr}",
        detailed: "${userInfo.user_detailed_addr}"
    };

    function execPostCode(){
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.roadAddress ? data.roadAddress : data.jibunAddress;
                $("#post").val(data.zonecode);
                $('#address1').val(addr);
                $('#address2').focus();
            }
        }).open();
    }

    $(function() {
        $('#updateForm').on('submit', function(e) {
            const current = {
                email: $('input[name="user_email"]').val().trim(),
                tel: $('input[name="user_tel"]').val().trim(),
                nick: $('input[name="user_nick_name"]').val().trim(),
                postal: $('input[name="user_postal_addr"]').val().trim(),
                addr: $('input[name="user_addr"]').val().trim(),
                detailed: $('input[name="user_detailed_addr"]').val().trim(),
                pwd: $('input[name="user_pwd"]').val().trim()
            };

            const allSame = (
                current.email === original.email &&
                current.tel === original.tel &&
                current.nick === original.nick &&
                current.postal === original.postal &&
                current.addr === original.addr &&
                current.detailed === original.detailed &&
                current.pwd === ""
            );

            if (allSame) {
                alert("변경된 내용이 없습니다.");
                e.preventDefault();
            }
        });
    });
</script>
</head>
<body>
<div class="content">
    <form id="updateForm" class="form form--join" method="post" action="UserUpdate.action">
        <h2 class="form__title">회원 정보 수정</h2>

        <input type="hidden" name="user_code_id" value="${userInfo.user_code_id}" />

        <div class="form__section">
            <h3 class="form__section-title">기본 정보</h3>
			
			<div class="form__group">
					<div class="form__field">
						<label for="email" class="form__label required">이메일</label>
						<div class="form__input--wrapper">
							<input type="email" class="form__input" id="email" name="user_email"
								placeholder="예: example@google.com" maxlength="100" readonly="readonly" value="${userInfo.user_email}" />
						</div>
					</div>
					<p id="emailCheck" class="result"></p>
				</div>

            <div class="form__group">
                <label class="form__label required">비밀번호</label>
                <input type="password" class="form__input" name="user_pwd" minlength="8" maxlength="20" placeholder="새 비밀번호 입력 (미입력 시 변경 안됨)" />
            </div>

            <div class="form__group">
                <label class="form__label required">이름</label>
                <input type="text" class="form__input" name="user_name" value="${userInfo.user_name}" readonly />
            </div>

            <div class="form__group">
                <label class="form__label required">전화번호</label>
                <input type="text" class="form__input" name="user_tel" value="${userInfo.user_tel}" required />
            </div>

            <div class="form__group">
                <label class="form__label required">닉네임</label>
                <input id="nickName" type="text" class="form__input" name="user_nick_name" value="${userInfo.user_nick_name}" required />
                <button type="button" class="btn btn--check" onclick="checkNickName()">중복확인</button>
                <p id="nickNameCheck" class="result"></p>
            </div>

            <div class="form__group">
                <label class="form__label required">주민등록번호</label>
                <input type="text" class="form__input" value="${fn:substring(userInfo.user_ssn1, 0, 6)}-${fn:substring(userInfo.user_ssn2, 0, 1)}●●●●●●" readonly />
            </div>

            <div class="form__group">
                <label class="form__label required">우편번호</label>
                <input type="text" id="post" class="form__input" name="user_postal_addr" value="${userInfo.user_postal_addr}" readonly />
                <button type="button" onclick="execPostCode()">우편번호 찾기</button>
            </div>

            <div class="form__group">
                <label class="form__label required">기본 주소</label>
                <input type="text" id="address1" class="form__input" name="user_addr" value="${userInfo.user_addr}" readonly />
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
    </form>
</div>
</body>
</html>
