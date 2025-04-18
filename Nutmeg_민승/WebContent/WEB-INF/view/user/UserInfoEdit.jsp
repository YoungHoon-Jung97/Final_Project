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
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/modal.css"></link>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
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
      }).open(
      {
         popupName : 'postPopup',
         width : 400,
         height : 500
      });
   }

   function closeModal()
   {
      document.getElementById("messageModal").style.display = "none";
   }

   function goToMain()
   {
      window.location.href = "${pageContext.request.contextPath}/main.action";
   }

   function resetPasswordFields()
   {
      document.querySelector('input[name="user_pwd"]').value = '';
      document.querySelector('input[name="password2"]').value = '';
      document.querySelector('input[name="user_pwd"]').focus();
   }

   function handleSubmit()
   {
      const pwd = document.querySelector('input[name="user_pwd"]').value
            .trim();
      const pwd2 = document.querySelector('input[name="password2"]').value
            .trim();
      const form = document.getElementById("updateForm");
      const hiddenCurrentPwd = document
            .querySelector('input[name="current_pwd"]');

      if (pwd !== "" || pwd2 !== "")
      {
         if (pwd !== pwd2)
         {
            document.getElementById("modalMessageText").textContent = "❌ 비밀번호가 일치하지 않습니다.";
            document.getElementById("messageModal").style.display = "flex";
            document.querySelector(".modal-submit").onclick = function()
            {
               closeModal();
               resetPasswordFields();
            };
            return;
         }
      } else
      {
         document.querySelector('input[name="user_pwd"]').value = hiddenCurrentPwd.value;
      }

      const current =
      {
         email : $('input[name="user_email"]').val().trim(),
         tel : $('input[name="user_tel"]').val().trim(),
         nick : $('input[name="user_nick_name"]').val().trim(),
         postal : $('input[name="user_postal_addr"]').val().trim(),
         addr : $('input[name="user_addr"]').val().trim(),
         detailed : $('input[name="user_detailed_addr"]').val().trim(),
         pwd : pwd
      };

      const allSame = (current.email === original.email
            && current.tel === original.tel
            && current.nick === original.nick
            && current.postal === original.postal
            && current.addr === original.addr
            && current.detailed === original.detailed && pwd === "" && pwd2 === "");

      if (allSame)
      {
         document.getElementById("modalMessageText").textContent = "❕ 변경된 내용이 없습니다.";
         document.getElementById("messageModal").style.display = "flex";
         document.querySelector(".modal-submit").onclick = function()
         {
            closeModal();
         };
         return;
      }

      document.getElementById("modalMessageText").textContent = "✔️ 수정이 완료되었습니다.";
      document.getElementById("messageModal").style.display = "flex";

      document.querySelector(".modal-submit").onclick = function()
      {
         form.submit();
      };
   }
</script>
<style>
.modal {
   position: fixed;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   background-color: rgba(0, 0, 0, 0.5);
   display: none;
   justify-content: center;
   align-items: center;
   z-index: 9999;
}

.modal-content {
   background-color: white;
   padding: 30px;
   border-radius: 12px;
   text-align: center;
   min-width: 280px;
   box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
   position: relative;
}

.close-modal {
   position: absolute;
   top: 10px;
   right: 15px;
   font-size: 24px;
   cursor: pointer;
}

.modal-button {
   padding: 8px 20px;
   border: none;
   border-radius: 5px;
   background-color: #4CAF50;
   color: white;
   font-weight: bold;
   cursor: pointer;
   margin: 10px;
}

.modal-button:hover {
   background-color: #45a049;
}
</style>
</head>
<body>
   <div class="content">
      <form id="updateForm" class="form form--join" method="post"
         action="${pageContext.request.contextPath}/UserUpdate.action">
         <h2 class="form__title">회원 정보 수정</h2>

         <input type="hidden" name="user_code_id"
            value="${userInfo.user_code_id}" /> <input type="hidden"
            name="current_pwd" value="${userInfo.user_pwd}" />

         <div class="form__section">
            <h3 class="form__section-title">기본 정보</h3>

            <div class="form__group">
               <label class="form__label required">이메일</label>
               <p class="form__text">${userInfo.user_email}</p>
               <input type="hidden" name="user_email"
                  value="${userInfo.user_email}" />
            </div>

            <div class="form__group">
               <label class="form__label">비밀번호</label> <input type="password"
                  class="form__input" name="user_pwd"
                  placeholder="새 비밀번호 입력 (변경하지 않으면 빈칸)" />
            </div>

            <c:if test="${not empty errorMsg}">
               <div style="color: red; margin-top: 5px;">${errorMsg}</div>
            </c:if>

            <div class="form__group">
               <label class="form__label">비밀번호 다시 입력</label> <input
                  type="password" class="form__input" name="password2"
                  placeholder="새 비밀번호 다시 입력" />
            </div>

            <div class="form__group">
               <label class="form__label required">이름</label>
               <p class="form__text">${userInfo.user_name}</p>
               <input type="hidden" name="user_name" value="${userInfo.user_name}" />
            </div>

            <div class="form__group">
               <label class="form__label">닉네임</label>
               <p class="form__text">${userInfo.user_nick_name}</p>
               <input type="hidden" name="user_nick_name"
                  value="${param.user_nick_name != null ? param.user_nick_name : userInfo.user_nick_name} "/>
            </div>

            <!-- 전화번호 -->
            <div class="form__group">
                <label class="form__label required">전화번호</label>
                <input type="text" class="form__input" name="user_tel"
                    value="${param.user_tel != null ? param.user_tel : userInfo.user_tel}" required />
            </div>
            
            <!-- 우편번호 -->
            <div class="form__group">
                <label class="form__label required">우편번호</label>
                <div class="form__input--wrapper">
                    <input type="text" id="post" class="form__input" name="user_postal_addr"
                        value="${param.user_postal_addr != null ? param.user_postal_addr : userInfo.user_postal_addr}" required />
                    <button type="button" class="btn btn--search" onclick="execPostCode()">우편번호 찾기</button>
                </div>
            </div>
            
            <!-- 기본 주소 -->
            <div class="form__group">
                <label class="form__label required">기본 주소</label>
                <input type="text" id="address1" class="form__input" name="user_addr"
                    value="${param.user_addr != null ? param.user_addr : userInfo.user_addr}" required />
            </div>
            
            <!-- 상세 주소 -->
            <div class="form__group">
                <label class="form__label required">상세 주소</label>
                <input type="text" id="address2" class="form__input" name="user_detailed_addr"
                    value="${param.user_detailed_addr != null ? param.user_detailed_addr : userInfo.user_detailed_addr}" required />
            </div>
         </div>

         <div class="form__actions">
            <button type="button" class="btn btn--submit"
               onclick="handleSubmit()">수정완료</button>
            <button type="reset" class="btn btn--reset">취소</button>
            <button type="button" class="btn btn--back" onclick="history.back()">뒤로가기</button>
         </div>

         <div id="messageModal" class="modal">
            <div class="modal-content">
               <span class="close-modal" onclick="closeModal()">&times;</span>
               <div class="modal-body" style="margin-top: 20px;">
                  <p id="modalMessageText"
                     style="font-size: 1.1em; font-weight: 500;">✔️ 수정이 완료되었습니다.</p>
               </div>
               <div class="modal-footer"
                  style="justify-content: center; width: 100%; margin-top: 20px;">
                  <button class="modal-button">확인</button>
               </div>
            </div>
         </div>
      </form>
   </div>
</body>
</html>
