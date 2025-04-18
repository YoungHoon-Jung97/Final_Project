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
<title>비밀번호 확인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>
<body class="d-flex align-items-center justify-content-center vh-100">
    <div class="card shadow" style="width: 400px;">
        <div class="card-body">
            <h5 class="card-title text-center mb-4">비밀번호 확인</h5>
            <form method="post" action="<%=cp%>/CheckPassword.action">
                <div class="mb-3">
                    <label for="userPw" class="form-label">비밀번호</label>
                    <input type="password" class="form-control" id="userPwd" name="user_pwd" required>
                </div>
                <c:if test="${not empty errorMsg}">
                    <div class="text-danger small mb-3">${errorMsg}</div>
                </c:if>
                <div class="d-grid">
                    <button type="submit" class="btn btn-success">확인</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>