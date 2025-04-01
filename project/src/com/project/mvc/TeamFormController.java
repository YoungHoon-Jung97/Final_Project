package com.project.mvc;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TeamFormController
{
	//동호회 메이 페이지 호출
	@RequestMapping(value="/teammainform.action", method = RequestMethod.GET)
	public String teamMainForm() {
		return "/team/TeamMainForm.jsp";
	}
	
	//투표 페이지 호출
	@RequestMapping(value="/voteform.action", method = RequestMethod.GET)
	public String voteForm() {
		return "/team/VoteForm.jsp";
	}
	
}
