<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">



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
		</c:forEach>
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
			
			    <!-- 구장에 대한 간단한 설명 -->
			    <div class="mt-4">
			        <h5>설명</h5>
			        <p>
			            천연 잔디 구장, 야간 조명 시설 완비. 인조잔디 구장도 있음.
			            샤워실, 주차장 등 부대시설 완비.
			        </p>
			    </div>
			
			    <!-- 지도 -->
			    <div class="mt-4">
			        <h5>위치 지도</h5>
			        <div class="map" id="map"></div>
			    </div>
			    <br />
			    <div class="d-flex justify-content-end">
			    <button type="button" onclick="mapload()" class="btn btn-secondary">
			        지도 다시 되돌리기
			    </button>
			</div>
			</div>
			<br />
			<br />
			<br />
			<br />
			<!-- 이용 후기 -->
			<div class="container">
				<!-- 주의 사항 -->
				<h5>주의 사항</h5>
					<div>
						<pre>
- 대여 시간보다 적게 사용 하더라도 대관비는 환불되지 않습니다.

- 무료 주차 가능하나, 주차 대수 제한이 있으니 미리 가능 여부를 필히 확인하시기 바랍니다.
			
- 시설 훼손 및 기물 파손 시 손해액을 호스트에게 배상하여야 합니다.
  (CCTV는 방범/분실/기물파손/인원확인 등의 이유로 녹화됨)

- 외부신발(특히 비, 눈 오는날) 은 밖에서 발바닥면을 닦고 입장부탁드리며, 체육관 내부에서는 꼭 실내용 신발을 착용해주세요. 

- 대관하신 체육관(대체육관, 소체육관)만 사용부탁드립니다. 해당사항을 위반할 시, 추가요금이 청구됩니다.

- 퇴실시, 화장실을 포함한 모든 불은 소등부탁드리며, 사용하신 냉난방기도 꼭 꺼주세요. 냉난방기를 켠상태로 퇴실하실 경우, 추가요금이 부가될 수 있으니 꼭 확인한 후 퇴실부탁드립니다.

- 사용하신 물건은 제자리에 정리정돈 부탁드리며, 쓰레기는 쓰레기통에 분리하여 버려주세요.(액체류는 미끄럼방지를 위해 화장실에 내용물을 버리고 분리수거 부탁드립니다.)
	
- 화장실(남자, 여자)은 체육관과 같은 2층에 있습니다. 겨울철에는 화장실 창문을 꼭 닫아주세요.

- 시간 초과시, 추가 요금은 현장 결제로 진행됩니다. (1시간 마다 발생)

- 체육관 내 주류는 반입불가이며, 금연구역입니다. 적발시, 즉시 퇴실조치되며, 환불되지않습니다.

- 냉난방기 이용시, 온도가 자동으로 설정되어있으니 꼭 전원버튼만 눌러서 사용해주세요.(온도조절 절대 금지)
						</pre>
					</div>
			<br />
			<br />
			<br />
			<br />
			
			</div>	
			
			</form>
		</div>
	


</body>
</html>
