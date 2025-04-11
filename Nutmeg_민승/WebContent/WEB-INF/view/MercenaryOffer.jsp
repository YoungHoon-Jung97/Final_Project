<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>용병 게시판</title>

    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <c:import url="/WEB-INF/view/Template.jsp"></c:import>
    <link rel="stylesheet" type="text/css" href="<%=cp %>/css/modal.css?after">
    <link rel="stylesheet" type="text/css" href="<%=cp %>/css/scrollBar.css?after">
    <link rel="stylesheet" type="text/css" href="<%=cp %>/css/MainPage.css?after">

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="<%=cp %>/js/MainPage.js?after"></script>

    <style>
    body {
        margin: 0;
        padding: 0;
        background-color: #f5f5f5;
        font-family: Arial, sans-serif;
        color: #333;
    }
    .merc-container {
        width: 1070px;
        max-width: 90%;
        margin: 30px auto;
        background-color: #fff;
        padding: 40px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    .merc-container h1 {
        margin: 0 0 30px;
        font-size: 1.8em;
        color: #444;
        text-align: center;
    }
    .search-area {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-bottom: 30px;
    }
    .search-area select,
    .search-area input[type="text"] {
        padding: 10px 12px;
        font-size: 1em;
        border: 1px solid #ccc;
        border-radius: 4px;
        background-color: #fff;
        color: #333;
    }
    .search-area button {
        padding: 10px 20px;
        font-size: 1em;
        border: 1px solid #ccc;
        border-radius: 4px;
        background-color: #fff;
        color: #333;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    .search-area button:hover {
        background-color: #eee;
    }
    .table {
        display: table;
        width: 100%;
        border-collapse: collapse;
    }
    .table-header {
        display: table-header-group;
        background-color: #fafafa;
    }
    .table-row {
        display: table-row;
        border-bottom: 1px solid #eee;
    }
    .table-cell {
        display: table-cell;
        padding: 15px;
        text-align: center;
        font-size: 1em;
    }
    .btn-hire {
        padding: 8px 16px;
        background-color: #333;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    .btn-hire:hover {
        background-color: #555;
    }
    .merc-name a {
        color: inherit;
        text-decoration: none;
        font-weight: bold;
    }
    .merc-name a:hover {
        text-decoration: underline;
    }
    .pagination {
        margin-top: 30px;
        text-align: center;
    }
    .pagination a,
    .pagination span {
        margin: 0 4px;
        padding: 6px 12px;
        text-decoration: none;
        color: #333;
        font-weight: bold;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    .pagination a:hover {
        background-color: #eee;
    }
    .pagination span {
        color: red;
        background-color: #f0f0f0;
    }
    </style>
</head>
<body>

    <!-- 본문 컨테이너 -->
    <div class="merc-container">
        <h1>용병 게시판</h1>

        <!-- 검색 -->
        <form action="MercenaryOffer.action" method="get" class="search-area">
            <select name="searchField">
                <option value="user_name">이름</option>
                <option value="position_name">포지션</option>
                <option value="time">선호시간</option>
            </select>
            <input type="text" name="searchKeyword" placeholder="검색어 입력">
            <button type="submit">검색</button>
        </form>

        <!-- 리스트 출력 -->
        <div class="table">
            <div class="table-header table-row">
                <div class="table-cell">이름</div>
                <div class="table-cell">포지션</div>
                <div class="table-cell">선호시간</div>
                <div class="table-cell">고용</div>
            </div>

            <c:forEach var="dto" items="${list}">
                <div class="table-row">
                    <div class="table-cell">${dto.user_name}</div>
                    <div class="table-cell">${dto.position_name}</div>
                    <div class="table-cell">${dto.mercenary_time_start_at}</div>
                    <div class="table-cell">
                        <button class="btn-hire">고용</button>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- 페이지네이션 -->
        <c:if test="${totalPages >= 1}">
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="?page=1&searchField=${param.searchField}&searchKeyword=${param.searchKeyword}">&laquo;</a>
                </c:if>
                <c:if test="${startPage > 1}">
                    <a href="?page=${startPage - 1}&searchField=${param.searchField}&searchKeyword=${param.searchKeyword}">&lt;</a>
                </c:if>
                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span>${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="?page=${i}&searchField=${param.searchField}&searchKeyword=${param.searchKeyword}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${endPage < totalPages}">
                    <a href="?page=${endPage + 1}&searchField=${param.searchField}&searchKeyword=${param.searchKeyword}">&gt;</a>
                </c:if>
                <c:if test="${currentPage < totalPages}">
                    <a href="?page=${totalPages}&searchField=${param.searchField}&searchKeyword=${param.searchKeyword}">&raquo;</a>
                </c:if>
            </div>
        </c:if>

    </div>

</body>
</html>
