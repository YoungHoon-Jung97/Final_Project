<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/Team.css">
</head>
<style type="text/css">
/*팀 메뉴 넘어갔을 때 표시*/
.teampage-link:nth-child(2) a {
    color: #a8d5ba;
    border-bottom: 2px solid #a8d5ba;
}

.team-modify {
    margin-top: 1px;
    margin-bottom: 10px;
}

.container1 {
    width: 100%;
    background-color: white;
    height: 1000px;
}

.view-buttons {
    display: flex;
    gap: 10px;
    margin-bottom: 20px;
}

.view-buttons button {
    padding: 8px 16px;
    background-color: #f1f3f4;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    color: #333;
}

.view-buttons button.active {
    background-color: #a8d5ba;
    color: white;
}

.match-item {
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 15px;
    margin-bottom: 15px;
}

.match-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}

.match-teams {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 15px;
}

.team {
    text-align: center;
    width: 40%;
}

.team-name {
    font-weight: bold;
    margin-bottom: 5px;
}

.team-score {
    font-size: 24px;
    font-weight: bold;
}

.vs {
    font-size: 18px;
    color: #777;
}

.match-details {
    border-top: 1px solid #eee;
    padding-top: 10px;
}

.detail-item {
    margin-bottom: 5px;
}

.detail-label {
    font-weight: bold;
    display: inline-block;
    width: 80px;
}

.modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 1000;
    align-items: center;
    justify-content: center;
}

.modal-content {
    background-color: white;
    border-radius: 8px;
    width: 90%;
    max-width: 500px;
    padding: 20px;
}
</style>

<body>
<div class="container">
	<div class="match-item">
		<div class="match-header"> 
		    <span class="match-date">  경기 날짜 :   </span> 
		    <span class="match-status" style="background-color: #e8f5e9; color: #388e3c;  ">  매치 참여 가능  </span> 
		</div> 
		<div class="match-teams"> 
		    <div class="team"> 
		        <div class="team-name">  props.homeTeam  </div> 
		        <div class="team-score">  props.homeScore  </div> 
		    </div> 
		    <div class="vs">VS</div> 
		    <div class="team"> 
		        <div class="team-name">  props.awayTeam  </div> 
		        <div class="team-score">  props.awayScore  </div> 
		    </div> 
		</div> 
		<div class="match-details"> 
		    <div class="detail-item"> 
		        <span class="detail-label">경기장:</span> 
		        <span>  props.venue  </span> 
		    </div> 
		    <div class="detail-item"> 
		        <span class="detail-label">참석 인원:</span> 
		        <span>  props.attendance  </span> 
		    </div> 
		</div><!-- match-header -->
	</div><!-- match-item -->
</div><!-- container -->
</body>
</html>