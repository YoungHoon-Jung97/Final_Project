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
<title>Footer.jsp</title>

<style type="text/css">

	footer
	{
		background-color: #343a40;
		color: #ffffff;
		padding: 20px 0;
		margin-top: 50px;
	}
	
	footer a
	{
		color: #ff7f50;
	}

</style>

</head>
<body>
<footer>
	<div class="container d-flex justify-content-between">
		<div>고객문의 : 정영훈 팀장 010-1234-5678</div>
		
		<div class="text-end">
			기술지원 : 3443-7262<br>
			도입문의 : <a href="mailto:kms7262@naver.com">kms7262@naver.com</a><br>
			팀번호 : 2team<br>
			COPYRIGHT ⓒ 2025. SSANGYOUNG
		</div>
	</div>
</footer>
</body>
</html>