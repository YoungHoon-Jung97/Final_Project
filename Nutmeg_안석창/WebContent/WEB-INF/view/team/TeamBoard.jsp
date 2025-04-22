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
<title>TeamBoard.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/team/TeamTemplate.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/team/TeamBoard.css?after">

<script type="text/javascript" src="<%=cp %>/js/TeamBoard.js?after"></script>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<div class="main-background">
	<main>
		<div class="container-fluid container">
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
					
					<div class="board-container">
						<div class="section-header text-center mt-5">
							<h1 class="display-5 fw-bold text-success">📄 동호회 게시판</h1>
							
							<p class="text-muted mt-2">우리 팀의 소식을 한눈에 확인해보세요!</p>
							
							<div class="underline mt-3 mx-auto"></div>
						</div>
						
						<button class="write-btn" onclick="location.href='MyTeamBoardWrite.action'">글쓰기</button>
						
						<!-- 페이징 정보 -->
						<c:if test="${not empty totalCount and totalCount > 0}">
							<div class="page-info">
								전체 ${totalCount}개 글
							</div>
						</c:if>
						
						<table class="board-table">
							<thead>
								<tr>
									<th width="10%">번호</th>
									<th width="60%">제목</th>
									<th width="15%">작성자</th>
									<th width="15%">작성일</th>
								</tr>
							</thead>
							
							<tbody>
								<c:if test="${empty teamBoardList}">
									<tr>
										<td colspan="4" style="text-align: center;">등록된 게시글이 없습니다.</td>
									</tr>
								</c:if>
								
								<c:forEach var="teamBoard" items="${teamBoardList}" varStatus="status">
									<tr class="clickable-row" data-href="SearchTeamBoard.action?id=${teamBoard.team_board_id}">
										<td>${teamBoard.rnum}</td>
										<td class="title-cell">
												${teamBoard.team_board_title}
										</td>
										<td>${teamBoard.user_nick_name}</td>
										<td>
											<fmt:formatDate value="${teamBoard.team_board_create_at}" pattern="yyyy-MM-dd"></fmt:formatDate>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						
						<!-- 페이징 -->
						<div class="pagination">${pageHtml}</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	
	<c:import url="/WEB-INF/view/Footer.jsp"></c:import>
</div>
</body>
</html>