<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 가입</title>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/Team.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/modal.css">
<script type="text/javascript">
	$(document).ready(function() {
		$("#teamApply").on("click",function(){
			$('#applyModal').css('display', 'flex');
			$("#applyModal").show();
	    	$("body").css("overflow", "hidden"); // 페이지 스크롤 방지
			
		});
	
	    // 모달 닫기 버튼
	    $("#apply-cancel").on("click", function() {
	    	$('#applyModal').css('display', 'none');
	        $("#applyModal").hide(); // 모달 숨기기
	        $("body").css("overflow", "auto"); // 페이지 스크롤 복원
	    });
	    
	    
	});
</script>

</head>
<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>

<!-- 팀 참여 모달 -->
<div id="applyModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">팀 신청</h3>
        </div>
        <div class="modal-body">
        	<form action="TeamApplyInsert.action" method="post">
	            <div class="content-section">
	            	<h4 class="section-title">신청자 설명</h4>
	            	<select name="position_id" id="position"
					class="selectpicker" style="width: 150px; margin-top: 10px; margin-bottom: 10px;">
						<option value="">포지션 선택 선택</option>
						<c:forEach var="position" items="${positionList }">
							<option value="${position.position_id }">${position.position_name }</option>
						</c:forEach>
					</select> 
	            
	                <h4 class="section-title">신청자 설명</h4>
	                <textarea id="apply-content" placeholder="자신의 정보를 입력하세요" name="team_apply_desc"></textarea>
	                <input type="hidden" name="team_id" value="${team_id}" />
	            </div>
	            <div class="modal-footer">
	                <button type="submit" id="submit-apply" class="modal-button modal-submit">신청</button>
	                <button type="reset" id="reset-apply" class="modal-button modal-cancel">취소</button>
	            </div>
            </form>
        </div>
    </div>
</div>	
	<div class="container-fluid container">
		<div class="main">
			<div class="main-content">
				
				<!-- .tean-menu -->

				<div class="team-info-wrap">

					<div class="left">
						<div class="team_box">
							<div class="team01">
							<span></span>
								<div class="team-img">
									<img src="${team.emblem}" alt="" />
								</div>
								<dt>${team.temp_team_name}</dt>
							</div>
							<div class="team02">
								<ul>
									<li></li>
								</ul>
								<p class="comment">${team.temp_team_desc}</p>
							</div>
						</div>
					</div>

					<div class="right">
						<table class="team-table">
							<caption>팀원정보</caption>
							<colgroup>
								<col style="width: 45%" />
								<col style="width: 10%" />
								<col style="width: 15%" />
								<col style="width: 30%" />
							</colgroup>
							<thead>
								<tr class="center">
									<th>이름</th>
									<th>포지션</th>
									<th>역할</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody class="center">
								<c:forEach var="teamMember" items="${teamMemberList}">
									<tr>
										<td>${teamMember.user_name}</td>
										<td>${teamMember.position_name}</td>
										<td>팀 개설자</td>
										<td></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<!-- .team-info-wrap -->
				<div class="team-modify">
					<button id="teamApply">팀 가입</button>
				</div>
			</div>
			<!-- .main-content  -->
		</div>
		<!-- .main  -->
	</div>


</body>
</html>
