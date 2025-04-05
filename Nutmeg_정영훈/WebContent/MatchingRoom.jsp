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
<title>MatchingRoom.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<style type="text/css">
body {
	font-family: Arial, sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
	background-color: #f4f4f4;
}

.match-room {
	width: 60%;
	display: grid;
	grid-template-columns: 1fr 1fr;
	grid-template-rows: 1fr 1fr;
	gap: 20px;
}

/* 자리 배치 스타일 */
.seat {
	width: 120px;
	height: 120px;
	border-radius: 15px;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 16px;
	font-weight: bold;
	color: white;
	text-align: center;
}

/* 레디 상태 (빨간색) */
.ready {
	background-color: red;
}

/* 대기 상태 (파란색) */
.waiting {
	background-color: blue;
}

/* 빈 자리 */
.empty {
	background-color: gray;
	color: #ddd;
}

.seat-container {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 20px;
}
</style>

</head>
<body>
<div class="match-room">
	<!-- 왼쪽 상단: 2자리 -->
	<div class="seat-container">
		<div class="seat ready">방 생성자 (레디)</div>
		<div class="seat empty">빈 자리</div>
	</div>

	<!-- 왼쪽 하단: 3자리 -->
	<div class="seat-container">
		<div class="seat waiting">대기 상태</div>
		<div class="seat empty">빈 자리</div>
		<div class="seat empty">빈 자리</div>
	</div>

	<!-- 오른쪽 상단: 방 생성자 정보 및 경기 정보 -->
	<div class="seat"
		style="grid-column: 2; grid-row: 1; background-color: lightgray; color: black;">
		<p>방 생성자 정보 및 경기 정보</p>
	</div>

	<!-- 오른쪽 하단: 레디 버튼 -->
	<div class="seat"
		style="grid-column: 2; grid-row: 2; background-color: #4CAF50; color: white; text-align: center;">
		<p>레디 버튼</p>
	</div>
</div>
</body>
</html>