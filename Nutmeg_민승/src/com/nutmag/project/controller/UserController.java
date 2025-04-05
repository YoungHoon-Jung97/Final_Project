package com.nutmag.project.controller;

<<<<<<< HEAD
import java.io.IOException;
=======
>>>>>>> c6073aca0348adfe2fdf1a94e187a96ae165c74b
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
<<<<<<< HEAD
import org.springframework.web.bind.annotation.ResponseBody;
=======
>>>>>>> c6073aca0348adfe2fdf1a94e187a96ae165c74b

import com.nutmag.project.dao.IUserDAO;
import com.nutmag.project.dto.LoginDTO;
import com.nutmag.project.dto.UserDTO;


@Controller
public class UserController
{


	@Autowired 
	private SqlSession sqlSession;

	// 메인 페이지
	@RequestMapping(value = "/MainPage.action",method=RequestMethod.GET)
	public String mainPage()
	{
		String result ="";
		
		
		result = "main/MainPage";
		return result;
	};
	
	// 유저 회원가입 폼
	@RequestMapping(value="/UserSignupForm.action", method = RequestMethod.GET)
	public String userSignupForm(Model model)
	{
		return "/user/UserSignupForm";
	}
	
<<<<<<< HEAD
	//유저 회원가입 이메일 중복검사
	@RequestMapping(value="/CheckEmail.action", method = RequestMethod.GET)
	public void checkEmail(@RequestParam("email") String email, HttpServletResponse response) throws IOException {
	    
	    IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
	    int count = dao.searchEmail(email);
	    
	    response.setCharacterEncoding("UTF-8");
	    response.setContentType("text/plain;charset=UTF-8");
	    
	    //이메일을 아무것도 안적었을 경우
	    if(email.equals("") || email.isEmpty()) {
	    	
	    	//error 발생
	    	response.setStatus(HttpServletResponse.SC_NOT_FOUND);

	    }
	    
	    if (count >0) {
	        response.getWriter().write("이미 사용중인 이메일 입니다.");
	    }
	    else {
	        response.getWriter().write("사용 가능한 이메일 입니다.");
	    }
	}
	
	//유저 회원가입 닉네임 중복검사
	@RequestMapping(value="/CheckNickName.action", method = RequestMethod.GET)
	public void checkNickName(@RequestParam("nickName") String nickName,HttpServletResponse response) throws IOException{
		
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		int count =dao.searchnickName(nickName);
		
		response.setCharacterEncoding("UTF-8");
	    response.setContentType("text/plain;charset=UTF-8");
		
		  //닉네임을 아무것도 안적었을 경우
	    if(nickName.equals("") || nickName.isEmpty()) {
	    	
	    	//error 발생
	    	response.setStatus(HttpServletResponse.SC_NOT_FOUND);

	    }
	    
	    if (count >0) {
	        response.getWriter().write("이미 사용중인 닉네임 입니다.");
	    }
	    else {
	        response.getWriter().write("사용 가능한 닉네임 입니다.");
	    }
		
	}
	
=======
>>>>>>> c6073aca0348adfe2fdf1a94e187a96ae165c74b
	// 유저 회원가입 인서트
	@RequestMapping(value = "/UserInsert.action", method=RequestMethod.POST)
	public String userInsert(UserDTO user)
	{
		String result = null;
		
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		
		dao.userInsert(user);
		
		result = "redirect:MainPage.action";
		return result;
	};
	
	// 로그인
	@RequestMapping(value="/Login.action", method = RequestMethod.GET)
	public String login(Model model)
	{
		return "/login/Login";
	}
	
	// 로그인 체크
	@RequestMapping("/LoginCheck.action")
	public String login(
			@RequestParam("logEmailKo") String email,
			@RequestParam("logPwKo") String pw,
			@RequestParam(value = "saveEmailKo", required = false) String saveEmail,
			HttpSession session,
			HttpServletResponse response
	) throws Exception
	
	{
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		LoginDTO dto = dao.userLogin(email, pw);

		if (dto != null && dto.getUser_id() > 0)
		{
			// 로그인 성공
			session.setAttribute("user_id", dto.getUser_id());
			session.setAttribute("user_name", dto.getUser_name());
			session.setAttribute("user_email", dto.getUser_email());

			if ("on".equals(saveEmail))
			{
				Cookie c = new Cookie("key", URLEncoder.encode(email, "UTF-8"));
				c.setMaxAge(399 * 24 * 60 * 60);
				response.addCookie(c);
			}
			
			String previousPage = (String) session.getAttribute("previousPage");
			
			if (previousPage != null)
			{
				session.removeAttribute("previousPage"); // 이전 페이지 정보 삭제
				
				// 만약 잘못된 JSP 경로가 저장된 경우 .action 경로로 변경
				if (previousPage.contains("/WEB-INF/view"))
					previousPage = previousPage.replaceAll(".*/", "/Nutmeg/").replace(".jsp", ".action");
				
				
				
				  // 응답이 이미 커밋된 경우를 체크
		        if (!response.isCommitted()) {
		            response.sendRedirect(previousPage); // 이전 페이지로 이동
		            return null; // 이후 코드 실행 방지
		        } else {
		            return "redirect:" + previousPage;
		        }
			}
			
			else
				return "redirect:/Error.action";

			
		}
		else
		{
			// 로그인 실패
			Cookie c = new Cookie("key", null);
			c.setMaxAge(0);
			response.addCookie(c);

			return "redirect:/Login.action?msg=fail";
		}
		
		
	}
	
	// 로그아웃
	@RequestMapping(value="/Logout.action", method=RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession();
		
		// 세션 삭제
		session.removeAttribute("user_id");
		session.removeAttribute("user_name");
		session.removeAttribute("user_email");
		
		// 로그아웃 상태 플래그 남기기
		session.setAttribute("logoutFlag", "1");
		
		// 리다이렉트 (이전 페이지 or 기본 Template)
		String returnUrl = request.getParameter("returnUrl");
		
		// logoutMsg 파라미터 제거
		if (returnUrl != null && returnUrl.contains("logoutMsg"))
	    {
			returnUrl = returnUrl.replaceAll("[&?]logoutMsg=1", "");
			// 끝에 ?나 &가 남으면 제거
			returnUrl = returnUrl.replaceAll("[?&]$", "");
	    }
	    
		return "redirect:" + (returnUrl != null ? returnUrl : "/Error.action");
	}
	
	// 이메일 찾기
	@RequestMapping(value="/ForgotEmail.action", method = RequestMethod.GET)
	public String forgotEmail(Model model)
	{
		return "ForgotEmail";
	}
	
	// 비밀번호 찾기
	@RequestMapping(value="/ForgotPassword.action", method = RequestMethod.GET)
	public String forgotPassword(Model model)
	{
		return "ForgotPassword";
	}
	
	// 내 정보
	@RequestMapping(value="/MyInformation.action", method = RequestMethod.GET)
	public String myInformation(Model model)
	{
		return "MyInformation";
	}
	
}
