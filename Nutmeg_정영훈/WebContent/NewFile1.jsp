<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>용병 게시판</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        /* 전체 스타일 */
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        /* 캘린더 스타일 */
        .calendar-container {
            width: 100%;
            max-width: 1000px;
            margin: 20px auto;
            overflow: hidden;
        }
        
        .calendar-nav {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .nav-arrow {
            background-color: #f0f0f0;
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            font-size: 18px;
            color: #666;
        }
        
        .date-list {
            display: flex;
            list-style: none;
            padding: 0;
            margin: 0;
            justify-content: space-between;
            width: 100%;
            overflow-x: auto;
        }
        
        .date-item {
            min-width: 80px;
            height: 80px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            border-radius: 10px;
            margin: 0 5px;
            transition: all 0.3s ease;
        }
        
        .date-item .day-number {
            font-size: 24px;
            font-weight: bold;
        }
        
        .date-item .day-name {
            font-size: 14px;
        }
        
        .date-item.active {
            background-color: #1a73e8;
            color: white;
        }
        
        .date-item:not(.active):hover {
            background-color: #f0f0f0;
        }
        
        /* 용병 게시판 테이블 스타일 */
        .merc-container {
            width: 100%;
            max-width: 1000px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .table-row {
            display: flex;
            border-bottom: 1px solid #eee;
        }
        
        .table-header {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        
        .table-cell {
            flex: 1;
            padding: 12px 15px;
            text-align: center;
        }
        
        .btn-hire {
            background-color: #1a73e8;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .btn-hire:hover {
            background-color: #1557b0;
        }
        
        /* 헤더 컨테이너 스타일 */
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .btn-add {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .btn-add:hover {
            background-color: #3e8e41;
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
        }
        
        .modal-content {
            background-color: #fff;
            margin: 10% auto;
            padding: 20px;
            border-radius: 8px;
            width: 80%;
            max-width: 500px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            position: relative;
        }
        
        .close-modal {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
            color: #aaa;
        }
        
        .close-modal:hover {
            color: #333;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        
        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }
        
        .btn-submit {
            background-color: #1a73e8;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .btn-submit:hover {
            background-color: #1557b0;
        }
        
        .btn-cancel {
            background-color: #f1f1f1;
            color: #333;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .btn-cancel:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <!-- 캘린더 컨테이너 -->
    <div class="calendar-container">
        <div class="calendar-nav">
            <button class="nav-arrow prev-week">◀</button>
            <ul class="date-list" id="dateList"></ul>
            <button class="nav-arrow next-week">▶</button>
        </div>
    </div>
    
    <!-- 본문 컨테이너 -->
    <div class="merc-container">
        <div class="header-container">
            <h1>용병 게시판</h1>
            <button id="addTimeLogBtn" class="btn-add">시간 기록 추가</button>
        </div>
        <!-- 리스트 출력 -->
        <div class="table">
            <div class="table-header table-row">
                <div class="table-cell">닉네임</div>
                <div class="table-cell">포지션</div>
                <div class="table-cell">지역</div>
                <div class="table-cell">고용</div>
            </div>
            <div id="mercenaryList">
                <!-- 여기에 AJAX로 불러온 데이터가 표시됩니다 -->
            </div>
        </div>
    </div>
    
    <!-- 시간 기록 모달 -->
    <div id="timeLogModal" class="modal">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <h2>용병 시간 기록</h2>
            <form id="timeLogForm">
                <div class="form-group">
                    <label for="mercenaryId">용병 ID</label>
                    <select id="mercenaryId" name="mercenaryId" required>
                        <option value="">용병 선택</option>
                        <!-- AJAX로 용병 목록을 불러옵니다 -->
                    </select>
                </div>
                <div class="form-group">
                    <label for="startTime">시작 시간</label>
                    <input type="datetime-local" id="startTime" name="startTime" required>
                </div>
                <div class="form-group">
                    <label for="endTime">종료 시간</label>
                    <input type="datetime-local" id="endTime" name="endTime" required>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn-submit">저장</button>
                    <button type="button" class="btn-cancel">취소</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // 날짜 데이터 관리를 위한 변수
            let currentDate = new Date();
            let currentDay = currentDate.getDay(); // 0(일) ~ 6(토)
            
            // 오늘 날짜를 기준으로 한 주의 시작일 계산 (일요일 기준)
            let weekStart = new Date(currentDate);
            weekStart.setDate(currentDate.getDate() - currentDay);
            
            // 달력 생성 함수
            function generateCalendar(startDate) {
                let dateList = $('#dateList');
                dateList.empty();
                
                // 요일 이름 배열
                const dayNames = ['일', '월', '화', '수', '목', '금', '토'];
                
                // 주별 7일 생성
                for (let i = 0; i < 7; i++) {
                    let date = new Date(startDate);
                    date.setDate(startDate.getDate() + i);
                    
                    // 날짜 포맷팅
                    let dayNumber = date.getDate();
                    let dayName = dayNames[date.getDay()];
                    
                    // 오늘 날짜 확인
                    let isToday = date.toDateString() === currentDate.toDateString();
                    
                    // 날짜 아이템 생성
                    let dateItem = $('<li>', {
                        class: 'date-item' + (isToday ? ' active' : ''),
                        'data-date': formatDate(date)
                    });
                    
                    dateItem.append($('<div>', {
                        class: 'day-number',
                        text: dayNumber
                    }));
                    
                    dateItem.append($('<div>', {
                        class: 'day-name',
                        text: dayName
                    }));
                    
                    dateList.append(dateItem);
                }
                
                // 날짜 클릭 이벤트 처리
                $('.date-item').click(function() {
                    $('.date-item').removeClass('active');
                    $(this).addClass('active');
                    
                    let selectedDate = $(this).data('date');
                    loadMercenaryData(selectedDate);
                });
            }
            
            // 날짜 포맷 함수 (YYYY-MM-DD)
            function formatDate(date) {
                let year = date.getFullYear();
                let month = String(date.getMonth() + 1).padStart(2, '0');
                let day = String(date.getDate()).padStart(2, '0');
                return `${year}-${month}-${day}`;
            }
            
            // AJAX로 용병 데이터 불러오기
            function loadMercenaryData(selectedDate) {
                $.ajax({
                    url: '/mercenary/list', // 실제 API 엔드포인트로 변경해야 합니다
                    type: 'GET',
                    data: { date: selectedDate },
                    dataType: 'json',
                    success: function(data) {
                        renderMercenaryList(data);
                    },
                    error: function(xhr, status, error) {
                        console.error('데이터 로드 오류:', error);
                        $('#mercenaryList').html('<div class="table-row"><div class="table-cell" colspan="4">데이터를 불러오는 중 오류가 발생했습니다.</div></div>');
                    }
                });
            }
            
            // 용병 리스트 렌더링 함수
            function renderMercenaryList(mercenaryList) {
                let listContainer = $('#mercenaryList');
                listContainer.empty();
                
                if (!mercenaryList || mercenaryList.length === 0) {
                    listContainer.html('<div class="table-row"><div class="table-cell" colspan="4">해당 날짜에 등록된 용병이 없습니다.</div></div>');
                    return;
                }
                
                mercenaryList.forEach(function(mercenary) {
                    let row = $('<div>', { class: 'table-row' });
                    
                    row.append($('<div>', {
                        class: 'table-cell',
                        text: mercenary.user_nick_name
                    }));
                    
                    row.append($('<div>', {
                        class: 'table-cell',
                        text: mercenary.position_name
                    }));
                    
                    row.append($('<div>', {
                        class: 'table-cell',
                        text: mercenary.region_name
                    }));
                    
                    let hireCell = $('<div>', { class: 'table-cell' });
                    let hireButton = $('<button>', {
                        class: 'btn-hire',
                        text: '고용',
                        'data-id': mercenary.id
                    });
                    
                    hireButton.click(function() {
                        hireMercenary($(this).data('id'));
                    });
                    
                    hireCell.append(hireButton);
                    row.append(hireCell);
                    
                    listContainer.append(row);
                });
            }
            
            // 용병 고용 함수
            function hireMercenary(mercenaryId) {
                $.ajax({
                    url: '/mercenary/hire', // 실제 API 엔드포인트로 변경해야 합니다
                    type: 'POST',
                    data: { id: mercenaryId },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            alert('용병 고용이 완료되었습니다.');
                            // 현재 선택된 날짜의 데이터 다시 로드
                            let selectedDate = $('.date-item.active').data('date');
                            loadMercenaryData(selectedDate);
                        } else {
                            alert('용병 고용 중 오류가 발생했습니다: ' + response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        alert('용병 고용 요청 중 오류가 발생했습니다.');
                        console.error('고용 오류:', error);
                    }
                });
            }
            
            // 모달 관련 함수들
            // 모달 열기
            function openModal() {
                $('#timeLogModal').css('display', 'block');
                loadMercenaryOptions();
            }
            
            // 모달 닫기
            function closeModal() {
                $('#timeLogModal').css('display', 'none');
                $('#timeLogForm')[0].reset();
            }
            
            // 용병 옵션 로드
            function loadMercenaryOptions() {
                $.ajax({
                    url: '/mercenary/all', // 실제 API 엔드포인트로 변경해야 합니다
                    type: 'GET',
                    dataType: 'json',
                    success: function(data) {
                        let mercenarySelect = $('#mercenaryId');
                        mercenarySelect.find('option:not(:first)').remove();
                        
                        data.forEach(function(mercenary) {
                            mercenarySelect.append(
                                $('<option>', {
                                    value: mercenary.mercenary_id,
                                    text: mercenary.user_nick_name + ' (' + mercenary.position_name + ')'
                                })
                            );
                        });
                    },
                    error: function(xhr, status, error) {
                        console.error('용병 목록 로드 오류:', error);
                        alert('용병 목록을 불러오는 중 오류가 발생했습니다.');
                    }
                });
            }
            
            // 시간 기록 저장
            function saveTimeLog(formData) {
                $.ajax({
                    url: '/mercenary/time-log/add', // 실제 API 엔드포인트로 변경해야 합니다
                    type: 'POST',
                    data: formData,
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            alert('시간 기록이 저장되었습니다.');
                            closeModal();
                            // 현재 선택된 날짜의 데이터 다시 로드
                            let selectedDate = $('.date-item.active').data('date');
                            loadMercenaryData(selectedDate);
                        } else {
                            alert('시간 기록 저장 중 오류가 발생했습니다: ' + response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        alert('시간 기록 저장 요청 중 오류가 발생했습니다.');
                        console.error('저장 오류:', error);
                    }
                });
            }
            
            // 모달 이벤트 리스너
            $('#addTimeLogBtn').click(function() {
                openModal();
            });
            
            $('.close-modal, .btn-cancel').click(function() {
                closeModal();
            });
            
            $(window).click(function(event) {
                if ($(event.target).is('#timeLogModal')) {
                    closeModal();
                }
            });
            
            // 폼 제출 이벤트
            $('#timeLogForm').submit(function(event) {
                event.preventDefault();
                
                // 시작 시간과 종료 시간 유효성 검사
                let startTime = new Date($('#startTime').val());
                let endTime = new Date($('#endTime').val());
                
                if (startTime >= endTime) {
                    alert('종료 시간은 시작 시간보다 나중이어야 합니다.');
                    return;
                }
                
                // 폼 데이터 수집
                let formData = {
                    mercenary_id: $('#mercenaryId').val(),
                    start_time: $('#startTime').val(),
                    end_time: $('#endTime').val()
                };
                
                saveTimeLog(formData);
            });
            
            // 이전 주 버튼 클릭 이벤트
            $('.prev-week').click(function() {
                weekStart.setDate(weekStart.getDate() - 7);
                generateCalendar(weekStart);
            });
            
            // 다음 주 버튼 클릭 이벤트
            $('.next-week').click(function() {
                weekStart.setDate(weekStart.getDate() + 7);
                generateCalendar(weekStart);
            });
            
            // 초기 달력 생성
            generateCalendar(weekStart);
            
            // 초기 데이터 로드 (오늘 날짜)
            loadMercenaryData(formatDate(currentDate));
        });
    </script>
</body>
</html>