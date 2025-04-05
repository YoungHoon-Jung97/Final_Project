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
<title>MatchingRoomCreate.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">

</head>
<body>
<div>
	<h1>풋살 매칭 방 생성</h1>
	<hr>
</div>

<div>
	<form action="MatchingRoom.jsp" method="POST">
		<label for="roomName">방 이름:</label> <input type="text" id="roomName"
			name="roomName" required><br>
		<br> <label for="roomDescription">방 설명:</label> <input
			type="text" id="roomDescription" name="roomDescription" required><br>
		<br>

		<button type="submit">방 생성</button>
	</form>
</div>
</body>
</html>