<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<script type="text/javascript" src="<%=cp %>/js/OperatorStadiumUpdateForm.js?after"></script>

<div class="match-card1">
	<strong>변경할 구장 정보를 입력하세요</strong>
</div>

<c:forEach var="stadium" items="${stadiumSearchList}">
	<form class="stadium-update-form" method="post" action="OperatorStadiumUpdate.action" enctype="multipart/form-data">
		<input type="hidden" name="stadium_reg_id" value="${stadium.stadium_reg_id}">
		<input type="hidden" name="user_code_id" value="${sessionScope.user_code_id}">
		
		<div class="form-group">
			<label>구장 이름</label>
			
			<div class="d-flex">
				<input type="text" class="form-control stadium-name" value="${stadium.stadium_reg_name}"
				name="stadium_reg_name" required>
				
				<button type="button" class="btn btn-outline-secondary check-dup-btn">중복 확인</button>
			</div>
			
			<span class="name-check-msg text-sm text-danger"></span>
		</div>
		
		<div class="error">
			<span id="nameCheckMsg" style="font-size: small;"></span>
		</div>
		
		<!-- 주소 필드들 -->
		<div class="form-group">
			<label>우편번호</label>
			
			<div class="d-flex">
				<input type="text" class="form-control post" name="stadium_reg_postal_addr" readonly>
				
				<button type="button" class="btn btn-outline-primary search-post-btn">우편번호 찾기</button>
			</div>
		</div>
		
		<div class="form-group">
			<label>주소</label>
			
			<input type="text" class="form-control address1" name="stadium_reg_addr" readonly>
			<input type="text" class="form-control address2" name="stadium_reg_detailed_addr">
		</div>
		
		<!-- 시간 -->
		<div class="form-group">
			<label>운영 시간</label>
			
			<select class="form-control time-start" name="stadium_time_id1">
				<option value="">시작 시간</option>
				
				<c:forEach var="t" items="${stadiumTimeList}">
					<option value="${t.stadium_time_id}">${t.stadium_time_at}</option>
				</c:forEach>
			</select>
			
			<select class="form-control time-end" name="stadium_time_id2">
				<option value="">종료 시간</option>
				
				<c:forEach var="t" items="${stadiumTimeList}">
					<option value="${t.stadium_time_id}">${t.stadium_time_at}</option>
				</c:forEach>
			</select>
		</div>
		
		<!-- 이미지 -->
		<div class="form-group">
			<label>이미지</label>
			
			<input type="file" class="form-control image" name="stadium_reg_image">
		</div>
		
		<button type="submit" class="btn btn-success submit-btn">저장</button>
	</form>
</c:forEach>