package com.nutmag.project.controller;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nutmag.project.dao.INotificationDAO;
import com.nutmag.project.dao.ITeamDAO;
import com.nutmag.project.dao.ITeamFeeDAO;
import com.nutmag.project.dto.TeamApplyDTO;
import com.nutmag.project.dto.TeamDTO;
import com.nutmag.project.dto.TeamFeeDTO;
import com.nutmag.project.dto.TeamMemberFeeDTO;

import util.PageUtil;


@Controller
public class TeamFeeController
{
	
	@Autowired
	private SqlSession sqlSession;
	
	// 가게부 호출
	@RequestMapping(value = "/TeamFee.action", method = RequestMethod.GET)
	public String teamFee(HttpServletRequest request,Model model)
	{
		 HttpSession session = request.getSession();
		 Integer temp_team_id = (Integer) session.getAttribute("team_id");
		 
		 // 동호회 정보 가져오기
		 ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		 ITeamFeeDAO teamFeeDAO = sqlSession.getMapper(ITeamFeeDAO.class);
		 
		 TeamDTO team = teamDAO.getTeamInfo(temp_team_id);
		 int team_id = team.getTeam_id();
		 
		 if (team_id == 0) {
			 
			String message = "ERROR_DUPLICATE_JOIN: 임시동호회 임으로 이용리 불가능합니다.";
			session.setAttribute("message", message);
			return "redirect:TeamMain.action";
			
		 }
		 
		 // 현재 페이지 파라미터 처리 (기본값: 1)
		 String pageParam = request.getParameter("page");
		 int currentPage = 1;
		 
		 if (pageParam != null && !pageParam.isEmpty()) 
		{
		    try 
		    {
		        currentPage = Integer.parseInt(pageParam);
		    } 
		    catch (NumberFormatException e) 
		    {
		        // 숫자 형식이 아닌 경우 기본값 사용
		    }
		}
		 
		 
		 // 전체 게시글 수 조회
		 int totalCount = teamFeeDAO.countTeamFee(team_id);
		 
		// 페이징 유틸 생성 (한 페이지에 10개씩, 5개 페이지 번호)
	    PageUtil pageUtil = new PageUtil(currentPage, totalCount, 10, 5);
	    int start =pageUtil.getStart();
        int end = pageUtil.getEnd();
	        
		 
		 
		 int income =  teamFeeDAO.getTeamIncome(team_id);
		 int expense = teamFeeDAO.getTeamexpense(team_id);
		 int tot = income - expense;
		 
		 List<TeamFeeDTO> teamFeeList=  teamFeeDAO.getTeamFeeList(start,end,team_id);
		 List<TeamFeeDTO> teamMonthFeeList=  teamFeeDAO.getTeamMonthFeeList(team_id);
		
		 // 페이징 HTML 생성
		 String pageHtml = pageUtil.getPageHtml("TeamFee.action?page=%d");
		 
		 LocalDate localDate = LocalDate.now();
		 
		 Calendar cal = Calendar.getInstance();
		 cal.set(Calendar.HOUR_OF_DAY, 0);
		 cal.set(Calendar.MINUTE, 0);
		 cal.set(Calendar.SECOND, 0);
		 cal.set(Calendar.MILLISECOND, 0);
		 Date today = cal.getTime();

		 request.setAttribute("today", today);
		 model.addAttribute("team", team);
		 model.addAttribute("teamFeeList", teamFeeList);
		 model.addAttribute("teamMonthFeeList", teamMonthFeeList);
		 model.addAttribute("expense", expense);
		 model.addAttribute("income", income);
		 model.addAttribute("tot", tot);
		 model.addAttribute("pageHtml", pageHtml);
	     model.addAttribute("totalCount", totalCount);
	     model.addAttribute("currentPage", currentPage);
		 
		 return "/team/TeamFee";
	}
	
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
		
		return "redirect:/TeamFee.action";
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
		
		
		ITeamFeeDAO teamFeeDAO = sqlSession.getMapper(ITeamFeeDAO.class);
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
		
		teamFeeDAO.addMonthFee(teamFee);
		
		return "redirect:/TeamFee.action";
	};
	
	
	//동호회 회비 납부자 명단
	@RequestMapping(value = "/TeamMonthFeeMember.action",method=RequestMethod.GET)
	public String getMemberFeeList(HttpServletRequest request, Model model)
	{
		HttpSession session = request.getSession();
		int team_fee_id = Integer.parseInt(request.getParameter("team_fee_id"));
		Integer temp_team_id = (Integer) session.getAttribute("team_id");
	
		ITeamFeeDAO teamFeeDAO = sqlSession.getMapper(ITeamFeeDAO.class);
		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		
		TeamFeeDTO teamFee =  teamFeeDAO.getTeamMonthFee(team_fee_id);
		
		TeamDTO team = teamDAO.getTeamInfo(temp_team_id);
		
		List<TeamMemberFeeDTO> teamMemberFeeList =  teamFeeDAO.getMemberFeeList(team_fee_id);

		model.addAttribute("teamMemberFeeList", teamMemberFeeList);
		model.addAttribute("team", team);
		model.addAttribute("teamFee", teamFee);
		
		return "/team/TeamMonthFee";
	};

}

