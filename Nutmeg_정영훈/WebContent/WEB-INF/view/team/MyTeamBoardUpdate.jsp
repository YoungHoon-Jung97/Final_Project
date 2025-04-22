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
<title>MyTeamBoardUpdate.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/TeamTemplate.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/MyTeamBoardWrite.css?after">

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<div class="main-background">
	<main>
		<div class="container">
			<div class="main">
				<div class="main-content">
					<ul class="team-menu">
						<li class="teampage-link">
							<a href="TeamMain.action">동호회 정보</a>
						</li>
						
						<li class="teampage-link">
							<a href="TeamSchedule.action">동호회 매치 일정</a>
						</li>
						
						<li class="teampage-link">
							<a href="TeamFee.action">동호회 가계부</a>
						</li>
						
						<li class="teampage-link">
							<a href="TeamBoard.action">동호회 게시판</a>
						</li>
					</ul>
					
					<!-- 게시글 작성 폼 시작 -->
					<div class="write-form-container">
						<div class="board-header">
							<div class="board-title">게시물 수정</div>
						</div>
						
						<form action="TeamBoardInsert.action" method="post">
							<div class="form-group">
								<label for="title">제목</label>
								
								<input type="text" id="title" name="team_board_title"
								class="form-control" placeholder="제목을 입력하세요" required>
							</div>
							
							<div class="form-group">
								<label for="content">내용</label>
								
								<textarea id="content" name="team_board_content" class="form-control"
								placeholder="내용을 입력하세요" style="resize: none;" required></textarea>
							</div>
							
							<div class="form-buttons">
								<button type="button" class="btn btn-cancel" onclick="location.href='MyTeamBoard.action'">취소</button>
								<button type="submit" class="btn">수정</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>
</div>
</body>
</html>