<%@ page contentType="text/html; charset=UTF-8" %>
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
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<h2>구장 이미지</h2>

<c:forEach var="dto" items="${stadiumList}">
    <div style="margin-bottom: 20px;">
        <p><strong>${dto.stadium_reg_name}</strong></p>
        <p>이미지 경로: ${dto.stadium_reg_image}</p>
        <img src="<%=cp %>${dto.stadium_reg_image}" style="width:300px;">
    </div>
</c:forEach>

</body>
</html>