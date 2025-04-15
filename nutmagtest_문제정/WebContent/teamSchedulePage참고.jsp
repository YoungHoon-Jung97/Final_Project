<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	Integer user_code_id = (Integer) session.getAttribute("user_code_id");
%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>팀 경기 일정</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Noto Sans KR', sans-serif;
        }
        
        body {
            background-color: #f5f5f5;
        }
        
        .container-fluid {
            width: 100%;
            padding: 0 15px;
        }
        
        .main {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px 0;
        }
        
        .main-content {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        
        .tean-menu {
            display: flex;
            list-style: none;
            border-bottom: 1px solid #e0e0e0;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }
        
        .teampage-link {
            margin-right: 30px;
        }
        
        .teampage-link a {
            text-decoration: none;
            color: #555;
            font-weight: 500;
            font-size: 16px;
            transition: color 0.3s;
        }
        
        .teampage-link a:hover {
            color: #1a73e8;
        }
        
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        h1 {
            font-size: 24px;
            color: #333;
        }
        
        .team-match-wrap {
            list-style: none;
        }
        
        .center {
            text-align: center;
            padding: 40px 0;
            color: #888;
            font-size: 16px;
        }
        
        /* 새로 추가한 스타일 */
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        
        .btn {
            padding: 8px 16px;
            border-radius: 4px;
            border: none;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .btn-primary {
            background-color: #1a73e8;
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #1557b0;
        }
        
        .btn-secondary {
            background-color: #f1f3f4;
            color: #333;
        }
        
        .btn-secondary:hover {
            background-color: #e0e0e0;
        }
        
        .filter-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 12px;
            border-radius: 8px;
            background-color: #f8f9fa;
        }
        
        .filter-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        select, input {
            padding: 8px 12px;
            border-radius: 4px;
            border: 1px solid #ddd;
            font-size: 14px;
        }
        
        .view-toggle {
            display: flex;
            gap: 10px;
        }
        
        .match-item {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            transition: box-shadow 0.3s;
        }
        
        .match-item:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .match-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        
        .match-date {
            font-weight: 500;
            color: #333;
        }
        
        .match-status {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .status-upcoming {
            background-color: #e3f2fd;
            color: #1976d2;
        }
        
        .status-completed {
            background-color: #e8f5e9;
            color: #388e3c;
        }
        
        .status-canceled {
            background-color: #ffebee;
            color: #c62828;
        }
        
        .match-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .team-info {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            width: 40%;
        }
        
        .team-name {
            font-weight: 500;
            margin: 8px 0;
        }
        
        .team-score {
            font-size: 32px;
            font-weight: 700;
            color: #333;
        }
        
        .vs {
            font-size: 18px;
            font-weight: 500;
            color: #888;
        }
        
        .match-details {
            margin-top: 12px;
            padding-top: 12px;
            border-top: 1px solid #e0e0e0;
            font-size: 14px;
            color: #555;
        }
        
        .detail-item {
            display: flex;
            gap: 10px;
            margin-bottom: 8px;
        }
        
        .detail-label {
            font-weight: 500;
            width: 100px;
        }
        
        .calendar-view {
            display: none;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            overflow: hidden;
        }
        
        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            background-color: #f8f9fa;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .month-nav {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .month-title {
            font-weight: 500;
            font-size: 18px;
        }
        
        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            border-collapse: collapse;
        }
        
        .calendar-day-header {
            padding: 10px;
            text-align: center;
            font-weight: 500;
            border: 1px solid #e0e0e0;
            background-color: #f8f9fa;
        }
        
        .calendar-day {
            height: 100px;
            padding: 10px;
            border: 1px solid #e0e0e0;
            vertical-align: top;
        }
        
        .day-number {
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 5px;
        }
        
        .day-event {
            background-color: #e3f2fd;
            color: #1976d2;
            padding: 2px 5px;
            border-radius: 3px;
            font-size: 12px;
            margin-bottom: 3px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            cursor: pointer;
        }
        
        .empty-day {
            background-color: #f8f9fa;
        }
        
        .no-match-placeholder {
            text-align: center;
            padding: 40px 0;
            color: #888;
            font-size: 16px;
        }
        
        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .match-content {
                flex-direction: column;
                gap: 15px;
            }
            
            .team-info {
                width: 100%;
            }
            
            .filter-section {
                flex-direction: column;
                gap: 10px;
                align-items: flex-start;
            }
            
            .header-container {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .action-buttons {
                width: 100%;
                justify-content: flex-start;
            }
            
            .calendar-day {
                height: 80px;
                padding: 5px;
            }
        }
    </style>
</head>
<body>
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
                    <div class="action-buttons">
                        <button class="btn btn-primary" id="addMatchBtn">일정 추가</button>
                        <button class="btn btn-secondary" id="exportBtn">일정 내보내기</button>
                    </div>
                </div>
                
                <div class="filter-section">
                    <div class="filter-group">
                        <select id="statusFilter">
                            <option value="all">전체 경기</option>
                            <option value="upcoming">예정된 경기</option>
                            <option value="completed">종료된 경기</option>
                            <option value="canceled">취소된 경기</option>
                        </select>
                        
                        <select id="yearFilter">
                            <option value="2025">2025년</option>
                            <option value="2024">2024년</option>
                            <option value="2023">2023년</option>
                        </select>
                        
                        <select id="monthFilter">
                            <option value="all">전체 월</option>
                            <option value="1">1월</option>
                            <option value="2">2월</option>
                            <option value="3">3월</option>
                            <option value="4">4월</option>
                            <option value="5">5월</option>
                            <option value="6">6월</option>
                            <option value="7">7월</option>
                            <option value="8">8월</option>
                            <option value="9">9월</option>
                            <option value="10">10월</option>
                            <option value="11">11월</option>
                            <option value="12">12월</option>
                        </select>
                    </div>
                    
                    <div class="view-toggle">
                        <button class="btn btn-secondary active" id="listViewBtn">목록 보기</button>
                        <button class="btn btn-secondary" id="calendarViewBtn">캘린더 보기</button>
                    </div>
                </div>
                
                <!-- 목록 뷰 -->
                <ul class="team-match-wrap" id="listView">
                    <!-- 샘플 경기 데이터 - 실제로는 서버에서 가져와야 함 -->
                    <li class="match-item">
                        <div class="match-header">
                            <span class="match-date">2025년 4월 20일 (일) 14:00</span>
                            <span class="match-status status-upcoming">예정됨</span>
                        </div>
                        <div class="match-content">
                            <div class="team-info">
                                <div class="team-name">우리팀</div>
                                <div class="team-score">-</div>
                            </div>
                            <div class="vs">VS</div>
                            <div class="team-info">
                                <div class="team-name">상대팀</div>
                                <div class="team-score">-</div>
                            </div>
                        </div>
                        <div class="match-details">
                            <div class="detail-item">
                                <span class="detail-label">경기장</span>
                                <span>서울시 강남구 OO 체육관</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">리그/대회</span>
                                <span>친선 경기</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">참석 인원</span>
                                <span>8명 참석 확정 / 2명 미정</span>
                            </div>
                        </div>
                    </li>
                    
                    <li class="match-item">
                        <div class="match-header">
                            <span class="match-date">2025년 4월 5일 (토) 16:30</span>
                            <span class="match-status status-completed">완료됨</span>
                        </div>
                        <div class="match-content">
                            <div class="team-info">
                                <div class="team-name">우리팀</div>
                                <div class="team-score">3</div>
                            </div>
                            <div class="vs">VS</div>
                            <div class="team-info">
                                <div class="team-name">강남FC</div>
                                <div class="team-score">2</div>
                            </div>
                        </div>
                        <div class="match-details">
                            <div class="detail-item">
                                <span class="detail-label">경기장</span>
                                <span>서울시 송파구 XX 공원</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">리그/대회</span>
                                <span>지역 리그 2차전</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">참석 인원</span>
                                <span>10명 참석</span>
                            </div>
                        </div>
                    </li>
                    
                    <li class="match-item">
                        <div class="match-header">
                            <span class="match-date">2025년 3월 28일 (토) 18:00</span>
                            <span class="match-status status-canceled">취소됨</span>
                        </div>
                        <div class="match-content">
                            <div class="team-info">
                                <div class="team-name">우리팀</div>
                                <div class="team-score">-</div>
                            </div>
                            <div class="vs">VS</div>
                            <div class="team-info">
                                <div class="team-name">서초구팀</div>
                                <div class="team-score">-</div>
                            </div>
                        </div>
                        <div class="match-details">
                            <div class="detail-item">
                                <span class="detail-label">경기장</span>
                                <span>서울시 서초구 YY 체육센터</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">리그/대회</span>
                                <span>친선 경기</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">취소 사유</span>
                                <span>우천으로 인한 경기 취소</span>
                            </div>
                        </div>
                    </li>
                </ul>
                
                <!-- 캘린더 뷰 -->
                <div class="calendar-view" id="calendarView">
                    <div class="calendar-header">
                        <div class="month-nav">
                            <button class="btn btn-secondary" id="prevMonth">&lt;</button>
                            <span class="month-title">2025년 4월</span>
                            <button class="btn btn-secondary" id="nextMonth">&gt;</button>
                        </div>
                        <div>
                            <button class="btn btn-secondary" id="todayBtn">오늘</button>
                        </div>
                    </div>
                    <div class="calendar-grid">
                        <div class="calendar-day-header">일</div>
                        <div class="calendar-day-header">월</div>
                        <div class="calendar-day-header">화</div>
                        <div class="calendar-day-header">수</div>
                        <div class="calendar-day-header">목</div>
                        <div class="calendar-day-header">금</div>
                        <div class="calendar-day-header">토</div>
                        
                        <!-- 4월 캘린더 그리드 샘플 (실제로는 JavaScript로 생성) -->
                        <div class="calendar-day empty-day"></div>
                        <div class="calendar-day">
                            <div class="day-number">1</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">2</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">3</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">4</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">5</div>
                            <div class="day-event">강남FC vs 우리팀 16:30</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">6</div>
                        </div>
                        
                        <!-- 나머지 달력 셀 샘플 -->
                        <div class="calendar-day">
                            <div class="day-number">7</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">8</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">9</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">10</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">11</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">12</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">13</div>
                        </div>
                        
                        <div class="calendar-day">
                            <div class="day-number">14</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">15</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">16</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">17</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">18</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">19</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">20</div>
                            <div class="day-event">우리팀 vs 상대팀 14:00</div>
                        </div>
                        
                        <!-- 더 많은 달력 셀 샘플 -->
                        <div class="calendar-day">
                            <div class="day-number">21</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">22</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">23</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">24</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">25</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">26</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">27</div>
                        </div>
                        
                        <div class="calendar-day">
                            <div class="day-number">28</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">29</div>
                        </div>
                        <div class="calendar-day">
                            <div class="day-number">30</div>
                        </div>
                        <div class="calendar-day empty-day"></div>
                        <div class="calendar-day empty-day"></div>
                        <div class="calendar-day empty-day"></div>
                        <div class="calendar-day empty-day"></div>
                    </div>
                </div>
                
                <!-- 경기 없을 때 메시지 (JavaScript로 처리) -->
                <div class="no-match-placeholder" id="noMatchPlaceholder" style="display: none;">
                    선택한 조건에 맞는 경기 일정이 없습니다.
                </div>
            </div>
            <!-- .main-content  -->
        </div>
        <!-- .main  -->
    </div>

    <!-- JavaScript 코드 -->
    <script>
        // DOM 요소
        const listView = document.getElementById('listView');
        const calendarView = document.getElementById('calendarView');
        const listViewBtn = document.getElementById('listViewBtn');
        const calendarViewBtn = document.getElementById('calendarViewBtn');
        const noMatchPlaceholder = document.getElementById('noMatchPlaceholder');
        const statusFilter = document.getElementById('statusFilter');
        const yearFilter = document.getElementById('yearFilter');
        const monthFilter = document.getElementById('monthFilter');
        const addMatchBtn = document.getElementById('addMatchBtn');
        const exportBtn = document.getElementById('exportBtn');
        const prevMonthBtn = document.getElementById('prevMonth');
        const nextMonthBtn = document.getElementById('nextMonth');
        const todayBtn = document.getElementById('todayBtn');
        const monthTitle = document.querySelector('.month-title');
        
        // 현재 날짜 정보
        const currentDate = new Date();
        let currentYear = currentDate.getFullYear();
        let currentMonth = currentDate.getMonth();
        
        // 샘플 데이터 (실제로는 서버에서 가져와야 함)
        const matchData = [
            {
                id: 1,
                date: new Date(2025, 3, 20, 14, 0), // 2025년 4월 20일 14:00
                homeTeam: '우리팀',
                awayTeam: '상대팀',
                homeScore: null,
                awayScore: null,
                status: 'upcoming',
                venue: '서울시 강남구 OO 체육관',
                league: '친선 경기',
                attendance: '8명 참석 확정 / 2명 미정'
            },
            {
                id: 2,
                date: new Date(2025, 3, 5, 16, 30), // 2025년 4월 5일 16:30
                homeTeam: '강남FC',
                awayTeam: '우리팀',
                homeScore: 2,
                awayScore: 3,
                status: 'completed',
                venue: '서울시 송파구 XX 공원',
                league: '지역 리그 2차전',
                attendance: '10명 참석'
            },
            {
                id: 3,
                date: new Date(2025, 2, 28, 18, 0), // 2025년 3월 28일 18:00
                homeTeam: '서초구팀',
                awayTeam: '우리팀',
                homeScore: null,
                awayScore: null,
                status: 'canceled',
                venue: '서울시 서초구 YY 체육센터',
                league: '친선 경기',
                cancelReason: '우천으로 인한 경기 취소'
            }
        ];
        
        // 뷰 토글 (목록 <-> 캘린더)
        listViewBtn.addEventListener('click', () => {
            listView.style.display = 'block';
            calendarView.style.display = 'none';
            listViewBtn.classList.add('active');
            calendarViewBtn.classList.remove('active');
        });
        
        calendarViewBtn.addEventListener('click', () => {
            listView.style.display = 'none';
            calendarView.style.display = 'block';
            listViewBtn.classList.remove('active');
            calendarViewBtn.classList.add('active');
            renderCalendar(currentYear, currentMonth);
        });
        
        // 필터링 함수
        function filterMatches() {
            const status = statusFilter.value;
            const year = parseInt(yearFilter.value);
            const month = monthFilter.value === 'all' ? 'all' : parseInt(monthFilter.value) - 1;
            
            const filteredMatches = matchData.filter(match => {
                // 상태 필터링
                if (status !== 'all' && match.status !== status) {
                    return false;
                }
                
                // 연도 필터링
                if (match.date.getFullYear() !== year) {
                    return false;
                }
                
                // 월 필터링
                if (month !== 'all' && match.date.getMonth() !== month) {
                    return false;
                }
                
                return true;
            });
            
            renderMatchList(filteredMatches);
            
            // 캘린더 보기가 활성화된 경우 캘린더도 업데이트
            if (calendarView.style.display === 'block') {
                renderCalendar(year, month === 'all' ? currentMonth : month);
            }
        }
        
        // 이벤트 리스너 등록
        statusFilter.addEventListener('change', filterMatches);
        yearFilter.addEventListener('change', filterMatches);
        monthFilter.addEventListener('change', filterMatches);
        
        // 일정 추가 버튼 이벤트
        addMatchBtn.addEventListener('click', () => {
            alert('일정 추가 기능은 개발 중입니다.');
            // 여기에 일정 추가 모달 열기 등의 코드가 들어갈 수 있음
        });
        
        // 일정 내보내기 버튼 이벤트
        exportBtn.addEventListener('click', () => {
            alert('일정 내보내기 기능은 개발 중입니다.');
            // 여기에 CSV 또는 캘린더 형식으로 내보내기 기능이 들어갈 수 있음
        });
        
        // 캘린더 네비게이션 (이전 달, 다음 달, 오늘)
        prevMonthBtn.addEventListener('click', () => {
            currentMonth--;
            if (currentMonth < 0) {
                currentMonth = 11;
                currentYear--;
            }
            renderCalendar(currentYear, currentMonth);
        });
        
        nextMonthBtn.addEventListener('click', () => {
            currentMonth++;
            if (currentMonth > 11) {
                currentMonth = 0;
                currentYear++;
            }
            renderCalendar(currentYear, currentMonth);
        });
        
        todayBtn.addEventListener('click', () => {
            const today = new Date();
            currentYear = today.getFullYear();
            currentMonth = today.getMonth();
            renderCalendar(currentYear, currentMonth);
        });
        
        // 경기 목록 렌더링 함수
        function renderMatchList(matches) {
            if (matches.length === 0) {
                listView.style.display = 'none';
                noMatchPlaceholder.style.display = 'block';
            } else {
                listView.style.display = 'block';
                noMatchPlaceholder.style.display = 'none';
                
                // 기존 목록 비우기
                listView.innerHTML = '';
                
                // 경기 항목 추가
                matches.forEach(match => {
                    const matchItem = document.createElement('li');
                    matchItem.className = 'match-item';
                    
                    // 날짜 포맷팅
                    const dateOptions = { year: 'numeric', month: 'long', day: 'numeric', weekday: 'short', hour: '2-digit', minute: '2-digit' };
                    const formattedDate = match.date.toLocaleDateString('ko-KR', dateOptions);
                    
                    // 상태에 따른 클래스
                    let statusClass = '';
                    let statusText = '';
                    
                    switch (match.status) {
                        case 'upcoming':
                            statusClass = 'status-upcoming';
                            statusText = '예정됨';
                            break;
                        case 'completed':
                            statusClass = 'status-completed';
                            statusText = '완료됨';
                            break;
                        case 'canceled':
                            statusClass = 'status-canceled';
                            statusText = '취소됨';
                            break;
                    }
                    
                    // HTML 구성
                    matchItem.innerHTML = `
                        <div class="match-header">
                            <span class="match-date">${formattedDate}</span>
                            <span class="match-status ${statusClass}">${statusText}</span>
                        </div>
                        <div class="match-content">
                            <div class="team-info">
                                <div class="team-name">${match.homeTeam}</div>
                                <div class="team-score">${match.homeScore !== null ? match.homeScore : '-'}</div>
                            </div>
                            <div class="vs">VS</div>
                            <div class="team-info">
                                <div class="team-name">${match.awayTeam}</div>
                                <div class="team-score">${match.awayScore !== null ? match.awayScore : '-'}</div>
                            </div>
                        </div>
                        <div class="match-details">
                            <div class="detail-item">
                                <span class="detail-label">경기장</span>
                                <span>${match.venue}</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">리그/대회</span>
                                <span>${match.league}</span>
                            </div>
                            ${match.status === 'canceled' 
                                ? `<div class="detail-item">
                                    <span class="detail-label">취소 사유</span>
                                    <span>${match.cancelReason}</span>
                                   </div>`
                                : `<div class="detail-item">
                                    <span class="detail-label">참석 인원</span>
                                    <span>${match.attendance}</span>
                                   </div>`
                            }
                        </div>
                    `;
                    
                    listView.appendChild(matchItem);
                });
            }
        }
        
        // 캘린더 렌더링 함수
        function renderCalendar(year, month) {
            // 월 제목 업데이트
            const monthNames = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
            monthTitle.textContent = `${year}년 ${monthNames[month]}`;
            
            // 월의 첫날과 마지막 날 구하기
            const firstDay = new Date(year, month, 1);
            const lastDay = new Date(year, month + 1, 0);
            
            // 달력 그리드 생성
            const calendarGrid = document.querySelector('.calendar-grid');
            calendarGrid.innerHTML = '';
            
            // 요일 헤더 추가
            const weekdays = ['일', '월', '화', '수', '목', '금', '토'];
            weekdays.forEach(day => {
                const dayHeader = document.createElement('div');
                dayHeader.className = 'calendar-day-header';
                dayHeader.textContent = day;
                calendarGrid.appendChild(dayHeader);
            });
            
            // 첫 주의 빈 칸 추가
            for (let i = 0; i < firstDay.getDay(); i++) {
                const emptyDay = document.createElement('div');
                emptyDay.className = 'calendar-day empty-day';
                calendarGrid.appendChild(emptyDay);
            }
            
            // 날짜 추가
            for (let day = 1; day <= lastDay.getDate(); day++) {
                const calendarDay = document.createElement('div');
                calendarDay.className = 'calendar-day';
                
                const dayNumber = document.createElement('div');
                dayNumber.className = 'day-number';
                dayNumber.textContent = day;
                calendarDay.appendChild(dayNumber);
                
                // 해당 날짜의 경기 찾기
                const currentDate = new Date(year, month, day);
                const matchesOnDay = matchData.filter(match => {
                    return match.date.getDate() === day && 
                           match.date.getMonth() === month && 
                           match.date.getFullYear() === year;
                });
                
                // 경기가 있으면 이벤트 추가
                matchesOnDay.forEach(match => {
                    const dayEvent = document.createElement('div');
                    dayEvent.className = 'day-event';
                    
                    // 시간 포맷팅
                    const hours = match.date.getHours().toString().padStart(2, '0');
                    const minutes = match.date.getMinutes().toString().padStart(2, '0');
                    const time = `${hours}:${minutes}`;
                    
                    dayEvent.textContent = `${match.homeTeam} vs ${match.awayTeam} ${time}`;
                    
                    // 상태에 따른 클래스 추가
                    switch (match.status) {
                        case 'completed':
                            dayEvent.style.backgroundColor = '#e8f5e9';
                            dayEvent.style.color = '#388e3c';
                            break;
                        case 'canceled':
                            dayEvent.style.backgroundColor = '#ffebee';
                            dayEvent.style.color = '#c62828';
                            break;
                    }
                    
                    dayEvent.addEventListener('click', () => {
                        // 경기 상세 정보를 보여주는 기능을 여기에 추가할 수 있음
                        alert(`${match.homeTeam} vs ${match.awayTeam} 경기 상세 정보`);
                    });
                    
                    calendarDay.appendChild(dayEvent);
                });
                
                calendarGrid.appendChild(calendarDay);
            }
            
            // 마지막 주의 빈 칸 추가
            const lastDayOfMonth = new Date(year, month, lastDay.getDate());
            const remainingCells = 7 - ((firstDay.getDay() + lastDay.getDate()) % 7);
            if (remainingCells < 7) {
                for (let i = 0; i < remainingCells; i++) {
                    const emptyDay = document.createElement('div');
                    emptyDay.className = 'calendar-day empty-day';
                    calendarGrid.appendChild(emptyDay);
                }
            }
        }
        
        // 초기 렌더링
        renderMatchList(matchData);
        
        // 현재 날짜로 필터 초기화
        yearFilter.value = currentDate.getFullYear().toString();
        monthFilter.value = (currentDate.getMonth() + 1).toString();
        
        // 모바일 환경에서의 UI 최적화
        function adjustForMobile() {
            if (window.innerWidth <= 768) {
                // 모바일 환경에서의 추가 설정이 필요하면 여기에 작성
            }
        }
        
        window.addEventListener('resize', adjustForMobile);
        adjustForMobile();
    </script>