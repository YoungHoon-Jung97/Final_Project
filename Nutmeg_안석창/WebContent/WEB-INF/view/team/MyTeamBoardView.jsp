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
<title>MyTeamBoardView.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/TeamTemplate.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/MyTeamBoardView.css?after">

<script type="text/javascript">

function confirmDelete(id)
{
	if (confirm("정말로 이 게시글을 삭제하시겠습니까?"))
		location.href = "MyTeamBoardDelete.action?id=" + id;
}

</script>

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
							<a href="MyTeam.action">동호회 정보</a>
						</li>
						
						<li class="teampage-link">
							<a href="MyTeamSchedule.action">동호회 매치 일정</a>
						</li>
						
						<li class="teampage-link">
							<a href="MyTeamFee.action">동호회 가계부</a>
						</li>
						
						<li class="teampage-link">
							<a href="MyTeamBoard.action">동호회 게시판</a>
						</li>
					</ul>
					
					<!-- 게시글 상세 보기 시작 -->
					<div class="board-view-container">
						<div class="board-info">
							<div class="board-info-item" style="margin-bottom: 5px; color: black;">
								<h2>${teamBoard.team_board_title}</h2>
							</div>
							
							<div class="board-info-item">
								<div class="board-info-item">
									<strong>작성자:</strong> ${teamBoard.user_nick_name}
								</div>
								
								<strong>작성일:</strong>
								<fmt:formatDate value="${teamBoard.team_board_create_at}"
								pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
							</div>
						</div>
						
						<div class="board-content">${teamBoard.team_board_content}</div>
						
						<div class="board-buttons">
							<a href="MyTeamBoard.action" class="btn btn-list">목록</a>
							
							<c:if test="${teamBoard.team_member_id == team_member_id}">
								<a href="MyTeamBoardUpdate.action?id=${teamBoard.team_board_id}" class="btn">수정</a>
								<a href="javascript:void(0);" onclick="confirmDelete(${teamBoard.team_board_id})"
								class="btn" style="background-color: #dc3545;">삭제</a>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
</div>
</body>
</html>