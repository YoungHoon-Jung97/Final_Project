<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 정보</title>
<style type="text/css">
/* General Reset */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Nanum Gothic', sans-serif;
}

body {
	background-color: #f5f5f5;
}

/* Main Container */
.main {
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
}

.main-content {
	width: 100%;
}

/* Team Menu */
.tean-menu {
	display:flex; /*영역 나누기*/
	list-style: none;
	border-bottom: 1px solid #ddd;
	margin-bottom: 20px;
}

.teampage-link {
	flex:1; /*부모 여역 균등하게 나누기*/
	text-align: center;
}

.teampage-link a {
	display: block;
	padding: 15px 0;
	text-decoration: none;
	color: #333;
	font-weight: bold;
	transition: all 0.3s;
}

/*팀 메뉴 넘어갔을 때 표시*/
.teampage-link:first-child a {
	color: #ff4500;
	border-bottom: 2px solid #ff4500;
}

.teampage-link a:hover {
	color: #ff4500;
}

/* Team Info Wrap */
.team-info-wrap {
	display: flex;
	margin-bottom: 20px;
}

.left {
	flex: 0 0 40%;
	margin-right: 20px;
}

.right {
	flex: 0 0 60%;
}

/* Team Box */
.team_box {
	background-color: #ff4500;
	border-radius: 5px;
	color: white;
	padding: 20px;
	text-align: center;
	margin-bottom: 20px;
}

.team01 {
	margin-bottom: 20px;
}

/*이미지 원*/
.team01 .img {
	width: 120px;
	height: 120px;
	background-color: white;
	border-radius: 50%;
	margin: 0 auto 20px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.team01 dt {
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 10px;
}

.team01 dd {
	font-size: 14px;
}

.team02 ul {
	list-style: none;
	display: flex;
	justify-content: center;
	margin-bottom: 15px;
}

.team02 .comment {
	background: rgba(255, 255, 255, 0.2);
	padding: 10px;
	border-radius: 5px;
	font-size: 14px;
}

/* Team Table */
.team-table {
	width: 100%;
	border-collapse: collapse;
	background-color: white;
	border: 1px solid #ddd;
}

.team-table caption {
	display: none;
}

.team-table th {
	background-color: #777;
	color: white;
	padding: 12px 8px;
	text-align: center;
}

.team-table td {
	padding: 12px 8px;
	border-bottom: 1px solid #ddd;
	text-align: center;
}

.center {
	text-align: center;
}


/* Team Modify Button */
.team-modify {
	text-align: center;
	margin-top: 30px;
}

.team-modify a {
	display: inline-block;
	padding: 10px 30px;
	border: 1px solid #ff4500;
	color: #ff4500;
	text-decoration: none;
	border-radius: 4px;
	transition: all 0.3s;
}

.team-modify a:hover {
	background-color: #ff4500;
	color: white;
}

/* Additional styles for the team info table at the bottom */
table {
	width: 100%;
	border-collapse: collapse;
	border: 1px solid #ddd;
}

table td {
	padding: 8px 12px;
	
}
</style>
</head>
<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>
	<section>
		<div class="main">
			<div class="main-content">
				<ul class="tean-menu">
					<li class="teampage-link"><a href="MyTeam.action">팀 정보</a></li>
					<li class="teampage-link"><a href="TeamSchedule.action">팀 매치</a></li>
					<li class="teampage-link"><a href="TeamFee.action">팀 가계부</a></li>
					<li class="teampage-link"><a href="TeamBoard.action">팀 게시판</a></li>
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



</body>
</html>
