<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
<style>

	body {
        padding: 0 10%; /* body의 왼쪽, 오른쪽에 10% 공백 */
        box-sizing: border-box; /* padding을 포함하여 크기 계산 */
    }

    .logo-image {
        width: 80px;
        height: 80px;
    }
    
    .test-image {
        width: 80px;
        height: 80px;
    }
    
    .logo-sentence
    {
    	font-size: 30pt;
    	height: middle;
    }
    
    .menu
    {
    	text-align: center;
    
    }
    ul
	{
		list-style-type: none;
		margin: 0;
		padding: 0;
		overflow: hidden;
	}
	li
	{
		width: 20%;
		float: left;
	}
	a.navMenu:link, a.navMenu:visited
{
	display: block;
	font-weight: bold;
	color: #ffffff;
	background-color: #008000;
	text-align: center;
	padding: 4px;
	text-decoration: none;
	text-transform: uppercase;
	height: 30px;
	font-size: 14pt;
}

/*
.main {
    display: flex;
    justify-content: space-between;
}
*/
/*
.item {
    text-align: center; 이미지와 이름을 중앙 정렬 
}

.test-image {
    display: block; 이미지를 블록으로 설정하여 아래 텍스트와 정렬되게 함
    margin: 0 auto; 이미지가 가로로 중앙 정렬되도록 함 
}
*/

/* .item {
    padding: 0 10%; 
} */

.link {
    display: inline-block;
}


</style>

</head>
<body>

<header style="display: flex; justify-content: space-between; align-items: center;">
    <!-- 왼쪽 영역: 이미지와 텍스트 -->
    <div style="display: flex; align-items: center;">
        <img alt="nutmag.png" src="<%=cp %>/imgs/nutmag.png" class="logo-image">
        <a href="" class="logo-sentence">nutmag</a>
        <img alt="nutmag.png" src="<%=cp %>/imgs/nutmag.png" class="logo-image">
    </div>
    
    <!-- 오른쪽 영역: "검색"과 input 박스 -->
     <div style="position: absolute; right: 5%; display: flex; align-items: center;">
        <span>검색 </span>
        <input type="text">
        <button type="button" >검색</button>
    </div>


    <hr />
</header>

<nav id="menu">
	<ul>
		<li>
			<a href="" class="navMenu">홈으로</a>
		</li>
		<li>
			<a href="" class="navMenu">커뮤니티</a>
		</li>
		<li>
			<a href="" class="navMenu">결제하기</a>
		</li>
		<li>
			<a href="" class="navMenu">메뉴판예시</a>
		</li>
		<li>
			<a href="" class="navMenu">로그아웃</a>
		</li>
		
	</ul>
</nav>

<div class="main">
	
		<h2>구장 이름1</h2>
	    <div class="item">
	        <img alt="nutmag.png" src="<%=cp %>/imgs/nutmag.png" class="test-image">
	        <a href="">구장 이름1</a>
	    </div>
	    <hr>
	    <h2>구장 이름2</h2>
	    <div class="item">
	        <img alt="nutmag.png" src="<%=cp %>/imgs/nutmag.png" class="test-image">
	        <a href="">구장 이름2</a>
	    </div>
	     <hr>
	     <h2 >구장 이름3</h2>
	    <div class="item">
	        <img alt="nutmag.png" src="<%=cp %>/imgs/nutmag.png" class="test-image">
	        <a href="" class="link">구장 이름3</a>
	    </div>
	    <hr>
    
</div>


</body>
</html>