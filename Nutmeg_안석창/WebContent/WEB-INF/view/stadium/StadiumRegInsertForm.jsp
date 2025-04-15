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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>StadiumRegInsertForm.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp%>/css/insertForm.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/scrollBar.css?after">

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	var user_code_id = "<%=user_code_id %>";
	
	var isNameChecked = false;

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
<script type="text/javascript" src="<%=cp %>/js/StadiumRegInsertForm.js?after"></script>

</head>
<body>
<div class="content">
	<form id="joinForm" class="form form--join" method="post" action="StadiumRegInsert.action" enctype="multipart/form-data">
		<input type="hidden" id="user_code_id" name="user_code_id" value="">
		
		<h2 class="form__title">구장 정보 입력</h2>
		
		<div class="form__section">
			<h3 class="form__section-title">기본 정보</h3>
			
			<!-- 구장 이름 입력 -->
			<div class="form__group">
				<div class="form__field">
					<label for="name" class="form__label required">구장 이름</label>
					
					<div class="form__input-wrapper">
						<input type="text" class="form__input" id="name" placeholder="구장이름"
						maxlength="20" name="stadium_reg_name" required data-type="name">
						
						<button type="button" id="checkDuplicateBtn" class="btn btn--check">중복 확인</button>
					</div>
					
					<div class="error">
						<span id="nameCheckMsg" style="font-size: small;"></span>
					</div>
				</div>
			</div>
			
			<!-- 우편번호 -->
			<div class="form__group">
				<div class="form__field">
					<label for="post" class="form__label required">우편번호</label>
					
					<div class="form__input--wrapper">
						<input type="text" class="form__input form__input--sm"
						readonly id="post" required name="stadium_reg_postal_addr">
						<button type="button" class="btn btn--search" onclick="execPostCode()">우편번호 찾기</button>
					</div>
				</div>
			</div>
			
			<!-- 주소 -->
			<div class="form__group">
				<div class="form__field">
					<label for="address" class="form__label required">주소</label>
					
					<div class="form__input--wrapper">
						<input type="text" class="form__input" id="address1"
						placeholder="주소 입력" readonly required name="stadium_reg_addr">
					</div>
				</div>
			</div>
			
			<!-- 상세주소 -->
			<div class="form__group">
				<div class="form__field">
					<label for="address" class="form__label required">상세주소</label>
					
					<div class="form__input--wrapper">
						<input type="text" class="form__input" id="address2"
						placeholder="상세주소 입력" required name="stadium_reg_detailed_addr">
					</div>
				</div>
			</div>
		</div>
		
		<div class="form__group">
			<div class="form__field">
				<label for="image" class="form__label required">첨부파일</label>
				
				<div class="file-upload-wrapper">
					<input type="file" id="image" name="stadium_reg_image" class="file-upload-input" />
					
					<button type="button" class="file-upload-btn" onclick="document.getElementById('image').click();">파일 선택</button>
					
					<span id="file-name" class="file-upload-filename">선택된 파일 없음</span>
				</div>
			</div>
		</div>
		
		<div class="form__group">
			<div class="form__field">
				<label for="operateTime" class="form__label required">운영시간</label>
				
				<div class="form__selection">
					<span class="size-label">시각 시간</span>
					
					<select name="stadium_time_id1" id="stadium_time_id1"
					class=" form__input select-size" style="width: 150px;">
						<option value="">시작 시간 선택</option>
						
						<c:forEach var="stadiumTime1" items="${stadiumTimeList }">
							<option value="${stadiumTime1.stadium_time_id }">${stadiumTime1.stadium_time_at }</option>
						</c:forEach>
					</select>
					
					<span class="size-label">종료 시간</span>
					
					<select name="stadium_time_id2" id="stadium_time_id2"
					class="form__input select-size" style="width: 150px;">
						<option value="">종료 시간 선택</option>
						
						<c:forEach var="stadiumTime2" items="${stadiumTimeList }">
							<option value="${stadiumTime2.stadium_time_id }">${stadiumTime2.stadium_time_at }</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>

		<div class="form__actions">
			<button type="submit" id="submitBtn" class="btn btn--submit">구장 등록</button>
			<button type="button" class="btn btn--back">뒤로가기</button>
		</div>
	</form>
</div>
</body>
</html>