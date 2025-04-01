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
.teampage-link:nth-child(2) a {
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


/* 투표 버튼 */
.vote {
	text-align: center;
	margin-top: 30px;
	border-bottom: 1px solid #ddd;
}

.vote button {
	display: inline-block;
	padding: 10px 30px;
	margin-bottom: 30px;
	text-align: right;
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

/* 모달 스타일 */
.vote-modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    overflow: auto;
}


.modal-content {
    background-color: white;
    margin: 5% auto;
    padding: 30px;
    width: 70%;
    max-width: 800px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
    animation: modalopen 0.4s;
}



.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #ddd;
    padding-bottom: 15px;
    margin-bottom: 20px;
}

.modal-title {
    font-size: 24px;
    color: #333;
    margin: 0;
}

.close-modal {
    font-size: 28px;
    font-weight: bold;
    color: #aaa;
    cursor: pointer;
}

.close-modal:hover {
    color: #333;
}

/* 투표 섹션 */
.vote-section {
    margin-bottom: 30px;
}

.section-title {
    font-size: 22px;
    color: #333;
    text-align: center;
    margin-bottom: 15px;
}


textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 5px;
    resize: vertical;
    min-height: 150px;
    margin-bottom: 20px;
}

/* 모달 버튼 */
.modal-buttons {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-top: 20px;
}

.modal-button {
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
    border: none;
    border-radius: 5px;
    transition: background-color 0.3s;
}

.submit-btn {
    background-color: #28a745;
    color: white;
}

.submit-btn:hover {
    background-color: #218838;
}

.cancel-btn {
    background-color: #dc3545;
    color: white;
}

.cancel-btn:hover {
    background-color: #c82333;
}

/* 알림 모달 */
.voteType-modal {
    display: none;
    position: fixed;
    z-index: 1100;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
}

.voteType-content {
    background-color: white;
    padding: 30px;
    width: 300px;
    text-align: center;
    margin: 25% auto;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
}

.voteType-content p {
    font-size: 18px;
    margin-bottom: 20px;
}

.voteType-button {
    padding: 8px 16px;
    background-color: #0056b3;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
}

.voteType-button:hover {
    background-color: #003d7a;
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
	    $("#cancel, #cancel-vote").on("click", function() {
	        $("#voteModal").hide(); // 모달 숨기기
	        $("#voteTypeModal").hide(); 
	        $("body").css("overflow", "auto"); // 페이지 스크롤 복원
	    });
	    
	    
	});

</script>


</head>
<body>

<!-- 투표 종류 모달 -->
<div id="voteTypeModal" class="voteType-modal">
    <div class="voteType-content">
        <p>투표 기능</p>
        <button id="openVote" class="voteType-button">생성</button>
        <button id="participantVote" class="voteType-button">참여</button>
        <button type="button" id="cancel" class="modal-button cancel-btn">취소</button>
    </div>
</div>


<!-- 투표 등록 모달 -->
<div id="voteModal" class="vote-modal">
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


	<section>
		<div class="main">
			<div class="main-content">
				<ul class="tean-menu">
					<li class="teampage-link"><a href="teammain.action">팀 정보</a></li>
					<li class="teampage-link"><a href="teamschedule.action">팀 매치</a></li>
					<li class="teampage-link"><a href="teamfee.action">팀 가계부</a></li>
					<li class="teampage-link"><a href="teamboard.action">팀 게시판</a></li>
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



</body>
</html>
