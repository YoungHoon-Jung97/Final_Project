<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp =	request.getContextPath();
%>
<%
    // 세션에서 로그인 정보를 확인
    // (LoginCheck.jsp 등에서 session.setAttribute("userSid", dto.getSid()); 한 값)
    Integer userSid = (Integer) session.getAttribute("userSid");
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");

    // 로그인되어 있지 않은 경우(세션이 없거나 만료 등)
    if (userSid == null || userSid == 0)
    {
        // 로그인 페이지로 리다이렉트
        response.sendRedirect("Login.action");
        return; // 이하 코드 실행 방지
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main.jsp</title>

<link rel="stylesheet" type="text/css" href="css/main.css">
<style type="text/css">

	body
	{
		font-family: 'Poppins', sans-serif;
		font-weight: 300;
		font-size: 15px;
		line-height: 1.7;
		background-image: url("images/background.png");
		background-size: cover;
		background-position: center center;
		background-attachment: fixed;
		overflow-x: hidden;
		overflow-y: hidden;
		width: 100%;
		min-height: 100vh;
		display: grid;
		place-items: center;
		margin: 0;
	}

</style>

<script type="text/javascript">

	function Submit()
	{
		document.getElementById("form").submit();
	}

</script>

</head>
<body>
<br><br><br><br>

<div>
	<h1>
		안녕하세요, <strong><%= userName %></strong>님!<br>
		이메일: <%= userEmail %>
	</h1>
</div>

<br><br><br><br>

<form action="Template.action" method="get" id="form">
	<button type="button" onclick="Submit()">로그아웃</button>
</form>

</body>
</html>