<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();
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
	flex: 0 0 30%;
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

</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
	    var startTimeId = null;
	    var endTimeId = null;
	    var selectionMode = "start";
	    
	    $(".time-container").click(function(){
	        var clickedTimeId = parseInt($(this).attr("data-time-id"));
	        
	        if(selectionMode == "start"){
	        	resetSelection();
	        	
	            startTimeId = clickedTimeId;
	            $(this).addClass("in-range");
	            selectionMode = "end";

	        } else {
	            endTimeId = clickedTimeId;
	            console.log("종료 시간 선택: " + endTimeId);
	            
	            if(startTimeId > endTimeId){
	                const temp = startTimeId;
	                startTimeId = endTimeId;
	                endTimeId = temp;
	            }
	            
	            timeRange(startTimeId, endTimeId);
	            selectionMode = "start";
	            $('#submit-button').prop('disabled', false);
	        }
	    });
	    
	    // 초기화 버튼 이벤트 핸들러 추가
	    $("#reset-button").click(function(){
	        resetSelection();
	    });
	    
	    // 선택 초기화
	    function resetSelection(){
	        $('.time-container').removeClass('in-range');
	        $('#submit-button').prop('disabled', true);
	        startTimeId = null;
	        endTimeId = null;
	    }
	    
	    function timeRange(start, end){
	    	resetSelection();
	        
	        for(let i = start; i <= end; i++){
	            // 템플릿 리터럴 대신 문자열 연결 사용
	            const element = $('.time-container[data-time-id="' + i + '"]');
	            if (i == start || i == end) {
	                element.addClass('in-range');
	            } else {
	                element.addClass('in-range');
	            }
	        }
	    }
	});
</script>

<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>
<div class="container mt-4">

	<section>
		<div class="main">
			<div class="main-top">
				<div class="left">
					<div class="field-img">					
						<img src="" alt="" />
					</div>
					<div class="field-size">
						<p>가로 : 24m X 세로 : 15m</p>
					</div>
				</div>
				<div class="right">
					<ul class="field-info-wrap">
						<li><strong>이름 : </strong> 서울 ○○ 축구장</li>
						<li><strong>위치 : </strong> 서울시 마포구 홍대</li>
						<li><strong>가격 : </strong>  2시간당 50,000원</li>
					</ul>
				</div>
			</div>
		
			<div class="time-table-wrap">
				<div class="time-table-helper">
					<span class="glyphicon glyphicon-stop resv-selectable helper-cell-square"></span>
					<b class="helper-cell-text">예약가능</b>
					<span class="glyphicon glyphicon-stop resv-disabled helper-cell-square"></span>
					<b class="helper-cell-text">예약불가</b>
				</div>
				<div class="container time-table">
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
				<div class="mt-3">
			        <button id="submit-button" class="btn btn-primary" disabled>선택 완료</button>
			        <button id="reset-button" class="btn btn-secondary ms-2">초기화</button>
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
			
		</div>

	</section>






</body>
</html>
