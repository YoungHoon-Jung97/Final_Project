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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var user_code_id = "<%= user_code_id %>";

		$('#teamName').on('input',function(){
			
			$('#teamNameCheck').css('display','none');
			$('#submitBtn').prop('disabled',false);
			
		});
		
		$('#user_code_id').val(user_code_id);
		
		var region = $("#regions").val();
		
		if (region == "") {
			$("#citys").html('<option value="">-- 먼저 지역을 선택하세요 --</option>');	
		}
		
		$("#regions").on('change',function(){
			region = $("#regions").val();
			$.ajax({
				url:"SearchCity.action",
				type:"get",
				data:{region:region},
				dataType:"JSON",
				success:function(result){
					$('#citys').empty();
					if (result.length >0) {
						$.each(result, function(index, city){
							$('#citys').append('<option value="' + city.city_id + '">' + city.city_name + '</option>');
						});
					}
				},
				error: function(xhr, status, error){
					alert("도시 목록을 불러오는 중 오류가 발생했습니다.");
				}
			});
		});
		
		$('form').on('submit',function(event){
			
			event.preventDefault();
			
			checkTeamName(function(isValid){
				if (isValid) {
	                // 중복 검사 통과 시 폼 제출
	                $('form')[0].submit();
	            }
				
			});
			
		});
	});
	
	function checkTeamName(callback){
		var teamName = $('#teamName').val();

	
		$.ajax({
			
			url:'CheckTeamName.action',
			type:'get',
			data:{teamName:teamName},
			dataType:'text',
			success:function(result){
				if(result == "이미 사용중인 팀네임 입니다."){
					
					$('#teamNameCheck').text(result);
					$('#teamNameCheck').css({'display': 'inline', 'color': 'red'})
					callback(false);
				}
				else if(result =="사용 가능한 팀네임 입니다."){
					
					$('#teamNameCheck').text(result);
					$('#teamNameCheck').css({'display': 'inline', 'color': 'green'})
					callback(true);
				}
			},
			error:function(){
				$('#teamNameCheck').text("팀네임을 입력하세요").css({'display':'inline','color':'red'});
				callback(false);
			}
			
		});
		
	}
</script>
</head>
<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>
<div class="container">
	<div>
		<h5 class="form__title">동호회 개설 신청 양식</h5>
		<form method="post" action="TeamInsert.action" class="form">
			<div class="form__section">
				<div class="form__group">
					<label for="teamName" class="form__label required">동호회 이름</label>
					<div class="form__input--wrapper">
						<input type="text" id="teamName" name="temp_team_name" class="form__input" placeholder="동호회 이름" required>
						<input type="hidden" id="user_code_id" name="user_code_id" value="">
					</div>
					<p id="teamNameCheck" class="result"></p>
				</div>
				<div class="form__group">
						<label for="memberCount" class="form__label required">동호회 회원 수</label>
						<input type="number" name="temp_team_person_count" class="form-control" placeholder="동호회 회원 수" required>
					</div>
				<div class="form__group">
					<label for="region" class="form__label required">지역</label>
					<div class="form__selection">
						<span class="size-label">시</span>	
						<select id="regions" name="region_id" class="form__input" required>
							<option value="">시를 선택하세요</option>
							<c:forEach var="region" items="${regionList}">
								<option value="${region.region_id}">${region.region_name}</option>
							</c:forEach>
						</select>
						<span class="size-label">구</span>
						<select id="citys" name="city_id" class="form__input" required>
						</select>
					</div>
				</div>
				<div class="form__group">
					<label for="discript" class="form__label">동호회 설명</label>
					<!-- <input type="text" name="temp_team_desc" class="form-control" placeholder="동호회 설명" required="required"> -->
					<textarea rows="5" cols="" class="form-control" name="temp_team_desc"  placeholder="동호회의 방향성 혹은 동호회 설명 등.."></textarea>
				</div>
				<!-- 첨부파일 -->
				<div class="form__group">
					<div class="form__field">
						<label for="image" class="form__label">동호회 앰블럼</label>
						<div class="form__input-wrapper file-upload">
							<input type="file"  class="form__input file-upload-input" id="image" name="temp_team_emblem"/>
						</div>
					</div>
				</div>
				<div>
			        <label for="bank" class="form__label">은행명</label>
			        <select id="bank" name="bank_id" class="required form__input"  required>
			            <option value="">은행을 선택하세요</option>
			            <c:forEach var="bank" items="${bankList}">
			                <option value="${bank.bank_id}">${bank.bank_name}</option>
			            </c:forEach>
			        </select>
			    </div>
			    <div class="form__group">
						<label for="depositor" class="form__label required">동호회 예금주</label>
						<input type="text" name="temp_team_account_holder" class="required form-control" placeholder="동호회 예금주" required>
					</div>
					<div class="form__group">
						<label for="account" class="form__label required">동호회 계좌번호</label>
						<input type="text" name="temp_team_account" class="required form-control" placeholder="동호회 계좌 번호" required>
					</div>
			</div>
			<div class="form__actions">
					<button type="submit" id="submitBtn" class="btn btn--submit" >개설하기</button>
					<button type="reset" class="btn btn--reset">취소</button>
					<button type="button" class="btn btn--back">뒤로가기</button>
			</div>
		</form>
	</div>
</div>
</body>
</html>
