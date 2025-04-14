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
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- FullCalendar CSS -->
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet">

<!-- FullCalendar 스크립트 -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales-all.min.js"></script>

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

<script>
	// 일정 데이터 (실제로는 서버에서 가져와야 함)
	const events = [];
	
	// AJAX로 데이터 가져오기
	function fetchEvents() {
	    $.ajax({
	    	//경기 일정 데이터를 가져올 action
	        url: '<%=cp%>/api/matches', 
	        type: 'GET',
	        dataType: 'json',
	        success: function(data) {
	            // 서버에서 받은 데이터를 FullCalendar 형식에 맞게 변환
	            events = data.map(match => {
	                return {
	                    id: match.id,
	                    title: `${match.homeTeam} vs ${match.awayTeam}`,
	                    start: `${match.matchDate}T${match.matchTime}`,
	                    extendedProps: {
	                        homeTeam: match.homeTeam,
	                        awayTeam: match.awayTeam,
	                        homeScore: match.homeScore || '-',
	                        awayScore: match.awayScore || '-',
	                        venue: match.venue,
	                        league: match.league,
	                        attendance: match.attendance,
	                        status: match.status,
	                        cancelReason: match.cancelReason
	                    },
	                    className: `event-${match.status}`
	                };
	            });
	            
	            // 캘린더에 이벤트 데이터 설정
	            calendar.removeAllEvents();
	            calendar.addEventSource(events);
	            
	            // 목록 뷰도 업데이트
	            updateListView(events);
	        },
	        error: function(xhr, status, error) {
	            console.error('일정을 불러오는데 실패했습니다:', error);
	            alert('일정을 불러오는데 실패했습니다.');
	        }
	    });
	}
	
	// 모달 관련 함수
	function closeModal() {
	    document.getElementById('addMatchModal').style.display = 'none';
	}
	
	function closeDetailsModal() {
	    document.getElementById('matchDetailsModal').style.display = 'none';
	}
	
	// 목록 뷰 업데이트 함수
	function updateListView(events) {
	    const listView = document.getElementById('listView');
	    listView.innerHTML = '';
	    
	    if (events.length === 0) {
	        document.getElementById('noMatch').style.display = 'block';
	        return;
	    }
	    
	    document.getElementById('noMatch').style.display = 'none';
	    
	    // 이벤트를 날짜 순으로 정렬
	    events.sort((a, b) => new Date(a.start) - new Date(b.start));
	    
	    // 각 이벤트마다 목록 아이템 생성
	    events.forEach(event => {
	        const props = event.extendedProps;
	        const date = new Date(event.start);
	        
	        // 날짜 포맷팅
	        const options = { 
	            year: 'numeric', 
	            month: 'long', 
	            day: 'numeric', 
	            weekday: 'short',
	            hour: '2-digit',
	            minute: '2-digit'
	        };
	        const formattedDate = date.toLocaleDateString('ko-KR', options);
	        
	        // 상태에 따른 스타일과 텍스트
	        let statusStyle = '';
	        let statusText = '';
	        
	        switch (props.status) {
	            case 'upcoming':
	                statusStyle = 'background-color: #e3f2fd; color: #1976d2;';
	                statusText = '예정됨';
	                break;
	            case 'completed':
	                statusStyle = 'background-color: #e8f5e9; color: #388e3c;';
	                statusText = '완료됨';
	                break;
	            case 'canceled':
	                statusStyle = 'background-color: #ffebee; color: #c62828;';
	                statusText = '취소됨';
	                break;
	        }
	        
	        // HTML 생성
	        const matchItem = document.createElement('div');
	        matchItem.className = 'match-item';
	        matchItem.innerHTML = `
	            <div class="match-header">
	                <span class="match-date">${formattedDate}</span>
	                <span class="match-status" style="${statusStyle}">${statusText}</span>
	            </div>
	            <div class="match-teams">
	                <div class="team">
	                    <div class="team-name">${props.homeTeam}</div>
	                    <div class="team-score">${props.homeScore}</div>
	                </div>
	                <div class="vs">VS</div>
	                <div class="team">
	                    <div class="team-name">${props.awayTeam}</div>
	                    <div class="team-score">${props.awayScore}</div>
	                </div>
	            </div>
	            <div class="match-details">
	                <div class="detail-item">
	                    <span class="detail-label">경기장:</span>
	                    <span>${props.venue}</span>
	                </div>
	                <div class="detail-item">
	                    <span class="detail-label">리그/대회:</span>
	                    <span>${props.league}</span>
	                </div>
	        `;
	        
	        // 취소된 경기인 경우 취소 사유 추가
	        if (props.status === 'canceled') {
	            matchItem.innerHTML += `
	                <div class="detail-item">
	                    <span class="detail-label">취소 사유:</span>
	                    <span>${props.cancelReason}</span>
	                </div>
	            `;
	        } else {
	            matchItem.innerHTML += `
	                <div class="detail-item">
	                    <span class="detail-label">참석 인원:</span>
	                    <span>${props.attendance}</span>
	                </div>
	            `;
	        }
	        
	        matchItem.innerHTML += '</div>';
	        listView.appendChild(matchItem);
	    });
	}
	
	// 페이지 로드 시 실행
	document.addEventListener('DOMContentLoaded', function() {
	    // FullCalendar 초기화
	    const calendarEl = document.getElementById('calendar');
	    
	 	// 초기 데이터 로드
	    fetchEvents();
	    
	 	// 캘린더 초기화 
	    const calendar = new FullCalendar.Calendar(calendarEl, {
	        initialView: 'dayGridMonth',
	        headerToolbar: {
	            left: 'prev,next today',
	            center: 'title',
	            right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
	        },
	        events: function(info, successCallback, failureCallback) {
	            // 뷰가 변경될 때마다 필요한 데이터만 서버에서 가져오는 방식
	            $.ajax({
	                url: '<%=cp%>/api/matches',
	                type: 'GET',
	                data: {
	                    start: info.startStr,  // YYYY-MM-DD 형식
	                    end: info.endStr       // YYYY-MM-DD 형식
	                },
	                dataType: 'json',
	                success: function(data) {
	                    const events = data.map(match => ({
	                        id: match.id,
	                        title: `${match.homeTeam} vs ${match.awayTeam}`,
	                        start: `${match.matchDate}T${match.matchTime}`,
	                        extendedProps: {
	                            // 위와 동일한 extendedProps
	                        },
	                        className: `event-${match.status}`
	                    }));
	                    successCallback(events);
	                },
	                error: function(xhr, status, error) {
	                    failureCallback(error);
	                    console.error('일정을 불러오는데 실패했습니다:', error);
	                }
	            });
	        },
	        locale: 'ko',
	        eventClick: function(info) {
	            showMatchDetails(info);
	        },
	        // 다른 설정은 동일
	    });
	    
	    calendar.render();
	    
	    // 보기 전환 버튼 이벤트
	    document.getElementById('listViewBtn').addEventListener('click', function() {
	        document.getElementById('listView').style.display = 'block';
	        document.getElementById('calendarView').style.display = 'none';
	        document.getElementById('listViewBtn').classList.add('active');
	        document.getElementById('calendarViewBtn').classList.remove('active');
	    });
	    
	    document.getElementById('calendarViewBtn').addEventListener('click', function() {
	        document.getElementById('listView').style.display = 'none';
	        document.getElementById('calendarView').style.display = 'block';
	        document.getElementById('listViewBtn').classList.remove('active');
	        document.getElementById('calendarViewBtn').classList.add('active');
	        // 캘린더 크기 재조정 (화면 전환 시 필요할 수 있음)
	        calendar.updateSize();
	    });
	    
	    // 일정 추가 버튼 이벤트
	    document.getElementById('addMatchBtn').addEventListener('click', function() {
	        document.getElementById('addMatchModal').style.display = 'flex';
	        
	        // 기본 날짜를 오늘로 설정
	        const today = new Date();
	        const yyyy = today.getFullYear();
	        const mm = String(today.getMonth() + 1).padStart(2, '0');
	        const dd = String(today.getDate()).padStart(2, '0');
	        document.getElementById('matchDate').value = `${yyyy}-${mm}-${dd}`;
	    });
	    
	    // 모달 외부 클릭 시 닫기
	    window.onclick = function(e) {
	        if (e.target == document.getElementById('addMatchModal')) {
	            closeModal();
	        }
	        if (e.target == document.getElementById('matchDetailsModal')) {
	            closeDetailsModal();
	        }
	    };
	    
	 // 폼 제출 이벤트
    document.getElementById('matchForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        // 폼 데이터 수집 - 기존과 동일
        const matchDate = document.getElementById('matchDate').value;
        const matchTime = document.getElementById('matchTime').value;
        const homeTeam = document.getElementById('homeTeam').value;
        const awayTeam = document.getElementById('awayTeam').value;
        const venue = document.getElementById('venue').value;
        const league = document.getElementById('league').value;
        const matchType = document.getElementById('matchType').value;
        
        // 간단한 검증 - 기존과 동일
        if (!matchDate || !matchTime || !homeTeam || !awayTeam || !venue) {
            alert('필수 항목을 모두 입력해주세요.');
            return;
        }
        
        // AJAX로 서버에 데이터 전송
        $.ajax({
            url: '<%=cp%>/api/matches',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                matchDate: matchDate,
                matchTime: matchTime,
                homeTeam: homeTeam,
                awayTeam: awayTeam,
                venue: venue,
                league: league || '친선 경기',
                matchType: matchType,
                status: 'upcoming'
            }),
            success: function(response) {
                alert('경기 일정이 추가되었습니다.');
                document.getElementById('matchForm').reset();
                closeModal();
                
                // 일정 다시 불러오기
                fetchEvents();
                
                // 캘린더 보기로 전환
                document.getElementById('calendarViewBtn').click();
            },
            error: function(xhr, status, error) {
                console.error('일정 추가에 실패했습니다:', error);
                alert('일정 추가에 실패했습니다. 다시 시도해주세요.');
            }
        });
    });
</script>


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
	        
	        <!-- 보기 전환 버튼 -->
            <div class="view-buttons">
                <button id="listViewBtn" class="active">목록 보기</button>
                <button id="calendarViewBtn">캘린더 보기</button>
            </div>
            
            <!-- 캘린더 보기 -->
            <div id="calendarView" style="display: none;">
                <div id="calendar"></div>
            </div>
            
            <!-- 목록 보기 -->
            <div id="listView" class="match-list">
                <div class="match-item">
                    <div class="match-header">
                        <span class="match-date">2025년 4월 20일 (일) 14:00</span>
                        <span class="match-status" style="background-color: #e3f2fd; color: #1976d2;">예정됨</span>
                    </div>
                    <div class="match-teams">
                        <div class="team">
                            <div class="team-name">우리팀</div>
                            <div class="team-score">-</div>
                        </div>
                        <div class="vs">VS</div>
                        <div class="team">
                            <div class="team-name">상대팀</div>
                            <div class="team-score">-</div>
                        </div>
                    </div>
                    <div class="match-details">
                        <div class="detail-item">
                            <span class="detail-label">경기장:</span>
                            <span>서울시 강남구 OO 체육관</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">리그/대회:</span>
                            <span>친선 경기</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">참석 인원:</span>
                            <span>8명 참석 확정 / 2명 미정</span>
                        </div>
                    </div>
                </div>
            </div>
  
			
		</div>
		<!-- .main-content  -->
	</div>
	<!-- .main  -->
</div>

<!-- 일정 추가 모달 -->
<div id="addMatchModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">경기 일정 추가</h3>
            <button class="close-modal" onclick="closeModal()">&times;</button>
        </div>
        <form id="matchForm" action="AddMatch.action" method="post">
            <div class="form-group">
                <label for="matchDate">경기 날짜</label>
                <input type="date" id="matchDate" name="matchDate" required>
            </div>
            <div class="form-group">
                <label for="matchTime">경기 시간</label>
                <input type="time" id="matchTime" name="matchTime" required>
            </div>
            <div class="form-group">
                <label for="homeTeam">홈팀</label>
                <input type="text" id="homeTeam" name="homeTeam" required>
            </div>
            <div class="form-group">
                <label for="awayTeam">원정팀</label>
                <input type="text" id="awayTeam" name="awayTeam" required>
            </div>
            <div class="form-group">
                <label for="venue">경기장</label>
                <input type="text" id="venue" name="venue" required>
            </div>
            <div class="form-group">
                <label for="league">리그/대회</label>
                <input type="text" id="league" name="league">
            </div>
            <div class="form-group">
                <label for="matchType">경기 유형</label>
                <select id="matchType" name="matchType">
                    <option value="official">공식 경기</option>
                    <option value="friendly">친선 경기</option>
                    <option value="practice">연습 경기</option>
                </select>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeModal()">취소</button>
                <button type="submit" class="btn btn-primary">저장</button>
            </div>
        </form>
    </div>
</div>

<!-- 경기 상세 정보 모달 -->
<div id="matchDetailsModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">경기 상세 정보</h3>
            <button class="close-modal" onclick="closeDetailsModal()">&times;</button>
        </div>
        <div id="matchDetailsContent">
            <!-- 상세 정보가 여기에 표시됩니다 -->
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" onclick="closeDetailsModal()">닫기</button>
        </div>
    </div>
</div>

</body>
</html>
