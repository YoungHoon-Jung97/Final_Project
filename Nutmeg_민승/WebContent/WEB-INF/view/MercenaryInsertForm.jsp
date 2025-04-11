<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>용병 등록</title>

    <!-- 외부 리소스 -->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <c:import url="/WEB-INF/view/Template.jsp"></c:import>
    <link rel="stylesheet" type="text/css" href="<%=cp %>/css/insertForm.css?after">

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <div class="content">
      <form class="form" method="POST" action="MercenaryInsert.action">
    <div class="form__title">용병 등록</div>

    <!-- 이름 -->
    <div class="form__section">
        <label class="form__label required" for="user_name">이름</label>
        <input type="text" class="form__input" id="user_name" name="user_name" required>
    </div>

    <!-- 소속 동호회 -->
    <div class="form__section">
        <label class="form__label required" for="temp_team_name">소속 동호회</label>
        <div class="form__input-wrapper">
            <input type="text" id="temp_team_name" name="temp_team_name" class="form__input" placeholder="동호회 선택" readonly required>
            <button type="button" class="btn btn--search" id="clubSearchBtn">검색</button>
        </div>
        <div class="form__input-wrapper">
            <input type="radio" id="club_none" name="clubOption" value="none">
            <label for="club_none" class="form__label">없음</label>
        </div>
    </div>

    <!-- 포지션 -->
    <div class="form__section">
        <label class="form__label required" for="position_name">포지션</label>
        <select id="position_name" name="position_name" class="form__input" required>
            <option value="">선택하세요</option>
            <option value="FW">FW</option>
            <option value="MF">MF</option>
            <option value="DF">DF</option>
            <option value="GK">GK</option>
        </select>
    </div>

    <!-- 선호 시간 -->
    <div class="form__section">
        <label class="form__label required" for="mercenary_time_start_at">선호시간</label>
        <select id="mercenary_time_start_at" name="mercenary_time_start_at" class="form__input" required>
            <option value="">선택하세요</option>
            <c:forEach var="i" begin="1" end="24">
                <option value="${i}시">${i}시</option>
            </c:forEach>
        </select>
    </div>

    <!-- 지역 -->
    <div class="form__section">
        <label class="form__label required" for="region_name">지역</label>
        <input type="text" id="region_name" name="region_name" class="form__input" required>
    </div>

    <!-- 도시 -->
    <div class="form__section">
        <label class="form__label required" for="city_name">도시</label>
        <input type="text" id="city_name" name="city_name" class="form__input" required>
    </div>

    <!-- 버튼 -->
    <div class="form__actions">
        <button type="submit" class="btn btn--submit">지원하기</button>
    </div>
</form>

    </div>
    </script>
</body>
</html>
