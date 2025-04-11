<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>경기장 메인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
    <script>
        let selectedRegionId = '';
        let selectedCityId = '';

        $(document).ready(function () {
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
        	                searchStadiums();
        	            }
        	        });
        	    } else {
        	        //  전체 선택 시 도시 초기화 + 검색 실행
        	        $('#cityTabs').html(`<li class="nav-item"><a class="nav-link active" href="#" data-id="">전체</a></li>`);
        	        searchStadiums();
        	    }
        	});

            $('#cityTabs').on('click', '.nav-link', function (e) {
                e.preventDefault();
                $('#cityTabs .nav-link').removeClass('active');
                $(this).addClass('active');
                selectedCityId = $(this).data('id');
                searchStadiums();
            });

            $('#searchBtn').click(function (e) {
                e.preventDefault();
                searchStadiums();
            });

            function searchStadiums() {
                let selectedRegionName = $('#regionTabs .nav-link.active').text().trim();
                let selectedCityName = $('#cityTabs .nav-link.active').text().trim();

                // '전체'는 공백 처리
                if (selectedRegionName === '전체') selectedRegionName = '';
                if (selectedCityName === '전체') selectedCityName = '';

                $.ajax({
                    url: "${pageContext.request.contextPath}/SearchStadiumList.action",
                    type: "GET",
                    data: {
                        region_name: selectedRegionName,
                        city_name: selectedCityName,
                        keyword: $('#title').val()
                    },
                    success: function (html) {
                        $('.row.g-4').html(html); // 경기장 카드 부분 업데이트
                    }
                });
            };
            
            $(document).on('click', '.reserve-btn', function () {
                const fieldCodeId = $(this).siblings('.field_code_id').val();
                if (fieldCodeId) {
                    window.location.href = "${pageContext.request.contextPath}/FieldReservationForm.action?field_code_id=" + fieldCodeId;
                } else {
                    alert("예약할 경기장 정보를 찾을 수 없습니다.");
                }
            });
            
            $.ajax({
                url: "${pageContext.request.contextPath}/GetUnavailableTimeIds.action",
                type: "GET",
                data: {
                    field_code_id: someFieldCodeId,
                    match_date: $("#matchDateInput").val()
                },
                success: function(unavailableIds) {
                    $(".time-container").each(function () {
                        const id = parseInt($(this).data("time-id"));
                        if (unavailableIds.includes(id)) {
                            $(this).addClass("resv-disabled").css("pointer-events", "none");
                        }
                    });
                }
            });
            
        });
    </script>
</head>
<body>
    <c:import url="/WEB-INF/view/Template.jsp" />
    <section class="container py-5">
        <div class="mb-4">
            <form class="row g-2 align-items-center">
                <div class="col-auto">
                    <input type="text" class="form-control" name="title" id="title" placeholder="검색어 입력">
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary" id="searchBtn">검색</button>
                </div>
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

        <!-- 경기장 리스트 -->
        <div class="row g-4">
	    	<c:forEach var="field" items="${fieldApprOkList}">
		        <div class="col-6">
		            <form action="FieldReservationForm.action" method="POST" class="card h-100">
		                <div class="row g-0 h-100">
		                    <!-- 이미지 영역 -->
		                    <div class="col-5 field-img">
		                        <img src="${field.field_reg_image}" class="img-fluid rounded-start"
		                             style="height: 250px; width: 250px; object-fit: cover;">
		                    </div>
		
		                    <!-- 내용 + 버튼 -->
		                    <div class="col-7 d-flex flex-column justify-content-between">
		                        <div class="card-body">
		                            <h4 class="card-title">구장: ${field.stadium_reg_name}</h4>
		                            <h5 class="card-title">경기장: ${field.field_reg_name}</h5>
		                            <p class="card-text">주소: ${field.stadium_reg_addr}, ${field.stadium_reg_detailed_addr}</p>
		                            <p class="card-text">이용요금: ${field.field_reg_price}원</p>
		                            <p class="card-text">이용시간: ${field.stadium_time_name1}시 ~ ${field.stadium_time_name2}시</p>
		                        </div>
		
		                        <!-- 예약 버튼 + field_code_id 전달 -->
		                        <div class="px-3 pb-3 d-flex justify-content-end align-items-end mt-auto">
		                            <input type="hidden" name="field_code_id" value="${field.field_code_id}" />
		                            <button type="submit" class="btn btn-outline-primary">경기장 예약하기</button>
		                        </div>
		                    </div>
		                </div>
		            </form>
		        </div>
		    </c:forEach>
		</div>
    </section>
</body>
</html>



<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function () {
    
	// 지역 탭 클릭 할때 반응
	$('#regionTabs .nav-link').click(function (e) {
	    e.preventDefault();

	    $('#regionTabs .nav-link').removeClass('active');
	    $(this).addClass('active');

	    const selectedRegionId = $(this).data('id');

	    // Ajax 호출로 도시 목록 받아오기, 컨트롤러에 연결
	    $.ajax({
	        url: "${pageContext.request.contextPath}/GetCityListByRegionId.action",
	        type: "GET",
	        data: { region_id: selectedRegionId },
	        success: function (data) {
	            
	        	// 기존 도시 리스트 비우고 새로 그리기
	            let cityTabsHtml = `
				    <li class="nav-item">
				        <a class="nav-link active" href="#" data-id="">전체</a>
				    </li>
				`;

	            $.each(data, function (index, city) {
	                cityTabsHtml += `
	                    <li class="nav-item">
	                        <a class="nav-link" href="#" data-id="${city.city_id}">${city.city_name}</a>
	                    </li>
	                `;
	            });

	            $('#cityTabs').html(cityTabsHtml);
	        },
	        error: function (xhr, status, error) {
	            console.error("에러 상태:", status);                // 예: "parsererror", "error", "timeout"
	            console.error("에러 메시지:", error);              // 서버 메시지 or null
	            console.error("응답 내용:", xhr.responseText);     // 에러 내용 or HTML
	            alert("도시 목록을 불러오는 데 실패했습니다.");
	        }
	    });
	});
});
</script>   
 
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

    <!-- 경기장 리스트 -->
   <div class="row g-4">
    <c:forEach var="field" items="${fieldApprOkList}">
        <div class="col-6">
            <div class="card h-100">
                <div class="row g-0">
                    <!-- 이미지 영역 -->
                    <div class="col-5 field-img ">
                        <img src="${field.field_reg_image}" alt=""
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
 --%>