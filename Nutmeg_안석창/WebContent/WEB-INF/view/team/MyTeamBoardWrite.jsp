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
<title>게시글 작성</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/TeamMain.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/TeamTemplate.css?after">
<style type="text/css">
/*팀 메뉴 넘어갔을 때 표시*/
.teampage-link:nth-child(4) a {
    color: #a8d5ba;
    border-bottom: 2px solid #a8d5ba;
}

/* 게시글 작성 폼 스타일 */
.write-form-container {
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

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}

.form-control {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
}

textarea.form-control {
    min-height: 300px;
    resize: vertical;
}

.form-buttons {
    text-align: right;
    margin-top: 20px;
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
}

.btn:hover {
    background-color: #8bc5a1;
}

.btn-cancel {
    background-color: #6c757d;
}

.btn-cancel:hover {
    background-color: #5a6268;
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
                
                <!-- 게시글 작성 폼 시작 -->
                <div class="write-form-container">
                    <div class="board-header">
                        <div class="board-title">공지사항 작성</div>
                    </div>
                    
                    <form action="TeamBoardInsert.action" method="post" onsubmit="return validateForm()">
                        <div class="form-group">
                            <label for="title">제목</label>
                            <input type="text" id="title" name="team_board_title" class="form-control" placeholder="제목을 입력하세요" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="content">내용</label>
                            <textarea id="content" name="team_board_content" class="form-control" placeholder="내용을 입력하세요" required></textarea>
                        </div>
                        
                        <div class="form-buttons">
                            <button type="button" class="btn btn-cancel" onclick="location.href='MyTeamBoard.action'">취소</button>
                            <button type="submit" class="btn">등록</button>
                        </div>
                    </form>
                </div>
                <!-- 게시글 작성 폼 끝 -->
            </div>
            <!-- .main-content -->
        </div>
        <!-- .main  -->
    </section>
</div>

<script>
function validateForm() {
    var title = document.getElementById("title").value;
    var content = document.getElementById("content").value;
    
    if (title.trim() === "") {
        alert("제목을 입력해주세요.");
        return false;
    }
    
    if (content.trim() === "") {
        alert("내용을 입력해주세요.");
        return false;
    }
    
    return true;
}
</script>
</body>
</html>