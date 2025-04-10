<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fieldInsertForm.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/insertForm.css">


</head>
<body>

	<div class="content">
		<form id="joinForm" class="form form--join" method="post" action="FieldRegInsert.action" enctype="multipart/form-data">
			<h2 class="form__title">경기장 정보 입력</h2>
			<!-- 기본 정보 섹션 -->
			<div class="form__section">
				<h3 class="form__section-title">기본 정보</h3>


				<!-- 경기장 이름 입력 -->
				<div class="form__group">
					<div class="form__field">
						<label for="name" class="form__label required">경기장이름</label>
						<div class="form__input--wrapper">
							<input type="text" class="form__input" id="name"
							placeholder="경기장이름" maxlength="20" name="field_reg_name" required />
						</div>
					</div>
				</div>

				<div>
				    <label for="fieldcondition" class="form__label required">경기장 필드</label>
				    <div class="form__selection">
				        <select id="field" name="field_type_id" class="required form__input" required>
				            <option value="">--필드 상태--</option>
				            <c:forEach var="field" items="${fieldTypeList}">
				                <option value="${field.field_type_id}">${field.field_type}</option>
				            </c:forEach>
				        </select>
				    </div>
				</div>
				

				<div>
				    <label for="fieldevnvironment" class="form__label required">경기장 환경</label>
				    <div class="form__selection">
				        <select id="field" name="field_environment_id" class="required form__input" required>
				            <option value="">--경기장 환경 선택--</option>
				            <c:forEach var="field" items="${fieldEnviromentList}">
				                <option value="${field.field_environment_id}">${field.field_environment_type}</option>
				            </c:forEach>
				        </select>
				    </div>
				</div>

				<!-- 구장 크기 선택-->
				<div class="form__group">
				  <div class="form__field">
				    <label for="width" class="form__label required">경기장 크기</label> 
				    <div class="form__input--wrapper field-size-wrapper">
				      <div class="form__selection">
				        <span class="size-label">가로</span>
				        <input type="text" name="field_reg_garo"/>
				        <span class="unit-label">m</span>
				      </div>
				      <span class="dash">X</span>
				      <div class="form__selection">
				        <span class="size-label">세로</span>
				        <input type="text" name="field_reg_sero" />
				        <span class="unit-label">m</span>
				      </div>
				    </div>
				  </div>
				</div>
				
				<!-- 경기장 수용 인원 -->
				<div class="form__group">
					<div class="form__field">
						<label for="personCount" class="form__label required">수용인원</label>
						<div class="form__input--wrapper">
							<input type="text" class="form__input" id="name"
							placeholder="경기장수용인원" maxlength="20" name="personCount" required />
						</div>
					</div>
				</div>
				
				<!-- 구장 금액-->
				<div class="form__group">
				  <div class="form__field">
				    <label for="price" class="form__label required">가격(2시간당)</label>
				    <div class="form__input--wrapper">
				      <input type="text" class="form__input" id="price"
						placeholder="가격을 입력하세요" name="field_reg_price" required />
				      <span class="unit-label">원</span>
				    </div>
				  </div>
				</div>
				
				
				<!-- 첨부파일 -->
				<div class="form__group">
					<div class="form__field">
						<label for="image" class="form__label ">첨부파일</label>
						<div class="form__input-wrapper file-upload">
							<input type="file"  class="form__input file-upload-input" id="image" name="field_reg_image"/>
						</div>
					</div>
				</div>
			</div>
			<input type="hidden" name="stadium_reg_id" value="${stadium_reg_id }">

				<!-- 버튼 그룹 -->
				<div class="form__actions">
					<button type="submit" class="btn btn--submit">등록</button>
					<button type="reset" class="btn btn--reset">취소</button>
					<button type="button" class="btn btn--back">뒤로가기</button>
				</div>
			
		</form>
		<!-- .form -->
	</div>
	<!-- .content -->

</body>
</html>