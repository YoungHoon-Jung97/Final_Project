package com.nutmag.project.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Random;

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
import com.nutmag.project.dto.OperatorResCancelDTO;
import com.nutmag.project.dto.UserDTO;

import util.MailUtil;

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
	
	// 구장 운영자 메인 페이지
		@RequestMapping(value = "/OperatorMainPage.action", method = RequestMethod.GET)
		public String operatorMainPage(Model model,HttpServletRequest request)
		{
			String result = null;

			IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
			HttpSession session = request.getSession();
			int user_code_id = (int) session.getAttribute("user_code_id");
			int operator_id = (int) session.getAttribute("operator_id");
			
			model.addAttribute("operatorInfo", dao.operatorLoginInfo(user_code_id));
			
			//System.out.println(operator_id);
			result = "/user/OperatorMainPage";
			return result;
		}

		// 경기장 승인 처리 페이지
		@RequestMapping(value="OperatorFieldResApprForm.action", method = {RequestMethod.POST, RequestMethod.GET})
		public String operatorFieldApprForm(Model model,HttpServletRequest request, HttpServletResponse response)
		{
			String result = null;
			
			HttpSession session = request.getSession();
			
			int operator_id = (int) session.getAttribute("operator_id");
			IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
			
			//System.out.println(operator_id);
			model.addAttribute("fieldBeforeResApprList", dao.fieldBeforeResApprList(operator_id));
			
			result = "/user/OperatorFieldResApprForm";
			return result;
		}
		
		// 구장 운영자 경기장 예약 승인 처리
		@RequestMapping(value = "FieldResApprInsert.action",method = RequestMethod.POST)
		public String operatorFieldResAppr(@RequestParam("field_res_id") int field_res_id ,Model model,HttpServletRequest request)
		{
			String result = null;
			IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
			
			//System.out.println(field_res_id);
			dao.fieldResApprInsert(field_res_id);
			
			result="redirect:OperatorFieldResApprForm.action";
			
			return result;
		}
		
		// 경기장 예약 반려 처리 폼
		@RequestMapping(value = "FieldResApprCancelForm.action", method = {RequestMethod.POST, RequestMethod.GET})
		public String adminResFieldApprCancel(Model model,HttpServletRequest request,@RequestParam("field_res_id") String field_res_id)
		{
			String result = null;
			
		    model.addAttribute("field_res_id", field_res_id);
			result = "/user/OperatorFieldResApprCancelForm";
			
			return result;
		}
			
		// 경기장 예약 반려 처리
		@RequestMapping(value="FieldResApprCancelInsert.action", method = {RequestMethod.POST, RequestMethod.GET})
		public String adminFieldApprCancelInsert(Model model,OperatorResCancelDTO dto,HttpServletRequest request)
		{
			String result = null;
			
			IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
			
			System.out.println("[DEBUG] 반려 요청 수신");
			System.out.println("reason : " + request.getParameter("field_pay_cancel_reason"));
			System.out.println("field_res_id : " + request.getParameter("field_res_id"));
			
			dao.fieldResApprCancelInsert(dto);
			
			result = "/user/OperatorFieldResApprForm";
			
			return result;
		}
	
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
			session.setAttribute("user_nick_name", dto.getUser_nick_name());
			
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
		session.removeAttribute("user_nick_name");
		session.removeAttribute("team_id");
		
		// 로그아웃 상태 플래그 남기기
		session.setAttribute("logoutFlag", "1");
		
		return "redirect:/MainPage.action";
	}
	
	
	// 이메일 찾기 폼 띄우기(get)
   @RequestMapping(value="/ForgotEmail.action", method = RequestMethod.GET)
   public String forgotEmail(Model model)
   {
	  model.addAttribute("searched", true);
      return "/user/ForgotEmail";
   }
   
   // 이메일 찾기 처리 (POST)
   @RequestMapping(value = "/ForgotEmail.action", method = RequestMethod.POST)
   public String forgotEmail(HttpServletRequest request, Model model)
   {
       String birth = request.getParameter("birth");
       String tel = request.getParameter("tel");
       System.out.println("입력값 확인 → birth: " + birth + ", tel: " + tel);

       IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
       List<String> emailList = dao.findEmailsByBirthAndTel(tel, birth);
       
       System.out.println("조회된 이메일 수: " + emailList.size());

       if (emailList == null || emailList.isEmpty()) {
           model.addAttribute("message", "입력하신 정보와 일치하는 이메일이 없습니다.");
           model.addAttribute("emailList", null);
       } else {
           model.addAttribute("emailList", emailList);
       }  	
	       return "/user/ForgotEmailResult";
	   }

   
   
	// 비밀번호 찾기 폼 띄우기 (GET)
	@RequestMapping(value = "/ForgotPassword.action", method = RequestMethod.GET)
	public String forgotPasswordForm(HttpServletRequest request,Model model) 
	{
		String user_email =(String)request.getParameter("user_email");
		
		model.addAttribute("user_email", user_email);
	    return "/user/ForgotPassword";
	}
	
	// 비밀번호 찾기 처리 (POST)
	@RequestMapping(value = "/ForgotPassword.action", method = RequestMethod.POST)
	public String forgotPassword(HttpServletRequest request, Model model) {

	    String email = request.getParameter("email");
	    String tel = request.getParameter("tel");
	    

	    System.out.println("비밀번호 찾기 요청 도착!");
	    System.out.println("email = " + email);
	    System.out.println("tel = " + tel);

	    // DAO 꺼내오기
	    IUserDAO dao = sqlSession.getMapper(IUserDAO.class);

	    // 사용자 유효성 검사
	    int result = dao.checkUserForPwd(email, tel);
	    boolean isValid = result > 0;

	    if (isValid) {
	        // 임시 비밀번호 생성
	        String tempPwd = createTempPassword();

	        // 비밀번호 업데이트
	        dao.updateTempPassword(email, tempPwd);
	        
	        // 이메일 전송
	        MailUtil.sendEmail(email, tempPwd);

	        // 안내 메시지 출력
	        model.addAttribute("message", "임시 비밀번호가 이메일로 전송되었습니다.");
	    } else {
	        model.addAttribute("message", "입력하신 정보와 일치하는 회원이 없습니다.");
	    }

	    return "/user/ForgotPassword"; // 결과 출력용 JSP
	}


	// 임시 비밀번호 생성
	private String createTempPassword() {
	    String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	    StringBuilder sb = new StringBuilder();
	    Random rnd = new Random();
	    for (int i = 0; i < 10; i++) {
	        sb.append(chars.charAt(rnd.nextInt(chars.length())));
	    }
	    return sb.toString();
	}
	


	
	// 내 정보
	@RequestMapping("/MyInformation.action")
	public String MyInformation(Model model, HttpServletRequest request)
	{
	    HttpSession session = request.getSession();
	    String message = "";

	    Integer user_code_id = (Integer) session.getAttribute("user_code_id");

	    // 로그인 체크
	    if (user_code_id == null) {
	        message = "로그인을 해야 합니다.";
	        model.addAttribute("message", message);
	        return "redirect:MainPage.action";  // 로그인 페이지나 메인 페이지
	    }

	    IUserDAO dao = sqlSession.getMapper(IUserDAO.class); // DAO 호출
	    UserDTO userInfo = dao.getUser(user_code_id);   // 정보 불러오기

	    if (userInfo == null) {
	        message = "회원 정보를 찾을 수 없습니다.";
	        model.addAttribute("message", message);
	        return "redirect:MainPage.action";
	    }

	    model.addAttribute("userInfo", userInfo);

	    return "/user/UserMainPage"; // 유저 정보 보여줄 페이지
	}
		
	// 내 정보 수정 폼 페이지 들어가기 전 비밀번호 확인
	@RequestMapping(value = "/CheckPassword.action", method = RequestMethod.GET)
	public String checkPasswordForm(HttpSession session) {
		
		  if (session.getAttribute("user_code_id") == null) return
		  "redirect:/Login.action";
		 
	    return "/user/CheckPassword";
	}

	@RequestMapping(value = "/CheckPassword.action", method = RequestMethod.POST)
	public String checkPasswordSubmit(HttpSession session, HttpServletRequest request, Model model) {
	    String inputPw = request.getParameter("user_pwd");
	    System.out.println("입력된 비밀번호: " + inputPw);
	    Object userCodeObj = session.getAttribute("user_code_id");

	    String userCode = userCodeObj.toString();

	    IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
	    String dbPw = dao.getPasswordByUserCode(userCode);

	    if (dbPw != null && dbPw.equals(inputPw)) {
	        return "redirect:/UserInfoEdit.action";
	    } else {
	        model.addAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
	        return "/user/CheckPassword";
	    }
	}
	
	// 내 정보 수정 폼 페이지 요청
	@RequestMapping(value = "/UserInfoEdit.action")
	public String userInfoEdit(Model model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
	    String message = "";

	    Integer user_code_id = (Integer) session.getAttribute("user_code_id");

	    // 로그인 체크
	    if (user_code_id == null) {
	        message = "로그인을 해야 합니다.";
	        model.addAttribute("message", message);
	        return "redirect:MainPage.action";  // 로그인 페이지나 메인 페이지
	    }

	    IUserDAO dao = sqlSession.getMapper(IUserDAO.class); // DAO 호출
	    UserDTO userEdit = dao.userUpdate(user_code_id);   // 정보 불러오기

	    if (userEdit == null) {
	        message = "회원 정보를 찾을 수 없습니다.";
	        model.addAttribute("message", message);
	        return "redirect:MainPage.action";
	    }

	    model.addAttribute("userInfo", userEdit);

	    return "/user/UserInfoEdit"; // 수정 폼 JSP로 이동
	}
	
	//사용자 정보 업데이트
	@RequestMapping(value = "/UserUpdate.action", method = RequestMethod.POST)
	   public String updateUser(UserDTO userDTO, HttpServletRequest request, Model model) {

	       HttpSession session = request.getSession();
	       Integer user_code_id = (Integer) session.getAttribute("user_code_id");
	       userDTO.setUser_code_id(user_code_id);

	       // 기존 비밀번호와 새로운 비밀번호를 비교
	       String currentPwd = request.getParameter("current_pwd");  // hidden으로 받은 기존 비밀번호
	       String newPwd = request.getParameter("user_pwd");         // 새 비밀번호
	       String confirmPwd = request.getParameter("password2");    // 새 비밀번호 확인

	       // 비밀번호가 다르면 수정 페이지로 돌아가기
	       if (!newPwd.equals(confirmPwd)) {  // equals()로 비밀번호 비교
	           return "redirect:UserInfoEdit.action";  // 수정 페이지로 돌아감
	       }

	       // 비밀번호가 일치하면 DB에 업데이트
	       if (newPwd != null && !newPwd.trim().equals("")) {
	           userDTO.setUser_pwd(newPwd);  // 새 비밀번호로 업데이트
	       } else {
	           userDTO.setUser_pwd(currentPwd); // 비밀번호 변경 없으면 기존 비밀번호 사용
	       }

	       // DB 업데이트
	       IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);
	       userDAO.updateUser(userDTO);  // 비밀번호 포함한 전체 정보 업데이트

	       // 메인 페이지로 리다이렉트
	       return "redirect:MainPage.action";
	   }
}