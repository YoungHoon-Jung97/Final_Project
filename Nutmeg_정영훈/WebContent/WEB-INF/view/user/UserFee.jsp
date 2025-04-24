<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserFee.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/util/UserTemplate.css?after">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<div class="main-background">
	<main>
		<div class="container wrapper">
			<!-- 메인 콘텐츠 -->
			<section class="content-area">
				<h4 class="mb-4">결제 내역</h4>
				
				<div class="bg-white p-4 rounded shadow-sm">
					<table class="table align-middle mb-0">
						<thead class="table-light">
							<tr>
								<th scope="col">납부 날짜</th>
								<th scope="col">종류</th>
								<th scope="col">내용</th>
								<th scope="col">금액</th>
								<th scope="col">납부자</th>
							</tr>
						</thead>
			
						<tbody>
							<c:choose>
								<c:when test="${empty feeList}">
									<tr>
										<td colspan="5" class="text-center text-muted py-4">결제 내역이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="fee" items="${feeList}">
										<tr>
											<td class="text-nowrap">${fee.team_member_fee_pay_at}</td>
											<td>회비</td>
											<td>납부</td>
											<td>
												<fmt:formatNumber value="${fee.team_member_fee_pay_price}" type="number" pattern="#,###"/>원
											</td>
											<td>${fee.user_nick_name}</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<!-- 페이징 -->
					<div class="pagination">${pageHtml}</div>
				</div>
			</section>
			
			<!-- 사이드바 -->
			<aside class="sidebar">
				<nav>
					<a class="nav-link active" href="UserMainPage.action">
						<i class="bi bi-person-circle"></i> 내 정보
					</a>
					
					<a class="nav-link" href="UserMatch.action">
						<i class="bi bi-flag"></i> 경기 기록
					</a>
					
					<a class="nav-link" href="UserFee.action">
						<i class="bi bi-cash"></i> 결제 내역
					</a>
					
					<a class="nav-link" href="UserNotification.action">
						<i class="bi bi-journal-text"></i> 알림
					</a>
					<a class="nav-link" href="UserMercenary.action">
						<i class="bi bi-trophy"></i>  용병 신청
					</a>
				</nav>
			</aside>
		</div>
	</main>
	
	<c:import url="/WEB-INF/view/Footer.jsp"></c:import>
</div>
</body>
</html>