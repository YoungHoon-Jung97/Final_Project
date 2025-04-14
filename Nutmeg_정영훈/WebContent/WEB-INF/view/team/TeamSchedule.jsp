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
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/modal.css">
<script type="text/javascript" src="<%=cp %>/js/Modal.js?after"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style type="text/css">
/*팀 메뉴 넘어갔을 때 표시*/
.teampage-link:nth-child(2) a {
    color: #a8d5ba;
    border-bottom: 2px solid #a8d5ba;
}


.team-modify{
	margin-top: 1px;
	margin-bottom: 10px;
}

.container1{
	width: 100%;
	background-color: white;
	height: 1000px;
}

</style>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>


<div class="container-fluid container1">
	<div class="main">
		<div class="main-content">
			<ul class="tean-menu">
				<li class="teampage-link"><a href="MyTeam.action">팀 정보</a></li>
				<li class="teampage-link"><a href="MyTeamSchedule.action">팀 매치</a></li>
				<li class="teampage-link"><a href="MyTeamFee.action">팀 가계부</a></li>
				<li class="teampage-link"><a href="MyTeamBoard.action">팀 게시판</a></li>
			</ul>
			
			<div class="header-container">
	            <h1>팀 경기 일정</h1>
	        </div>
			
			<ul class="team-match-wrap">
				<li class="center"> 매치 정보 없음</li>
			</ul><!-- .team-match-wrap -->
			
		</div>
		<!-- .main-content  -->
	</div>
	<!-- .main  -->
</div>


</body>
</html>
