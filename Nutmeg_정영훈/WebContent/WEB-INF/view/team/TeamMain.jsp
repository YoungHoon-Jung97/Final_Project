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
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/Team.css">
<style type="text/css">
/*팀 메뉴 넘어갔을 때 표시*/
.teampage-link:first-child a {
	color: #ff4500;
	border-bottom: 2px solid #ff4500;
}
</style>

</head>
<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>
<!-- 팀 참여 모달 -->
<div id="applyModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">투표 등록</h3>
            <span id="vote-cancel" class="close-modal">&times;</span>
        </div>
        <div class="modal-body">
        	<form action="">
	            <div class="content-section">
	                <h4 class="section-title">투표 내용</h4>
	                <textarea id="apply-content" placeholder="자신의 정보를 입력하세요"></textarea>
	            </div>
	            <div class="modal-footer">
	                <button type="button" id="submit-vote" class="modal-button modal-submit">신청</button>
	                <button type="button" id="cancel-vote" class="modal-button modal-cancel">취소</button>
	            </div>
            </form>
        </div>
    </div>
</div>



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
	</div>


</body>
</html>
