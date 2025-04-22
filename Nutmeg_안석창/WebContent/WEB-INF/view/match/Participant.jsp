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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/team/MemberListScore.css">

</head>
<body>
<table class="team-table">
	<caption>동호회 회원 정보</caption>
	
	<colgroup>
		<col style="width: 25%">
		<col style="width: 25%">
		<col style="width: 25%">
		<col style="width: 25%">
	</colgroup>
	
	<thead>
		<tr class="center">
			<th>이름</th>
			<th>포지션</th>
			<th>나이</th>
			<th>성별</th>
		</tr>
	</thead>
	
	<tbody class="center">
		<c:forEach var="paticipant" items="${paticipantList}">
			<tr>
				<td>${paticipant.user_nick_name}</td>
				<td>${paticipant.position_name}</td>
				<td>${paticipant.age}</td>
				<td>${paticipant.gender}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

</body>
</html>