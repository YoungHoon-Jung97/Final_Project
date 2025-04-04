
<%@page import="com.nutmag.project.dto.LoginDTO"%>
<%@page import="com.nutmag.project.dao.LoginDAO"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="javax.servlet.http.Cookie"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String lang = request.getParameter("lang");
	String email = null, pw = null, saveEmail = null;
	
	if (lang.equals("ko"))
	{
		email = request.getParameter("logEmailKo");
		pw = request.getParameter("logPwKo");
		saveEmail = request.getParameter("saveEmailKo");
	}
	
	else
	{
		email = request.getParameter("logEmailEn");
		pw = request.getParameter("logPwEn");
		saveEmail = request.getParameter("saveEmailEn");
	}
	
	// DAO 객체 생성 / 연결
	LoginDAO dao = new LoginDAO();
	dao.connection();
	
	// 로그인 메서드 호출
	LoginDTO dto = dao.login(email, pw);
	
	// DB 연결 종료
	dao.close();
	
	// 로그인 성공 / 실패 분기
	// dto.getSid()가 0이면 로그인 정보가 없다는 뜻
	if (dto.getSid() > 0)
	{
		// 로그인 성공
	
		// 1) 세션에 사용자 정보 저장
		session.setAttribute("userSid", dto.getSid());
		session.setAttribute("userName", dto.getName());
		session.setAttribute("userEmail", dto.getEmail());
		
		// 2) 이메일 저장 체크박스가 on 인지 확인
		if ("on".equals(saveEmail))
		{
			// 체크박스가 체크되어 있다면 쿠키 저장
			// - 한글/특수문자 대비: URLEncoder.encode()로 인코딩
			Cookie c = new Cookie("key", URLEncoder.encode(email, "UTF-8"));
			// 만료기간: 예) 399일
			c.setMaxAge(399 * 24 * 60 * 60);
			// 필요하다면 path 설정 (예: 사이트 전역 유효)
			// c.setPath("/");
			response.addCookie(c);
		}
	
		else
		{
			// 체크박스가 미체크라면 혹시 남아 있을 쿠키 삭제
			Cookie c = new Cookie("key", null);
			c.setMaxAge(0);
			// c.setPath("/") // 저장 시 path를 지정했다면 동일 path 설정
			response.addCookie(c);
		}
	
		// 이전 페이지 URL 가져오기
		String previousPage = (String) session.getAttribute("previousPage");
		
		if (previousPage != null)
		{
			session.removeAttribute("previousPage"); // 이전 페이지 정보 삭제
			
			// 만약 잘못된 JSP 경로가 저장된 경우 .action 경로로 변경
			if (previousPage.contains("/WEB-INF/view"))
				previousPage = previousPage.replaceAll(".*/", "/project/").replace(".jsp", ".action");
			
			response.sendRedirect(previousPage); // 이전 페이지로 이동
		}
		
		else
			response.sendRedirect("Main.action");
	}
	
	else
	{
		// 로그인 실패
		if (!"on".equals(saveEmail))
		{
			Cookie c = new Cookie("key", null);
			c.setMaxAge(0);
			// c.setPath("/") // 저장 시 path를 지정했다면 동일 path 설정
			response.addCookie(c);
		}
		
		// 다시 로그인 페이지로 돌아가면서, 실패 메시지 등을 전달
		session.setAttribute("lang", lang);
		response.sendRedirect("Login.action?msg=fail");
	}
%>