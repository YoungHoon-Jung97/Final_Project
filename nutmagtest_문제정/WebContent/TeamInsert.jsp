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
<title>동호회 개설</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<style>
    body {
        font-family: Arial, sans-serif;
    }
    .container {
        width: 400px;
        margin: 50px auto;
    }
    h1 {
        font-size: 22px;
        font-weight: bold;
        text-align: left;
    }
    label {
        display: block;
        font-size: 16px;
        font-weight: bold;
        margin-top: 15px;
        text-align: left;
    }
    input[type="text"] {
        width: 108%;
        padding: 12px;
        margin-top: 5px;
        border: none;
        background-color: #f4a261;
        border-radius: 5px;
        font-size: 16px;
    }
    .buttons {
        display: flex;
        justify-content: left;
        gap: 10px;
        flex-wrap: wrap;
        margin-top: 10px;
    }
    .weekday-buttons, .time-buttons {
        display: flex;
        justify-content: left;
        gap: 10px;
    }
    button {
        background-color: #f4a261;
        border: none;
        padding: 12px 20px;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
    }
   .nav-button {
        width: 48%;
        background-color: #14213d;
        color: white;
        font-size: 18px;
        padding: 12px;
        border-radius: 5px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
    }
    .active {
        background-color: #e76f51;
        color: white;
    }
</style>
<script>
    function toggleButton(button) {
        button.classList.toggle('active');
    }
</script>
</head>
<body>
    <div class="container">
        <h1>동호회 개설</h1>
        <label>동호회 이름</label>
        <input type="text">
        <label>활동 요일</label>
        <div class="weekday-buttons">
            <button onclick="toggleButton(this)">월</button>
            <button onclick="toggleButton(this)">화</button>
            <button onclick="toggleButton(this)">수</button>
            <button onclick="toggleButton(this)">목</button>
            <button onclick="toggleButton(this)">금</button>
            <button onclick="toggleButton(this)">토</button>
            <button onclick="toggleButton(this)">일</button>
        </div>
        <label>활동 시간대</label>
        <div class="time-buttons">
            <button onclick="toggleButton(this)">아침</button>
            <button onclick="toggleButton(this)">낮</button>
            <button onclick="toggleButton(this)">저녁</button>
            <button onclick="toggleButton(this)">심야</button>
        </div>
        <a href="test2.jsp" class="nav-button">다음</a>
    </div>
</body>
</html>
