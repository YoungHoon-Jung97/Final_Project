<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
    Integer user_code_id = (Integer) session.getAttribute("user_code_id");
    
    // 현재 날짜 정보 가져오기
    java.util.Calendar cal = java.util.Calendar.getInstance();
    int year = request.getParameter("year") != null ? Integer.parseInt(request.getParameter("year")) : cal.get(java.util.Calendar.YEAR);
    int month = request.getParameter("month") != null ? Integer.parseInt(request.getParameter("month")) : cal.get(java.util.Calendar.MONTH) + 1;
    
    // 이전 월, 다음 월 계산
    int prevYear = month == 1 ? year - 1 : year;
    int prevMonth = month == 1 ? 12 : month - 1;
    int nextYear = month == 12 ? year + 1 : year;
    int nextMonth = month == 12 ? 1 : month + 1;
    
    // 월의 첫날과 마지막 날
    cal.set(year, month - 1, 1);
    int firstDayOfWeek = cal.get(java.util.Calendar.DAY_OF_WEEK); // 1: 일요일, 2: 월요일, ...
    int lastDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
    
    // 현재 날짜 (오늘)
    java.util.Calendar today = java.util.Calendar.getInstance();
    int currentDay = today.get(java.util.Calendar.DATE);
    int currentMonth = today.get(java.util.Calendar.MONTH) + 1;
    int currentYear = today.get(java.util.Calendar.YEAR);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>팀 경기 일정</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
            background-color: #1a73e8;
            color: white;
        }
        
        /* 캘린더 스타일 */
        .calendar-container {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 20px;
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
        }
        
        .calendar-day-header {
            padding: 10px;
            text-align: center;
            font-weight: 500;
            border: 1px solid #e0e0e0;
            background-color: #f8f9fa;
        }
        
        .sunday {
            color: #e74c3c;
        }
        
        .saturday {
            color: #3498db;
        }
        
        .calendar-day {
            height: 90px;
            padding: 5px;
            border: 1px solid #e0e0e0;
            vertical-align: top;
            position: relative;
        }
        
        .today {
            background-color: #e8f0fe;
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
        
        .completed-event {
            background-color: #e8f5e9;
            color: #388e3c;
        }
        
        .canceled-event {
            background-color: #ffebee;
            color: #c62828;
        }
        
        .empty-day {
            background-color: #f8f9fa;
        }
        
        /* 일정 목록 스타일 */
        .match-list {
            list-style: none;
            padding: 0;
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
        
        .match-date {
            font-weight: 500;
        }
        
        .match-status {
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 12px;
        }
        
        .match-teams {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
        }
        
        .team {
            text-align: center;
            width: 40%;
        }
        
        .team-name {
            font-weight: 500;
            margin-bottom: 5px;
        }
        
        .team-score {
            font-size: 24px;
            font-weight: bold;
        }
        
        .vs {
            margin: 0 20px;
            font-size: 16px;
            color: #888;
        }
        
        .match-details {
            font-size: 14px;
            color: #555;
            border-top: 1px solid #e0e0e0;
            padding-top: 10px;
            margin-top: 10px;
        }
        
        .detail-item {
            margin-bottom: 5px;
        }
        
        .detail-label {
            font-weight: 500;
            display: inline-block;
            width: 100px;
        }
        
        .no-match {
            text-align: center;
            padding: 30px;
            color: #888;
        }
        
        /* 버튼 스타일 */
        .btn {
            padding: 8px 16px;
            border-radius: 4px;
            border: none;
            font-size: 14px;
            cursor: pointer;
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
        
        /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        
        .modal-content {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            width: 90%;
            max-width: 500px;
        }
        
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .modal-title {
            font-size: 18px;
            font-weight: 500;
        }
        
        .close-modal {
            background: none;
            border: none;
            font-size: 20px;
            cursor: pointer;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }
        
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
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
                    <button id="addMatchBtn" class="btn btn-primary">일정 추가</button>
                </div>
                
                <!-- 보기 전환 버튼 -->
                <div class="view-buttons">
                    <button id="listViewBtn" class="active">목록 보기</button>
                    <button id="calendarViewBtn">캘린더 보기</button>
                </div>
                
                <!-- 캘린더 보기 -->
                <div id="calendarView" class="calendar-container" style="display: none;">
                    <div class="calendar-header">
                        <div class="month-nav">
                            <a href="MyTeamSchedule.action?year=<%=prevYear%>&month=<%=prevMonth%>" class="btn btn-secondary">&lt;</a>
                            <span class="month-title"><%=year%>년 <%=month%>월</span>
                            <a href="MyTeamSchedule.action?year=<%=nextYear%>&month=<%=nextMonth%>" class="btn btn-secondary">&gt;</a>
                        </div>
                        <a href="MyTeamSchedule.action" class="btn btn-secondary">오늘</a>
                    </div>
                    
                    <div class="calendar-grid">
                        <!-- 요일 헤더 -->
                        <div class="calendar-day-header sunday">일</div>
                        <div class="calendar-day-header">월</div>
                        <div class="calendar-day-header">화</div>
                        <div class="calendar-day-header">수</div>
                        <div class="calendar-day-header">목</div>
                        <div class="calendar-day-header">금</div>
                        <div class="calendar-day-header saturday">토</div>
                        
                        <!-- 날짜 그리드 -->
                        <% 
                        // 이전 달의 빈 셀 생성
                        for (int i = 1; i < firstDayOfWeek; i++) { 
                        %>
                            <div class="calendar-day empty-day"></div>
                        <% 
                        }
                        
                        // 이번 달 날짜 생성
                        for (int i = 1; i <= lastDay; i++) {
                            boolean isToday = (currentYear == year && currentMonth == month && currentDay == i);
                            cal.set(year, month - 1, i);
                            int dayOfWeek = cal.get(java.util.Calendar.DAY_OF_WEEK);
                        %>
                            <div class="calendar-day <%= isToday ? "today" : "" %>">
                                <div class="day-number <%= dayOfWeek == 1 ? "sunday" : dayOfWeek == 7 ? "saturday" : "" %>">
                                    <%= i %>
                                </div>
                                
                                <% 
                                // 샘플 일정 데이터 (실제로는 DB에서 가져와야 함)
                                if (month == 4 && i == 5 && year == 2025) { 
                                %>
                                    <div class="day-event completed-event" onclick="showMatchDetails('강남FC', '우리팀', '2025-04-05', '16:30', '2', '3', '서울시 송파구 XX 공원')">
                                        강남FC vs 우리팀 16:30
                                    </div>
                                <% 
                                } 
                                if (month == 4 && i == 20 && year == 2025) { 
                                %>
                                    <div class="day-event" onclick="showMatchDetails('우리팀', '상대팀', '2025-04-20', '14:00', '-', '-', '서울시 강남구 OO 체육관')">
                                        우리팀 vs 상대팀 14:00
                                    </div>
                                <% 
                                } 
                                if (month == 3 && i == 28 && year == 2025) { 
                                %>
                                    <div class="day-event canceled-event" onclick="showMatchDetails('우리팀', '서초구팀', '2025-03-28', '18:00', '-', '-', '서울시 서초구 YY 체육센터', '취소됨')">
                                        우리팀 vs 서초구팀 18:00
                                    </div>
                                <% 
                                } 
                                %>
                            </div>
                        <% 
                        }
                        
                        // 다음 달의 빈 셀 생성
                        int remainingCells = 7 - ((firstDayOfWeek - 1 + lastDay) % 7);
                        if (remainingCells < 7) {
                            for (int i = 0; i < remainingCells; i++) { 
                        %>
                            <div class="calendar-day empty-day"></div>
                        <% 
                            }
                        }
                        %>
                    </div>
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
                    
                    <div class="match-item">
                        <div class="match-header">
                            <span class="match-date">2025년 4월 5일 (토) 16:30</span>
                            <span class="match-status" style="background-color: #e8f5e9; color: #388e3c;">완료됨</span>
                        </div>
                        <div class="match-teams">
                            <div class="team">
                                <div class="team-name">강남FC</div>
                                <div class="team-score">2</div>
                            </div>
                            <div class="vs">VS</div>
                            <div class="team">
                                <div class="team-name">우리팀</div>
                                <div class="team-score">3</div>
                            </div>
                        </div>
                        <div class="match-details">
                            <div class="detail-item">
                                <span class="detail-label">경기장:</span>
                                <span>서울시 송파구 XX 공원</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">리그/대회:</span>
                                <span>지역 리그 2차전</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">참석 인원:</span>
                                <span>10명 참석</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="match-item">
                        <div class="match-header">
                            <span class="match-date">2025년 3월 28일 (토) 18:00</span>
                            <span class="match-status" style="background-color: #ffebee; color: #c62828;">취소됨</span>
                        </div>
                        <div class="match-teams">
                            <div class="team">
                                <div class="team-name">우리팀</div>
                                <div class="team-score">-</div>
                            </div>
                            <div class="vs">VS</div>
                            <div class="team">
                                <div class="team-name">서초구팀</div>
                                <div class="team-score">-</div>
                            </div>
                        </div>
                        <div class="match-details">
                            <div class="detail-item">
                                <span class="detail-label">경기장:</span>
                                <span>서울시 서초구 YY 체육센터</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">리그/대회:</span>
                                <span>친선 경기</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">취소 사유:</span>
                                <span>우천으로 인한 경기 취소</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 일정 없음 메시지 (필요시 표시) -->
                <div id="noMatch" class="no-match" style="display: none;">
                    등록된 경기 일정이 없습니다.
                </div>
            </div>
        </div>
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
    
    <script>
        // 목록/캘린더 뷰 전환
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
        });
        
        // 일정 추가 모달 열기
        document.getElementById('addMatchBtn').addEventListener('click', function() {
            document.getElementById('addMatchModal').style.display = 'flex';
        });
        
        // 모달 닫기
        function closeModal() {
            document.getElementById('addMatchModal').style.display = 'none';
        }
        
        // 경기 상세 정보 모달 닫기
        function closeDetailsModal() {
            document.getElementById('matchDetailsModal').style.display = 'none';
        }
        
        // 경기 상세 정보 표시
        function showMatchDetails(homeTeam, awayTeam, date, time, homeScore, awayScore, venue, status) {
            var detailsContent = document.getElementById('matchDetailsContent');
            
            // 상태 색상 설정
            var statusColor = '';
            var statusText = '';
            if (status === '취소됨') {
                statusColor = 'background-color: #ffebee; color: #c62828;';
                statusText = '취소됨';
            } else if (homeScore !== '-' && awayScore !== '-') {
                statusColor = 'background-color: #e8f5e9; color: #388e3c;';
                statusText = '완료됨';
            } else {
                statusColor = 'background-color: #e3f2fd; color: #1976d2;';
                statusText = '예정됨';
            }
            
            // 상세 정보 HTML 생성
            var html = `
                <div class="match-header">
                    <span class="match-date">${date} ${time}</span>
                    <span class="match-status" style="${statusColor}">${statusText}</span>
                </div>
                <div class="match-teams" style="margin: 20px 0;">
                    <div class="team">
                        <div class="team-name">${homeTeam}</div>
                        <div class="team-score">${homeScore}</div>
                    </div>
                    <div class="vs">VS</div>
                    <div class="team">
                        <div class="team-name">${awayTeam}</div>
                        <div class="team-score">${awayScore}</div>
                    </div>
                </div>
                <div class="match-details">
                    <div class="detail-item">
                        <span class="detail-label">경기장:</span>
                        <span>${venue}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">리그/대회:</span>
                        <span>지역 리그</span>
                    </div>
                </div>
            `;
            
            // 취소된 경기인 경우 취소 사유 추가
            if (status === '취소됨') {
                html += `
                    <div class="detail-item">
                        <span class="detail-label">취소 사유:</span>
                        <span>우천으로 인한 경기 취소</span>
                    </div>
                `;
            }
            
            detailsContent.innerHTML = html;
            document.getElementById('matchDetailsModal').style.display = 'flex';
        }
        
                    // 폼 제출 이벤트
        document.getElementById('matchForm').addEventListener('submit', function(e) {
            e.preventDefault(); // 폼 제출 방지 (실제로는 서버에 제출해야 함)
            
            // 폼 데이터 수집
            var matchDate = document.getElementById('matchDate').value;
            var matchTime = document.getElementById('matchTime').value;
            var homeTeam = document.getElementById('homeTeam').value;
            var awayTeam = document.getElementById('awayTeam').value;
            var venue = document.getElementById('venue').value;
            var league = document.getElementById('league').value;
            var matchType = document.getElementById('matchType').value;
            
            // 간단한 검증 (실제로는 더 많은 검증이 필요함)
            if (!matchDate || !matchTime || !homeTeam || !awayTeam || !venue) {
                alert('필수 항목을 모두 입력해주세요.');
                return;
            }
            
            // 데이터가 정상적으로 서버로 전송되었다고 가정하고 폼 초기화
            alert('경기 일정이 추가되었습니다.');
            document.getElementById('matchForm').reset();
            closeModal();
            
            // 실제 구현에서는 서버에 AJAX로 데이터를 전송하고 
            // 성공 시 페이지를 새로고침하거나 동적으로 일정을 추가해야 함
        });
        
        // 모달 외부 클릭 시 닫기
        window.onclick = function(e) {
            if (e.target == document.getElementById('addMatchModal')) {
                closeModal();
            }
            if (e.target == document.getElementById('matchDetailsModal')) {
                closeDetailsModal();
            }
        }
        
        // 오늘 날짜 기본 설정 (일정 추가 모달)
        document.addEventListener('DOMContentLoaded', function() {
            var today = new Date();
            var yyyy = today.getFullYear();
            var mm = String(today.getMonth() + 1).padStart(2, '0');
            var dd = String(today.getDate()).padStart(2, '0');
            document.getElementById('matchDate').value = `${yyyy}-${mm}-${dd}`;
        });
    </script>
</body>
</html>