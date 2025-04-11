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
<title>용병 모집</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/Mercenary.css">
</head>
<body>
	<div class="container">
		<div class="breadcrumb">커뮤니티 > 용병 모집</div>
		<div class="navbar-title">
			<h1>용병 모집</h1>
		</div>

		<div class="search-filter">
			<div class="search-bar">
				<input type="text" placeholder="검색">
				<button>🔍</button>
			</div>
			<div class="filter-container">
				<select>
					<option value="title">제목</option>
					<option value="detail">내용</option>
					<option value="author">글쓴이</option>
				</select>
			</div>
		</div>

		<div class="table-container">
			<div class="table-row header">
				<div class="table-cell">제목</div>
				<div class="table-cell">글쓴이</div>
				<div class="table-cell">날짜</div>
				<div class="table-cell">조회</div>
			</div>
			<div class="table-row">
				<div class="table-cell">
					<a href="#">용병 모집합니다</a>
				</div>
				<div class="table-cell">김신</div>
				<div class="table-cell">2025.02.20</div>
				<div class="table-cell">45</div>
			</div>
		</div>

		<div class="pagination">
			<a href="#">&lt;이전</a> <a href="#">1</a> <a href="#">2</a> <a
				href="#">3</a> <a href="#">4</a> <a href="#">5</a> <a href="#">6</a>
			<a href="#">7</a> <a href="#">8</a> <a href="#">9</a> <a href="#">10
				...</a> <a href="#">다음&gt;</a>
		</div>

		<button class="scroll-up">⬆</button>
	</div>
</body>
</html>
