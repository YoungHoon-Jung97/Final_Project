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
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style type="text/css">
/*팀 메뉴 넘어갔을 때 표시*/
.teampage-link:nth-child(2) a {
    color: #a8d5ba;
    border-bottom: 2px solid #a8d5ba;
}

/* 모달 기본 스타일 */
.modal {
    display: none; /* 초기 상태 숨김 */
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    justify-content: center;
    align-items: center;
}

.modal.show {
    display: flex;
}


textarea {
    width: 100%;
    height: 80px;
    margin: 10px 0;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
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
<script type="text/javascript">
$(document).ready(function() {
    // 모달 열기 함수
    function openModal(modalId) {
        $(modalId).addClass("show");
        $("body").css("overflow", "hidden");
    }
    
    // 모달 닫기 함수
    function closeModal(modalId) {
        $(modalId).removeClass("show");
        $("body").css("overflow", "auto");
    }
    
    // 모든 모달 닫기
    function closeAllModals() {
        $(".modal").removeClass("show");
        $("body").css("overflow", "auto");
    }
    
    // 투표 종류 모달 열기
    $("#openVoteModal").on("click", function() {
        openModal("#voteTypeModal");
    });
    
    // 투표 등록 모달 열기
    $("#openVote").on("click", function() {
        closeModal("#voteTypeModal");
        openModal("#voteModal");
    });
    
    // 참여 버튼 (기능 추가 필요)
    $("#participantVote").on("click", function() {
        closeModal("#voteTypeModal");
        // 여기에 참여 관련 코드 추가
        alert("투표 참여 기능은 추후 구현 예정입니다.");
    });
    
    // 투표 올리기 버튼
    $("#submit-vote").on("click", function() {
        // 투표 내용 검증
        var voteContent = $("#vote-content").val().trim();
        if (voteContent === "") {
            alert("투표 내용을 입력해주세요.");
            return;
        }
        
        // 여기에 투표 저장 관련 AJAX 로직 추가
        alert("투표가 등록되었습니다.");
        closeAllModals();
    });
    
    // 닫기 버튼들
    $(".close-modal, .modal-cancel").on("click", function() {
        closeAllModals();
    });
    
    // 모달 외부 클릭 시 닫기
    $(".modal").on("click", function(e) {
        if ($(e.target).hasClass("modal")) {
            closeAllModals();
        }
    });
});
</script>


</head>
<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>

<!-- 투표 종류 모달 -->
<div id="voteTypeModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">투표 기능</h3>
            <span id="cancel-vote-type" class="close-modal">&times;</span>
        </div>
        <div class="modal-body">
            <button id="openVote" class="modal-button modal-submit">생성</button>
            <button id="participantVote" class="modal-button modal-submit">참여</button>
            <button type="button" id="cancel-vote-type" class="modal-button modal-cancel">취소</button>
        </div>
    </div>
</div>

<!-- 투표 등록 모달 -->
<div id="voteModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">투표 등록</h3>
            <span id="vote-cancel" class="close-modal">&times;</span>
        </div>
        <div class="modal-body">
            <div class="vote-section content-section">
                <h4 class="section-title">투표 내용</h4>
                <textarea id="vote-content" placeholder="투표 내용을 입력하세요"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" id="submit-vote" class="modal-button modal-submit">투표 올리기</button>
                <button type="button" id="cancel-vote" class="modal-button modal-cancel">취소</button>
            </div>
        </div>
    </div>
</div>


<div class="container-fluid container1">
	<div class="main">
		<div class="main-content">
			<ul class="tean-menu">
				<li class="teampage-link"><a href="MyTeam.action">팀 정보</a></li>
				<li class="teampage-link"><a href="MyTeamSchedule.action">팀 매치</a></li>
				<li class="teampage-link"><a href="MyTeamFee.action">팀 가계부</a></li>
				<li class="teampage-link"><a href="MyTeamBoard.action">팀 게시판</a></li>
			</ul>
			<!-- .team-menu -->
			<div class="team-modify">
				<button id="openVoteModal" class="btn">투표</button>
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
