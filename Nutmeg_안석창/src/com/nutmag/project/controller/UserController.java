package com.nutmag.project.controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.nutmag.project.dao.IBankDAO;
import com.nutmag.project.dao.ITeamDAO;
import com.nutmag.project.dao.IUserDAO;
import com.nutmag.project.dto.OperatorDTO;
import com.nutmag.project.dto.UserDTO;

@Controller
public class UserController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 유저 회원가입 폼
	@RequestMapping(value = "/UserSignupForm.action", method = RequestMethod.GET)
	public String userSignupForm(Model model)
	{
		return "/user/UserSignupForm";
	}
	
	// 유저 회원가입 이메일 중복검사
	@RequestMapping(value = "/CheckEmail.action", method = RequestMethod.GET)
	public void checkEmail(@RequestParam("email") String email, HttpServletResponse response) throws IOException
	{
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		int count = dao.searchEmail(email);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain;charset=UTF-8");
		
		// 이메일을 아무것도 안적었을 경우
		if (email.equals("") || email.isEmpty())
			// error 발생
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		
		if (count > 0)
			response.getWriter().write("이미 사용중인 이메일 입니다.");
		
		else
			response.getWriter().write("사용 가능한 이메일 입니다.");
	}
	
	// 유저 회원가입 이메일 중복검사
	@RequestMapping(value = "/CheckNickName.action", method = RequestMethod.GET)
	public void checkNickName(@RequestParam("nickName") String nickName, HttpServletResponse response) throws IOException
	{
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		int count = dao.searchnickName(nickName);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain;charset=UTF-8");
		
		// 이메일을 아무것도 안적었을 경우
		if (nickName.equals("") || nickName.isEmpty())
			// error 발생
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		
		if (count > 0)
			response.getWriter().write("이미 사용중인 닉네임 입니다.");
		
		else
			response.getWriter().write("사용 가능한 닉네임 입니다.");
	}
	
	// 유저 회원가입 인서트
	@RequestMapping(value = "/UserInsert.action", method = RequestMethod.POST)
	public String userInsert(UserDTO user)
	{
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		
		dao.userInsert(user);
		
		return "redirect:MainPage.action";
	};
	
	//===============================================================================	
	
	// 구장 운영자 회원가입 폼
	@RequestMapping(value = "/OperatorSignupForm.action", method = RequestMethod.GET)
	public String operatorSignupForm(Model model, HttpServletRequest request)
	{
		IBankDAO bankDAO = sqlSession.getMapper(IBankDAO.class);
		
		model.addAttribute("bankList", bankDAO.bankList());
		
		return "/user/OperatorSignupForm";
	}
	
	// 구장 운영자 회원가입 이메일 중복검사
	@RequestMapping(value = "/CheckEmailOperator.action", method = RequestMethod.GET)
	public void checkEmailOperator(@RequestParam("email") String email, HttpServletResponse response) throws IOException
	{
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		int count = dao.searchEmailOperator(email);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain;charset=UTF-8");
		
		// 이메일을 아무것도 안적었을 경우
		if (email.equals("") || email.isEmpty())
			// error 발생
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		
		if (count > 0)
			response.getWriter().write("이미 사용중인 이메일 입니다.");
		
		else
			response.getWriter().write("사용 가능한 이메일 입니다.");
	}
	
	// 구장 운영자 회원가입 계좌 중복검사
	@RequestMapping(value = "/CheckAccountNo.action", method = RequestMethod.GET)
	public void checkAccountNo(@RequestParam("accountNo") String accountNo, HttpServletResponse response) throws IOException
	{
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		int count = dao.searchAccountOperator(accountNo);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain;charset=UTF-8");
		
		// 이메일을 아무것도 안적었을 경우
		if (accountNo.equals("") || accountNo.isEmpty())
			// error 발생
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		
		if (count > 0)
			response.getWriter().write("이미 사용중인 계좌번호 입니다.");
		
		else
			response.getWriter().write("사용 가능한 계좌번호 입니다.");
	}
	
	// 구장 운영자 회원가입 인서트
	@RequestMapping(value = "/OperatorInsert.action", method = RequestMethod.POST)
	public String operatorInsert(OperatorDTO operator, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		
		dao.operatorInsert(operator);
		
		String message = "SUCCESS_INSERT: 구장 운영자 회원가입이 완료되었습니다.";
		session.setAttribute("message", message);
		
		return "redirect:MainPage.action";
	};
	
	//==================================================================
	
	// 로그인
	@RequestMapping(value = "/Login.action", method = RequestMethod.GET)
	public String login(Model model)
	{
		return "/login/Login";
	}
	
	// 로그인 체크
	@RequestMapping("/LoginCheck.action")
	public String login(@RequestParam(value = "logEmailKo", required = false) String logEmailKo,
						@RequestParam(value = "logPwKo", required = false) String logPwKo,
						@RequestParam(value = "saveEmailKo", required = false) String saveEmail,
						@RequestParam(value = "logEmailEn", required = false) String logEmailEn,
						@RequestParam(value = "logPwEn", required = false) String logPwEn,
						@RequestParam("lang") String lang, HttpSession session, HttpServletResponse response) throws Exception
	{
		IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);
		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		
		UserDTO dto = null;
		
		if ("ko".equals(lang))
			dto = userDAO.userLoginKo(logEmailKo, logPwKo);
		
		else
			dto = userDAO.userLoginEn(logEmailEn, logPwEn);
		
		if (dto != null && dto.getUser_id() > 0)
		{
			// 로그인 성공
			session.setAttribute("user_name", dto.getUser_name());
			session.setAttribute("user_email", dto.getUser_email());
			session.setAttribute("user_code_id", dto.getUser_code_id());
			session.setAttribute("operator_id", userDAO.operatorSearchId(dto.getUser_code_id()));

			if (teamDAO.searchMyTempTeam(dto.getUser_code_id()) != null)
				session.setAttribute("team_id", teamDAO.searchMyTempTeam(dto.getUser_code_id()));
			
			else if (teamDAO.searchMyTeam(dto.getUser_code_id()) != null)
				session.setAttribute("team_id", teamDAO.searchMyTeam(dto.getUser_code_id()));
			
			else
				session.setAttribute("team_id", 0);
			
			// 로그인 상태 플래그 남기기
			session.setAttribute("loginFlag", "1");
			
			teamDAO.searchMyTeam(dto.getUser_code_id());
			teamDAO.searchMyTempTeam(dto.getUser_code_id());
			
			if ("on".equals(saveEmail))
			{
				if ("ko".equals(lang))
				{
					Cookie c = new Cookie("key", URLEncoder.encode(logEmailKo, "UTF-8"));
					c.setMaxAge(399 * 24 * 60 * 60);
					response.addCookie(c);
				}
				
				else
				{
					Cookie c = new Cookie("key", URLEncoder.encode(logEmailEn, "UTF-8"));
					c.setMaxAge(399 * 24 * 60 * 60);
					response.addCookie(c);
				}
			}
			
			String previousPage = (String) session.getAttribute("previousPage");
			
			if (previousPage != null)
			{
				session.removeAttribute("previousPage"); // 이전 페이지 정보 삭제
				
				// 만약 잘못된 JSP 경로가 저장된 경우 .action 경로로 변경
				if (previousPage.contains("/WEB-INF/view"))
					previousPage = previousPage.replaceAll(".*/", "/Nutmeg/").replace(".jsp", ".action");
				
				// 응답이 이미 커밋된 경우를 체크
				if (!response.isCommitted())
				{
					response.sendRedirect(previousPage); // 이전 페이지로 이동
					return null; // 이후 코드 실행 방지
				}
				
				else
					return "redirect:" + previousPage;
			}
			
			else
				return "redirect:/Error.action";
		}
		
		else
		{
			// 로그인 실패
			session.setAttribute("lang", lang);
			return "redirect:/Login.action?msg=fail";
		}
	}
	
	// 로그아웃
	@RequestMapping(value = "/Logout.action", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession();
		
		// 세션 삭제
		session.removeAttribute("user_name");
		session.removeAttribute("user_email");
		session.removeAttribute("user_code_id");
		session.removeAttribute("operator_id");
		
		// 로그아웃 상태 플래그 남기기
		session.setAttribute("logoutFlag", "1");
		
		return "redirect:/MainPage.action";
	}
	
	// 이메일 찾기
	@RequestMapping(value = "/ForgotEmail.action", method = RequestMethod.GET)
	public String forgotEmail(Model model)
	{
		return "ForgotEmail";
	}
	
	// 비밀번호 찾기
	@RequestMapping(value = "/ForgotPassword.action", method = RequestMethod.GET)
	public String forgotPassword(Model model)
	{
		return "ForgotPassword";
	}
	
	// 내 정보
	@RequestMapping(value = "/MyInformation.action", method = RequestMethod.GET)
	public String myInformation(Model model)
	{
		return "MyInformation";
	}
}