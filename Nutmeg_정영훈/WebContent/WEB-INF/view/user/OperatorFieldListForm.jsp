<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OperatorFieldListForm.jsp</title>

</head>
<body>
<div class="match-card1">
	<strong>구장에 소속된 경기장을 확인 해주세요</strong>
</div>

<c:forEach var="field" items="${fieldSearchId}">
	<div class="match-card2">
		<div class="stadium-card">
			<div class="stadium-img-wrapper">
				<img src="${field.field_reg_image}" alt="경기장 이미지" class="stadium-img">
				
				<div class="stadium-info">
					<strong>${field.field_reg_name}</strong>
					등록일 : ${field.field_reg_at}<br>
					가로 : ${field.field_reg_garo}, 세로 : ${field.field_reg_sero}<br>
					바닥 종류 : ${field.field_type}, 환경 : ${field.field_environment_type}<br>
					2시간당 가격 : ${field.field_reg_price}
				</div>
			</div>
			
			<!-- 버튼 -->
			<input type="hidden" name="stadium_reg_id" value="${stadium.stadium_reg_id}">
		</div>
	</div>
</c:forEach>
</body>
</html>