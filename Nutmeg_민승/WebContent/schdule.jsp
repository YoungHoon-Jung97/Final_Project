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
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- FullCalendar CSS -->
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet">
    
    <!-- FullCalendar 스크립트 -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales-all.min.js"></script>
    
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
        // 일정 데이터 (실제로는 서버에서 가져와야 함)
        const events = [
            {
                id: '1',
                title: '우리팀 vs 상대팀',
                start: '2025-04-20T14:00:00',
                extendedProps: {
                    homeTeam: '우리팀',
                    awayTeam: '상대팀',
                    homeScore: '-',
                    awayScore: '-',
                    venue: '서울시 강남구 OO 체육관',
                    league: '친선 경기',
                    attendance: '8명 참석 확정 / 2명 미정',
                    status: 'upcoming'
                },
                className: 'event-upcoming'
            },
            {
                id: '2',
                title: '강남FC vs 우리팀',
                start: '2025-04-05T16:30:00',
                extendedProps: {
                    homeTeam: '강남FC',
                    awayTeam: '우리팀',
                    homeScore: '2',
                    awayScore: '3',
                    venue: '서울시 송파구 XX 공원',
                    league: '지역 리그 2차전',
                    attendance: '10명 참석',
                    status: 'completed'
                },
                className: 'event-completed'
            },
            {
                id: '3',
                title: '우리팀 vs 서초구팀',
                start: '2025-03-28T18:00:00',
                extendedProps: {
                    homeTeam: '우리팀',
                    awayTeam: '서초구팀',
                    homeScore: '-',
                    awayScore: '-',
                    venue: '서울시 서초구 YY 체육센터',
                    league: '친선 경기',
                    cancelReason: '우천으로 인한 경기 취소',
                    status: 'canceled'
                },
                className: 'event-canceled'
            }
        ];
        
        // 모달 관련 함수
        function closeModal() {
            document.getElementById('addMatchModal').style.display = 'none';
        }
        
        function closeDetailsModal() {
            document.getElementById('matchDetailsModal').style.display = 'none';
        }
        
        // 경기 상세 정보 표시 함수
        function showMatchDetails(info) {
            const event = info.event;
            const props = event.extendedProps;
            
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
            
            // 날짜 포맷팅
            const date = new Date(event.start);
            const options = { 
                year: 'numeric', 
                month: 'long', 
                day: 'numeric', 
                weekday: 'short',
                hour: '2-digit',
                minute: '2-digit'
            };
            const formattedDate = date.toLocaleDateString('ko-KR', options);
            
            // HTML 생성
            let html = `
                <div class="match-header">
                    <span class="match-date">${formattedDate}</span>
                    <span class="match-status" style="${statusStyle}">${statusText}</span>
                </div>
                <div class="match-teams" style="margin: 20px 0;">
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
                html += `
                    <div class="detail-item">
                        <span class="detail-label">취소 사유:</span>
                        <span>${props.cancelReason}</span>
                    </div>
                `;
            } else {
                html += `
                    <div class="detail-item">
                        <span class="detail-label">참석 인원:</span>
                        <span>${props.attendance}</span>
                    </div>
                `;
            }
            
            html += '</div>';
            
            document.getElementById('matchDetailsContent').innerHTML = html;
            document.getElementById('matchDetailsModal').style.display = 'flex';
        }
        
        // 페이지 로드 시 실행
        document.addEventListener('DOMContentLoaded', function() {
            // FullCalendar 초기화
            const calendarEl = document.getElementById('calendar');
            const calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
                },
                events: events,
                locale: 'ko', // 한국어 설정
                eventClick: function(info) {
                    showMatchDetails(info);
                },
                dayMaxEvents: true, // 이벤트가 많을 경우 "더보기" 링크 표시
                height: 'auto', // 자동 높이 조정
                // firstDay: 1, // 월요일부터 시작하려면 1로 설정
                buttonText: {
                    today: '오늘',
                    month: '월간',
                    week: '주간',
                    day: '일간',
                    list: '목록'
                }
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
                e.preventDefault(); // 폼 제출 방지 (실제로는 서버에 제출해야 함)
                
                // 폼 데이터 수집
                const matchDate = document.getElementById('matchDate').value;
                const matchTime = document.getElementById('matchTime').value;
                const homeTeam = document.getElementById('homeTeam').value;
                const awayTeam = document.getElementById('awayTeam').value;
                const venue = document.getElementById('venue').value;
                const league = document.getElementById('league').value;
                const matchType = document.getElementById('matchType').value;
                
                // 간단한 검증
                if (!matchDate || !matchTime || !homeTeam || !awayTeam || !venue) {
                    alert('필수 항목을 모두 입력해주세요.');
                    return;
                }
                
                // FullCalendar에 이벤트 추가 (실제로는 서버에 저장 후 처리해야 함)
                const newEvent = {
                    id: String(new Date().getTime()),
                    title: `${homeTeam} vs ${awayTeam}`,
                    start: `${matchDate}T${matchTime}:00`,
                    extendedProps: {
                        homeTeam: homeTeam,
                        awayTeam: awayTeam,
                        homeScore: '-',
                        awayScore: '-',
                        venue: venue,
                        league: league || '친선 경기',
                        attendance: '참석자 미정',
                        status: 'upcoming'
                    },
                    className: 'event-upcoming'
                };
                
                calendar.addEvent(newEvent);
                
                alert('경기 일정이 추가되었습니다.');
                document.getElementById('matchForm').reset();
                closeModal();
                
                // 캘린더 보기로 전환
                document.getElementById('calendarViewBtn').click();
            });
        });
    </script>
</body>
</html>