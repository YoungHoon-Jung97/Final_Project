
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
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/Team.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/modal.css">
<link href="https://fonts.googleapis.com/css?family=Stylish:400" rel="stylesheet">




<script>
        document.addEventListener("DOMContentLoaded", function () {
            // 요소 가져오기
            
            const openVoteTypeBtn = document.getElementById("openVoteTypeModal"); //투표
            const openScheduleBtn = document.getElementById("openScheduleModal"); //일정
            
            
            
            const openVoteBtn = document.getElementById("openVote");
            
            const scheduleModal = document.getElementById("scheduleModal"); //일정 화면
            const voteModal = document.getElementById("voteModal");			//투표 화면
            const voteTypeModal = document.getElementById("voteTypeModal"); //투표 종류 화면
            
            const closeVoteBtn = document.querySelector("vote-cancel"); //X 버튼
            const closeScheduleBtn = document.querySelector("schedule-cancel"); //X 버튼
            
            
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
            
            
         	// 일정 모달 닫기 (X 버튼)
            closeVoteBtn.addEventListener("click", function() {
            	scheduleModal.style.display = "none";
                document.body.style.overflow = "auto"; // 페이지 스크롤 복원
            });

            // 투표 종류 모달 닫기 (취소 버튼)
            cancelTypeBtn.addEventListener("click", function() {
            	voteTypeModal.style.display = "none";
                document.body.style.overflow = "auto"; // 페이지 스크롤 복원
            });

            
            // 투표 모달 닫기 (취소 버튼)
            closeScheduleBtn.addEventListener("click", function() {
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