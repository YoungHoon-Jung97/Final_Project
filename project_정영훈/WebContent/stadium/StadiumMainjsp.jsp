<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 정보</title>
<style type="text/css">
/* General Reset */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Nanum Gothic', sans-serif;
}

body {
	background-color: #f5f5f5;
}

/* Main Container */
.main {
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
}

.main-content {
	width: 100%;
}

/* 지역 선택 */
.region-list-wrap{
	display:flex; /*영역 나누기*/
	list-style: none;
	border-bottom: 1px solid #ddd;
	margin-bottom: 20px;
}

.region-list-wrap li {
	flex:1; /*부모 여역 균등하게 나누기*/
	text-align: center;
}

.region-list-wrap a {
	display: block;
	padding: 15px 0;
	text-decoration: none;
	color: #333;
	font-weight: bold;
	transition: all 0.3s;
}

/*팀 메뉴 넘어갔을 때 표시*/
.region-list-wrap:nth-child(1) a {
	color: #ff4500;
	border-bottom: 2px solid #ff4500;
}

.region-list-wrap a:hover {
	color: #ff4500;
}

/* 구장 정보 구분 */
.wrap {
	display: flex;
	margin-bottom: 20px;
}

.field-img {
	flex: 0 0 40%;
	margin-right: 20px;
}

.field-info {
	flex: 0 0 60%;
}

/* 구장구분 */
.field-wrap{
	display: flex;
	margin-bottom: 20px;
}

.field-wrap li {
	flex: 1;
	margin-right: 20px;
}

</style>
</head>
<body>
	<section>
		<div class="main">
			<div class="main-content">
			
				<!-- 경기장 검색  -->
				<div class="field-search-top">
					<div class="field-search">
						<form action="">
							<select name="searchType" id="searchType">
								<input type="text" name="title"  id="title"/>
								<input type="submit" value="검색" class="btnSearch" />
							</select>
						</form>
					</div>
				</div>
				
				<div class="region-list">
					<ul class="region-list-wrap">
						<li>
							<a href="">
								<p class="field-list-txt">전체</p>
							</a>
						</li>
						<li>
							<a href="">
								<p class="field-list-txt">서울</p>
							</a>
						</li>
					</ul>
				</div>
				
				<div class="region-list">
					<ul class="region-list-wrap">
						<li>
							<a href="">
								<p class="field-list-txt">전체</p>
							</a>
						</li>
						<li>
							<a href="">
								<p class="field-list-txt">강남</p>
							</a>
						</li>
					</ul>
				</div>
				
				<!-- 경기장 리스트 -->
				<ul class="field-wrap">
					<li>
						<a href="">
							<div class="wrap">
								<div class="field-img">
									<img src="" alt="" />
								</div>
								<div cass="field-info">
									<div class="field-info-wrap">
										<p cass="fieldName">도봉구민체육센터</p>
										<p clss="fieldAddress">서울 틀별시 도봉구 창동</p>
										<dl>
											<dt>전화번호</dt>
											<dt>02-652-4851</dt>
										</dl>
										<dl class=""></dl>
									</div>
								</div>
							</div>
						</a>
					</li>
					<li>
						<a href="">
							<div class="wrap">
								<div class="field-img">
									<img src="" alt="" />
								</div>
								<div cass="field-info">
									<div class="field-info-wrap">
										<p cass="fieldName">남서울 대학교</p>
										<p clss="fieldAddress">서울 틀별시 서교동</p>
										<dl>
											<dt>전화번호</dt>
											<dt>02-652-4652</dt>
										</dl>
										<dl class=""></dl>
									</div>
								</div>
							</div>
						</a>
					</li>
				</ul>
			</div>
			<!-- .main-content  -->
		</div>
		<!-- .main  -->
	</section>



</body>
</html>