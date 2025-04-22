<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/team/Team.css">
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
    width: 100px;
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
<c:import url="/WEB-INF/view/Template.jsp"></c:import>
<div class="container">
	<c:forEach var="match" items="${matchRoomList}">
	<form action="MatchEnterCheckForm.action" method="post">
		<div class="match-item">
			<div class="match-header"> 
			    <span class="match-date">  경기 날짜 : ${match.match_date }   </span> 
			    <span class="match-status" style="background-color: #e8f5e9; color: #388e3c;  ">  ${match.match_status}  </span> 
			</div> 
			<div class="match-teams"> 
			    <div class="team"> 
			        <div class="team-name">  매치 개최팀 (Home Team)  </div> 
			        <div class="team-score"> ${match.home_team_name } </div> 
			    </div> 
			    <div class="vs">VS</div> 
			    <div class="team"> 
			        <div class="team-name"> 참가팀 (Away Team)  </div> 
			        <div class="team-score">  참가자 모집중  </div> 
			    </div> 
			</div> 
			<div class="match-details">
				<div class="detail-item"> 
			        <span class="detail-label">경기장 이름 : </span> 
			        <span> ${match.field_name}</span> 
			    </div> 
			    <div class="detail-item"> 
			        <span class="detail-label">경기장 주소 : </span> 
			        <span> ${match.stadium_addr}, ${match.stadium_detailed_addr}</span> 
			    </div> 
			    <div class="detail-item" >
			    	<div>
			    		<span class="detail-label">경기 시간:</span> 
			            <span>${match.start_time} 시 ~ ${match.end_time } 시</span>
			    	</div>
			        <div>
			            <span class="detail-label">참석 인원:</span> 
			            <span>${match.match_inwon}</span>
			        </div>
			        <div>
			            <span class="detail-label">가격:</span> 
			            <span>
						    <fmt:formatNumber value="${match.pay_amount / 2}" pattern="#,###" />원
						</span>
			        </div>
			    </div> 
			    <div class="detail-item" style="display: flex; justify-content: space-between; align-items: center;">
				    <a href="FieldReservationForm.action?field_code_id=${match.field_code_id}"
					   class="btn btn-primary d-flex justify-content-center align-items-center"
					   style="width: 200px; height: 50px;">
					   경기장 상세정보 확인하기
					</a>
					<input type="hidden" name="match_date" value="${match.match_date }">
					<input type="hidden" name="start_time" value="${match.start_time}">
					<input type="hidden" name="end_time" value="${match.end_time }">
					<input type="hidden" name="home_team_id" value="${match.home_team_id }">
					<input type="hidden" name="pay_amount" value="${match.pay_amount}">
					<input type="hidden" name="match_inwon" value="${match.match_inwon}">
					<input type="hidden" name="field_res_id" value="${match.field_res_id}">
					<input type="hidden" name="field_code_id" value="${match.field_code_id}">
					
				    <button type="submit" class="btn btn-success" style="width: 200px; height: 50px;">
				        참여하기
				    </button>
				</div>
			</div>
		</div><!-- match-item -->
	</form>
	</c:forEach>
</div><!-- container -->
</body>
</html>