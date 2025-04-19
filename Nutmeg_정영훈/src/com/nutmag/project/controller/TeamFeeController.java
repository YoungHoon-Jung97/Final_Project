package com.nutmag.project.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nutmag.project.dao.INotificationDAO;
import com.nutmag.project.dao.ITeamDAO;
import com.nutmag.project.dao.ITeamFeeDAO;
import com.nutmag.project.dto.TeamApplyDTO;
import com.nutmag.project.dto.TeamDTO;
import com.nutmag.project.dto.TeamFeeDTO;


@Controller
public class TeamFeeController
{
	
	@Autowired
	private SqlSession sqlSession;
	
	//동호회 회비 정보 등록
	@RequestMapping(value = "/AddFeeInfo.action",method=RequestMethod.GET)
	public String addTeamFeeInfo(TeamFeeDTO teamFee,HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		ITeamFeeDAO teaFeeDAO = sqlSession.getMapper(ITeamFeeDAO.class);
		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		Integer temp_team_id = (Integer) session.getAttribute("team_id");
		TeamDTO team = teamDAO.getTeamInfo(temp_team_id);
		
		int team_id = team.getTeam_id();
		
		teamFee.setTeam_id(team_id);
		
		System.out.println("\n==================================동호회 회비 등록==================================");
		System.out.println("회비 날짜 = " + teamFee.getTeam_fee_pay_start_at());
		System.out.println("회비 = " + teamFee.getTeam_fee_price());
		System.out.println("납부 기한 = " + teamFee.getTeam_fee_pay_end_at());
		System.out.println("설명 = " + teamFee.getTeam_fee_desc());
		System.out.println("팀_id = " + teamFee.getTeam_id());
		System.out.println("=================================================================================");
		
		teaFeeDAO.addTeamFeeInfo(teamFee);
		
		return "redirect:/MyTeamFee.action";
	};
	
	//동호회 회비 정보 등록
	@RequestMapping(value = "/TeamMonthFee.action",method=RequestMethod.GET)
	public String addTeamMonthFeeInfo(HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		int team_fee_id = Integer.parseInt(request.getParameter("team_fee_id"));
		int team_fee_price = Integer.parseInt(request.getParameter("team_fee_price"));
		Integer temp_team_id = (Integer) session.getAttribute("team_id");
		Integer user_code_id = (Integer) session.getAttribute("user_code_id");
		
		
		ITeamFeeDAO teaFeeDAO = sqlSession.getMapper(ITeamFeeDAO.class);
		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		
		TeamDTO team = teamDAO.getTeamInfo(temp_team_id);
		int team_id = team.getTeam_id();
		
		TeamApplyDTO teamApply= teamDAO.searchTeamMemberCode(team_id, user_code_id);
		
		int team_member_id =teamApply.getTeam_member_id();
		
		TeamFeeDTO teamFee = new TeamFeeDTO();
		System.out.println("\n==================================동호회 회비 납부==================================");
		System.out.println("team_id = " + team_id);
		System.out.println("team_member_id = " + team_member_id);
		System.out.println("team_fee_price = " + team_fee_price);
		System.out.println("=================================================================================");
		
		teamFee.setTeam_member_id(team_member_id);
		teamFee.setTeam_fee_id(team_fee_id);
		teamFee.setTeam_fee_price(team_fee_price);
		
		teaFeeDAO.addMonthFee(teamFee);
		
		return "redirect:/MyTeamFee.action";
	};

}

