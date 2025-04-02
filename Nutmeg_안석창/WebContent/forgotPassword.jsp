<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp =	request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forgotPassword.jsp</title>

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
	<h1>그걸 까먹음?ㅋ</h1>
</div>

<br><br><br><br>

<form action="Login.do" method="post" id="form">
	<button type="button" onclick="Submit()">돌아가기</button>
</form>
</body>
</html>