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
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/TeamMain.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/modal.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/TeamTemplate.css?after">

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


.container1 {
    width: 100%;
    background-color: white;
    height: 100%;
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


</style>

<script>


// 스크립트를 CDATA로 감싸서 EL 충돌 방지
//<![CDATA[
let calendar;

//[0 순서] 페이지 로드 시 실행 (달력에 일정 표시)
document.addEventListener('DOMContentLoaded', function() {
    // FullCalendar 초기화
    const calendarEl = document.getElementById('calendar');
    
 	// 캘린더 초기화 부분 수정
	calendar = new FullCalendar.Calendar(calendarEl, {
	    initialView: 'dayGridMonth',
	    headerToolbar: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'dayGridMonth,timeGridWeek,listMonth'
	    },
	    events: function(info, successCallback, failureCallback) {
	        $.ajax({
	            url: '<%=cp%>/MatchList.action',
	            type: 'GET',
	            dataType: 'json',
	            success: function(data) {
	                console.log("서버에서 받은 데이터:", data);
	                
	                if (!data || data.length === 0) {
	                    console.log("데이터가 없습니다.");
	                    successCallback([]);
	                    return;
		              }
	                
	                const events = data.map(match => {
	                    console.log("매치 데이터:", match);
	                    console.log("날짜:", match.match_date, "시간:", match.start_time);
	                    
	                    // 날짜 형식 처리
	                    var dateStr = match.match_date;
	                    if (dateStr && dateStr.includes(" 00:00:00")) {
	                        // "2025-04-17 00:00:00" 형식에서 시간 부분 제거
	                        dateStr = dateStr.split(" ")[0];
	                    }
	                    
	                    // 시작 시간 형식 처리
	                    var startTimeStr = match.start_time;
	                    if (startTimeStr && startTimeStr.includes("~")) {
	                        // "10:00~11:50" 형식에서 시작 시간만 추출
	                        startTimeStr = startTimeStr.split("~")[0].trim();
	                    }
	                    
	                 	// 종료 시간 형식 처리
	                    var endTimeStr = match.end_time;
	                    if (endTimeStr && endTimeStr.includes("~")) {
	                        // "10:00~11:50" 형식에서 시작 시간만 추출
	                        endTimeStr = endTimeStr.split("~")[1].trim();
	                    }
	                    
	                    // 완전한 ISO 형식으로 조합 (HH:MM 형식이면 :00 초 추가)
	                    var startDateTime = dateStr;
	                    if (startTimeStr) {
	                        
	                        // FullCalendar에 맞는 ISO 형식으로 변환 (~ 제거)
	                        startDateTime = dateStr + "T" + startTimeStr;
	                    }
	                    
	                    return {
	                        id: match.field_res_id,
	                        title: match.home_team_name + ' vs ' + match.away_team_name,
	                        start: dateStr + "T" + startTimeStr,  // start 필드에는 시작 시간만
	                        end: endTimeStr ? dateStr + "T" + endTimeStr : null,  // end 필드 별도 지정
	                        extendedProps: {
	                            homeTeam: match.home_team_name,
	                            awayTeam: match.away_team_name,
	                            homeScore: match.match_result_home_score || '-',
	                            awayScore: match.match_result_away_score || '-',
	                            venue: match.stadium_addr,
	                            attendance: match.match_inwon,
	                            status: match.match_status,
	                            fullTime: startTimeStr + "~" + endTimeStr ||""
	                        },
	                        className: 'event-' + (match.match_status ? match.match_status.replace(/\s+/g, '-').toLowerCase() : 'default')
	                    };
	                });
	                
	                console.log("변환된 이벤트:", events);
	                successCallback(events);
	            },
	            error: function(xhr, status, error) {
	                console.error('일정을 불러오는데 실패했습니다:', error);
	                failureCallback(error);
	            }
	        });
	    },
	    locale: 'ko',
	    eventClick: function(info) {
	        showMatchDetails(info);
	    }
	});
    
    calendar.render();
    
    // 초기 데이터 로드
    fetchEvents();
    
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
        calendar.updateSize();
    });
    

});


//[1 순서] AJAX로 이벤트 데이터 가져오기
function fetchEvents() {
    loadEvents(null, null, function(events) {
        updateListView(events);
    });
}

//[2 순서] 목록 뷰 업데이트
function updateListView(events) {
    const listView = document.getElementById('listView');
    listView.innerHTML = '';
    
    if (!events || events.length === 0) {
        listView.innerHTML = '<div class="text-center p-5">등록된 경기 일정이 없습니다.</div>';
        return;
    }
    
    // 날짜순 정렬
    events.sort((a, b) => new Date(a.start) - new Date(b.start));
    
    events.forEach(event => {
        createMatchListItem(event, listView);
    });
}

//[3 순서] 경기 목록 아이템 생성
function createMatchListItem(event, container) {
const props = event.extendedProps;
const id = event.id;

    // 날짜 추출 및 형식화
    let formattedDate = "날짜 정보 없음";
    
    if (event.start) {
        let dateObj;
        if (typeof event.start === 'string') {
            // ISO 형식의 문자열에서 날짜 부분만 추출
            const datePart = event.start.split('T')[0];
            dateObj = new Date(datePart);
        } else {
            dateObj = new Date(event.start);
        }
        
        if (!isNaN(dateObj.getTime())) {
            // 연, 월, 일 추출
            const year = dateObj.getFullYear();
            const month = dateObj.getMonth() + 1;
            const day = dateObj.getDate();
            
            // 기본 날짜 형식
            formattedDate = year + '년 ' + month + '월 ' + day + '일';
            
            // 시간 정보 추가 (있는 경우)
            if (props.fullTime) {
                formattedDate += ' ' + props.fullTime;
            }
        }
    }
    
    // 이하 동일...
    let statusStyle = getStatusStyle(props.status);
    let statusText = getStatusText(props.status);
    
    
    
    const matchItem = document.createElement('div');
    matchItem.className = 'match-item';
    
    matchItem.innerHTML = 
        '<div class="match-header">' +
            '<span class="match-date">' + formattedDate + '</span>' +
            '<span class="match-status" style="' + statusStyle + '">' + statusText + '</span>' +
        '</div>' +
        '<div class="match-teams">' +
            '<div class="team">' +
                '<div class="team-name">' + props.homeTeam + '</div>' +
                '<div class="team-score">' + props.homeScore + '</div>' +
            '</div>' +
            '<div class="vs">VS</div>' +
            '<div class="team">' +
                '<div class="team-name">' + props.awayTeam + '</div>' +
                '<div class="team-score">' + props.awayScore + '</div>' +
            '</div>' +
        '</div>' +
        '<div class="match-details">' +
            '<div class="detail-item">' +
                '<span class="detail-label">경기장:</span>' +
                '<span>' + props.venue + '</span>' +
            '</div>' +
            '<div class="detail-item">' +
                '<span class="detail-label">참석 인원:</span>' +
                '<span>' + props.attendance + '</span>' +
            '</div>' +
            '<a class="btn" href="ApplyMatch.action?field_res_id='+id+'">참가하기</a>'+
            '<a class="btn" href="Participant.action?field_res_id='+id+'">참가인원 보기</a>'
        '</div>';
    
    container.appendChild(matchItem);
}

// 상태별 스타일
function getStatusStyle(status) {
    switch(status) {
        case '예정됨': return 'background-color: #e3f2fd; color: #1976d2;';
        case '완료됨': return 'background-color: #e8f5e9; color: #388e3c;';
        case '취소됨': return 'background-color: #ffebee; color: #c62828;';
        case '결제대기': return 'background-color: #fff3e0; color: #e65100;';
        case '결과입력대기': return 'background-color: #f3e5f5; color: #7b1fa2;';
        default: return 'background-color: #e0e0e0; color: #616161;';
    }
}




// 날짜 범위에 따른 이벤트 로드
function loadEvents(start, end, successCallback, failureCallback) {
    $.ajax({
        url: '<%=cp%>/MatchList.action',
        type: 'GET',
        data: start && end ? { start: start, end: end } : {},
        dataType: 'json',
        success: function(data) {
            // 서버에서 받은 데이터를 FullCalendar 형식으로 변환
            const events = transformEvents(data);
            
            if (typeof successCallback === 'function') {
                successCallback(events);
            }
        },
        error: function(xhr, status, error) {
            console.error('일정을 불러오는데 실패했습니다:', error);
            if (typeof failureCallback === 'function') {
                failureCallback(error);
            }
        }
    });
}

// 데이터 변환 함수
function transformEvents(data) {
    if (!data || data.length === 0) {
        return [];
    }
    
    return data.map(match => {
        // 시작 시간과 종료 시간 처리
        let startTimeStr = match.start_time;
        let endTimeStr = match.end_time;
        
        if (startTimeStr && startTimeStr.includes("~")) {
            // "10:00~11:50" 형식에서 분리
            const timeParts = startTimeStr.split("~");
            startTimeStr = timeParts[0].trim();
            endTimeStr = timeParts[1] ? timeParts[1].trim() : endTimeStr;
        }
        
        // 전체 시간 문자열 생성
        const fullTimeStr = startTimeStr + (endTimeStr ? "~" + endTimeStr : "");
        
        return {
            id: match.field_res_id,
            title: match.home_team_name + ' vs ' + match.away_team_name,
            start: match.match_date + 'T' + startTimeStr,
            extendedProps: {
                homeTeam: match.home_team_name,
                awayTeam: match.away_team_name,
                homeScore: match.match_result_home_score || '-',
                awayScore: match.match_result_away_score || '-',
                venue: match.stadium_addr,
                attendance: match.match_inwon,
                status: match.match_status,
                fullTime: fullTimeStr // 전체 시간 문자열 추가
            },
            className: 'event-' + match.match_status
        };
    });
}


// 경기 상세 정보 표시
function showMatchDetails(info) {
    const event = info.event;
    const props = event.extendedProps;
    
    // 날짜 형식화
    const date = new Date(event.start);
    const options = { 
        year: 'numeric', 
        month: 'long', 
        day: 'numeric', 
        weekday: 'short'
    };
    let formattedDate = date.toLocaleDateString('ko-KR', options);
    
    // 시간 정보가 있으면 원래 시간 범위 표시
    if (props.fullTime) {
        formattedDate += ' ' + props.fullTime;
    }
    
    // 모달 내용 생성 (앞의 코드와 동일)
    document.getElementById('matchDetailsContent').innerHTML = 
        '<div class="match-header">' +
            '<span class="match-date">' + formattedDate + '</span>' +
            '<span class="match-status" style="' + getStatusStyle(props.status) + '">' + getStatusText(props.status) + '</span>' +
        '</div>' +
        '<div class="match-teams" style="margin: 20px 0;">' +
            '<div class="team">' +
                '<div class="team-name">' + props.homeTeam + '</div>' +
                '<div class="team-score">' + props.homeScore + '</div>' +
            '</div>' +
            '<div class="vs">VS</div>' +
            '<div class="team">' +
                '<div class="team-name">' + props.awayTeam + '</div>' +
                '<div class="team-score">' + props.awayScore + '</div>' +
            '</div>' +
        '</div>' +
        '<div class="match-details">' +
            '<div class="detail-item">' +
                '<span class="detail-label">경기장:</span>' +
                '<span>' + props.venue + '</span>' +
            '</div>' +
            '<div class="detail-item">' +
                '<span class="detail-label">참석 인원:</span>' +
                '<span>' + props.attendance + '</span>' +
            '</div>' +
        '</div>';
    
    document.getElementById('matchDetailsModal').style.display = 'flex';
}


// 상태 텍스트
function getStatusText(status) {
    return status || '상태 정보 없음';
}

// 모달 기능
function closeModal() {
    document.getElementById('addMatchModal').style.display = 'none';
}

function closeDetailsModal() {
    document.getElementById('matchDetailsModal').style.display = 'none';
}

// 기본 날짜 설정
function setDefaultDate() {
    const today = new Date();
    const yyyy = today.getFullYear();
    const mm = String(today.getMonth() + 1).padStart(2, '0');
    const dd = String(today.getDate()).padStart(2, '0');
    document.getElementById('matchDate').value = yyyy + '-' + mm + '-' + dd;
}

// 폼 제출 처리
function submitMatchForm() {
    const matchDate = document.getElementById('matchDate').value;
    const matchTime = document.getElementById('matchTime').value;
    const homeTeam = document.getElementById('homeTeam').value;
    const awayTeam = document.getElementById('awayTeam').value;
    const venue = document.getElementById('venue').value;
    const matchType = document.getElementById('matchType').value;
    
    if (!matchDate || !matchTime || !homeTeam || !awayTeam || !venue) {
        alert('필수 항목을 모두 입력해주세요.');
        return;
    }
    
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
            matchType: matchType,
            status: 'upcoming'
        }),
        success: function(response) {
            alert('경기 일정이 추가되었습니다.');
            document.getElementById('matchForm').reset();
            closeModal();
            fetchEvents();
            document.getElementById('calendarViewBtn').click();
        },
        error: function(xhr, status, error) {
            console.error('일정 추가에 실패했습니다:', error);
            alert('일정 추가에 실패했습니다. 다시 시도해주세요.');
        }
    });
}
//]]>
</script>
</head>
<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>

<div class="container-fluid container1">
    <div class="main">
        <div class="main-content">
            <ul class="team-menu">
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
                <!-- 일정 항목들이 동적으로 추가됩니다 -->
            </div>
        </div>
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