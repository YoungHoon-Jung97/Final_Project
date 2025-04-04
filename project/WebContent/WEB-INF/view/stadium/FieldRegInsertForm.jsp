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
<script type="text/javascript">

	$(document).ready(function()
	{
		$("#field_type_id").click(function()
		{
			alert("#field_type_id".val());
			
		});
		
	})

</script>

</head>
<body>
	<div>배너 넣을 공간</div>
	<!-- 상단 정보 영역 -->
	<div class="container my-4">
			<div class="border rounded p-3 bg-white">
				<h5 class="mb-3 text-center">경기장 등록 양식</h5>
				<form method="post" action="">
					<div class="mb-2">
						<div>경기장 이름</div>
						<input type="text" name="field_reg_name" class="form-control" placeholder="구장 이름" required="required">
					</div>
					<div class="mb-2">
						<div>우편 주소</div>
						<input type="text" name="field_reg_postal_addr" class="form-control" placeholder="우편 주소" required="required">
					</div>
					<div class="mb-2">
						<div>주소</div>
						<input type="text" name="field_reg_addr" class="form-control" placeholder="주소 " required="required">
					</div>
					<div class="mb-2">
						<div>상세 주소</div>
						<input type="text" name="field_reg_detailed_addr" class="form-control" placeholder="상세 주소">
					</div>
					<div class="mb-2">
						<div>경기장 이미지 올리기</div>
						<input type="file" name="field_reg_image" class="form-control">
						<input type="file" name="field_reg_image" class="form-control">
					</div>
					
					<div class="mb-2">
						<div>필드 종류</div>
            			<select name="field_type_id" id="field_type_id" class=" filter-bar form-select" style="width: 150px;">
            				<option>필드 종류 선택</option>
            				<c:forEach var="fieldTypeList" items="${fieldTypeList }">
            				<option value="${fieldTypeList.field_type_id }">${fieldTypeList.field_type }</option>
            				</c:forEach>
            			</select>
					</div>
					
					<div class="mb-2">
						<div>경기장 환경</div>
            			<select name="field_environment_id" class=" filter-bar form-select" style="width: 150px;">
            				<option>경기장 환경 선택</option>
            				<c:forEach var="fieldEnviromentList" items="${fieldEnviromentList }">
            				<option value="${fieldEnviromentList.field_environment_id }">${fieldEnviromentList.field_environment_type }</option>
            				</c:forEach>
            			</select>
					</div>
					

					<div class="text-center">
					<button type="submit" class="btn btn-primary" style="width: 30%;">제출하기</button>
					<button type="submit" class="btn btn-primary" style="width: 30%;">취소하기</button>
					</div>
				</form>
			</div>
	</div>

</body>
</html>