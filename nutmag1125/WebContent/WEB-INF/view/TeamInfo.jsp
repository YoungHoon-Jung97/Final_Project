<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<jsp:include page="test7.jsp" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>팀 정보 페이지</title>
<style>
    body {
        font-family: Arial, sans-serif;
    }
    .container {
        width: 80%;
        margin: 0 auto;
        text-align: center;
    }
    .team-header {
        background-color: #E74C3C;
        color: white;
        padding: 20px;
        border-radius: 10px;
        margin-bottom: 20px;
    }
    .team-header img {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        margin-bottom: 10px;
    }
    .team-info {
        background-color: #f9f9f9;
        padding: 15px;
        border-radius: 10px;
        text-align: left;
        display: inline-block;
        width: 100%;
    }
    .team-info p {
        margin: 5px 0;
        padding: 5px;
        border-bottom: 1px solid #ddd;
    }
    .team-members {
        margin-top: 20px;
    }
    .team-members table {
        width: 100%;
        border-collapse: collapse;
    }
    .team-members th, .team-members td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
    }
    .team-members th {
        background-color: #eee;
    }
    .btn {
        padding: 10px 15px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-top: 10px;
    }
    .btn-edit {
        background-color: #E74C3C;
        color: white;
    }
</style>
</head>
<body>
<div class="container">
    <div class="team-header">
        <img src="images/soccer.jpg" alt="팀 로고">
        <h2>프링글스</h2>
        <p>0전 0승 0무 0패</p>
    </div>
    <div class="team-info">
        <p><strong>지역:</strong> 서울-양정</p>
        <p><strong>활동구장:</strong> 남서울대학교</p>
        <p><strong>팀 유형:</strong> 일반동호회</p>
        <p><strong>평균연령:</strong> 20대</p>
        <p><strong>경기유형:</strong> 풋살</p>
        <p><strong>실력:</strong> 하</p>
        <p><strong>유니폼:</strong> 빨간색입니다.</p>
        <p><strong>팀원 수:</strong> 6명</p>
        <p><strong>간단한 팀 소개:</strong> 즐겁게 차시죠~</p>
    </div>
    <div class="team-members">
        <h3>팀원 정보</h3>
        <table>
            <tr>
                <th>이름(아이디)</th>
                <th>포지션</th>
                <th>역할</th>
            </tr>
            <tr>
                <td>박세진 (gkdltb2@naver.com)</td>
                <td>CB</td>
                <td>팀 개설자</td>
            </tr>
        </table>
    </div>
    <button class="btn btn-edit">팀 정보 수정</button>
</div>
</body>
</html>