<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/stadium/StadiumFieldCheckForm.css?after">

<h4 class="mb-4">경기장 승인, 취소 내역</h4>

<div class="approval">
	<h5 class="mb-4">경기장 승인 목록</h5>
	
	<c:choose>
		<c:when test="${empty fieldApprOkList}">
			<div class="alert alert-info">승인된 경기장이 없습니다.</div>
		</c:when>
		
		<c:otherwise>
			<c:forEach var="ok" items="${fieldApprOkList}">
				<div class="match-card">
					<div class="stadium-card">
						<div class="stadium-img-wrapper">
							<img src="${ok.field_reg_image}" alt="경기장 이미지" class="stadium-img">
							
							<div class="stadium-info">
								<strong>${ok.field_reg_name}</strong><br>
								경기장 이름 : ${ok.field_reg_name}<br>
								경기장 승인 신청일 : ${ok.field_reg_at}<br>
								경기장 승인 허가일 : ${ok.field_appr_at}
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</div>

<hr style="margin: 25px 0 20px 0;">

<div class="return">
	<h5 class="mb-4">경기장 취소 목록</h5>
	
	<c:choose>
		<c:when test="${empty fieldApprCancelList}">
			<div class="alert alert-info">취소된 경기장이 없습니다.</div>
		</c:when>
		
		<c:otherwise>
			<c:forEach var="cancel" items="${fieldApprCancelList}">
				<div class="match-card">
					<div class="stadium-card">
						<div class="stadium-img-wrapper">
							<img src="${cancel.field_reg_image}" alt="경기장 이미지" class="stadium-img">
							
							<div class="stadium-info">
								<strong>${cancel.field_reg_name}</strong><br>
								경기장 이름 : ${cancel.field_reg_name}<br>
								경기장 승인 신청일 : ${cancel.field_reg_at}<br>
								경기장 승인 반려일 : ${cancel.field_appr_cancel_at}
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</div>