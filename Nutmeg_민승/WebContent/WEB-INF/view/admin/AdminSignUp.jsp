<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%

    request.setCharacterEncoding("UTF-8");
    
    // 폼에서 전송된 파라미터 받기
    String adminId       = request.getParameter("adminId");
    String adminEmail    = request.getParameter("adminEmail");
    String adminNickName = request.getParameter("adminNickName");
    String adminTel      = request.getParameter("adminTel");
    String userCodeId    = request.getParameter("userCodeId");
    
    // 폼이 제출된 경우(즉, 모든 파라미터가 null이 아닐 때)만 DB 처리
    if (adminId != null && adminEmail != null && adminNickName != null 
            && adminTel != null && userCodeId != null) {
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            // 1) 드라이버 로딩
            Class.forName("oracle.jdbc.driver.OracleDriver");
            
            // 2) DB 연결 (URL, 계정, 비밀번호를 실제 환경에 맞게 수정)
            conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", 
                "username", 
                "password"
            );
            
            // 3) INSERT 쿼리 준비
            String sql = "INSERT INTO ADMIN (admin_id, admin_email, admin_nickName, admin_tel, userCode_id) "
                       + "VALUES (?, ?, ?, ?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, adminId);
            pstmt.setString(2, adminEmail);
            pstmt.setString(3, adminNickName);
            pstmt.setString(4, adminTel);
            pstmt.setString(5, userCodeId);
            
            // 4) 실행
            int result = pstmt.executeUpdate();
            
            // 5) 결과 처리
            if (result > 0) {
                out.println("<script>alert('관리자 회원가입 성공!');</script>");
            } else {
                out.println("<script>alert('관리자 회원가입 실패!');</script>");
            }
            
        } catch (Exception e) {
            out.println("<script>alert('에러 발생: " + e.getMessage() + "');</script>");
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception ignore) {}
            try { if (conn != null)  conn.close();  } catch (Exception ignore) {}
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 회원가입</title>
    <style>
        body { font-family: sans-serif; }
        .container { width: 400px; margin: 0 auto; }
        label { display: inline-block; width: 120px; margin-top: 10px; }
        input { width: 200px; padding: 5px; }
        button { margin-top: 20px; padding: 10px 20px; }
    </style>
</head>
<body>
<div class="container">
    <h2>관리자 회원가입</h2>
    
    <!-- 관리자 회원가입 폼 -->
    <form method="post" action="AdminSignUp.jsp">
        <label for="adminId">관리자 ID</label>
        <input type="text" id="adminId" name="adminId" required><br>
        
        <label for="adminEmail">관리자 이메일</label>
        <input type="email" id="adminEmail" name="adminEmail" required><br>
        
        <label for="adminNickName">관리자 닉네임</label>
        <input type="text" id="adminNickName" name="adminNickName" required><br>
        
        <label for="adminTel">휴대폰 번호</label>
        <input type="text" id="adminTel" name="adminTel" placeholder="010-0000-0000" required><br>        
    
        <button type="submit">회원가입</button>
    </form>
</div>
</body>
</html>
