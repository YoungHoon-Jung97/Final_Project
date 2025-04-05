<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>구장 예약</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
    
    	.test-image {
        width: 80px;
        height: 80px;
    }
        .filter-bar {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        .stadium-item {
            display: flex;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid #ddd;
            background: #fff;
            transition: background 0.3s;
        }
        .stadium-item:hover {
            background: #f8f9fa;
        }
        .stadium-img {
            width: 120px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 15px;
        }
        .stadium-info {
            flex-grow: 1;
        }
        .stadium-name {
            font-size: 18px;
            font-weight: bold;
        }
        .stadium-details {
            font-size: 14px;
            color: #555;
        }
        .reservation-wrapper {
            width: 100%;
        }
        .time-labels {
            display: flex;
            justify-content: space-between;
            font-size: 12px;
            color: #333;
            margin-bottom: 5px;
        }
        .reservation-bar {
            display: flex;
            width: 100%;
            height: 8px;
            border-radius: 4px;
            overflow: hidden;
        }
        .time-slot {
            flex: 1;
            height: 100%;
        }
        .available { background-color: #007bff; }
        .unavailable { background-color: #ccc; }
        .reserve-btn {
            min-width: 100px;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <h2 class="mb-3">구장 예약</h2>
		
        <!-- 필터 바 -->
        <form method="get" action="Reservation.jsp" class="filter-bar">
            <select name="region" class="form-select" style="width: 150px;">
                <option value="">모든 지역</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="부산">부산</option>
                <option value="부산">대구</option>
            </select>
            
            <input type="date" name="date" class="form-control" style="width: 160px;" value="<%= request.getParameter("date") != null ? request.getParameter("date") : "" %>">

            <select name="stadiumType" class="form-select" style="width: 150px;">
                <option value="">구장 종류</option>
                <option value="실내">실내</option>
                <option value="실외">실외</option>
            </select>

            <select name="floorType" class="form-select" style="width: 150px;">
                <option value="">바닥 종류</option>
                <option value="잔디">잔디</option>
                <option value="인조잔디">인조잔디</option>
                <option value="우레탄">우레탄</option>
            </select>

            <button type="submit" class="btn btn-primary">검색</button>
        </form>

        <!-- 구장 리스트 -->
        <div class="list-group">
            <%
                // 현재 시간 가져오기
                java.util.Calendar calendar = java.util.Calendar.getInstance();
                int currentHour = calendar.get(java.util.Calendar.HOUR_OF_DAY);
                int currentMinute = calendar.get(java.util.Calendar.MINUTE);
                int currentTimeSlot = (currentHour - 6) * 2 + (currentMinute >= 30 ? 1 : 0); // 30분 단위 변환
                
                // 예제 데이터 (DB에서 가져올 수도 있음)
                String[][] stadiums = {
                    {"서울", "A구장", "37x20m", "실외", "인조잔디", "40,000원~50,000원/시간", "img1.jpg"},
                    {"경기", "B구장", "37x20m", "실내", "잔디", "40,000원/시간", "img2.jpg"},
                    {"부산", "C구장", "37x20m", "실외", "우레탄", "40,000원~60,000원/시간", "img3.jpg"},
                    {"서울", "D구장", "33x20m", "실외", "인조잔디", "40,000원~50,000원/시간", "img4.jpg"},
                    {"부산", "E구장", "40x30m", "실내", "인조잔디", "50,000원/시간", "img5.jpg"},
                    {"대구", "F구장", "40x30m", "실내", "인조잔디", "50,000원/시간", "img6.jpg"},
                };

                String selectedRegion = request.getParameter("region");
                String selectedType = request.getParameter("stadiumType");
                String selectedFloor = request.getParameter("floorType");

                for (String[] stadium : stadiums) {
                    if ((selectedRegion == null || selectedRegion.isEmpty() || selectedRegion.equals(stadium[0])) &&
                        (selectedType == null || selectedType.isEmpty() || selectedType.equals(stadium[3])) &&
                        (selectedFloor == null || selectedFloor.isEmpty() || selectedFloor.equals(stadium[4]))) {
            %>
            <div class="stadium-item">
                <%-- <img alt="<%= stadium[6] %>" src="<%=cp %>/imgs/<%= stadium[6] %>" class="stadium-img"> --%>
                <img alt="nutmag.png" src="<%=cp %>/imgs/nutmag.png" class="test-image">
                <div class="stadium-info">
                    <div class="stadium-name"><%= stadium[1] %> (<%= stadium[0] %>)</div>
                    <div class="stadium-details">크기: <%= stadium[2] %> | 종류: <%= stadium[3] %> | 바닥: <%= stadium[4] %></div>
                    <div class="stadium-details">가격: <%= stadium[5] %></div>

                    <!-- 시간 표시 -->
                    <div class="time-labels">
                        <%
                            for (int i = 6; i <= 24; i++) {
                                out.print("<span>" + String.format("%02d:00", i) + "</span>");
                            }
                        %>
                    </div>

                    <!-- 시간별 예약 가능 여부 바 -->
                    <div class="reservation-bar">
                        <%
                            for (int slot = 0; slot < 37; slot++) 
                            { // 06:00 ~ 00:00 (30분 단위 총 37칸)
                                String status = (slot >= currentTimeSlot) ? "available" : "unavailable";
                        %>
                            <div class="time-slot <%= status %>"></div>
                        <% } %>
                    </div>
                </div>

                <!-- 버튼 상태 변경 -->
                <button class="btn btn-primary reserve-btn" <%= (currentHour >= 24) ? "disabled" : "" %>>예약하기</button>
            </div>
            <% } } %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
