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
<title>게시글 상세</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/TeamMain.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/TeamTemplate.css?after">
<style type="text/css">
/*팀 메뉴 넘어갔을 때 표시*/
.teampage-link:nth-child(4) a {
    color: #a8d5ba;
    border-bottom: 2px solid #a8d5ba;
}

/* 게시글 상세 보기 스타일 */
.board-view-container {
    width: 100%;
    margin: 20px 0;
}

.board-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.board-title {
    font-size: 24px;
    font-weight: bold;
}

.btn {
    background-color: #a8d5ba;
    color: white;
    border: none;
    padding: 8px 15px;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
    margin-left: 10px;
    text-decoration: none;
}

.btn:hover {
    background-color: #8bc5a1;
}

.btn-list {
    background-color: #6c757d;
}

.btn-list:hover {
    background-color: #5a6268;
}

.board-info {
    background-color: #f8f8f8;
    padding: 15px;
    border-radius: 5px;
    margin-bottom: 20px;
}

.board-info-item {
    display: inline-block;
    margin-right: 20px;
    color: #666;
}

.board-content {
    min-height: 300px;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 5px;
    margin-bottom: 20px;
    line-height: 1.6;
}

.board-buttons {
    text-align: right;
    margin-top: 20px;
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
                
                <!-- 게시글 상세 보기 시작 -->
                <div class="board-view-container">
                    <div class="board-header">
                        <div class="board-title">공지사항</div>
                    </div>
                    
                    <h2>${teamBoard.team_board_title}</h2>
                    
                    <div class="board-info">
                        <div class="board-info-item">
                            <strong>작성자:</strong> ${teamBoard.user_nick_name}
                        </div>
                        <div class="board-info-item">
                            <strong>작성일:</strong> 
                            <fmt:formatDate value="${teamBoard.team_board_create_at}" pattern="yyyy-MM-dd HH:mm" />
                        </div>
                    </div>
                    
                    <div class="board-content">
                        ${teamBoard.team_board_content}
                    </div>
                    
                    <div class="board-buttons">
                        <a href="MyTeamBoard.action" class="btn btn-list">목록</a>
                        <c:if test="${teamBoard.team_member_id == team_member_id}">
                            <a href="MyTeamBoardUpdate.action?id=${teamBoard.team_board_id}" class="btn">수정</a>
                            <a href="javascript:void(0);" onclick="confirmDelete(${teamBoard.team_board_id})" class="btn" style="background-color: #dc3545;">삭제</a>
                        </c:if>
                    </div>
                </div>
                <!-- 게시글 상세 보기 끝 -->
            </div>
            <!-- .main-content -->
        </div>
        <!-- .main  -->
    </section>
</div>

<script>
function confirmDelete(id) {
    if (confirm("정말로 이 게시글을 삭제하시겠습니까?")) {
        location.href = "MyTeamBoardDelete.action?id=" + id;
    }
}
</script>
</body>
</html>