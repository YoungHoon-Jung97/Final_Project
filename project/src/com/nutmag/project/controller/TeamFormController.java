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
