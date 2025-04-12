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
<title>팀 정보</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/Team.css">
<style type="text/css">
/*팀 메뉴 넘어갔을 때 표시*/
.teampage-link:nth-child(4) a {
    color: #a8d5ba;
    border-bottom: 2px solid #a8d5ba;
}
</style>
</head>
<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>
<div class="container">
	<section>
		<div class="main">
			<div class="main-content">
				<ul class="tean-menu">
					<li class="teampage-link"><a href="MyTeam.action">팀 정보</a></li>
					<li class="teampage-link"><a href="MyTeamSchedule.action">팀 매치</a></li>
					<li class="teampage-link"><a href="MyTeamFee.action">팀 가계부</a></li>
					<li class="teampage-link"><a href="MyTeamBoard.action">팀 게시판</a></li>
				</ul>
				<!-- .tean-menu -->

				<div class="team-info-wrap">

					<div class="left">
						<div class="team_box">
							<div class="team01">
								<p class="img">
									<img src="" alt="" />
								</p>
								<dt>팀 이름</dt>
								<dd>경기 판수</dd>
							</div>
							<div class="team02">
								<ul>
									<li></li>
								</ul>
								<p class="comment">설명없음</p>
							</div>
						</div>
					</div>

					<div class="right">
						<table class="team-table">
							<caption>팀원정보</caption>
							<colgroup>
								<col style="width: 45%" />
								<col style="width: 10%" />
								<col style="width: 15%" />
								<col style="width: 30%" />
							</colgroup>
							<thead>
								<tr class="center">
									<th>이름</th>
									<th>포지션</th>
									<th>역할</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody class="center">
								<tr>
									<td>정영훈</td>
									<td></td>
									<td>팀 개설자</td>
									<td></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- .team-info-wrap -->
				<div class="team-modify">
					<a href=""> 
						<span>팀 정보 수정</span>
					</a>
				</div>
			</div>
			<!-- .main-content  -->
		</div>
		<!-- .main  -->
	</section>
</div>


</body>
</html>
