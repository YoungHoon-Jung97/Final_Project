<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserNotification.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/util/UserTemplate.css?after">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/util/UserNotification.css?after">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>

</head>
<body>
<div class="main-background">
	<main>
		<div class="container wrapper">
			<!-- 메인 콘텐츠 -->
			<section class="content-area">
				<h4 class="mb-4">알림</h4>
				
				<div class="profile-box">
					<c:choose>
						<c:when test="${empty notificationList}">
							<div style="display: flex; justify-content: center;">
								알림이 없습니다.
							</div>
						</c:when>
						
						<c:otherwise>
							<c:forEach var="notification" items="${notificationList}">
								<div class="info-row ${notification.is_read == 'N' ? 'unread' : 'read'}">
									<span>
										<a href="IsRead.action?notification_id=${notification.notification_id}"
										class="notification-link" style="text-decoration:none;">
										<strong>[${notification.notification_type}]</strong>	${notification.message}
										</a>
										<a href="DeleteNotification.action?notification_id=${notification.notification_id}" 
							      		class="delete-button" onclick="return confirm('정말 삭제하시겠습니까?');">
											삭제
							   			</a>
									</span>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
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