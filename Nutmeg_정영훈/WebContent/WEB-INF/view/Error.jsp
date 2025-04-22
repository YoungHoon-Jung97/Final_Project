<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>404 - 페이지를 찾을 수 없습니다</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/util/error.css?after">

</head>
<body>
	<!-- 귀여운 에러 아이콘 이미지 -->
	<img src="<%=cp%>/images/sad-glasses.png" alt="404" style="width: 120px;">
	
	<div class="error-title">404</div>
	<div class="error-subtitle">SORRY, PAGE NOT FOUND T T</div>
	<div class="error-description">
		찾으시는 페이지가 이동되었거나 삭제되었거나,<br> 존재하지 않는 페이지입니다.
	</div>
	
	<a href="<%=cp%>/" class="go-home-btn">메인으로 이동</a>
</body>
</html>
