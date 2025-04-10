<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>풋살 매칭 서비스</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	
	/* $(document).ready(function(){
		
		$(".btn").click(function()
		{
			alert($(this).val());
		})
		
	}); */
</script>
<style>

body {
	background-color: #f9f9f9;
	margin-top: 1rem;
	padding: 0;
}

.navbar {
	background-color: #fff;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
	padding: 1rem 2rem;
}

.nav-link {
	margin-right: 20px;
	color: #333;
	font-weight: 500;
}

.filter-bar button {
	margin: 0 5px;
}

.match-card {
	background: #fff;
	border-radius: 8px;
	padding: 1rem;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
	margin-bottom: 1rem;
}

.footer {
	padding: 2rem;
	text-align: center;
	background-color: #f1f1f1;
	margin-top: 2rem;
}

</style>
</head>
<body>

	<c:import url="/WEB-INF/view/Template.jsp"></c:import>
	<!-- 상단 정보 영역 -->
	
	
	<!-- 스타디움 -->
	<div class="container mt-4">
	<div class="match-card">
	아래 구장의 정보를 확인 해주세요
	</div>
	<!-- ${param.stadium_reg_id} 값 넘어오는거 확인 -->
		<c:forEach var="stadium" items="${stadiumSearchId}">
			<form method="post" action="FieldRegInsertForm.action">
			    <div class="match-card">
			        <div class="d-flex justify-content-between align-items-center">
			            <!-- 왼쪽에 표시 될 이미지 -->
			            <div style="display: flex; align-items: center;">
			                <img src="${stadium.stadium_reg_image}" alt="" 
			                    style="height: 150px; width: 150px; object-fit: cover; margin-right: 15px;"/>
							
			                <!-- 오른쪽에 텍스트 (이미지 옆에 멘트들) -->
			                <div style="max-width: 500px;">
			                    <strong>${stadium.stadium_reg_name}</strong><br>
			                    ${stadium.stadium_reg_addr}, ${stadium.stadium_reg_detailed_addr}
			                </div>
			            </div>
			            <!-- 버튼 -->
			            <input type="hidden" name="stadium_reg_id" value="${stadium.stadium_reg_id}" />
			            <button type="submit" class="btn btn-secondary" >클릭</button>
			        </div>
			    </div>
		    </form>
		</c:forEach>
		
		<div class="match-card">
		<strong>구장에 포함된 경기장 표시</strong>
		</div>
		
		<c:forEach var="field" items="${fieldSearchId}">
		<div class="match-card">
	        <div class="d-flex justify-content-between align-items-center">
            <div style="display: flex; align-items: center;">
               <div style="display: flex; align-items: center;">
		                <img src="${field.field_reg_image}" alt="" 
		                    style="height: 150px; width: 150px; object-fit: cover; margin-right: 15px;"/>
	                <div style="max-width: 500px;">
	                    <strong>${field.field_reg_name}</strong><br>
	                    등록일 : ${field.field_reg_at} <br>
	                    가로 : ${field.field_reg_garo}, 세로 : ${field.field_reg_sero } <br>
	                    바닥 종류 : ${field.field_type }, 환경 : ${field.field_environment_type }<br>
	                    2시간당 가격 : ${field.field_reg_price }
	                </div>
                </div>
            </div>
            <!-- 버튼 -->
            <input type="hidden" name="stadium_reg_id" value="${stadium.stadium_reg_id}" />
	        </div>
	    </div>
		</c:forEach>
		
	</div>
		
	<!-- 푸터(맨 아래 부분) -->
	<div class="footer"></div>


</body>
</html>