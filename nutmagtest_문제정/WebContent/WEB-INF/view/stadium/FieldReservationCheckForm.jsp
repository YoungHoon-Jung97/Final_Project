<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>예약 내용 확인</title>
</head>
<body>
<c:if test="${not empty sessionScope.message}">
	<script type="text/javascript">
		var message = "${fn:escapeXml(sessionScope.message)}";
		var parts = message.split(":");
		
		if (parts.length > 1)
		{
			var type = parts[0].trim();
			var content = parts[1].trim();
			
			switch (type)
			{
				case "SUCCESS_INSERT":
				case "SUCCESS_APPLY":
					swal("성공", content, "success");
					break;
				
				case "NEED_REGISTER_STADIUM":
					swal("주의", content, "warning");
					break;
					
				case "ERROR_DUPLICATE_JOIN":
				case "ERROR_AUTH_REQUIRED":
				case "ERROR_DUPLICATE_REQUEST":
					swal("에러", content, "error");
					break;
				
				default:
					swal("알림", content, "info");
			}
		}
		
		else
		{
			// fallback: 구분자 없는 일반 메시지
			swal("처리 필요", message, "info");
		}
	</script>
	
	<c:remove var="message" scope="session"></c:remove>
</c:if>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>
<form action="FieldReservationInsert.action" method="post">
    <h2>예약 내용 확인 페이지</h2>
    <p>예약 날짜: ${match_date}</p>
    <p>예약 시간: ${start_time_text} ~ ${end_time_text}</p>
	
	<p><strong>운영자 이름 :</strong> ${operator.operator_name}</p>
	<p><strong>계좌번호 : </strong> ${operator.operator_account_no}</p>
	<p><strong>예금주 : </strong> ${operator.operator_account_holder}</p>
	<p><strong>은행명 : </strong> ${operator.bank_name}</p>
	<p><strong>금액(2시간 당) : </strong> ${field_reg_price}</p>
	
	<p><strong>총 금액 : </strong> ${totalPrice}</p>
	
	<p>경기는 몇대몇으로 할까요?</p>
	<select name="match_inwon_id">
		<option value="">매칭인원</option>
		<c:forEach var="inwon" items="${inwonList}">
			<option value="${inwon.match_inwon_id }">${inwon.match_inwon_type }</option>
		</c:forEach>
	</select>
	
	<h2>필수! 예약 확정 후 2일 이내로 입금을 해야 합니다</h2>
	<h4>입금이 없을시 자동 취소 될 수 있습니다.</h4>
    <!-- 확정 버튼 -->
    
        <input type="hidden" name="field_code_id" value="${field_code_id}" />
        <input type="hidden" name="field_res_match_at" value="${match_date}" />
        <input type="hidden" name="stadium_time_id1" value="${start_time_id}" />
        <input type="hidden" name="stadium_time_id2" value="${end_time_id}" />
        <input type="hidden" name="field_res_pay_amount" value="${totalPrice}" />
        <input type="hidden" name="team_id" value="${team_id}" />

        <input type="hidden" name="start_time_text" value="${start_time_text}" />
        <input type="hidden" name="end_time_text" value="${end_time_text}" />
        
        <button type="submit">예약 확정</button>
        <button type="button" onclick="history.back();">뒤로가기</button>
    </form>
</body>
</html>