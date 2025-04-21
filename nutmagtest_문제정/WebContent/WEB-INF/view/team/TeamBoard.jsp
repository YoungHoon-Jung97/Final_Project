<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 게시판</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/TeamMain.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/TeamTemplate.css?after">
<style type="text/css">
/*팀 메뉴 넘어갔을 때 표시*/
.teampage-link:nth-child(4) a {
    color: #a8d5ba;
    border-bottom: 2px solid #a8d5ba;
}

/* 게시판 스타일 */
.board-container {
    width: 100%;
    margin: 20px 0;
}

.board-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}

.board-title {
    font-size: 24px;
    font-weight: bold;
}

.write-btn {
    background-color: #a8d5ba;
    color: white;
    border: none;
    padding: 8px 15px;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
}

.write-btn:hover {
    background-color: #8bc5a1;
}

.board-table {
    width: 100%;
    border-collapse: collapse;
}

.board-table th, .board-table td {
    padding: 12px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

.board-table th {
    background-color: #f8f8f8;
    font-weight: bold;
}

.board-table tr:hover {
    background-color: #f5f5f5;
}

.board-table .title-cell {
    text-align: center;
}

.board-table .title-cell a {
    color: #333;
    text-decoration: none;
}

.board-table .title-cell a:hover {
    color: #a8d5ba;
    text-decoration: underline;
}

.pagination {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}

.pagination a {
    color: #333;
    padding: 8px 12px;
    text-decoration: none;
    border: 1px solid #ddd;
    margin: 0 4px;
}

.pagination a.active {
    background-color: #a8d5ba;
    color: white;
    border: 1px solid #a8d5ba;
}

.pagination a:hover:not(.active) {
    background-color: #f5f5f5;
}

.page-info {
    text-align: right;
    margin-bottom: 10px;
    font-size: 14px;
    color: #666;
}
</style>
</head>
<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>
<div class="container">
    <section>
        <div class="main">
            <div class="main-content">
                <ul class="team-menu">
                    <li class="teampage-link"><a href="MyTeam.action">팀 정보</a></li>
                    <li class="teampage-link"><a href="MyTeamSchedule.action">팀 매치</a></li>
                    <li class="teampage-link"><a href="MyTeamFee.action">팀 가계부</a></li>
                    <li class="teampage-link"><a href="MyTeamBoard.action">팀 게시판</a></li>
                </ul>
                <!-- .team-menu -->
                
                <!-- 게시판 시작 -->
                <div class="board-container">
                    <div class="board-header">
                        <div class="board-title">공지사항</div>
                        <button class="write-btn" onclick="location.href='TeamBoardWrite.action'">글쓰기</button>
                    </div>
                    
                    <!-- 페이징 정보 -->
                    <div class="page-info">
                        전체 ${totalCount}개 글, ${currentPage} / ${totalPage} 페이지
                    </div>
                    
                    <table class="board-table">
                        <thead>
                            <tr>
                                <th width="8%">번호</th>
                                <th width="50%">제목</th>
                                <th width="14%">작성자</th>
                                <th width="20%">작성일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty teamBoardList}">
                                <tr>
                                    <td colspan="4" style="text-align: center;">등록된 게시글이 없습니다.</td>
                                </tr>
                            </c:if>
                            
                            <c:forEach var="teamBoard" items="${teamBoardList}" varStatus="status">
                                <tr>
                                    <td>${teamBoard.rnum}</td>
                                    <td class="title-cell">
                                        <a href="SearchTeamBoard.action?id=${teamBoard.team_board_id}" >
                                            ${teamBoard.team_board_title}
                                        </a>
                                    </td>
                                    <td>${teamBoard.user_nick_name}</td>
                                    <td>
                                        <fmt:formatDate value="${teamBoard.team_board_create_at}" pattern="yyyy-MM-dd" />
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    
                    <!-- 페이징 -->
                    <div class="pagination">
                        ${pageHtml}
                    </div>
                </div>
                <!-- 게시판 끝 -->
            </div>
            <!-- .main-content -->
        </div>
        <!-- .main  -->
    </section>
</div>
</body>
</html>