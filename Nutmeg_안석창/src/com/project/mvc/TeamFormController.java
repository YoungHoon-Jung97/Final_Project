package com.project.mvc;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TeamFormController
{
	//동호회 메이 페이지 호출
	@RequestMapping(value="/teammain.action", method = RequestMethod.GET)
	public String teamMain() {
		return "/team/TeamMain.jsp";
	}
	
	//일정 호출
	@RequestMapping(value="/teamschedule.action", method = RequestMethod.GET)
	public String teamSchedule() {
		return "/team/TeamSchedule.jsp";
	}
	
	//가게부 호출
	@RequestMapping(value="/teamfee.action" , method = RequestMethod.GET)
	public String teamFee() {
		return "/team/TeamFee.jsp";
	}
	
	//팀 게시판 호출
	@RequestMapping(value="/teamboard.action" , method = RequestMethod.GET)
	public String teamBoard() {
		return "/team/TeamBoard.jsp";
	}
}
