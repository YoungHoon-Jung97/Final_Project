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
<title>구장 등록하기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<style>
body {
	background-color: #f9f9f9;
	margin: 0;
	padding: 0;
}


</style>

<script>
	$(document).ready(function()
	{
		$("#checkDuplicateBtn").click(function () {
	        var name = $("#stadium_reg_name").val();
	        if (!name) {
	            $("#nameCheckMsg").html("구장 이름을 입력하세요.");
	            return;
	        }

	        $.ajax({
	            url: "${pageContext.request.contextPath}/CheckStadiumName.action",
	            type: "GET",
	            data: { stadium_reg_name: name },
	            success: function (result) {
	                if (result == "duplicate") {
	                    $("#nameCheckMsg").html("이미 있는 이름입니다.").css("color", "red");
	                } else {
	                    $("#nameCheckMsg").html("사용 가능한 이름입니다.").css("color", "green");
	                }
	            },
	            error: function () {
	                $("#nameCheckMsg").text("오류가 발생했습니다.").css("color", "red");
	            }
	        });
	    });
	});
    
</script>


</head>
<body>
	<div>배너 넣을 공간</div>
	<!-- 상단 정보 영역 -->
	<div class="container my-4">
			<div class="border rounded p-3 bg-white">
				<h5 class="mb-3 text-center">경기장 등록 양식</h5>
				<form method="post" action="StadiumRegInsert.action" enctype="multipart/form-data">
					<div class="mb-2">
					    <div>경기장 이름</div>
					    <div class="input-group">
					        <input type="text" id="stadium_reg_name" name="stadium_reg_name" class="form-control" required>
					        <button type="button" id="checkDuplicateBtn" class="btn btn-outline-secondary">중복 확인</button>
					    </div>
					    <small id="nameCheckMsg" class="form-text"></small>
					</div>
					<div class="mb-2">
						<div>우편 주소</div>
						<input type="text" name="stadium_reg_postal_addr" class="form-control" placeholder="우편 주소" required="required">
					</div>
					<div class="mb-2">
						<div>주소</div>
						<input type="text" name="stadium_reg_addr" class="form-control" placeholder="주소 " required="required">
					</div>
					<div class="mb-2">
						<div>상세 주소</div>
						<input type="text" name="stadium_reg_detailed_addr" class="form-control" placeholder="상세 주소">
					</div>
					<div class="mb-2">
						<div>구장 이미지 올리기</div>
						<input type="file" name="stadium_reg_image" class="form-control">
					</div>
					
					<div class="mb-2">
						<div>구장 운영 시간</div>
            			<select name="stadium_time_id1" id="stadium_time_id1" class=" filter-bar form-select" style="width: 150px;">
            				<option value="">시작 시간 선택</option>
            				<c:forEach var="stadiumTime1" items="${stadiumTimeList }">
            				<option value="${stadiumTime1.stadium_time_id }">${stadiumTime1.stadium_time_at }</option>
            				</c:forEach>
            			</select>
            			<select name="stadium_time_id2" id="stadium_time_id2" class=" filter-bar form-select" style="width: 150px;">
            				<option value="">종료 시간 선택</option>
            				<c:forEach var="stadiumTime2" items="${stadiumTimeList }">
            				<option value="${stadiumTime2.stadium_time_id }">${stadiumTime2.stadium_time_at }</option>
            				</c:forEach>
            			</select>
					</div>
					<input type="hidden" name="user_code_id" value="1" />	

					<div class="text-center">
					<button type="submit" class="btn btn-primary" style="width: 30%;">제출하기</button>
					<button type="submit" class="btn btn-primary" style="width: 30%;">취소하기</button>
					</div>
				</form>
			</div>
	</div>

</body>
</html>