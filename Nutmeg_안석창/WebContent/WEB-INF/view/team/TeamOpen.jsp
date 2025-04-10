<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	Integer user_code_id = (Integer) session.getAttribute("user_code_id");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>TeamOpen.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/insertForm.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/scrollBar.css?after">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	var user_code_id = "<%=user_code_id %>";
	
	$(function()
	{
		// 뒤로 가기
		$('.btn--back').on('click', function()
		{
			var prevPage = "<%=session.getAttribute("prevPage") %>";
			var fallback = "<%=cp %>/MainPage.action";

			if (prevPage && prevPage !== "null")
				window.location.href = prevPage;
			
			else
		        window.location.href = fallback;
		});
	});

</script>
<script type="text/javascript" src="<%=cp %>/js/TeamOpen.js?after"></script>

</head>
<body>
<div class="content">
	<form method="post" action="TeamInsert.action" class="form form--join" enctype="multipart/form-data">
		<h2 class="form__title">동호회 개설 신청</h2>
		
		<div class="form__section">
			<h3 class="form__section-title">기본 정보</h3>
			
			<!-- 동호회 이름 -->
			<div class="form__group">
				<div class="form__field">
					<label for="teamName" class="form__label required">동호회 이름</label>
					
					<div class="form__input--wrapper">
						<input type="text" id="teamName" name="temp_team_name" class="form__input" placeholder="동호회 이름" required>
						<input type="hidden" id="user_code_id" name="user_code_id" value="<%=user_code_id %>">
					</div>
				</div>
				
				<p id="teamNameCheck" class="result"></p>
			</div>
			
			<!-- 동호회 인원 -->
			<div class="form__group">
				<div class="form__field">
					<label for="memberCount" class="form__label required">동호회 회원 수</label>
					
					<div class="form__input--wrapper">
						<input type="number" id="memberCount" name="temp_team_person_count"
						class="form__input" placeholder="4~25명" required min="4" max="25">
					</div>
				</div>
			</div>
			
			<!-- 지역 -->
			<div class="form__group">
				<div class="form__field">
					<label class="form__label required">지역</label>
					
					<div class="form__selection">
						<select id="regions" name="region_id" class="form__input" required>
							<option value="">시를 선택하세요</option>
							
							<c:forEach var="region" items="${regionList}">
								<option value="${region.region_id}">${region.region_name}</option>
							</c:forEach>
						</select>
						
						<select id="citys" name="city_id" class="form__input" required>
							<option value="">구를 선택하세요</option>
						</select>
					</div>
				</div>
			</div>
			
			<!-- 동호회 설명 -->
			<div class="form__group">
				<div class="form__field">
					<label for="discript" class="form__label">동호회 설명</label>
					
					<textarea rows="5" id="discript" name="temp_team_desc" class="form__input"
					placeholder="동호회의 방향성 혹은 동호회 설명 등.."></textarea>
				</div>
			</div>
			
			<!-- 앰블럼 -->
			<div class="form__group">
				<div class="form__field">
					<label class="form__label">동호회 앰블럼</label>
					
					<div class="file-upload-wrapper">
						<input type="file" id="image" name="temp_team_emblem" class="file-upload-input" />
						<button type="button" class="file-upload-btn" onclick="document.getElementById('image').click();">파일 선택</button>
						<span id="file-name" class="file-upload-filename">선택된 파일 없음</span>
					</div>
				</div>
			</div>
		</div>
		
		<div class="form__section">
			<h3 class="form__section-title">계좌 정보</h3>

			<!-- 은행 -->
			<div class="form__group">
				<div class="form__field">
					<label for="bank" class="form__label required">은행명</label>
					
					<div class="form__input--wrapper">
						<select id="bank" name="bank_id" class="form__input" required>
							<option value="">은행을 선택하세요</option>
							
							<c:forEach var="bank" items="${bankList}">
								<option value="${bank.bank_id}">${bank.bank_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			
			<!-- 예금주 -->
			<div class="form__group">
				<div class="form__field">
					<label for="depositor" class="form__label required">예금주</label>
					
					<div class="form__input--wrapper">
						<input type="text" id="depositor" name="temp_team_account_holder"
						class="form__input" placeholder="동호회 예금주" required>
					</div>
				</div>
			</div>
			
			<!-- 계좌번호 -->
			<div class="form__group">
				<div class="form__field">
					<label for="account" class="form__label required">계좌번호</label>
					
					<div class="form__input--wrapper">
						<input type="text" id="account" name="temp_team_account"
						class="form__input" placeholder="동호회 계좌 번호" required>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 버튼 그룹 -->
		<div class="form__actions">
			<button type="submit" id="submitBtn" class="btn btn--submit">개설하기</button>
			<button type="button" class="btn btn--back">뒤로가기</button>
		</div>
	</form>
</div>
</body>
</html>