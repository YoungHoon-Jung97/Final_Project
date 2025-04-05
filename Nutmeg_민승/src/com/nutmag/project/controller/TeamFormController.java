package com.nutmag.project.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.nutmag.project.dao.IBankDAO;
import com.nutmag.project.dao.IRegionDAO;

@Controller
public class TeamFormController
{
	@Autowired 
	private SqlSession sqlSession;
	
	//동호회 개설 페이지 호출
	@RequestMapping(value="/TempOpen.action", method = RequestMethod.GET)
	public String teamOpen(Model model, HttpServletRequest request, HttpServletResponse response) {
		
		
		HttpSession session = request.getSession();
		
		if (session.getAttribute("user_email") == null)		//로그인 안되어 있을 경우
		{
			return "redirect:Login.action";
		}
		
		IBankDAO bankDAO = sqlSession.getMapper(IBankDAO.class);
		IRegionDAO regionDAO = sqlSession.getMapper(IRegionDAO.class);
		
		model.addAttribute("bankList", bankDAO.bankList());
		model.addAttribute("regionList", regionDAO.regionList());
		
		return "/team/TeamOpen";
	}
	
	//동호회 메인 페이지 호출
	@RequestMapping(value="/MyTeam.action", method = RequestMethod.GET)
	public String teamMain() {
		return "/team/TeamMain";
	}
	
	//일정 호출
	@RequestMapping(value="/MyTeamSchedule.action", method = RequestMethod.GET)
	public String teamSchedule() {
		return "/team/TeamSchedule";
	}
	
	//가게부 호출
	@RequestMapping(value="/MyTeamFee.action" , method = RequestMethod.GET)
	public String teamFee() {
		return "/team/TeamFee";
	}
	
	//팀 게시판 호출
	@RequestMapping(value="/MyTeamBoard.action" , method = RequestMethod.GET)
	public String teamBoard() {
		return "/team/TeamBoard";
	}
}
