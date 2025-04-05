<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6474375f344948f35b988948291eb5f2"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>

	function mapload()
	{
		var container = document.getElementById('map');
	    var options = {
	    	center: new kakao.maps.LatLng(37.556570, 126.919544),
	        level: 3
	    };
	    var map = new kakao.maps.Map(container, options);
	    	
	    markerPosition = new kakao.maps.LatLng(37.556570, 126.919544);	    
		marker = new kakao.maps.Marker({
			
		position: markerPosition
			
		});
	    
			marker.setMap(map);
			
	}
    
</script>

<style>
        .header {
            margin-top: 20px;
        }
        .image {
            height: 400px;
            object-fit: cover;
            width: 100%;
        }
        .map {
            height: 300px;
        }
    </style>

<body onload="mapload()">

<div class="container mt-4">
	
	<div>
		<c:import url="Menu.jsp"></c:import>
	</div>
	
    <!-- 이미지 부분 -->
    <div id="venueCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="imgs/img1.jpg" class="d-block w-100 image" alt="...">
            </div>
            <div class="carousel-item">
                <img src="imgs/field2.jpg" class="d-block w-100 image" alt="...">
            </div>
            <!-- 여기에 추가 이미지 가능 -->
        </div>
        
        <!-- 이미지 슬라이드 버튼임 -->
        <button class="carousel-control-prev" type="button" data-bs-target="#venueCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#venueCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>

    <!-- 장소 정보 기재 하는곳 -->
    <div class="header d-flex justify-content-between align-items-center mt-4">
	    <div>
	        <h2>서울 ○○ 축구장</h2>
	        <p><strong>위치:</strong> 서울시 마포구 홍대</p>
	        <p><strong>가격:</strong> 시간당 50,000원</p>
	    </div>
	    <div>
	    	<button class="btn btn-call btn-lg" style="background-color: green; color: white; ">문의하기</button>
	        <button class="btn btn-primary btn-lg">예약하기</button>
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
			<pre>- 대여 시간보다 적게 사용 하더라도 대관비는 환불되지 않습니다.

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
    <!-- 시설 정보 -->
    <div>
        <h5>시설 정보</h5>
        <ul class="list-group list-group-horizontal">
            <li class="list-group-item flex-fill text-center"><h1>🛁</h1>샤워실 있음</li>
            <li class="list-group-item flex-fill text-center"><h1>🅿️</h1> 주차 가능</li>
            <li class="list-group-item flex-fill text-center"><h1>💡</h1> 야간 조명</li>
            <li class="list-group-item flex-fill text-center"><h1>⛳</h1> 천연잔디</li>
        </ul>
    </div>
	<br />
	<br />
	<br />
	<br />
    <!-- 이용 후기 -->
    <div>
        <h5>이용 후기</h5>
        <div class="card">
            <div class="card-body">
                <h5>이순신</h5> "구장 상태 너무 좋고, 관리자도 친절했어요!"
            </div>
        </div>
        <br />
        <div class="card">
            <div class="card-body">
                <h5>홍길동</h5> "주차장이 넓어서 편했어요. 재방문 의사 있어요!"
            </div>
        </div>
    </div>
    
	<br />
	<br />
	<br />
	<br />
	
    <!-- 예약 가능 시간 -->
    <div>
        <h5>예약 가능 시간</h5>
        <table class="table table-bordered text-center">
            <thead>
                <tr>
                    <th>날짜</th>
                    <th>시간</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>3월 29일 (금)</td>
                    <td>18:00 ~ 20:00</td>
                    <td><span class="badge bg-success">예약 가능</span></td>
                </tr>
                <tr>
                    <td>3월 29일 (금)</td>
                    <td>20:00 ~ 22:00</td>
                    <td><span class="badge bg-danger">예약 완료</span></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>


