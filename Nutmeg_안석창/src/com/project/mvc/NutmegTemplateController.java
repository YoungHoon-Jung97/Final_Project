package com.project.mvc;
	
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class NutmegTemplateController
{
	// 템플릿
	@RequestMapping(value="/Template.action", method = RequestMethod.GET)
	public String template(Model model)
	{
		return "Template";
	}
	
	// 로그인
	@RequestMapping(value="/Login.action", method = RequestMethod.GET)
	public String login(Model model)
	{
		return "Login";
	}
	
	// 로그인 체크
	@RequestMapping(value="/LoginCheck.action", method = RequestMethod.POST)
	public String loginCheck(Model model)
	{
		return "LoginCheck";
	}
	
	// 메인
	@RequestMapping(value="/Main.action", method = RequestMethod.GET)
	public String main(Model model)
	{
		return "Main";
	}
	
	// 회원가입
	@RequestMapping(value="/Join.action", method = RequestMethod.GET)
	public String join(Model model)
	{
		return "Join";
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
	
	// 동호회 모집
	@RequestMapping(value="/Team.action", method = RequestMethod.GET)
	public String team(Model model)
	{
		return "Team";
	}
	
	// 동호회 개설
	@RequestMapping(value="/TempTeam.action", method = RequestMethod.GET)
	public String temp_team(Model model)
	{
		return "TempTeam";
	}
	
	// 경기장 예약
	@RequestMapping(value="/Field.action", method = RequestMethod.GET)
	public String field(Model model)
	{
		return "Field";
	}
	
	// 경기장 등록
	@RequestMapping(value="/Stadium.action", method = RequestMethod.GET)
	public String stadium(Model model)
	{
		return "Stadium";
	}
	
	// 용병 게시판
	@RequestMapping(value="/MercenaryOffer.action", method = RequestMethod.GET)
	public String mercenary_offer(Model model)
	{
		return "MercenaryOffer";
	}
	
	// 용병 등록
	@RequestMapping(value="/Mercenary.action", method = RequestMethod.GET)
	public String mercenary(Model model)
	{
		return "Mercenary";
	}
	
	// 매치 참가
	@RequestMapping(value="/Match.action", method = RequestMethod.GET)
	public String match(Model model)
	{
		return "Match";
	}
	
	// 내 정보
	@RequestMapping(value="/MyInformation.action", method = RequestMethod.GET)
	public String myInformation(Model model)
	{
		return "MyInformation";
	}
	
	// 내 동호회
	@RequestMapping(value="/MyTeam.action", method = RequestMethod.GET)
	public String myTeam(Model model)
	{
		return "MyTeam";
	}
	
	// 로그아웃
	@RequestMapping(value="/Logout.action", method=RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession();
		
		// 세션 삭제
		session.removeAttribute("userSid");
		session.removeAttribute("userName");
		session.removeAttribute("userEmail");
		
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
	    
		return "redirect:" + (returnUrl != null ? returnUrl : "/Template.action");
	}
}