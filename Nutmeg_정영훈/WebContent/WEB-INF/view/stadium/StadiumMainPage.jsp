<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>팀 정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f5f5f5;
            font-family: 'Nanum Gothic', sans-serif;
        }
        .field-img img {
            width: 100%;
            height: auto;
            border-radius: 0.5rem;
        }
    </style>
</head>
<body>
<c:import url="/WEB-INF/view/Template.jsp" />

<section class="container py-5">
    <div class="mb-4">
        <!-- 검색 폼 -->
        <form class="row g-2 align-items-center">
            <div class="col-auto">
                <select class="form-select" name="searchType" id="searchType">
                    <option value="">선택</option>
                    <!-- 옵션 추가 -->
                </select>
            </div>
            <div class="col-auto">
                <input type="text" class="form-control" name="title" id="title" placeholder="검색어 입력">
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-primary">검색</button>
            </div>
        </form>
    </div>

    <!-- 지역 선택  -->
    <ul class="nav nav-pills mb-3">
        <li class="nav-item">
            <a class="nav-link active" href="#">전체</a>
        </li>
        <c:forEach var="region" items="${regionList }">
        <li class="nav-item">
            <a class="nav-link" href="#">${region.region_name }</a>
            <input type="hidden" name="region_id" value="${region_id }">
        </li>
        </c:forEach>
    </ul>

    <!-- 도시 선택  -->
    <ul class="nav nav-tabs mb-4">
    	
        <li class="nav-item">
            <a class="nav-link active" href="#">전체</a>
        </li>
        <c:forEach var="city" items="${cityList }">
        <li class="nav-item">
            <a class="nav-link" href="#">${city.city_name }</a>
        </li>
        </c:forEach>
    </ul>

    <!-- 경기장 리스트 -->
   <div class="row g-4">
    <c:forEach var="field" items="${fieldApprOkList}">
        <div class="col-6">
            <div class="card h-100">
                <div class="row g-0">
                	<p>루트 디버그 :${field.field_reg_image}</p>
                    <!-- 이미지 영역 -->
                    <div class="col-5">
                        <img src="${field.field_reg_image}" alt="구장 이미지"
                             class="img-fluid rounded-start" 
                             style="height: 250px; width: 250px; object-fit: cover; margin-right: 15px;">
                    </div>

                    <div class="col-7 d-flex flex-column justify-content-between">
					    <div class="card-body">
					        <h4 class="card-title">구장 : ${field.stadium_reg_name}</h4>
					        <h5 class="card-title">경기장 : ${field.field_reg_name}</h5>
					        <p class="card-text"> 주소 : ${field.stadium_reg_addr}, ${field.stadium_reg_detailed_addr}</p>
					        <p class="card-text"> 이용요금 : ${field.field_reg_price }원</p>
					        <p class="card-text"> 이용시간 : ${field.stadium_time_name1 }시 ~ ${field.stadium_time_name2 }시</p>
					    </div>
					    <input type="hidden" name="stadium_reg_id" value="${field.stadium_reg_id}" />
					    <!-- 버튼 오른쪽 아래 정렬 -->
					    <div class="px-3 pb-3 d-flex justify-content-end align-items-end mt-auto">
					        <button type="button" class="btn btn-outline-primary">경기장 예약하기</button>
					    </div>
					</div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
</section>

</body>
</html>
