
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();

    // 현재 페이지 번호 (기본값 1)
    int currentPage = 1;
    // URL에 붙은 page 라는 값 (예: board.jsp?page=3이면 3페이지)
    String pageParam = request.getParameter("page");
    if(pageParam != null) {
        try {
            currentPage = Integer.parseInt(pageParam);
        } catch(Exception e) {
            currentPage = 1;
        }
    }
    // 이전, 다음 버튼은 한 페이지씩 이동
    int prevPage = (currentPage > 1) ? currentPage - 1 : 1;
    int nextPage = currentPage + 1;
    
    // 페이지 번호 링크 10개를 보여준다고 가정하고, 현재 페이지를 가운데에 오도록 계산
    int displayCount = 10;
    int half = displayCount / 2;
    int startPage = currentPage - half;
    if(startPage < 1) {
        startPage = 1;
    }
    int endPage = startPage + displayCount - 1;
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://fonts.googleapis.com/css?family=Stylish:400" rel="stylesheet">



<style type="text/css">

  /* 전체 스타일 */
body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f5f5f5;
    text-align: center;
}

/* 컨테이너 */
.container, .container1 {
    width: 80%;
    margin: 0 auto;
    padding: 40px;
}

/* 헤딩 */
h2 {
    text-align: center;
    color: #333;
}

/* 메뉴 및 네비게이션 */
.menu {
    text-align: center;
    margin-bottom: 20px;
}

.menu button, .nav button {
    padding: 10px 20px;
    margin: 5px;
    font-size: 16px;
    cursor: pointer;
    border: none;
    border-radius: 5px;
}

.menu button {
    background-color: #0056b3;
    color: white;
    transition: background-color 0.3s;
}

.menu button:hover {
    background-color: #003d7a;
}

.nav {
    display: flex;
    justify-content: space-around;
    background-color: #4CAF50;
    padding: 10px;
    color: white;
    font-weight: bold;
    border-radius: 5px;
}

.nav button {
    background: transparent;
    color: white;
    font-size: 16px;
}

.nav button:hover {
    text-decoration: underline;
}

/* 게시판 스타일 */
.board-list {
    margin-top: 20px;
}

.board-item {
    background-color: #f4a460;
    margin: 10px 0;
    padding: 10px;
    border-radius: 5px;
    font-weight: bold;
    cursor: pointer;
}

.board-item:hover {
    background-color: #e08e3c;
}

/* 강조 텍스트 */
.important {
    color: red;
}

.notice {
    color: green;
}

/* 페이지네이션 */
.pagination {
    margin-top: 20px;
    position: relative;
    display: inline-block;
}

.pagination a {
    text-decoration: none;
    padding: 5px 10px;
    margin: 2px;
    background: orange;
    color: white;
    border-radius: 3px;
    cursor: pointer;
}

.pagination a:hover {
    background: darkorange;
}

.page-input {
    display: none;
    position: absolute;
    bottom: 50px;
    left: 90%;
    transform: translateX(-50%);
    background: white;
    padding: 10px;
    border-radius: 5px;
    box-shadow: 0px 0px 5px gray;
    width: 150px;
}

.page-input::after {
    content: "";
    position: absolute;
    top: 100%;
    left: 50%;
    transform: translateX(-50%);
    border-width: 10px;
    border-style: solid;
    border-color: white transparent transparent transparent;
}

.page-input input {
    width: 50px;
    text-align: center;
    margin-right: 5px;
}

.page-input button {
    cursor: pointer;
}

/* 스크롤업 버튼 */
.scroll-up {
    position: fixed;
    bottom: 20px;
    right: 20px;
    background-color: black;
    color: white;
    padding: 10px;
    border-radius: 50%;
    cursor: pointer;
}

/* 메인 레이아웃 */
main {
    display: flex;
    justify-content: space-between;
    gap: 20px;
    padding: 20px;
}

.wrap_left {
    width: 65%;
}

.wrap_right {
    width: 30%;
    padding: 20px;
}

/* 헤더 */
.head {
    display: flex;
    align-items: center;
    padding: 10px;
}

.logo {
    margin-right: auto;
}

.search {
    flex-grow: 1;
    display: flex;
    justify-content: flex-end;
}

fieldset {
    border: none;
}

/* 공통 숨김 스타일 */
.blind {
    display: none;
    clip: rect(0 0 0 0);
    overflow: hidden;
    position: absolute;
}

/* 네비게이션 바 */
.gnb_bar {
    background: linear-gradient(to right, #ff7e5f, #feb47b);
    padding: 10px 0;
}

.gnb_list_clear {
    display: flex;
    justify-content: center;
    gap: 15px;
}

li {
    list-style: none;
}

/* 공지사항 & 일정 */
.left_top_content,
.left_bottom_content {
    width: 100%;
    padding: 20px;
    margin-bottom: 20px;
}

.left_bottom_content {
    min-height: 300px;
    text-align: center;
}

/* 테이블 스타일 */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}

th, td {
    border: 1px solid #ddd;
    text-align: center;
    padding: 8px;
    width: 14.2%;
}

th {
    background: #eee;
}

/* 캘린더 */
#calendar {
    width: 100%;
}

.calendar-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    background: #ff7e5f;
    color: white;
    font-weight: bold;
    border-radius: 5px;
}

.calendar-header button {
    background: white;
    border: none;
    cursor: pointer;
    font-size: 18px;
    padding: 5px 10px;
    border-radius: 5px;
}

.calendar-header button:hover {
    background: #feb47b;
    color: white;
}

.today {
    background: #ff7e5f;
    color: white;
    border-radius: 50%;
}

/* 동호회 멤버 & 팀 정보 */
.section {
    margin-bottom: 20px;
}

.section_head {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 10px;
}

.section_list li {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 10px;
    border-bottom: 1px solid #ddd;
}

.member_profile {
    width: 40px;
    height: 40px;
    background-color: #eee;
    border-radius: 50%;
}

.member_inform {
    display: flex;
    flex-direction: column;
}

.member_name {
    font-weight: bold;
}

.member_level {
    font-size: 14px;
    color: gray;
}

/* 팀 정보 */
.section_list_wrapper div {
    display: flex;
    justify-content: space-between;
    padding: 10px;
    border-bottom: 1px solid #ddd;
}

.section_list_wrapper div:last-child {
    border-bottom: none;
}

/* 모달 버튼 */
.open-modal-btn {
    display: block;
    margin: 10px auto;
    padding: 10px 15px;
    font-size: 15px;
    background-color: #28a745;
    color: black;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    
}

.open-modal-btn:hover {
    background-color: #218838;
}

/* 모달 스타일 */
.modal {
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

.date-container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
    margin-bottom: 20px;
}

.date-field {
    padding: 15px;
    background-color: #f9f9f9;
    border-radius: 5px;
    border: 1px solid #ddd;
}

.date-label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
    color: #555;
}

input[type="date"] {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.content-section textarea {
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
.notification-modal {
    display: none;
    position: fixed;
    z-index: 1100;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
}

.notification-content {
    background-color: white;
    padding: 30px;
    width: 300px;
    text-align: center;
    margin: 25% auto;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
}

.notification-content p {
    font-size: 18px;
    margin-bottom: 20px;
}

.notification-button {
    padding: 8px 16px;
    background-color: #0056b3;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
}

.notification-button:hover {
    background-color: #003d7a;
}
</style>
<script>
        document.addEventListener("DOMContentLoaded", function () {
            // 요소 가져오기
            
            const openVoteTypeBtn = document.getElementById("openVoteTypeModal"); //투표
            const openScheduleBtn = document.getElementById("openScheduleModal"); //일정
            
            
            
            const openVoteBtn = document.getElementById("openVote");
            
            const scheduleModal = document.getElementById("scheduleModal"); //일정 화면
            const voteModal = document.getElementById("voteModal");			//투표 화면
            const voteTypeModal = document.getElementById("voteTypeModal"); //투표 종류 화면
            
            const closeVoteBtn = document.getElementById("vote-cancel"); //X 버튼
            const closeScheduleBtn = document.getElementById("schedule-cancel"); //X 버튼
            
            
            const cancelVoteBtn = document.getElementById("cancel-vote");
            const cancelTypeBtn = document.getElementById("cancel-type");
            
            const submitVoteBtn = document.getElementById("submit-vote");
           
            const participantVote = document.getElementById("participantVote");
         
            
            // 현재 날짜 가져오기
            const today = new Date();
            const formattedDate = today.toISOString().split('T')[0];
            
            // 시작일 기본값으로 오늘 날짜 설정
            document.getElementById("start-date").value = formattedDate;
            
            // 종료일 기본값으로 7일 후 설정
            const nextWeek = new Date(today);
            nextWeek.setDate(today.getDate() + 7);
            document.getElementById("end-date").value = nextWeek.toISOString().split('T')[0];

            
         	// 투표 종류 모달 열기
            openVoteTypeBtn.addEventListener("click", function() {
            	voteTypeModal.style.display = "block";
                document.body.style.overflow = "hidden"; // 페이지 스크롤 방지
            });
            
         	
            // 투표 모달 열기
            openVoteBtn.addEventListener("click", function() {
            	voteTypeModal.style.display = "none";
                voteModal.style.display = "block";
                
            });
            
            //일정 모달 열기
            openScheduleBtn.addEventListener("click",function(){
            	scheduleModal.style.display = "block";
            	document.body.style.overflow = "hidden";
            });
            
                
            // 투표 모달 닫기 (X 버튼)
            closeVoteBtn.addEventListener("click", function() {
                voteModal.style.display = "none";
                document.body.style.overflow = "auto"; // 페이지 스크롤 복원
            });
            
            
            closeScheduleBtn.addEventListener("click", function() {
                scheduleModal.style.display = "none";
                document.body.style.overflow = "auto"; // 페이지 스크롤 복원
            });

            // 투표 종류 모달 닫기 (취소 버튼)
            cancelTypeBtn.addEventListener("click", function() {
            	voteTypeModal.style.display = "none";
                document.body.style.overflow = "auto"; // 페이지 스크롤 복원
            });

            
            // 투표 모달 닫기 (취소 버튼)
            cancelVoteBtn.addEventListener("click", function() {
                voteModal.style.display = "none";
                document.body.style.overflow = "auto"; // 페이지 스크롤 복원
            });

          

            // 모달 바깥을 클릭하면 닫기
            window.addEventListener("click", function(event) {
                if (event.target === voteModal) {
                    voteModal.style.display = "none";
                    document.body.style.overflow = "auto"; // 페이지 스크롤 복원
                }
                if (event.target === voteTypeModal) {
                	voteTypeModal.style.display = "none";
                    document.body.style.overflow = "auto"; // 페이지 스크롤 복원
                }
                if (event.target === scheduleModal) {
                	scheduleModal.style.display = "none";
                    document.body.style.overflow = "auto"; // 페이지 스크롤 복원
                }
            });
        });
    </script>

</head>
<body>

<!--페이지 최상단  -->
<header class="hearder">
	<div class="head">
		<!--로고  -->
		<div class="logo">
			<!--로고 링크  -->
			<a href="https://www.google.com">
				<img src="./img/google.png" alt="동호회 보기" style="width: 100px; height: 50px;" >
			</a>
			<!--//로고 링크  -->
		</div>
		<!--//로고  -->
		<!--최상단 검색창  -->
		<div class="search">
			<form action="" id="searchform" name="search_process">
				<fieldset>
					<legend class="blind">동호회 정보</legend>
					<!--검색창  -->
					<div class="top_search">
						<div class="inner_search">
							<input type="text" id="keyword" class="keyword" name="search"
							placeholder="동호회정보 검색"/>
							<button type="submit" id="searchSubmit">
							확인
							</button>
						</div>
					</div>
					<!--//검색창  -->
				</fieldset>
			</form>
		</div>
		<!--//최상단 검색창  -->
	</div>
</header>
<!--//페이지 최상단   -->


<!--GNB  -->
<div class="gnb_bar">
	<nav class="gnb clear">
		<h2 class="blind">GNB</h2>
		<!--리스트 메뉴 -->
		<ul class="gnb_list_clear">
			<!--두 번째 리스트  -->
			<li>
				<!-- 모달 열기 버튼 -->
        		<button id="openVoteTypeModal" class="open-modal-btn">투표</button>
			</li>
			<!--//두 번째 리스트  -->
			<!--세 번째 리스트  -->
			<li>
				<button id="openScheduleModal" class="open-modal-btn">일정</button>
			</li>
			<!--//세 번째 리스트  -->
			<!--네 번째 리스트  -->
			<li>
				<button id="openMemberModal" class="open-modal-btn">동호회원</button>
			</li>
		</ul>
		<!--리스트 메뉴 -->
		
	</nav>
</div>
<!--//GNB  -->

<!-- 투표 종류 모달 -->
<div id="voteTypeModal" class="notification-modal">
    <div class="notification-content">
        <p>투표가 성공적으로 등록되었습니다.</p>
        <button id="openVote" class="notification-button">생성</button>
        <button id="participantVote" class="notification-button">참여</button>
        <button type="button" id="cancel-type" class="modal-button cancel-btn">취소</button>
    </div>
</div>

<!-- 투표 등록 모달 -->
<div id="voteModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">투표 등록</h3>
            <span id="vote-cancel" class="close-modal">&times;</span>
        </div>
        
        <!-- 투표 입력 폼 -->
        <div class="board-list">
            <!-- 날짜 선택 섹션 -->
            <div class="vote-section">
                <h4 class="section-title">투표 기간</h4>
                <div class="date-container">
                    <div class="date-field">
                        <label class="date-label" for="start-date">시작일:</label>
                        <input type="date" id="start-date">
                    </div>
                    <div class="date-field">
                        <label class="date-label" for="end-date">종료일:</label>
                        <input type="date" id="end-date">
                    </div>
                </div>
            </div>

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


<!-- 일정 모달 -->
<div id="scheduleModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">일정</h3>
            <span id="schedule-cancel" class="close-modal">&times;</span>
        </div>
        
        <!-- 투표 입력 폼 -->
        <div class="board-list">
            <!-- 일정 리스트 -->
            <div class="board-item" onclick="location.href='post.html'">게시물</div>
        </div>
    </div>
</div>



<main>
	<!--왼쪽 화면  -->
	<div class="wrap_left">
		<h2 class="blind">메인 컨텐츠 영역</h2>
		
		<div class="container-board">
	    
	        <div class="board-list">
	            <div class="board-item important" onclick="location.href='important.html'">★ 중요 공지 사항</div>
	            <div class="board-item notice" onclick="location.href='notice.html'">🔔 공지 사항</div>
	            <div class="board-item" onclick="location.href='post.html'">게시물</div>

	            
	            <!-- 기타 게시물 항목들 -->
	        </div>
	        <div class="pagination">
	            <!-- 한 페이지씩 이동하는 이전 버튼 -->
	            <a href="<%= cp %>/board.jsp?page=<%= prevPage %>">이전</a>
	            <!-- 현재 페이지 블록 (10개씩) 출력 -->
	            <% for(int i = startPage; i <= endPage; i++) { %>
	                <a href="<%= cp %>/board.jsp?page=<%= i %>"><%= i %></a>
	            <% } %>
	            <!-- 페이지 번호 입력 말풍선 -->
	            <a href="#" onclick="event.preventDefault(); togglePageInput();">...</a>
	            <div id="page-input" class="page-input">
	                <input type="number" id="page-number" min="1" placeholder="페이지"/>
	                <button onclick="goToPage()">이동</button>
	            </div>
	            <!-- 한 페이지씩 이동하는 다음 버튼 -->
	            <a href="<%= cp %>/board.jsp?page=<%= nextPage %>">다음</a>
	        </div>
	    </div>
		
		
		
		
		<!--일정  -->
		<section class="left_bottom_content">
	   		<div id="calendar">
	       		<div class="calendar-header">
	           		<button id="prevMonth">&lt;</button>
	           		<h2 id="currentMonth">3</h2>
	           		<button id="nextMonth">&gt;</button>
	       		</div>
	       		<table>
	           		<thead>
	                	<tr>
		                    <th>일</th>
		                    <th>월</th>
		                    <th>화</th>
		                    <th>수</th>
		                    <th>목</th>
		                    <th>금</th>
		                    <th>토</th>
	                	</tr>
	           		</thead>
	           		<tbody id="calendarBody">
	           			<tr>
	           				<td></td>
	           				<td></td>
	           				<td></td>
	           				<td></td>
	           				<td></td>
	           				<td></td>
	           				<td>1</td>
	           			</tr>
	           			<tr>
	           				<td>2</td>
	           				<td>3</td>
	           				<td>4</td>
	           				<td>5</td>
	           				<td>6</td>
	           				<td>7</td>
	           				<td>8</td>
	           			</tr>
	           			<tr>
	           				<td>9</td>
	           				<td>10</td>
	           				<td>11</td>
	           				<td>12</td>
	           				<td>13</td>
	           				<td>14</td>
	           				<td>15</td>
	           			</tr>
	           			<tr>
	           				<td>16</td>
	           				<td>17</td>
	           				<td>18</td>
	           				<td>19</td>
	           				<td>20</td>
	           				<td>21</td>
	           				<td>22</td>
	           			</tr>
	           			<tr>
	           				<td>23</td>
	           				<td>24</td>
	           				<td>25</td>
	           				<td>26</td>
	           				<td>27</td>
	           				<td>28</td>
	           				<td>29</td>
	           			</tr>
	           			<tr>
	           				<td>30</td>
	           				<td>31</td>
	           				<td></td>
	           				<td></td>
	           				<td></td>
	           				<td></td>
	           				<td></td>
	           			</tr>
	           		</tbody>
	       		</table>
	   		</div>
		</section>
		<!--//일정  -->
	</div>
	<!--//왼쪽 화면  -->
	
	<!--오른쪽 화면  -->
	<div class="wrap_right">
		<!--동호회 정보 맴버 리스트  -->
		<div class="section">
			<!--동호회 맴버 정보  -->
			<div class="section_head">
				<div class="section_title"> 주요 멤버</div>
			</div>
			<div class="section_list">
				<li>
					<a href="">
						<div class="member_profile"></div>
						<div class="member_inform">
							<p class="member_name">정영훈</p>
							<span class="member_level">아마추어3</span>
						</div>
					</a>
				</li>
				<li>
					<a href="">
						<div class="member_profile"></div>
						<div class="member_inform">
							<p class="member_name">김민승</p>
							<span class="member_level">비기너1</span>
						</div>
					</a>
				</li>
			</div>
		</div>
		<!--//동호회 정보 맴버 리스트  -->
		
		<!--동호회 정보 리스트  -->
		<section class="section">
			<div class="section_head">
				<div class="section_title">팀정보</div>
			</div>
			<div class="section_list_wrapper">
				<div class="club_region">
					<span>지역</span>
					<span class="region_name">
						인천
					</span>
				</div>
				<div class="club_homeground">
					<span>홈 구장</span>
					<span class="homeground_name">
						인천 계양 고고풋살
					</span>
				</div>
				<div class="club_age">
					<span>평균 나이</span>
					<span class="age_average">
						26세
					</span>
				</div>
				<div class="club_member">
					<span>멤버</span>
					<span class="member_count">
						4명
					</span>
				</div>
				<div class="club_level">
					<span>레벨</span>
					<span class="level">
						프로
					</span>
				</div>
			</div>
		</section>
		<!--//동호회 정보 리스트  -->
	</div>
	<!--//오른쪽 화면  -->
</main>


</body>
</html>