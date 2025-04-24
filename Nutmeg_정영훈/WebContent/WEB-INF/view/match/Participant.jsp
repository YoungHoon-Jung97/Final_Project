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
<title>Participant.jsp</title>

<style type="text/css">

/* 컨테이너: 흰색 박스 */
.member-container
{
	width: 95vw; /* 화면 기준 너비로 */
	max-width: 1280px;
	background-color: #ffffff;
	border-radius: 16px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
	overflow: hidden;
	padding: 30px 40px;
	box-sizing: border-box;
}

/* 상단 타이틀 */
.member-title
{
	text-align: center;
	font-size: 28px;
	font-weight: bold;
	color: #2e7d32;
	margin-bottom: 30px;
}

/* 헤더 */
.member-header
{
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	background-color: #7dcfb6;
	color: #fff;
	font-weight: 600;
	text-align: center;
	padding: 14px 0;
	font-size: 15px;
	border-radius: 12px;
	margin-bottom: 10px;
}

/* 각 참가자 행 */
.member-row
{
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	text-align: center;
	padding: 14px 0;
	border-bottom: 1px solid #eee;
	transition: background-color 0.2s ease;
}

.member-row:hover
{
	background-color: #f9f9f9;
}

.member-row .col
{
	font-size: 15px;
	color: #333;
	word-break: keep-all;
}

/* 비어있는 경우 메시지 */
.empty-row
{
	text-align: center;
	padding: 50px 0;
	color: #999;
	font-size: 16px;
}

</style>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<div class="main-background">
	<main>
		<div class="member-container">
			<div class="member-title">매치 참가 인원</div>
			
			<div class="member-header">
				<div class="col">이름</div>
				<div class="col">포지션</div>
				<div class="col">나이</div>
				<div class="col">성별</div>
			</div>
			
			<c:choose>
				<c:when test="${not empty paticipantList}">
					<c:forEach var="paticipant" items="${paticipantList}">
						<div class="member-row">
							<div class="col">${paticipant.user_nick_name}</div>
							<div class="col">${paticipant.position_name}</div>
							<div class="col">${paticipant.age}</div>
							<div class="col">${paticipant.gender}</div>
						</div>
					</c:forEach>
				</c:when>
				
				<c:otherwise>
					<div class="empty-row">참가한 인원이 없습니다.</div>
				</c:otherwise>
			</c:choose>
		</div>
	</main>
	
	<c:import url="/WEB-INF/view/Footer.jsp"></c:import>
</div>
</body>
</html>