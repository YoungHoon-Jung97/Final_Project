<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	Integer team_id = (Integer)session.getAttribute("team_id");
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 정보</title>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/Team.css">
<script type="text/javascript">

	$(document).ready(function(){

	});
	
	
	


</script>
<style type="text/css">
/*팀 메뉴 넘어갔을 때 표시*/
.teampage-link:first-child a {
	color: #ff4500;
	border-bottom: 2px solid #ff4500;
}

/* =============================================*/

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', sans-serif;
        }
        
        body {
            background-color: #f5f5f5;
            padding: 20px;
        }
             
        
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background-color: #f8f8f8;
            font-weight: bold;
        }
        
        tr:hover {
            background-color: #f1f1f1;
        }
        
        .action-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
       
        
        .btn-danger {
            background-color: #f44336;
            color: white;
        }
        
        .btn-secondary {
            background-color: #e7e7e7;
            color: #333;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        
        .pagination a {
            color: black;
            padding: 8px 16px;
            text-decoration: none;
            transition: background-color .3s;
            border: 1px solid #ddd;
            margin: 0 4px;
        }
        
        .pagination a.active {
            background-color: #4CAF50;
            color: white;
            border: 1px solid #4CAF50;
        }
        
        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }
        


</style>

</head>
<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>
	<div class="container-fluid container">
		<div class="main">
			<div class="main-content">
				<ul class="tean-menu">
					<li class="teampage-link"><a href="MyTeam.action">팀 정보</a></li>
					<li class="teampage-link"><a href="MyTeamSchedule.action">팀 매치</a></li>
					<li class="teampage-link"><a href="MyTeamFee.action">팀 가계부</a></li>
					<li class="teampage-link"><a href="MyTeamBoard.action">팀 게시판</a></li>
				</ul>
				<!-- .tean-menu -->

				<div class="">
			        <h1>동호회 신청 수락 관리</h1>
			        <table>
			            <thead>
			                <tr>
			                	<th>번호</th>
			                    <th>이름</th>
			                    <th>신청 동호회</th>
			                    <th>가입 이유</th>
			                    <th>신청일</th>
			                    <th>포지션</th>
			                    <th>작업</th>
			                </tr>
			            </thead>
			            <tbody>
		                    <c:forEach var="teamApply" items="${teamApplyList}">
				                <tr>
									<td>${teamApply.user_nick_name}</td>
									<td>${teamApply.team_name}</td>
									<td>${teamApply.team_apply_desc}</td>
						            <td>${teamApply.team_apply_at}</td>
						            <td>${teamApply.position_name}</td>
									<td>
			                        	<a href="AddMember.action?team_apply_id=${teamApply.team_apply_id}&user_code_id=${teamApply.user_code_id}&team_id=${team.temp_team_id}" class="btn-primary btn-small approve-btn" data-id="1">승인</button>
			                        	<button class="btn-danger btn-small reject-btn" data-id="1">거절</button>
			                    	</td>
				                </tr>
							</c:forEach>
			            </tbody>
			        </table>
			        
	
			        <div class="pagination">
			            <a href="#">&laquo;</a>
			            <a href="#" class="active">1</a>
			            <a href="#">2</a>
			            <a href="#">3</a>
			            <a href="#">4</a>
			            <a href="#">5</a>
			            <a href="#">&raquo;</a>
			        </div>
			    </div>
				<!-- container -->
			</div>
			<!-- .main-content  -->
		</div>
		<!-- .main  -->
	</div>
	

</body>
<%	if(request.getParameter("message") != null)
	{
%>
		<script type="text/javascript">
			if (history.replaceState)
				history.replaceState({}, '', location.pathname);
			
			else
			{
				var cleanUrl = location.protocol + '//' + location.host + location.pathname;
				location.href = cleanUrl;
			}
			
			swal("warning", "<%= request.getParameter("message") %>", "warning");
			
		</script>
<%	}
%>
</html>
