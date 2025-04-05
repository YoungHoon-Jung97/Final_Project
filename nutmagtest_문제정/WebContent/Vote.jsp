<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>인원 투표</title></head>
<body>
<h2>⚽ 인원 투표</h2>
<form action="vote_insert.jsp" method="post">
  <input type="hidden" name="club_id" value="1"> <!-- 클럽은 로그인 유저 기준으로 정해짐 -->
  
  <label>경기 날짜:</label>
  <input type="date" name="vote_date" required><br><br>
  
  <label>참여 가능 여부:</label>
  <select name="is_available">
    <option value="true">참여 가능</option>
    <option value="false">불가능</option>
  </select><br><br>

  <input type="submit" value="투표하기">
</form>
</body>
</html>