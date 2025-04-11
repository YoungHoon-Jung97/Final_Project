<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>용병 고용</title>
<link rel="stylesheet" type="text/css" href="<%= cp %>/css/Mercenary.css">
</head>
<body>
    <div class="container">
        <!-- 네비게이션 타이틀 -->
        <div class="navbar-title">넛맥</div>
        
        <!-- 브레드크럼 -->
        <div class="breadcrumb">
            <a href="#">홈</a> > <a href="#">매칭</a> > 용병 고용
        </div>
        
        <!-- 용병 고용 컨테이너 -->
        <div class="table-container">
            <div class="table-row header">
                <div class="table-cell">용병 고용</div>
            </div>
            
            <!-- 검색 및 필터 영역 -->
            <div class="search-filter">
                <div class="search-bar">
                    <input type="text" name="searchKeyword" placeholder="검색어 입력">
                    <button type="submit">검색</button>
                </div>
                <div class="filter-container">
                    <select name="searchField">
                        <option value="name">이름</option>
                        <option value="clan">소속 동호회</option>
                        <option value="position">포지션</option>
                        <option value="time">선호시간</option>
                    </select>
                </div>
            </div>
            
            <!-- 용병 리스트 테이블 -->
            <div class="table-row header">
                <div class="table-cell">이름</div>
                <div class="table-cell">소속 동호회</div>
                <div class="table-cell">포지션</div>
                <div class="table-cell">선호시간</div>
                <div class="table-cell">고용</div>
            </div>
            
            <!-- 데이터 행 (예시) -->
            <div class="table-row">
                <div class="table-cell">
                    <a href="<%= cp %>/mercenaryProfile.jsp">문제정</a>
                </div>
                <div class="table-cell">문도리</div>
                <div class="table-cell">DF</div>
                <div class="table-cell">13시</div>
                <div class="table-cell">
                    <button class="search-bar button">고용</button>
                </div>
            </div>
            
            <div class="table-row">
                <div class="table-cell">
                    <a href="<%= cp %>/mercenaryProfile.jsp">정영훈</a>
                </div>
                <div class="table-cell">없음</div>
                <div class="table-cell">MF</div>
                <div class="table-cell">18시</div>
                <div class="table-cell">
                    <button class="search-bar button">고용</button>
                </div>
            </div>
            
            <div class="table-row">
                <div class="table-cell">
                    <a href="<%= cp %>/mercenaryProfile.jsp">박세진</a>
                </div>
                <div class="table-cell">풋도리</div>
                <div class="table-cell">FW</div>
                <div class="table-cell">21시</div>
                <div class="table-cell">
                    <button class="search-bar button">고용</button>
                </div>
            </div>
            
            <div class="table-row">
                <div class="table-cell">
                    <a href="<%= cp %>/mercenaryProfile.jsp">안석창</a>
                </div>
                <div class="table-cell">없음</div>
                <div class="table-cell">GK</div>
                <div class="table-cell">15시</div>
                <div class="table-cell">
                    <button class="search-bar button">고용</button>
                </div>
            </div>
        </div>
        
        <!-- 페이지네이션 -->
        <div class="pagination">
            <a href="#">&lt;</a>
            <a href="#">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#">&gt;</a>
        </div>
        
        <!-- 스크롤 업 버튼 -->
        <div class="scroll-up">↑</div>
    </div>
    
    <!-- JavaScript for 스크롤 업 버튼 -->
    <script>
        // 스크롤 업 버튼 기능
        document.querySelector('.scroll-up').addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    </script>
</body>
</html>