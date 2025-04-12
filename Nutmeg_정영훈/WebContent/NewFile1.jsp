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
        
        /* 검색 영역 스타일 */
        .search-container {
            width: 100%;
            
            max-width: 1000px;
            margin: 20px auto;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        
        .search-form {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .date-input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .btn-search {
            background-color: #1a73e8;
            color: white;
            border: none;
            padding: 10px 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .btn-search:hover {
            background-color: #1557b0;
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
        
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        h1 {
            margin: 0;
            color: #333;
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
        
        /* 폼 스타일 */
        .form {
            width: 100%;
        }
        
        .form__section {
            margin-bottom: 20px;
        }
        
        .form__group {
            margin-bottom: 20px;
        }
        
        .form__field {
            margin-bottom: 15px;
        }
        
        .form__label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        .form__label.required:after {
            content: "*";
            color: red;
            margin-left: 3px;
        }
        
        .form__selection {
            display: flex;
            gap: 10px;
        }
        
        .form__input,
        .selectpicker {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        
        .form__actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }
        
        .btn {
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            border: none;
        }
        
        .btn--submit {
            background-color: #1a73e8;
            color: white;
        }
        
        .btn--submit:hover {
            background-color: #1557b0;
        }
        
        .btn--reset {
            background-color: #f1f1f1;
            color: #333;
        }
        
        .btn--reset:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <!-- 검색 컨테이너 -->
    <div class="search-container">
        <form class="search-form" id="dateSearchForm">
            <input type="date" class="date-input" id="searchDate" required>
            <button type="submit" class="btn-search">검색</button>
        </form>
    </div>
    
    <!-- 본문 컨테이너 -->
    <div class="merc-container">
        <div class="header-container">
            <h1>용병 게시판</h1>
            <button id="addMercenaryBtn" class="btn-add">용병 등록</button>
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
    
    <!-- 용병 등록 모달 -->
    <div class="modal">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <h2>용병 등록</h2>
            <form class="form" method="POST" action="MercenaryInsert.action">
                <!-- 포지션 -->
                <div class="form__section">
                    <select name="position_id" id="position"
                    class="selectpicker" style="width: 150px; margin-top: 10px; margin-bottom: 10px;">
                        <option value="">포지션 선택 선택</option>
                        <c:forEach var="position" items="${positionList}">
                            <option value="${position.position_id }">${position.position_name}</option>
                        </c:forEach>
                    </select> 
                </div>
                <!-- 지역 -->
                <div class="form__group">
                    <div class="form__field">
                        <label class="form__label required">지역</label>
                        
                        <div class="form__selection">
                            <select id="regions" name="region_id" class="form__input" required>
                                <option value="">시를 선택하세요</option>
                                
                                <c:forEach var="region" items="${regionList}">
                                    <option value="${region.region_id}">${region.region_name}</option>
                                </c:forEach>
                            </select>
                            
                            <select id="citys" name="city_id" class="form__input" required>
                                <option value="">구를 선택하세요</option>
                            </select>
                        </div>
                    </div>
                </div>
                <!-- 버튼 -->
                <div class="form__actions">
                    <button type="submit" class="btn btn--submit">지원하기</button>
                    <button type="reset" class="btn btn--reset">취소</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // 오늘 날짜를 기본값으로 설정
            let today = new Date();
            let formattedDate = today.toISOString().split('T')[0];
            $('#searchDate').val(formattedDate);
            
            // 날짜 제한 설정 (오늘부터 1달 후까지)
            let oneMonthLater = new Date(today);
            oneMonthLater.setMonth(today.getMonth() + 1);
            let maxDate = oneMonthLater.toISOString().split('T')[0];
            
            $('#searchDate').attr('min', formattedDate);
            $('#searchDate').attr('max', maxDate);
            
            // 초기 데이터 로드
            loadMercenaryData(formattedDate);
            
            // 날짜 검색 폼 제출 이벤트
            $('#dateSearchForm').submit(function(event) {
                event.preventDefault();
                let selectedDate = $('#searchDate').val();
                loadMercenaryData(selectedDate);
            });
            
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
                            let selectedDate = $('#searchDate').val();
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
                $('.modal').css('display', 'block');
            }
            
            // 모달 닫기
            function closeModal() {
                $('.modal').css('display', 'none');
                $('.form')[0].reset();
            }
            
            // 지역에 따른 도시 로드
            function loadCities(regionId) {
                if (!regionId) {
                    $('#citys').html('<option value="">구를 선택하세요</option>');
                    return;
                }
                
                $.ajax({
                    url: '/city/by-region', // 실제 API 엔드포인트로 변경해야 합니다
                    type: 'GET',
                    data: { region_id: regionId },
                    dataType: 'json',
                    success: function(data) {
                        let citySelect = $('#citys');
                        citySelect.html('<option value="">구를 선택하세요</option>');
                        
                        data.forEach(function(city) {
                            citySelect.append(
                                $('<option>', {
                                    value: city.city_id,
                                    text: city.city_name
                                })
                            );
                        });
                    },
                    error: function(xhr, status, error) {
                        console.error('도시 목록 로드 오류:', error);
                        alert('도시 목록을 불러오는 중 오류가 발생했습니다.');
                    }
                });
            }
            
            // 모달 이벤트 리스너
            $('#addMercenaryBtn').click(function() {
                openModal();
            });
            
            $('.close-modal, .btn--reset').click(function() {
                closeModal();
            });
            
            $(window).click(function(event) {
                if ($(event.target).is('.modal')) {
                    closeModal();
                }
            });
            
            // 지역 변경 이벤트
            $('#regions').change(function() {
                let regionId = $(this).val();
                loadCities(regionId);
            });
        });
    </script>
</body>
</html>