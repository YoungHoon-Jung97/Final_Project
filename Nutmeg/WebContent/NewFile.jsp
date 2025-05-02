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
<title>매치 참가 인원 - 더미 데이터 버전</title>

<style type="text/css">
/* 컨테이너: 흰색 박스 */
.member-container {
	width: 95vw;
	max-width: 1280px;
	background-color: #ffffff;
	border-radius: 16px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
	overflow: hidden;
	padding: 30px 40px;
	box-sizing: border-box;
}

/* 상단 타이틀 */
.member-title {
	text-align: center;
	font-size: 28px;
	font-weight: bold;
	color: #2e7d32;
	margin-bottom: 30px;
}

/* 헤더 */
.member-header {
	display: grid;
	grid-template-columns: repeat(5, 1fr);
	background-color: #7dcfb6;
	color: #fff;
	font-weight: 600;
	text-align: center;
	padding: 14px 0;
	font-size: 15px;
	border-radius: 12px;
	margin-bottom: 10px;
}

/* 각 참가자 행 */
.member-row {
	display: grid;
	grid-template-columns: repeat(5, 1fr);
	text-align: center;
	padding: 14px 0;
	border-bottom: 1px solid #eee;
	transition: background-color 0.2s ease;
}

.member-row:hover {
	background-color: #f9f9f9;
}

.member-row .col {
	font-size: 15px;
	color: #333;
	word-break: keep-all;
}
</style>

<c:import url="/WEB-INF/view/Template.jsp"></c:import>
</head>

<body>
<div class="main-background">
	<main>
		<div class="member-container">
			<div class="member-title">매치 참가 인원</div>

			<div class="member-header">
				<div class="col">이름</div>
				<div class="col">직책</div>
				<div class="col">포지션</div>
				<div class="col">나이</div>
				<div class="col">성별</div>
			</div>

			<!-- 여기부터 더미 데이터 -->
			<div class="member-row">
				<div class="col">풋돌이</div>
				<div class="col">회장</div>
				<div class="col">공격수</div>
				<div class="col">25</div>
				<div class="col">남성</div>
			</div>
			<div class="member-row">
				<div class="col">가시방석</div>
				<div class="col">용병</div>
				<div class="col">공격수</div>
				<div class="col">27</div>
				<div class="col">남성</div>
			</div>
			<div class="member-row">
				<div class="col">홍길동</div>
				<div class="col">동호회원</div>
				<div class="col">미드필더</div>
				<div class="col">24</div>
				<div class="col">남성</div>
			</div>
			<div class="member-row">
				<div class="col">김영희</div>
				<div class="col">동호회원</div>
				<div class="col">미드필더</div>
				<div class="col">22</div>
				<div class="col">여성</div>
			</div>
			<div class="member-row">
				<div class="col">이철수</div>
				<div class="col">용병</div>
				<div class="col">미드필더</div>
				<div class="col">28</div>
				<div class="col">남성</div>
			</div>
			<div class="member-row">
				<div class="col">박수진</div>
				<div class="col">동호회원</div>
				<div class="col">수비수</div>
				<div class="col">23</div>
				<div class="col">여성</div>
			</div>
			<div class="member-row">
				<div class="col">오태식</div>
				<div class="col">동호회원</div>
				<div class="col">수비수</div>
				<div class="col">29</div>
				<div class="col">남성</div>
			</div>
			<div class="member-row">
				<div class="col">최민수</div>
				<div class="col">동호회원</div>
				<div class="col">수비수</div>
				<div class="col">26</div>
				<div class="col">남성</div>
			</div>
			<div class="member-row">
				<div class="col">정예린</div>
				<div class="col">용병</div>
				<div class="col">골키퍼</div>
				<div class="col">21</div>
				<div class="col">여성</div>
			</div>
			<div class="member-row">
				<div class="col">한지민</div>
				<div class="col">동호회원</div>
				<div class="col">골키퍼</div>
				<div class="col">30</div>
				<div class="col">여성</div>
			</div>
			<!-- 여기까지 더미 데이터 -->
			
		</div>
	</main>
	
	<c:import url="/WEB-INF/view/Footer.jsp"></c:import>
</div>
</body>
</html>
