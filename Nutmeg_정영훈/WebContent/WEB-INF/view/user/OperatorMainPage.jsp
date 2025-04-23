<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta>
<title>사용자 페이지</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/stadium/StadiumListForm.css?after">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/util/insertForm.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/util/scrollBar.css?after">
<script type="text/javascript" src="<%=cp %>/js/OperatorStadiumUpdateForm.js?after"></script>
<style>
/* 기본 HTML 및 바디 설정 */
html, body {
    margin: 0;
    padding: 0;
    background-color: white; /* 연한 회색 배경 */
    color: #333; /* 기본 텍스트 색상 */
    width: 100%;
  	background: #ffffff !important;
  	background-image: none !important;
}


/* 전체 레이아웃 wrapper */
.wrapper {
    display: flex; /* 좌우 나란히 배치 */
    width: 100%;
    min-height: 100vh; /* 화면 전체 높이 */
    margin-top: -200px;
    padding: 200px 350px; /* 안쪽 여백 */
    box-sizing: border-box;
    gap: 40px; /* 사이 간격 */
}

/* 사이드바 영역 */
.sidebar {
    width: 280px;
    background-color: #ffffff; /* 흰 배경 */
    border-radius: 16px; /* 모서리 둥글게 */
    padding: 30px 25px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.06); 
    flex-shrink: 0; /* 사이즈 축소 방지 */
    border: 1px solid #e0e0e0;

}

/* 사용자 박스 (사진, 이름, 상태) */
.profile-box {
    text-align: center;
    margin-bottom: 30px;
}

/* 사용자 프로필 이미지 */
.profile-box img {
    width: 100px;
    height: 100px;
    border-radius: 50%; /* 원형 */
    border: 2px solid #4CAF50; /* 초록 테두리 */
    object-fit: cover;
    margin-bottom: 12px;
}

/* 사용자 이름 */
.profile-box h5 {
    font-size: 20px;
    margin-bottom: 5px;
}

/* 사용자 역할 텍스트 */
.profile-box .text-muted {
    font-size: 14px;
    color: #777;
}

/* 로그인 뱃지 */
.profile-box .badge {
    background-color: #4CAF50;
    font-size: 12px;
}

/* 사이드 메뉴 타이틀 */
.menu-section-title {
    font-weight: bold;
    margin-top: 24px;
    margin-bottom: 10px;
    color: #2e7d32;
    font-size: 15px;
}

/* 사이드 메뉴 링크 */
.sidebar .nav-link {
    font-size: 15px;
    padding: 10px 12px;
    margin-bottom: 8px;
    color: #333;
    text-decoration: none;
    display: block;
    border-radius: 6px;
}

/* 메뉴 호버 효과 */
.sidebar .nav-link:hover {
    background-color: #e9f5ec;
    color: #000;
}

/* 메인 콘텐츠 */
.content-area {
    flex: 1;
    background-color: #ffffff;
    border-radius: 16px;
    padding: 40px 50px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.03);
    border: 1px solid #e0e0e0;
}

/* 내 정보 타이틀 */
.content-area h4 {
    font-weight: bold;
    margin-bottom: 30px;
    font-size: 22px;
    color: blue;
}

/* 사용자 상세 정보 박스 */
.profile-box {
    background-color: #ffffff;
    border: 1px solid #dfece6;
    border-radius: 12px;
    padding: 30px;
    box-shadow: 0 1px 4px rgba(0, 0, 0, 0.02);
}

/* 정보 한 줄씩 나열하는 영역 */
.profile-box .info-row {
    display: flex;
    align-items: center;
    justify-content: flex-start; /* 좌측 정렬 */
    padding: 12px 0;
    border-bottom: 1px solid #efefef;
    font-size: 15px;
    color: #333;
    gap: 40px; /* ✅ 항목 간 여백 */
}

/* 마지막 줄엔 밑줄 없음 */
.profile-box .info-row:last-child {
    border-bottom: none;
}

/* 왼쪽 라벨 */
.profile-box .info-row strong {
    color: #2e7d32;
    font-weight: 600;
    min-width: 140px; /* ✅ 라벨 고정 폭 */
    text-align: left;
}

/* 오른쪽 데이터 */
.profile-box .info-row span {
    flex: 1;
    color: #555;
    word-break: break-word;
    text-align: left; /* ✅ 오른쪽 몰림 방지 */
}

/* 수정 버튼 */
.edit-button {
    background-color: #4CAF50;
    color: white;
    font-weight: bold;
    border: none;
    border-radius: 8px;
    padding: 12px 28px;
    margin-top: 30px;
    font-size: 16px;
    display: inline-block;
    transition: background-color 0.3s ease;
}

/* 수정 버튼 호버 효과 */
.edit-button:hover {
    background-color: #388E3C;
}

.dashboard-card {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 20px;
  border-radius: 12px;
  background: #ffffff;
  box-shadow: 0 4px 10px rgba(0,0,0,0.05);
  transition: transform 0.2s ease;
}
.dashboard-card:hover {
  transform: translateY(-3px);
}
.card-icon {
  font-size: 28px;
  color: #4CAF50;
}
.card-label {
  font-weight: 600;
  color: #666;
  font-size: 14px;
}
.card-value {
  font-size: 22px;
  font-weight: bold;
  color: #222;
}
.table th {
  background-color: #f8f9fa;
  font-weight: 600;
  text-align: center;
}
.table td {
  text-align: center;
}
.section-title {
  font-size: 22px;
  font-weight: 700;
  color: #333;
  padding-left: 12px;
  border-left: 5px solid #4CAF50;
  margin-bottom: 30px;
  display: flex;
  align-items: center;
  gap: 8px;
}
</style>



<script>
$(document).on('click', '.menu-link', function (e) {
    e.preventDefault();
    const url = $(this).data('url');
    if (!url) return;
    console.log("요청 URL: ", $(this).data('url'));
    $.ajax({
        url: url,
        method: 'GET',
        success: function (result) {
            $('#content-area').html(result);
        },
        error: function () {
            alert("콘텐츠를 불러오는 데 실패했습니다.");
        }
    });
});
</script>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>

<body>
<div class="wrapper">
    <!-- 사이드바 -->
    <div class="sidebar">
        	<c:forEach var="info" items="${operatorInfo}">
                <h5 class="mb-1"  style="text-align: center;">${info.operator_name } </h5>
                <div style="text-align: center;">님 반갑습니다!</div>
            </c:forEach>  
        <div class="mt-2" style="text-align: center;"><span class="badge bg-primary text-dark">구장 운영자</span></div>
	        <nav>
	        	<a class="nav-link menu-active" onclick="location.reload();">
				    <i class="bi bi-house-door me-2"></i> 구장 운영자 대시보드
				</a>
	       		<a class="nav-link menu-link" data-url="OperatorStadiumListForm.action">
				    <i class="bi bi-house-door me-2"></i> 나의 구장 목록
				</a>
				<a class="nav-link menu-link" data-url="OperatorStadiumUpdateList.action">
				    <i class="bi bi-pencil-square me-2"></i> 구장 정보 수정
				</a>
				<a class="nav-link menu-link" data-url="OperatorFieldUpdateListForm.action">
				    <i class="bi bi-gear me-2"></i> 경기장 정보 수정
				</a>
				<a class="nav-link menu-link" data-url="OperatorStadiumHolidayInsertListForm.action">
				    <i class="bi bi-calendar-plus me-2"></i> 경기장 휴무일 입력
				</a>
				<a class="nav-link menu-link" data-url="OperatorStadiumHolidayDeleteForm.action">
				    <i class="bi bi-calendar-check me-2"></i> 경기장 휴무일 삭제
				</a>
				<a class="nav-link menu-link" data-url="OperatorFieldResApprForm.action">
				    <i class="bi bi-check-circle me-2"></i> 경기장 승인관리
				</a>
				<a class="nav-link menu-link" data-url="OperatorFieldApprList.action">
				    <i class="bi bi-list-check me-2"></i> 경기장 승인,취소 내역
				</a>
				<a class="nav-link menu-link" data-url="OperatorFieldResHistory.action">
				    <i class="bi bi-credit-card me-2"></i> 결제 내역
				</a>
				<a class="nav-link menu-active" href="Logout.action">
				    <i class="bi bi-box-arrow-right me-2"></i> 로그아웃
				</a>
	        </nav>
        </div>

	<div class="content-area" id="content-area">
		  <div class="section-title">
			  <i class="bi bi-speedometer2 me-2"></i>
			  구장 운영자 대시보드
			</div>
		
		  <!-- 요약 카드 섹션 -->
		  <div class="row mb-5">
		    <div class="col-md-3">
		      <div class="dashboard-card">
		        <div class="card-icon"><i class="bi bi-building"></i></div>
		        <div>
		          <div class="card-label">총 구장 수</div>
		          <div class="card-value">${totalStadiumCount} 개</div>
		        </div>
		      </div>
		    </div>
		    <div class="col-md-3">
		      <div class="dashboard-card">
		        <div class="card-icon"><i class="bi bi-calendar-event"></i></div>
		        <div>
		          <div class="card-label">오늘 예약 수</div>
		          <div class="card-value">${todayReservationCount} 건</div>
		        </div>
		      </div>
		    </div>
		    <div class="col-md-3">
		      <div class="dashboard-card">
		        <div class="card-icon"><i class="bi bi-currency-dollar"></i></div>
		        <div>
		          <div class="card-label">이번 달 매출</div>
		          <div class="card-value">${monthlyRevenue} 원</div>
		        </div>
		      </div>
		    </div>
		    <div class="col-md-3">
		      <div class="dashboard-card">
		        <div class="card-icon"><i class="bi bi-clock-history"></i></div>
		        <div>
		          <div class="card-label">대기 중 승인</div>
		          <div class="card-value">${pendingApprovals} 건</div>
		        </div>
		      </div>
		    </div>
		  </div>
		
		  <!-- 최근 예약 목록 -->
		  <h5 class="mb-3">최근 예약 내역</h5>
		  <div class="table-responsive">
		    <table class="table table-bordered align-middle">
		      <thead>
		        <tr class="table-light">
		          <th>예약일</th>
		          <th>경기장명</th>
		          <th>시간</th>
		          <th>결제 금액</th>
		          <th>상태</th>
		        </tr>
		      </thead>
		      <tbody>
		        <c:forEach var="r" items="${recentReservations}">
		        <tr>
		          <td>${r.match_date}</td>
		          <td>${r.field_name}</td>
		          <td>${r.start_time} ~ ${r.end_time}</td>
		          <td>${r.pay_amount} 원</td>
		          <td>${r.match_status}</td>
		        </tr>
		        </c:forEach>
		      </tbody>
		    </table>
		  </div>
		</div>
	</div>
</body>
</html>
