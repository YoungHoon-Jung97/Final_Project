<%@ page import="java.sql.*" %>
<%
  request.setCharacterEncoding("UTF-8");

  int clubId = Integer.parseInt(request.getParameter("club_id"));
  String voteDate = request.getParameter("vote_date");
  boolean isAvailable = Boolean.parseBoolean(request.getParameter("is_available"));

  // 예: 로그인된 사용자 ID를 세션에서 가져왔다고 가정
  int userId = (Integer)session.getAttribute("user_id");

  Connection conn = null;
  PreparedStatement pstmt = null;

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdb", "root", "password");

    // 1단계: vote 테이블에 새로운 투표 생성 (필요시)
    String insertVoteSQL = "INSERT INTO vote (club_id, vote_date, created_by) VALUES (?, ?, ?)";
    pstmt = conn.prepareStatement(insertVoteSQL, Statement.RETURN_GENERATED_KEYS);
    pstmt.setInt(1, clubId);
    pstmt.setString(2, voteDate);
    pstmt.setInt(3, userId);
    pstmt.executeUpdate();

    ResultSet rs = pstmt.getGeneratedKeys();
    int voteId = 0;
    if (rs.next()) {
      voteId = rs.getInt(1);
    }

    // 2단계: vote_participation 테이블에 현재 유저 투표 결과 저장
    String insertPartSQL = "INSERT INTO vote_participation (vote_id, user_id, is_available) VALUES (?, ?, ?)";
    pstmt = conn.prepareStatement(insertPartSQL);
    pstmt.setInt(1, voteId);
    pstmt.setInt(2, userId);
    pstmt.setBoolean(3, isAvailable);
    pstmt.executeUpdate();

    out.println("<p>투표가 완료되었습니다!</p>");

  } catch(Exception e) {
    e.printStackTrace();
    out.println("<p>오류 발생: " + e.getMessage() + "</p>");
  } finally {
    try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
    try { if(conn != null) conn.close(); } catch(Exception e) {}
  }
%>