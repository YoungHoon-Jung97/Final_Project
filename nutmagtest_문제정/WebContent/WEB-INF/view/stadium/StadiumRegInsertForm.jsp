<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	Integer user_code_id = (Integer) session.getAttribute("user_code_id");
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>구장 등록하기</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/insertForm.css">
<!-- 우편번호 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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
		
		var user_code_id = "<%= user_code_id != null ? user_code_id.toString() : "" %>";
		
		if (!user_code_id) {
			alert("로그인이 필요합니다.");
			//로그인 안되어 있으면 로그인 창으로 보냄
			location.href = "MainPage.action"; 
		}

		$('#user_code_id').val(user_code_id);

		$('#stadium_time_id1').on('change', function() {
			var selectedValue = $(this).val();
			alert("선택한 값: " + selectedValue);
		});
		
		$('#user_code_id').val(user_code_id);
		
		$("#checkDuplicateBtn").click(function () {
	        var name = $("#name").val();
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
	
	function execPostCode(){
		new daum.Postcode({
			
			//oncomplete : 주소를 선택하면 팝업이 닫히고 값이 입력 필드에 설정
			oncomplete: function(data) {
				//도로명 주소와 지번 주소 중 하나를 선택하여 출력
				var addr = data.roadAddress ? data.roadAddress : data.jibunAddress;
				
				//우편번호와 주소를 입력란에 넣기
				$("#post").val(data.zonecode);  //우편번호
				$('#address1').val(addr);		//기본 주소
				
				//상세주소 입력창 포커스 이동
				$('#address2').focus();
			},

			
		}).open({
			popupName: 'postPopup', // 팝업 이름 지정(중복 방지)
			width: 400,
            height: 500
			
		});
		
	}
    
</script>


</head>

<body>
	<div class="content">
		<form id="joinForm" class="form form--join" method="post" action="StadiumRegInsert.action" enctype="multipart/form-data">
			<h2 class="form__title">구장 정보 입력</h2>

			<div class="form__section">
				<h3 class="form__section-title">기본 정보</h3>

				<!-- 구장 이름 입력 -->
				<div class="form__group">
					<div class="form__field">
						<label for="name" class="form__label required">구장이름</label>
						<div class="form__input-wrapper">
							<input type="text" class="form__input" id="name"
								placeholder="구장이름" maxlength="20" name="stadium_reg_name"
								required data-type="name" />
							<button type="button" id="checkDuplicateBtn" class="btn btn--check">중복
								확인</button>
						</div>
						<span id="nameCheckMsg"></span>
					</div>
				</div>

				<!-- 우편번호 -->
				<div class="form__group">
					<div class="form__field">
						<label for="post" class="form__label required">우편번호</label>
						<div class="form__input--wrapper">
							<input type="text" class="form__input form__input--sm" readonly
								id="post" required name="stadium_reg_postal_addr" />
							<button type="button" class="btn btn--search"
								onclick="execPostCode()">우편번호 찾기</button>
						</div>
					</div>
				</div>

				<!-- 상세주소 -->
				<div class="form__group">
					<div class="form__field">
						<label for="address" class="form__label">주소</label>
						<div class="form__input--wrapper">
							<input type="text" class="form__input" id="address1"
								placeholder="상세주소 입력" readonly required name="stadium_reg_addr" />
						</div>
					</div>
				</div>
				<div class="form__group">
					<div class="form__field">
						<label for="address" class="form__label">상세주소</label>
						<div class="form__input--wrapper">
							<input type="text" class="form__input" id="address2"
								placeholder="상세주소 입력" required name="stadium_reg_detailed_addr" />
						</div>
					</div>
				</div>
			</div>



			<div class="form__group">
					<div class="form__field">
						<label for="image" class="form__label ">첨부파일</label>
						<input type="file"  class="form__input" id="image" name="stadium_reg_image" style="border: 0;"/>
					</div>
				</div>

			<div class="form__group">
				<div class="form__field">
					<label for="operateTime" class="form__label required" >운영시간</label>
					<div class="form__selection">
						<span class="size-label">시각 시간</span>
						<select name="stadium_time_id1" id="stadium_time_id1"
						class=" form__input select-size" style="width: 150px;">
							<option value="">시작 시간 선택</option>
							<c:forEach var="stadiumTime1" items="${stadiumTimeList }">
								<option value="${stadiumTime1.stadium_time_id }">${stadiumTime1.stadium_time_at }</option>
							</c:forEach>
						</select> 
						<span class="size-label">종료 시간</span>
						<select name="stadium_time_id2" id="stadium_time_id2"
							class="form__input select-size" style="width: 150px;">
							<option value="">종료 시간 선택</option>
							<c:forEach var="stadiumTime2" items="${stadiumTimeList }">
								<option value="${stadiumTime2.stadium_time_id }">${stadiumTime2.stadium_time_at }</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<input type="hidden" id="user_code_id" name="user_code_id" value="">

			<div class="form__actions">
				<button type="submit" class="btn btn--submit">구장 등록</button>
				<button type="reset" class="btn btn--reset">취소</button>
				<button type="button" class="btn btn--back">뒤로가기</button>
			</div>
			
		</form>
	</div>

</body>
</html>