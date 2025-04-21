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

import com.nutmag.project.dao.IAdminDAO;
import com.nutmag.project.dao.IFieldDAO;
import com.nutmag.project.dao.IUserDAO;
import com.nutmag.project.dto.AdminDTO;
import com.nutmag.project.dto.AdminFieldApprDTO;
import com.nutmag.project.dto.AdminFieldCancelDTO;
import com.nutmag.project.dto.UserDTO;


@Controller
public class AdminController
{
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/AdminInsertForm.action",method=RequestMethod.GET)
	public String adminInsertForm()
	{
		String result ="";
		
		
		result = "/admin/AdminInsertForm";
		return result;
	};
	
	//관리자 회원가입 이메일 중복검사
	@RequestMapping(value="/AdminCheckEmail.action", method = RequestMethod.GET)
	public void checkEmail(@RequestParam("email") String email, HttpServletResponse response) throws IOException {
	    
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
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
	
	//관리자 회원가입 닉네임 중복검사
	@RequestMapping(value="/AdminCheckNickName.action", method = RequestMethod.GET)
	public void checkNickName(@RequestParam("nickName") String nickName,HttpServletResponse response) throws IOException{
		
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
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
	
	// 구장 운영자 인서트
	@RequestMapping(value = "/AdminInsert.action",method=RequestMethod.POST)
	public String adminInsert(AdminDTO adminDTO)
	{
		String result ="";
		
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
		
		dao.adminInsert(adminDTO);
		
		result = "redirect:AdminInsertForm.action";
		
		return result;
	};
	
	// 어드민 로그인 폼
	@RequestMapping(value="/AdminLogin.action", method = RequestMethod.GET)
	public String login(Model model)
	{
		return "/login/AdminLogin";
	}
	
	
	// 어드민 로그인 체크
	@RequestMapping("/AdminLoginCheck.action")
	public String login(
			@RequestParam(value = "logEmailKo", required = false) String logEmailKo,
			@RequestParam(value = "logPwKo", required = false) String logPwKo,
			@RequestParam(value = "saveEmailKo", required = false) String saveEmail,
			@RequestParam(value = "logEmailEn", required = false) String logEmailEn,
			@RequestParam(value = "logPwEn", required = false) String logPwEn,
			@RequestParam("lang") String lang,
			HttpSession session,
			HttpServletResponse response
	) throws Exception
	
	{
		
		String result = null;
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
		AdminDTO dto = null;
		
		if ("ko".equals(lang))
			dto = dao.adminLoginKo(logEmailKo, logPwKo);
		
		else
			dto = dao.adminLoginEn(logEmailEn, logPwEn);

		if (dto != null && dto.getAdmin_id() > 0)
		{
			// 로그인 성공
			session.setAttribute("admin_id", dto.getAdmin_id());
			session.setAttribute("admin_email", dto.getAdmin_email());
			session.setAttribute("admin_nickName", dto.getAdmin_nickName());
			session.setAttribute("user_code_id", dto.getUser_code_id());

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
			
			
			//String previousPage = (String) session.getAttribute("previousPage");
			
			//if (previousPage != null)
			//{
			//	session.removeAttribute("previousPage"); // 이전 페이지 정보 삭제
				
			// 만약 잘못된 JSP 경로가 저장된 경우 .action 경로로 변경
			//	if (previousPage.contains("/WEB-INF/view"))
			//		previousPage = previousPage.replaceAll(".*/", "/Nutmeg/").replace(".jsp", ".action");
				
				// 응답이 이미 커밋된 경우를 체크
		   //     if (!response.isCommitted())
		   //     {
		   //         response.sendRedirect(previousPage); // 이전 페이지로 이동
		   //         return null; // 이후 코드 실행 방지
		   //     }
		        
		   //     else
		   //          return "redirect:" + previousPage;
			//}
			
			// else
				result = "redirect:AdminMainPage.action";
				return result;
		}
		
		else
		{
			// 로그인 실패
			Cookie c = new Cookie("key", null);
			c.setMaxAge(0);
			response.addCookie(c);
			
			session.setAttribute("lang", lang);
			return "redirect:/Login.action?msg=fail";
		}
	}
	
	// 로그아웃
	@RequestMapping(value="/AdminLogout.action", method=RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession();
		
		// 세션 삭제
		session.removeAttribute("admin_id");
		session.removeAttribute("admin_email");
		session.removeAttribute("admin_nickName");
		session.removeAttribute("user_code_id");
		
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
	
	// 관리자 메인 페이지 연결
	@RequestMapping(value="/AdminMainPage.action", method=RequestMethod.GET)
	public String adminMainPage(Model model,HttpServletRequest request, HttpServletResponse response)
	{
		String result =null;
		
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
		
		HttpSession session = request.getSession();
		
		//디버그 코드
		int admin_id = (int)session.getAttribute("admin_id");
		String email = (String)session.getAttribute("admin_email");
		String nickName = (String)session.getAttribute("admin_nickName");
		int user_code = (int)session.getAttribute("user_code_id");
		
		System.out.println(admin_id + " "+email + " "+nickName + " "+user_code + " ");
		
		model.addAttribute("adminLoginInfo", dao.adminLoginInfo(admin_id));
		
		
		
		result = "/admin/AdminMainPage";
	    
		return result;
	}
	
	// 미승인 경기장 페이지 호출
	@RequestMapping(value="AdminFieldApprForm.action", method=RequestMethod.GET)
	public String adminFieldApprForm(Model model,HttpServletRequest request, HttpServletResponse response)
	{
		String result = null;
		
		IFieldDAO dao = sqlSession.getMapper(IFieldDAO.class);
		
		model.addAttribute("fieldAllList", dao.fieldBeforeApprList());
		
		result = "/admin/AdminFieldApprForm";
		return result;
	}
	
	
	// 경기장 승인 처리
	@RequestMapping(value="FieldApprInsert.action", method=RequestMethod.POST)
	public String adminFieldApprInsert(AdminFieldApprDTO dto)
	{
		String result = null;
		
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
		
		dao.fieldApprInsert(dto);
		
		result = "redirect:AdminFieldApprForm.action";
		return result;
	}
	
	
	
	// 경기장 반려 처리 폼
	@RequestMapping(value = "FieldApprCancelForm.action", method = RequestMethod.POST)
	public String adminFieldApprCancel(Model model,HttpServletRequest request)
	{
		String result = null;
		
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
		
		String field_reg_id = request.getParameter("field_reg_id");
	    String user_code_id = request.getParameter("user_code_id");

	    
	    model.addAttribute("field_reg_id", field_reg_id);
	    model.addAttribute("user_code_id", user_code_id);
		model.addAttribute("cancelTypeList", dao.fieldApprCancelTypeList());
		
		result = "/admin/AdminFieldApprCancelForm";
		
		return result;
	}
	
	// 경기장 반려 처리
	@RequestMapping(value="FieldApprCancelInsert.action", method = RequestMethod.POST)
	public String adminFieldApprCancelInsert(Model model,AdminFieldCancelDTO dto)
	{
		String result = null;
		
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
		
		dao.fieldApprCancelInsert(dto);
		
		result = "/admin/AdminFieldApprCancelForm";
		
		return result;
	}
	
	
	
	
	// 유저 관리 페이지
	@RequestMapping(value="UserManage.action", method=RequestMethod.GET)
	public String userManagePage()
	{
		String result = null;
		
		result = "/admin/UserManagePage";
		
		return result;
	}
	
	// 회사 소개 페이지
							
	@RequestMapping(value = "CompanyIntro.action", method=RequestMethod.GET)
	public String companyIntro()
	{
		String result = null;
		
		result = "/admin/Aboutme";
		
	    return result;
	}
	
}

