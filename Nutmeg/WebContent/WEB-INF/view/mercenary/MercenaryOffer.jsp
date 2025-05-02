<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<title>풋살 선수 리스트</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link href="https://unicons.iconscout.com/release/v4.0.0/css/line.css" rel="stylesheet">


<link rel="stylesheet" type="text/css" href="<%=cp %>/css/util/modal.css?after">


<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/Time.js?after"></script>

<script type="text/javascript">
    var contextPath = "${pageContext.request.contextPath}";
    $(function() {
        // "영입하기" 버튼 클릭
        $('.open-modal').click(function() {
            // 현재 카드에서 mercenary_id 가져오기
            var mercenaryId = $(this).closest('.player-card').find('input[name="mercenary_id"]').val();
            
            if (!mercenaryId) {
                // 없으면 모달 안 열고 return
                alert("선수 ID를 찾을 수 없습니다.");
                return;
            }
            
            // 모달 안 숨겨진 input에 ID 세팅
            $('#modalMercenaryId').val(mercenaryId);

            // 필요한 경우, 경기 선택 <select>도 다시 세팅 가능 (ajax로 최신화 가능)

            // 모달 열기
            $('#mercenaryModal').fadeIn();
            $("header, .floatingButton-wrapper, .filter-panel").addClass("blur-background");
        });

        // 모달 닫기
        $('.close-modal, .modal-cancel').click(function() {
            $('#mercenaryModal').fadeOut();
            $("header, .floatingButton-wrapper, .filter-panel").removeClass("blur-background");
        });

        // 바깥쪽 클릭 시 닫기
        $(window).click(function(event) {
            if ($(event.target).is('#mercenaryModal')) {
                $('#mercenaryModal').fadeOut();
                $("header, .floatingButton-wrapper, .filter-panel").removeClass("blur-background");
            }
        });
    });

</script>
<style>
  
        .board-container {
           	width: 100%;
            margin: 0 auto;
            padding: 20px;
        }
        
        header {
            background-color: #2c3e50;
            color: white;
            padding: 20px 0;
            margin-bottom: 30px;
            border-radius: 5px;
            box-shadow: 0 3px 6px rgba(0,0,0,0.1);
        }
        
        header h1 {
            text-align: center;
            font-size: 2.5rem;
        }
        
        .search-filter {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 10px;
        }
        
        .search-bar {
            flex: 2;
            min-width: 300px;
        }
        
        .search-bar input {
            width: 100%;
            padding: 10px 15px;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 1rem;
        }
        
        .filters {
            flex: 1;
            display: flex;
            gap: 10px;
            min-width: 300px;
            justify-content: flex-end;
        }
        
        .filters select {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
            background-color: white;
            font-size: 1rem;
        }
        
        .player-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }
        
        .player-card {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .player-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.15);
        }
        
        .player-image {
            height: 200px;
            background-color: #ddd;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        
        .player-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .player-info {
            padding: 20px;
        }
        
        .player-name {
            font-size: 1.4rem;
            font-weight: bold;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        
        .player-position {
            background-color: #3498db;
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.9rem;
            display: inline-block;
            margin-bottom: 10px;
        }
        
        .player-stats {
            display: flex;
            flex-wrap: wrap;
            margin-bottom: 15px;
        }
        
        .stat {
            flex: 1;
            min-width: 85px;
            margin-bottom: 5px;
        }
        
        .stat-label {
            font-size: 0.8rem;
            color: #7f8c8d;
        }
        
        .stat-value {
            font-size: 1rem;
            font-weight: bold;
        }
        
        .player-description {
            font-size: 0.9rem;
            color: #555;
            margin-bottom: 15px;
            line-height: 1.5;
        }
        
        .player-actions {
            display: flex;
            justify-content: space-between;
        }
        
        .action-button {
            flex: 1;
            padding: 8px 0;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s ease;
            text-align: center;
        }
        
        .recruit-button {
            background-color: #2ecc71;
            color: white;
            margin-right: 5px;
        }
        
        .details-button {
            background-color: #f1f1f1;
            color: #333;
            margin-left: 5px;
        }
        
        .recruit-button:hover {
            background-color: #27ae60;
        }
        
        .details-button:hover {
            background-color: #e0e0e0;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }
        
        .pagination a {
            margin: 0 5px;
            padding: 8px 15px;
            border-radius: 5px;
            background-color: white;
            color: #333;
            text-decoration: none;
            transition: background-color 0.3s ease;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .pagination a.active {
            background-color: #3498db;
            color: white;
        }
        
        .pagination a:hover:not(.active) {
            background-color: #f1f1f1;
        }
        
        footer {
            text-align: center;
            margin-top: 50px;
            color: #7f8c8d;
            font-size: 0.9rem;
        }
        
        @media (max-width: 768px) {
            .search-filter {
                flex-direction: column;
                align-items: stretch;
            }
            
            .filters {
                justify-content: space-between;
            }
            
            .player-grid {
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            }
        }
    </style>
<script type="text/javascript">
	var contextPath = "${pageContext.request.contextPath}";
</script>
<script type="text/javascript" src="<%=cp %>/js/MercenaryOffer.js?after"></script>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<c:if test="${not empty sessionScope.message}">
	<script type="text/javascript">
		window.addEventListener("pageshow", function(event)
		{
			if (!event.persisted && performance.navigation.type != 2)
			{
				var message = "${fn:escapeXml(sessionScope.message)}";
				var parts = message.split(":");
				
				if (parts.length > 1)
				{
					var type = parts[0].trim();
					var content = parts[1].trim();
					
					switch (type)
					{
						case "SUCCESS_INSERT":
						case "SUCCESS_APPLY":
							swal("성공", content, "success");
							break;
						
						case "NEED_REGISTER_STADIUM":
							swal("주의", content, "warning");
							break;
							
						case "ERROR_DUPLICATE_JOIN":
						case "ERROR_AUTH_REQUIRED":
						case "ERROR_DUPLICATE_REQUEST":
						case "ERROR":
							swal("에러", content, "error");
							break;
						
						default:
							swal("알림", content, "info");
					}
				}
				
				else
					swal("처리 필요", message, "info");
			}
		});
	</script>
	
	<c:remove var="message" scope="session"></c:remove>
</c:if>
<div class="main-background">
	<main >
		<div class="board-container">
			<div class="header-container">
				<div class="section-header text-center mt-3 mb-3">
					<h1 class="display-5 fw-bold text-success">⚽ 풋살 선수 리스트</h1>
					
					<p class="text-muted mt-2">원하는 선수를 찾아 영입해보세요!</p>
					
				    <div class="underline mt-3 mx-auto"></div>
				</div>
			</div>
			
            <!-- 검색 및 필터 섹션 -->
            <div class="search-filter">
                <div class="search-bar">
                    <input type="text" placeholder="선수 이름 검색...">
                </div>
                <div class="filters">
                    <select>
                        <option value="">포지션 전체</option>
                        <option value="pivot">공격수</option>
                        <option value="ala">수비수</option>
                        <option value="fixo">미드필더</option>
                        <option value="goleiro">골키퍼</option>
                    </select>
                    <select>
                        <option value="">등급 전체</option>
                        <option value="S">S급</option>
                        <option value="A">A급</option>
                        <option value="B">B급</option>
                        <option value="C">C급</option>
                    </select>
                </div>
            </div>
			
			<div id="mercenaryList" class="player-grid">
				
				<c:choose>
					<c:when test="${not empty mercenaryList}">
						<c:forEach var="mercenary" items="${mercenaryList}">
							<div class="player-card">
				                <div class="player-image">
				                	<img src="${pageContext.request.contextPath}/${mercenary.profile}" alt="프로필 이미지">
				                </div>
				                <div class="player-info">
				                	<input type="hidden" name="mercenary_id" value="${mercenary.mercenary_id}">
				                    <div class="player-name">${mercenary.user_nick_name}</div>
				                    <div class="player-position">${mercenary.position_name}</div>
				                    <div class="player-stats">
				                        <div class="stat">
				                            <div class="stat-label">등급</div>
				                            <div class="stat-value">A</div>
				                        </div>
				                        <div class="stat">
				                            <div class="stat-label">지역</div>
				                            <div class="stat-value">${mercenary.region_name}</div>
				                        </div>
				                        <div class="stat">
				                            <div class="stat-label">도시</div>
				                            <div class="stat-value">${mercenary.city_name}</div>
				                        </div>
				                    </div>
				                    <div class="player-description">
				                        뛰어난 기술과 경기 이해도를 갖춘 유능한 선수입니다. 팀의 중요한 자산이 될 것입니다.
				                    </div>
				                    <div class="player-actions">
				                        <button type="button" class="open-modal action-button recruit-button" >영입하기</button>
				                        <button type="button" class="action-button details-button">상세정보</button>
				                    </div>
									
								</div>
							</div>
						</c:forEach>
					</c:when>
					
					<c:otherwise>
						<div class="no-data text-center py-5 w-100">
							<p class="fs-5 text-muted">해당 날짜에 등록된 선수가 없습니다.</p>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
           
		</div>
	</main>
	
	<c:import url="/WEB-INF/view/Footer.jsp"></c:import>
</div>

<!-- body 끝나기 전에 추가 -->
<div id="mercenaryModal" class="modal" style="display: none;">
    <div class="modal-content">
        <span class="close-modal">&times;</span>
        <div class="modal-header">
            <h2 class="modal-title">팀 매치 선택</h2>
        </div>
        <form id="mercenaryForm" action="SendMercenary.action">
            <div class="modal-body">
                <div class="form__field">
                    <label class="form__label required">경기 선택</label>
                    <div class="form__input--wrapper">
                        <input type="hidden" name="mercenary_id" id="modalMercenaryId" value="">
                        <select class="form__input" name="field_res_id" id="modalFieldResId">
                           <c:choose>
						        <c:when test="${empty teamMatchList}">
						            <option value="0">없음</option>
						        </c:when>
						        <c:otherwise>
						            <c:forEach var="teamMatch" items="${teamMatchList}">
						                <option value="${teamMatch.field_res_id}">시간 : ${teamMatch.match_date}/ 장소 : ${teamMatch.stadium_addr}</option>
						            </c:forEach>
						        </c:otherwise>
						    </c:choose>
                        </select>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="modal-button modal-cancel">취소</button>
                <button type="submit" class="modal-button modal-submit">확인</button>
            </div>
        </form>
    </div>
</div>

<div id="filterPanel" class="filter-panel">
	<h4>필터</h4>
	<hr>
	
	<div class="mb-3">
		<label for="regionSelect" class="form-label">지역</label>
		
		<select id="regionSelect" name="region" class="form-select">
			<option value="">전체</option>
			
			<c:forEach var="region" items="${regionList}">
				<option value="${region.region_id}">${region.region_name}</option>
			</c:forEach>
		</select>
	</div>
	
	<div class="mb-3">
		<label for="citySelect" class="form-label">도시</label>
		
		<select id="citySelect" name="city" class="form-select">
			<option value="">전체</option>
		</select>
	</div>
	
	<div class="mb-3">
		<div class="search-container">
			<label for="searchDate" class="form-label">날짜</label>
			
			<form class="search-form" id="dateSearchForm" action="mercenary.action" method="GET">
				<div class="input-group">
					<input type="date" class="date-input form-control" id="searchDate" name="searchDate" required>
					<button id="searchBtn" type="submit" class="btn-search btn btn-success">검색</button>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- 플로팅 버튼 (Top, 필터) -->
<div class="floatingButton-wrapper">
	<button id="topIconButton" class="top-icon-slide" title="맨 위로 이동">
		<i class="bi bi-caret-up-fill"></i>
	</button>
	
	<button id="leftIconButton" class="left-icon-slide" title="필터">
		<i class="bi bi-funnel-fill"></i>
	</button>
	
	<div id="floatingButton" class="floatingButton">
		<img src="images/soccerball.png" alt="floating" class="floatingButton-img">
	</div>
</div>

</body>
</html>