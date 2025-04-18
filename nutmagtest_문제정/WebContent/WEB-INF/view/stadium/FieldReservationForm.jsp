<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<%
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	
	java.util.Calendar cal = java.util.Calendar.getInstance(); // 오늘 날짜 기준
	cal.add(java.util.Calendar.DATE, 1); // 하루 더하기
	String tomorrow = sdf.format(cal.getTime());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>축구장 상세 페이지</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">



<style>
.header {
	margin-top: 20px;
}

.main-top{
	display: flex;
}

.left{
	flex: 0 0 100%;
}

.right{
	flex: 0 0 70%;
}

.time-bar {
    position: relative;
    display: flex;
    width: 100%;
    height: 60px;
    background-color: #f8f9fa;
    border-radius: 4px;
    overflow: hidden;
}

.time-container {
    position: relative;
    flex: 1;
    text-align: center;
    border-right: 1px solid #e9ecef;
}

.time-container:last-child {
    border-right: none;
}

.time-title {
    font-size: 12px;
    color: #6c757d;
    padding-top: 5px;
}
.time-container {
    cursor: pointer;
}

.in-range {
    background-color: #6ea8fe;
    color: white;
}
.resv-disabled {
    background-color: red !important;
    color: white !important;
    cursor: not-allowed !important;
    pointer-events: none !important;
}

</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        let startTimeId = null;
        let endTimeId = null;
        let selectionMode = "start";
        const baseUrl = "<%= request.getContextPath() %>";
		
        
        $(".time-container").on("click", function () {
            if ($(this).hasClass("resv-disabled")) {
                console.log("🚫 예약 불가 시간 클릭 차단됨");
                return;
            }

            const clickedTimeId = parseInt($(this).attr("data-time-id"));
            console.log("⏱ 클릭된 시간 ID:", clickedTimeId);
			
            if (selectionMode === "start") {
                resetSelection();
                startTimeId = clickedTimeId;
                $(this).addClass("in-range");
                selectionMode = "end";
            } else {
                endTimeId = clickedTimeId;

                if (startTimeId > endTimeId) {
                    [startTimeId, endTimeId] = [endTimeId, startTimeId];
                }
				
                let hasDisabled = false;
                for (let i = startTimeId; i <= endTimeId; i++) {
                    const $check = $('.time-container').filter(function () {
                        return Number($(this).data("time-id")) === i;
                    });
                    if ($check.hasClass("resv-disabled")) {
                        hasDisabled = true;
                        break;
                    }
                }

                if (hasDisabled) {
                    alert("선택한 시간 범위에 예약 불가능한 시간이 포함되어 있어요.");
                    resetSelection();
                    return;
                }
                
                timeRange(startTimeId, endTimeId);
                selectionMode = "start";
                $("#submit-button").prop("disabled", false);
            }
            
        });

        $("#reset-button").click(function () {
            resetSelection();
        });
		

        function resetSelection() {
            $('.time-container')
                .not('.resv-disabled') // 예약 불가능 시간은 유지
                .removeClass('in-range');
            $('#submit-button').prop('disabled', true);
            startTimeId = null;
            endTimeId = null;
            selectionMode = "start"; // ← 이거 꼭 추가!
        }

        function timeRange(start, end) {
            $('.time-container').removeClass('in-range');
            for (let i = start; i <= end; i++) {
                const element = $('.time-container[data-time-id="' + i + '"]');
                if (!element.hasClass('resv-disabled')) {
                    element.addClass('in-range');
                }
            }
        }

        $("#matchDateInput").on("change", function () {
            const match_date = $(this).val();
            const field_code_id = $("#field_code_id").val();
			
            const today = new Date();
            today.setHours(0, 0, 0, 0); // 시간 제거
            const selectedDate = new Date(match_date);

            if (selectedDate < today) {
                alert("오늘 이전 날짜는 선택할 수 없습니다.");
                $(this).val(""); // 날짜 초기화
                return;
            }
            
            resetSelection();
            
            console.log("날짜 변경됨:", match_date);
            console.log("Ajax 요청 주소:", baseUrl + "/GetUnavailableTimeRange.action");

            if (match_date && field_code_id) {
                $.ajax({
                    url: baseUrl + "/GetUnavailableTimeRange.action",
                    type: "GET",
                    data: {
                        match_date: match_date,
                        field_code_id: field_code_id
                    },
                    headers: {
                        "Accept": "application/json"
                    },
                    success: function (timeRanges) {
                        console.log("✅ Ajax 성공!");
                        console.log("📦 서버 응답 데이터:", timeRanges);

                        // 모든 슬롯 초기화
                        $(".time-container").removeClass("resv-disabled").removeAttr("style");
                        $(".unavailable-label").remove();
                        
                        let totalDisabled = 0;

                        timeRanges.forEach(function (range, index) {
                            const start = Number(range.STADIUM_TIME_ID1);
                            const end = Number(range.STADIUM_TIME_ID2);

                            if (isNaN(start) || isNaN(end)) {
                                console.warn(`⚠️ 잘못된 시간값: start=${start}, end=${end}`);
                                return;
                            }

                            for (let i = start; i <= end; i++) {
                                const $slot = $('.time-container').filter(function () {
                                    return Number($(this).data("time-id")) === i;
                                });

 
                                $slot.addClass("resv-disabled").css({
                                    "background-color": "red",
                                    "color": "white",
                                    "cursor": "not-allowed",
                                    "pointer-events": "none"
                                });
                                
                                if ($slot.find(".unavailable-label").length === 0) {
                                    $slot.append('<div class="unavailable-label">예약불가</div>');
                                }

                                console.log(`🟥 예약 불가 처리 완료: data-time-id="${i}"`);
                                totalDisabled++;
                            }
                        });

                        console.log(`✅ 총 예약 불가 시간 슬롯 수: ${totalDisabled}`);
                        blockUnavailableTimeByStadiumTimeId();
                    },
                    error: function (xhr, status, error) {
                 
                    },
                    complete: function () {
                        console.log("🔁 Ajax 완료");
                    }
                });
            }
        });
         
        // 폼 전송 구문
        $("#submit-button").click(function (e) {
            e.preventDefault(); // 기본 동작 막고
            
            
            if (startTimeId == null || endTimeId == null) {
                alert("시간을 선택해 주세요.");
                return;
            }
            
            if ($("#matchDateInput").val() == null || $("#matchDateInput").val() == "")
			{
            	alert("날짜를 선택해 주세요.");
                return;
			}
            
            // 시작 시간 텍스트 추출 (예: "12:00")
            const startText = $('.time-container[data-time-id="' + startTimeId + '"]').find('.time-title').text();
            const startOnly = startText.split('~')[0].trim();

            // 종료 시간 텍스트 추출 (예: "15:50")
            const endText = $('.time-container[data-time-id="' + endTimeId + '"]').find('.time-title').text();
            const endOnly = endText.split('~')[1].trim();

            console.log("✅ 설정된 시간 ID:", startTimeId, "~", endTimeId);
            console.log("🕒 설정된 시간 텍스트:", startOnly, "~", endOnly);

            // hidden 필드에 값 넣기
            $("#start_time_id").val(startTimeId);
            $("#end_time_id").val(endTimeId);
            $("#start_time_text").val(startOnly);
            $("#end_time_text").val(endOnly);
            
            // 폼 전송
            $(this).closest("form")[0].submit();
        });
        
        
        
        
    });
    
    function blockUnavailableTimeByStadiumTimeId() {
        const minTimeId = parseInt($("#timeStartLimit").val()); // 예: 2
        const maxTimeId = parseInt($("#timeEndLimit").val());   // 예: 6
		
        console.log("🔧 제한 시간 시작:", $("#timeStartLimit").val());
        console.log("🔧 제한 시간 끝:", $("#timeEndLimit").val());
        
        if (isNaN(minTimeId) || isNaN(maxTimeId)) {
            console.warn("❗ minTimeId 또는 maxTimeId가 유효하지 않습니다.");
        }
        
        $(".time-container").each(function () {
            const timeId = parseInt($(this).attr("data-time-id"));
	
            if (timeId < minTimeId || timeId > maxTimeId) {
                $(this).addClass("resv-disabled").css({
                    "background-color": "red",
                    "color": "white",
                    "cursor": "not-allowed",
                    "pointer-events": "none"
                });

                if ($(this).find(".unavailable-label").length === 0) {
                    $(this).append('<div class="unavailable-label">이용불가</div>');
                }
            }
        });
    }
    
    
</script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6474375f344948f35b988948291eb5f2&libraries=services"></script>
<script>
window.onload = function () {
    initialize();
};

//지도 생성 함수
function initialize() {
    const fullAddress = "${field_addr}"; // ← JSP에서 넘긴 전체 주소
    const container = document.getElementById("map");

    const map = new kakao.maps.Map(container, {
    	// 임시 좌표 설정
        center: new kakao.maps.LatLng(37.5665, 126.9780),
        level: 3
    });
	
    // 좌표로 변환하는 메소드
    const geocoder = new kakao.maps.services.Geocoder();
	
	// 입력한 주소를 좌표로 변환하는 메소드
    geocoder.addressSearch(fullAddress, function(result, status) {
       
    	// 만약 불러온 좌표의 값의 lenght가 0 이상 이라면 (값이 불러져 왔다면)
        if (status === kakao.maps.services.Status.OK && result.length > 0) {
            const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			
            // 맵의 센터를 coords라는 좌표로 이동 시켜라
            map.setCenter(coords);
			
            // 마커 생성
            const marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });
        } else {
            alert("❌ 주소 검색 실패. 입력한 주소: " + fullAddress);
        }
    });
}
</script>



<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>
<div class="container mt-4">
	<form action="FieldReservationCheckForm.action" method="post">
		<div class="main">
		<c:forEach var="field" items="${fieldApprOkSearchList}">
		    <div class="main-top">
		        <div class="left">
		            <div class="field-img w-100 mb-3">
				        <img src="${field.field_reg_image}" alt="경기장 이미지"
				             style="width: 100%; height: 400px;" />
		            </div>
		            <div class="right">
		            <ul class="field-info-wrap">
		                <li><strong>이름 : </strong> ${field.field_reg_name}</li>
		                
		                <li><strong>경기장 코드 : </strong> ${field.field_code_id}</li>
		                <li><strong>위치 : </strong> ${field.stadium_reg_addr}, ${field.stadium_reg_detailed_addr}</li>
		                <li><strong>가격 : </strong> ${field.field_reg_price}원</li>
		                <li><strong>가로 : </strong> ${field.field_reg_garo}m X 세로 : ${field.field_reg_sero}m</li>
		            </ul>
		            <input type="hidden" id="timeStartLimit" value="${field.stadium_time_id1}" />
					<input type="hidden" id="timeEndLimit" value="${field.stadium_time_id2}" />
		        </div>
		        </div>
		        <input type="hidden" name="field_code_id" id="field_code_id" value="${field.field_code_id}" />
		        <input type="hidden" name="field_reg_price" id="field_reg_price" value="${field.field_reg_price}" />
		    </div>
			
			<div class="time-table-wrap">
				<div class="container time-table">
				
					<div class="container mt-4">
					    <div class="d-flex align-items-center gap-3">
					        <label for="matchDateInput" class="form-label mb-0"><strong>예약 날짜 선택</strong></label>
					        <input type="date" id="matchDateInput" name="match_date"
					               class="form-control" style="max-width: 250px;" value="" min="<%= tomorrow %>">
					    </div>
					</div>
					<br>
					<div class="time-table">
						<div class="time-bar">
							<div class="time-container" data-time-id="1">
								<div class="time-title">06:00 ~ 07:50</div>
							</div>
							<div class="time-container" data-time-id="2">
								<div class="time-title">08:00 ~ 09:50</div>
							</div>
							<div class="time-container" data-time-id="3">
								<div class="time-title">10:00 ~ 11:50</div>
							</div>
							<div class="time-container" data-time-id="4">
								<div class="time-title">12:00 ~ 13:50</div>
							</div>
							<div class="time-container" data-time-id="5">
								<div class="time-title">14:00 ~ 15:50</div>
							</div>
							<div class="time-container" data-time-id="6">
								<div class="time-title">16:00 ~ 17:50</div>
							</div>
							<div class="time-container" data-time-id="7">
								<div class="time-title">18:00 ~ 19:50</div>
							</div>
							<div class="time-container" data-time-id="8">
								<div class="time-title">20:00 ~ 21:50</div>
							</div>
							<div class="time-container" data-time-id="9">
								<div class="time-title">22:00 ~ 23:50</div>
							</div>
						</div>
					</div> 
				</div>
				<input type="hidden" name="start_time_id" id="start_time_id" value=""/>
				<input type="hidden" name="end_time_id" id="end_time_id" value="" />
				<input type="hidden" name="start_time_text" id="start_time_text"  value=""  />
				<input type="hidden" name="end_time_text" id="end_time_text"  value=""  />
				<div class="mt-3 d-flex justify-content-end">
			        <button type="button" id="submit-button" class="btn btn-primary" disabled>예약하기</button>
			        <button type="button" id="reset-button" class="btn btn-secondary ms-2">초기화</button>
				</div>
			
			</div>
			
				<!-- 지도 -->
			    <div class="mt-4">
			        <h5>위치 지도</h5>
			        <div class="map" id="map" name="map" style="width:100%; height:400px;"></div>
			    </div>
			    <br />
			    <div class="d-flex justify-content-end">
			    <button type="button" onclick="initialize()" class="btn btn-secondary">
			        지도 다시 되돌리기
			    </button>
				</div>
				<br>
				<br>
			    <!-- 구장에 대한 간단한 설명 -->
			    
			    <div class="container">
				  <div class="row">
				    <c:forEach var="entry" items="${field.facilitiesMap}" varStatus="status">
				      <div class="col-md-4 mb-3">
				        <div class="border rounded p-3 d-flex justify-content-between align-items-center">
				          <div>
				            <c:choose>
				              <c:when test="${entry.key == '샤워실'}"><i class="bi bi-droplet me-2"></i></c:when>
				              <c:when test="${entry.key == '탈의실'}"><i class="bi bi-person-lines-fill me-2"></i></c:when>
				              <c:when test="${entry.key == '주차장'}"><i class="bi bi-car-front-fill me-2"></i></c:when>
				              <c:when test="${entry.key == '음료판매'}"><i class="bi bi-cup-straw me-2"></i></c:when>
				              <c:when test="${entry.key == '풋살화대여'}"><i class="bi bi-bag-check-fill me-2"></i></c:when>
				              <c:when test="${entry.key == '조끼대여'}"><i class="bi bi-backpack me-2"></i></c:when>
				              <c:otherwise><i class="bi bi-question-circle me-2"></i></c:otherwise>
				            </c:choose>
				            ${entry.key}
				          </div>
				          <div>
				            <c:choose>
				              <c:when test="${entry.value}">
				                <span class="text-success">사용 가능</span>
				              </c:when>
				              <c:otherwise>
				                <span class="text-danger">없음</span>
				              </c:otherwise>
				            </c:choose>
				          </div>
				        </div>
				      </div>
				
				      <!-- 줄바꿈: 3개씩 한 줄로 -->
				      <c:if test="${(status.index + 1) % 3 == 0}">
				        </div><div class="row">
				      </c:if>
				    </c:forEach>
				  </div>
				</div>
			
			<br />
			<br />
				<!-- 이용 후기 -->
				<div class="mt-4">
					<!-- 주의 사항 -->
					<h5>주의 사항</h5>
					
						<p>
							${field.field_reg_notice }	
						</p>

				</c:forEach>
					<br />
					<br />
					<br />
					<br />
				</div>	
			</form>
		</div>
	


</body>
</html>
