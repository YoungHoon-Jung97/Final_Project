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
<title>팀 가입</title>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/Team.css">
</head>
<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>
	<div class="container-fluid container">
		<div class="main">
			<div class="main-content">
				
				<!-- .tean-menu -->

				<div class="team-info-wrap">

					<div class="left">
						<div class="team_box">
							<div class="team01">
							<span></span>
								<div class="team-img">
									<img src="${team.emblem}" alt="" />
								</div>
								<dt>${team.temp_team_name}</dt>
							</div>
							<div class="team02">
								<ul>
									<li></li>
								</ul>
								<p class="comment">${team.temp_team_desc}</p>
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
									<td>${team.temp_team_name}</td>
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
						<span>팀 정보 가입</span>
					</a>
				</div>
			</div>
			<!-- .main-content  -->
		</div>
		<!-- .main  -->
	</div>
	

</body>
</html>
