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
<title>팀 목록</title>
<style>
     body {
            font-family: Arial, sans-serif;
        }
        .container1 {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
        }
    .filter-container {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 10px;
        border: 1px solid #ccc;
        margin-bottom: 20px;
    }
    .filter-container select, .filter-container input {
        padding: 5px;
        margin: 0 5px;
    }
	
	
	.filter-container .search-btn {
	    padding: 5px 15px;
	    background-color: #e74c3c;
	    color: white;
	    border: none;
	    cursor: pointer;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    gap: 10px;
	}
    .filter-container .reset-btn {
        padding: 5px 15px;
        border: 1px solid #ccc;
        cursor: pointer;
        display: flex;
        align-items: center;
        background-color: white;
    }
    .reset-btn img {
        width: 15px;
        height: 15px;
        margin-right: 5px;
    }
    .team-list {
        width: 100%;
        margin-top: 20px;
    }
    .team-item {
        padding: 10px;
        border: 1px solid #000;
        margin-bottom: 5px;
        font-weight: bold;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
    }
    .pagination {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }
    .pagination button {
        padding: 10px;
        margin: 0 5px;
        border: 1px solid #000;
        background-color: white;
        cursor: pointer;
    }
</style>
</head>
<body>

<div class="container1">
    <div class="filter-container">
        <label>▪ 팀</label>
        <select>
            <option>전체</option>
            <option>서울</option>
            <option>경기</option>
            <option>부산</option>
            <option>강원</option>
            <option>제주</option>
        </select>

        <label>▪ 연령</label>
        <select>
            <option>전체 연령</option>
            <option>20대</option>
            <option>30대</option>
            <option>40대</option>
            <option>50대</option>
            <option>60대</option>
        </select>

        <input type="text" placeholder="검색어 입력">
        <button class="search-btn">검색</button>
        <button class="reset-btn">
            <img src="soccer.jpg" alt="초기화"> 초기화
        </button>
    </div>

    <!-- 팀 목록 예시 -->
    <div class="team-item header">
        <span>순위</span>
        <span>팀명</span>
        <span>점수</span>
        <span>팀 정보</span>
    </div>

    <div class="team-list">
        <div class="team-item">동호회 명1</div>
        <div class="team-item">동호회 명2</div>
        <div class="team-item">동호회 명3</div>
        <div class="team-item">동호회 명4</div>
    </div>

    <!-- 매칭 신청 페이지로 이동하는 링크 -->
    <a href="MakeMatching.jsp" class="search-btn">매칭 신청 페이지로 이동</a>
</div>

</body>
</html>