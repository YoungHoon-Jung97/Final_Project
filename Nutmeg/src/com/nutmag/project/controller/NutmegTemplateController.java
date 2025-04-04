package com.nutmag.project.controller;


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
	
	
		
}