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
<title>용병 게시판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/Time.js?after"></script>
<script type="text/javascript" src="<%=cp %>/js/Modal.js?after"></script>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/modal.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/Board.css?after">

<script>
    $(document).ready(function() {
        
    	let selectedRegionId = '';
        let selectedCityId = '';
    	
        // 모달 닫기
        function closeModal() {
            $('.modal').css('display', 'none');
            $('.form')[0].reset();
            
            // 모달 닫을 때 날짜 초기화
            $('#stardate').val(formattedDate);
        }
        
        //지역 검색
        $('#regionTabs').on('click', '.nav-link', function (e) {
    	    e.preventDefault();
    	    $('#regionTabs .nav-link').removeClass('active');
    	    $(this).addClass('active');

    	    selectedRegionId = $(this).data('id'); // 전체면 ""로 들어옴
    	    selectedCityId = '';

    	    if (selectedRegionId) {
    	        // 지역 선택 시 도시 탭 다시 로딩
    	        $.ajax({
    	            url: '${pageContext.request.contextPath}/GetCityListByRegionId.action',
    	            type: 'GET',
    	            data: { region_id: selectedRegionId },
    	            success: function (html) {
    	                $('#cityTabs').html(html);
    	                searchMercenary();
    	            }
    	        });
    	    } else {
    	        //  전체 선택 시 도시 초기화 + 검색 실행
    	        $('#cityTabs').html(`<li class="nav-item"><a class="nav-link active" href="#" data-id="">전체</a></li>`);
    	        searchMercenary();
    	    }
    	});

        $('#cityTabs').on('click', '.nav-link', function (e) {
            e.preventDefault();
            $('#cityTabs .nav-link').removeClass('active');
            $(this).addClass('active');
            selectedCityId = $(this).data('id');
            searchMercenary();
        });

        $('#searchBtn').click(function (e) {
            e.preventDefault();
            searchMercenary();
        });

        //지역, 시간 용병 검색
        function searchMercenary() {
            let selectedRegionName = $('#regionTabs .nav-link.active').text().trim();
            let selectedCityName = $('#cityTabs .nav-link.active').text().trim();
            let time = $('#searchDate').val();

            // 디버깅 로그 추가
            console.log("AJAX 요청 시작");
            console.log("지역:", selectedRegionName);
            console.log("도시:", selectedCityName);
            console.log("검색 시간:", time);

            // '전체'는 공백 처리
            if (selectedRegionName == '전체') selectedRegionName = '';
            if (selectedCityName == '전체') selectedCityName = '';
            
         	// AJAX 코드 수정
            $.ajax({
                url: "${pageContext.request.contextPath}/SearchMercenary.action",
                type: "GET",
                data: {
                    region_name: selectedRegionName,
                    city_name: selectedCityName,
                    time:time
                },
                dataType: 'json',
                success: function (data) {
                    console.log("AJAX 성공", data);
                    
                    // HTML 생성
                    var html = '';
                    if (data && data.length > 0) {
                        data.forEach(function(mercenary) {
                            html += '<div class="table-row">';
                            html += '<div class="table-cell">' + mercenary.user_nick_name + '</div>';
                            html += '<div class="table-cell">' + mercenary.position_name + '</div>';
                            html += '<div class="table-cell">' + mercenary.region_name + '</div>';
                            html += '<div class="table-cell">' + mercenary.city_name + '</div>';
                            html += '<div class="table-cell">';
                            html += '<form action="hireMercenary.action" method="POST">';
                            html += '<input type="hidden" name="mercenary_id" value="' + mercenary.mercenary_id + '">';
                            html += '<button type="submit" class="btn-hire">고용</button>';
                            html += '</form>';
                            html += '</div>';
                            html += '</div>';
                        });
                    } else {
                        html = '<div class="table-row"><div class="table-cell" style="grid-column: span 5; text-align: center;">해당 지역에 등록된 용병이 없습니다.</div></div>';
                    }
                    
                    $('#mercenaryList').html(html);
                },
                error: function(xhr, status, error) {
                    console.error("AJAX 오류 발생:", status, error);
                    console.log(xhr.responseText);
                }
            });
        };

    });
</script>
    
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
    
	.nav-pills .nav-link {
	    border-radius: 50rem;
	    padding: 0.5rem 1rem;
	    font-weight: 500;
	    color: #495057;
	    background-color: #f1f3f5;
	    margin: 0.25rem;
	    transition: background-color 0.3s ease, color 0.3s ease;
	}
	.nav-pills .nav-link:hover {
	    background-color: #dee2e6;
	    color: #0d6efd;
	}
	.nav-pills .nav-link.active {
	    background-color: #0d6efd;
	    color: #ffffff !important;
	    font-weight: bold;
	}
</style>
</head>
<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>
    <!-- 검색 컨테이너 -->
    <div class="search-container">
        <form class="search-form" id="dateSearchForm" action="mercenary.action" method="GET">
            <input type="date" class="date-input" id="searchDate" name="searchDate" required>
            <button id="searchBtn" type="submit" class="btn-search">검색</button>
        </form>
    </div>
    
    <!-- 지역 선택 -->
    <ul class="nav nav-pills mb-3 flex-wrap" id="regionTabs">
        <li class="nav-item">
            <a class="nav-link active" href="#" data-id="">전체</a>
        </li>
        <c:forEach var="region" items="${regionList}">
            <li class="nav-item">
                <a class="nav-link" href="#" data-id="${region.region_id}">${region.region_name}</a>
            </li>
        </c:forEach>
    </ul>

    <!-- 도시 선택 -->
    <ul class="nav nav-pills mb-4 flex-wrap" id="cityTabs">
        <li class="nav-item">
            <a class="nav-link active" href="#" data-id="">전체</a>
        </li>
        <c:forEach var="city" items="${cityList}">
            <li class="nav-item">
                <a class="nav-link" href="#" data-id="${city.city_id}">${city.city_name}</a>
            </li>
        </c:forEach>
    </ul>
    
    
    
    <!-- 본문 컨테이너 -->
    <div class="board-container">
        <div class="header-container">
            <h1>용병 게시판</h1>
            <button id="addTimeLogBtn" class="btn-add open-modal">시간 기록 추가</button>
        </div>
        
        <!-- 리스트 출력 -->
        <div class="table">
            <div class="table-header table-row">
                <div class="table-cell">닉네임</div>
                <div class="table-cell">포지션</div>
                <div class="table-cell">지역</div>
                <div class="table-cell">구</div>
                <div class="table-cell">고용</div>
            </div>
            <div id="mercenaryList">
                <!-- 서버에서 렌더링된 데이터가 표시됩니다 -->
                <c:choose>
                    <c:when test="${not empty mercenaryList}">
                        <c:forEach var="mercenary" items="${mercenaryList}">
                            <div class="table-row">
                                <div class="table-cell">${mercenary.user_nick_name}</div>
                                <div class="table-cell">${mercenary.position_name}</div>
                                <div class="table-cell">${mercenary.region_name}</div>
                                <div class="table-cell">${mercenary.city_name}</div>
                                <div class="table-cell">
                                    <form action="hireMercenary.action" method="POST">
                                        <input type="hidden" name="mercenary_id" value="${mercenary.mercenary_id}">
                                        <button type="submit" class="btn-hire">고용</button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="table-row">
                            <div class="table-cell" colspan="4">해당 날짜에 등록된 용병이 없습니다.</div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        
        <!-- 시간 기록 모달 -->
	    <div id="timeLogModal" class="modal">
	        <div class="modal-content">
	        	<div class="modal-header">
	            	<h4 class="modal-title">용병 시간 기록</h2>
	            	<span class="close-modal">&times;</span>
	            </div>
	            
		        <form id="timeLogForm" action="MercenaryTimeUpdate.action">
		            <div class="modal_body">
		                
		                <!-- 선호 시간 -->
					    <div class="form__group">
					        <div class="form__field">
					            <label class="form__label required">시간</label>
					        	<div class="form__input--wrapper">
						            시작시간
						            <input type="date" class="form__input" id="stardate" name="mercenary_time_start_at" required>
						            종료시간
						            <input type="date" class="form__input" id="endDate" name="mercenary_time_end_at" required>
					           </div>
					        </div>
					    </div>
		                <div class="form-actions">
		                    <button type="submit" class="modal-submit">저장</button>
		                    <button type="button" class="modal-cancel">취소</button>
		                </div>
			    	</div>
		        </form>
	        </div>
	    </div>  
    </div>
</body>
</html>