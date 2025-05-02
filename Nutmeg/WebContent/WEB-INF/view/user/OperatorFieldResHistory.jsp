<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/stadium/StadiumFieldCheckForm.css?after">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">


	$(document).on("click", ".page-btn", function()
	{
		var page = $(this).data("page");
		
		$.ajax(
		{
			url : "/Nutmeg/OperatorFieldResHistory.action",
			method : "GET",
			data : { page : page },
			success : function(data)
			{
				console.log("서버 응답 확인:");
				console.log(data);
				$("#history-container").replaceWith(data); // ✅ 핵심 수정
			},
			error : function()
			{
				alert("페이지 로딩 중 오류가 발생했습니다.");
			}
		});
	});

</script>

<h4 class="mb-4">결제 내역</h4>

<div id="history-container">
	<div class="match-card" id="total-payment">
		<strong>지금까지 총 결제 금액 ${total} 원, 모든 거래 횟수 ${totalCount}회</strong>
	</div>
	
	<c:forEach var="history" items="${fieldResHistoryList}">
		<div class="match-card">
			<div class="stadium-card">
				<div class="stadium-img-wrapper">
					<div class="stadium-info">
						<strong>${history.field_name}</strong><br>
						경기장 이름 : ${history.field_name}<br>
						경기장 예약 승인일 : ${history.field_res_pay_at}<br>
						경기장 예약 경기일 : ${history.match_date} ${history.start_time} ~ ${history.end_time}<br>
						경기장 결제액 : ${history.pay_amount}원<br>
						경기장 상황 : ${history.match_status}
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
	
	<!-- 페이징 버튼 -->
	<div class="pagination" style="margin-top: 20px;">
		<c:if test="${currentPage > 1}">
			<button class="page-btn btn btn-outline-primary" data-page="${currentPage - 1}"
			style="color: white;">이전</button>
		</c:if>
		
		<c:forEach begin="1" end="${totalPage}" var="i">
			<button class="page-btn btn <c:if test='${i eq currentPage}'>btn-primary</c:if> btn-outline-secondary"
			data-page="${i}" style="color: white;">${i}</button>
		</c:forEach>
		
		<c:if test="${currentPage < totalPage}">
			<button class="page-btn btn btn-outline-primary" data-page="${currentPage + 1}"
			style="color: white;">다음</button>
		</c:if>
	</div>
</div>