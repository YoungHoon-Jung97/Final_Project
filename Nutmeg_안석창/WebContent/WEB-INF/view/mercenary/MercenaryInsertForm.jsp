<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>용병 등록</title>

<!-- 외부 리소스 -->
<link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<c:import url="/WEB-INF/view/Template.jsp"></c:import>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/insertForm.css?after">
<script type="text/javascript" src="<%=cp %>/js/Time.js?after"></script>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>

<script type="text/javascript">

$(document).ready(function() {
	
	// 지역 변경 이벤트
	$('#regions').change(function() {
	    let regionId = $(this).val();
	    loadCities(regionId);
	});
	
	//지역에 따른 도시 로드
	function loadCities(regionId) {
	    if (!regionId) {
	        $('#citys').html('<option value="">구를 선택하세요</option>');
	        return;
	    }
	    
	    $.ajax({
	        url: "SearchCity.action",
	        type: 'GET',
	        data: { region: regionId },
	        dataType: 'json',
	        success: function(data) {
	            let citySelect = $('#citys');
	            citySelect.html('<option value="">구를 선택하세요</option>');
	            
	            if (data && data.length > 0) {
	                data.forEach(function(city) {
	                    citySelect.append(
	                        $('<option>', {
	                            value: city.city_id,
	                            text: city.city_name
	                        })
	                    );
	                });
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('도시 목록 로드 오류:', error);
	            alert('도시 목록을 불러오는 중 오류가 발생했습니다.');
	        }
	    });
	}
});

</script>
<body>
<div class="content">
	<form class="form" method="POST" action="MercenaryInsert.action">
		<div class="form__title">용병 등록</div>
  
   		<!-- 포지션 -->
   		<div class="form__group">
		    <div class="form__field">
				<label class="form__label required">포지션</label>
				<div class="form__section">
			    	<select name="position_id" id="position"
			   		class="form__input" style="width: 150px; margin-top: 10px; margin-bottom: 10px;">
						<option value="">포지션 선택 선택</option>
						<c:forEach var="position" items="${positionList}">
					       	<option value="${position.position_id }">${position.position_name}</option>		
						</c:forEach>
				    </select> 
				</div>
			</div>
		</div>

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

    	<!-- 지역 -->
		<div class="form__group">
		    <div class="form__field">
		        <label class="form__label required">지역</label>
		        
		        <div class="form__selection">
		            <select id="regions" name="region_id" class="form__input" required>
		                <option value="">시를 선택하세요</option>
		                
		                <c:forEach var="region" items="${regionList}">
		                    <option value="${region.region_id}">${region.region_name}</option>
		                </c:forEach>
		            </select>
		            
		            <select id="citys" name="city_id" class="form__input" required>
		                <option value="">구를 선택하세요</option>
		            </select>
		        </div>
		    </div>
		</div>

	    <!-- 버튼 -->
	    <div class="form__actions">
	        <button type="submit" class="btn btn--submit">지원하기</button>
	    </div>
	</form>
</div>
</body>
</html>