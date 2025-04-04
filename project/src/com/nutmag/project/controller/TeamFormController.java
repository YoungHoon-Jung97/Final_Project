package com.nutmag.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TeamFormController
{
	//동호회 메인 페이지 호출
	@RequestMapping(value="/MyTeam.action", method = RequestMethod.GET)
	public String teamMain() {
		return "/WEB-INF/view/team/TeamMain.jsp";
	}
	
	//일정 호출
	@RequestMapping(value="/TeamSchedule.action", method = RequestMethod.GET)
	public String teamSchedule() {
		return "/WEB-INF/view/team/TeamSchedule.jsp";
	}
	
	//가게부 호출
	@RequestMapping(value="/TeamFee.action" , method = RequestMethod.GET)
	public String teamFee() {
		return "/WEB-INF/view/team/TeamFee.jsp";
	}
	
	//팀 게시판 호출
	@RequestMapping(value="/TeamBoard.action" , method = RequestMethod.GET)
	public String teamBoard() {
		return "/WEB-INF/view/team/TeamBoard.jsp";
	}
}
