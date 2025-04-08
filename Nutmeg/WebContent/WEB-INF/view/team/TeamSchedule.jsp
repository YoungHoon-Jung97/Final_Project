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
<style type="text/css">
/*팀 메뉴 넘어갔을 때 표시*/
.teampage-link:nth-child(2) a {
    color: #ff4500;
    border-bottom: 2px solid #ff4500;
}

</style>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		
	    $("#openVoteModal").on("click",function(){
	    	$("#voteTypeModal").show();
	    	$("body").css("overflow", "hidden"); // 페이지 스크롤 방지
	    });
	    
	    
	    $("#openVote").on("click", function() {
	        $("#voteTypeModal").hide(); 
	        $("#voteModal").show(); // 모달 보이기
	    });
	
	    // 모달 닫기 버튼
	    $("#cancel, #vote-cancel","#cancel-vote").on("click", function() {
	        $("#voteModal").hide(); // 모달 숨기기
	        $("#voteTypeModal").hide(); 
	        $("body").css("overflow", "auto"); // 페이지 스크롤 복원
	    });
	    
	    
	});

</script>


</head>
<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>

<!-- 투표 종류 모달 -->
<div id="voteTypeModal" class="voteType-modal modal">
    <div class="voteType-content">
        <p>투표 기능</p>
        <button id="openVote" class="voteType-button">생성</button>
        <button id="participantVote" class="voteType-button">참여</button>
        <button type="button" id="cancel" class="modal-button cancel-btn">취소</button>
    </div>
</div>


<!-- 투표 등록 모달 -->
<div id="voteModal" class="vote-modal modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">투표 등록</h3>
            <span id="vote-cancel" class="close-modal">&times;</span>
        </div>
        
        <!-- 투표 입력 폼 -->
            <!-- 내용 입력 섹션 -->
            <div class="vote-section content-section">
                <h4 class="section-title">투표 내용</h4>
                <textarea id="vote-content" placeholder="투표 내용을 입력하세요"></textarea>
            </div>

            <!-- 버튼 -->
            <div class="modal-buttons">
                <button type="button" id="submit-vote" class="modal-button submit-btn">투표 올리기</button>
                <button type="button" id="cancel-vote" class="modal-button cancel-btn">취소</button>
            </div>
        </div>
    </div>
</div>

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
				<!-- .team-menu -->
				<div class="vote">
					<button id="openVoteModal" class="btn">투표</button>
				</div>
				
				
				<ul class="team-match-wrap">
					<li class="center"> 매치 정보 없음</li>
				</ul><!-- .team-match-wrap -->
				
			</div>
			<!-- .main-content  -->
		</div>
		<!-- .main  -->
	</section>
</div>


</body>
</html>
