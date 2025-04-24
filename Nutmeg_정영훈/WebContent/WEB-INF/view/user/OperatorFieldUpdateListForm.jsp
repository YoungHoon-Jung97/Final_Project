<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/stadium/StadiumFieldCheckForm.css?after">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<h4 class="mb-4">경기장 정보 수정</h4>

<c:forEach var="field" items="${fieldList}">
	<form action="OperatorFieldUpdateForm.action" method="post">
		<div class="match-card">
			<div class="field-card">
				<div class="field-img-wrapper">
					<img src="${field.field_reg_image}" alt="경기장 이미지"
					class="field-img" style="width: 100%; height: 300px;">
					
					<div class="field-info">
						<strong>이름 : ${field.field_reg_name}</strong><br>
						등록일 : ${field.field_reg_at}<br>
						가로 : ${field.field_reg_garo}, 세로 : ${field.field_reg_sero}<br>
						바닥 종류 : ${field.field_type}, 환경: ${field.field_environment_type}<br>
						2시간당 가격 : ${field.field_reg_price}
					</div>
				</div>
				
				<!-- 버튼 -->
				<input type="hidden" name="field_code_id" value="${field.field_code_id}">
				
				<div style="display: flex; justify-content: flex-end;">
					<button type="submit" class="btn btn-secondary card-action">
						정보 수정하기</button>
				</div>
			</div>
		</div>
	</form>
</c:forEach>