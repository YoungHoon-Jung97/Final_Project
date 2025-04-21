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
<link rel="stylesheet" type="text/css" href="css/MemberListScore.css">
<!-- Bootstrap Icons CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

</head>
<body>

<!-- 종 아이콘 -->
<i class="bi bi-bell"></i>   <!-- 빈 종 -->
<i class="bi bi-bell-fill"></i>   <!-- 채워진 종 -->
<i class="bi bi-bell-slash"></i>   <!-- 알림 꺼짐 -->
</body>
</html>