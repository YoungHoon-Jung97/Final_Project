<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserMatch.jsp</title>

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
				<h4 class="mb-4">용병 신청</h4>
				<form action="MercenaryResponse.action">
					<div class="bg-white p-4 rounded shadow-sm">
						<table class="table align-middle mb-0">
							<thead class="table-light">
								<tr>
									<th scope="col">경기 날짜</th>
									<th scope="col">시작 시간</th>
									<th scope="col">구장 이름</th>
									<th scope="col">구장 주소</th>
									<th scope="col">팀 이름</th>
									<th scope="col">응답</th>
								</tr>
							</thead>
				
							<tbody>
								<c:choose>
									<c:when test="${empty mercenaryOfferList}">
										<tr>
											<td colspan="5" class="text-center text-muted py-4">용병 오퍼가 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="mercenaryOffer" items="${mercenaryOfferList}">
											<input type="hidden" name="mercenary_offer_id" value="${mercenaryOffer.mercenary_offer_id}" />
											<input type="hidden" name="mercenay_offer_id" value="${mercenaryOffer.mercenary_id}"/>
											<tr>
												<td><fmt:formatDate value="${mercenaryOffer.match_date}" pattern="yyyy-MM-dd" /></td>
												<td>${mercenaryOffer.start_time}</td>
												<td>${mercenaryOffer.stadium_name}</td>
												<td>${mercenaryOffer.stadium_addr}</td>
												<td>${mercenaryOffer.offer_team_name}</td>
												<td>
													<button name="response_type_id" type="submit" value="1">승락</button>
													<button  name="response_type_id" type="submit" value="2">거절</button>
												</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						<!-- 페이징 -->
						<div class="pagination">${pageHtml}</div>
					</div>
				</form>
			</section>
			
			<!-- 사이드바 -->
			<aside class="sidebar">
				<nav>
					<a class="nav-link" href="UserMainPage.action">
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
					
					<a class="nav-link active" href="UserMercenary.action">
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