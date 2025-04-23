package com.nutmag.project.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.dsig.keyinfo.RetrievalMethod;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.nutmag.project.dao.IMatchDAO;
import com.nutmag.project.dao.ITeamDAO;
import com.nutmag.project.dto.MatchDTO;
import com.nutmag.project.dto.TeamApplyDTO;
import com.nutmag.project.dto.TeamDTO;

@Controller
public class MatchController {

	
	@Autowired
	private SqlSession sqlSession;
	
	//매치 참여자 참여
	@RequestMapping(value = "/ApplyMatch.action", method = RequestMethod.GET)
	public String joinMatch(HttpServletRequest request, Model model)
	{
		HttpSession session = request.getSession();
		
		Integer user_code_id = (Integer) session.getAttribute("user_code_id"); 	//사용자 정보
		//Integer temp_team_id = (Integer) session.getAttribute("team_id");		//팀 정보
		String strField_res_id =(String)request.getParameter("field_res_id");	//예약 정보
		int field_res_id = Integer.parseInt(strField_res_id);
		String message = "";													//신청 성공/실패 안내 메시지
		
		IMatchDAO matchDAO = sqlSession.getMapper(IMatchDAO.class);
		TeamApplyDTO member =  matchDAO.searchTeamMember(user_code_id);			//사용자 정보
		
		MatchDTO match = matchDAO.getMatch(field_res_id);						//해당 매치 정보
		
		int team_id = member.getTeam_id();
		int home_team_id = match.getHome_team_id();
		int away_team_id = match.getAway_team_id();
		int team_member_id =member.getTeam_member_id();
		int match_pay_id = match.getMatch_pay_id();
		
		MatchDTO matchDTO = new MatchDTO();										//데이터를 insert시키기 위한 DTO
		
		matchDTO.setField_res_id(field_res_id);
		matchDTO.setTeam_member_id(team_member_id);
		matchDTO.setMatch_pay_id(match_pay_id);
		
		//디버그 코드
		System.out.println("=========================[확인00]=========================");
		System.out.println("field_res_id = " +field_res_id);
		System.out.println("team_member_id = " +team_member_id);
		System.out.println("===========================================================");
		
		//홈팀 동호회 참가자 인원
		if(home_team_id == team_id) {
			
			//◆◆◆◆◆참여 인원 제한◆◆◆◆◆
			
			
			int attendance= matchDAO.searchHomeTeamMember(matchDTO);
			
			
			//이미 신청한 사람은 신청 불가 제약 조건 필수
			if(attendance ==0) {
				
				matchDAO.addHomeTeamMember(matchDTO);
				message = "SUCCESS_APPLY: 매치 참여 신청이 완료되었습니다.";
				session.setAttribute("message", message);
			}
			else {
				message = "ERROR_DUPLICATE_JOIN: 이미 참여 신청이 되어있습니다.";
				session.setAttribute("message", message);
			}
				
		}
		//어웨이 동호회 참가자 인원
		else if(away_team_id == team_id) {
			
			//◆◆◆◆◆참여 인원 제한◆◆◆◆◆
			
			int attendance = matchDAO.searchAwayTeamMember(matchDTO);
			
			
			//이미 신청한 사람은 신청 불가 제약 조건 필수
			if(attendance ==0) {
				
				matchDAO.addAwayTeamMember(matchDTO);
				message = "SUCCESS_APPLY: 매치 참여 신청이 완료되었습니다.";
				session.setAttribute("message", message);
			}
			else {
				message = "ERROR_DUPLICATE_JOIN: 이미 참여 신청이 되어있습니다.";
				session.setAttribute("message", message);
			}
			
			
			matchDAO.addAwayTeamMember(matchDTO);
		}
		else {
			return "Error";
		}
		
		return "redirect:TeamSchedule.action";
	}
	
	//매치 참여자 출력 페이지 호출
	@RequestMapping(value = "/Participant.action", method = RequestMethod.GET)
	public String paticipateMember(HttpServletRequest request, Model model)
	{
		HttpSession session = request.getSession();
		
		Integer user_code_id = (Integer) session.getAttribute("user_code_id"); 	//사용자 정보
		int field_res_id = Integer.parseInt(request.getParameter("field_res_id"));	//예약 정보
		String message = "";													//신청 성공/실패 안내 메시지
		
		// 로그인 여부
		if (user_code_id == -1)
		{
			message = "ERROR_AUTH_REQUIRED: 로그인을 해야 합니다.";
			session.setAttribute("message", message);
			return "redirect:MainPage.action";
		}
		
		IMatchDAO matchDAO = sqlSession.getMapper(IMatchDAO.class);
		TeamApplyDTO member =  matchDAO.searchTeamMember(user_code_id);			//사용자 정보
		
		MatchDTO match = matchDAO.getMatch(field_res_id);						//매치 정보
		
		int team_id = member.getTeam_id();
		int home_team_id = match.getHome_team_id();
		int away_team_id = match.getAway_team_id();
		
		List<MatchDTO> paticipantList;
		//홈팀 동호회 참가자 인원
		if(home_team_id == team_id) {
			
			paticipantList = matchDAO.homeTeamPaticipantList(field_res_id);	
		}
		//어웨이 동호회 참가자 인원
		else if(away_team_id == team_id) {
			
			paticipantList = matchDAO.awayTeamPaticipantList(field_res_id);
		}
		else {
			return "Error";
		}
		
		session.setAttribute("paticipantList", paticipantList);
		
		return "match/Participant";
	}
	
	// 매치방 메인 페이지
	@RequestMapping(value ="/MatchMainPage.action", method = RequestMethod.GET )
	public String matchMainPage(Model model)
	{
		
		IMatchDAO dao = sqlSession.getMapper(IMatchDAO.class);
		
		model.addAttribute("matchRoomList", dao.matchRoomList());
		
		return "/match/MatchMainPage";
	}
	
	//에웨이팀 매치 승인
	@RequestMapping(value ="/ApproveMatch.action", method = RequestMethod.GET )
	public String approveMatch(Model model,HttpServletRequest request)
	{
		int field_res_id = Integer.parseInt(request.getParameter("field_res_id"));	//예약 정보
		
		IMatchDAO matchDAO = sqlSession.getMapper(IMatchDAO.class);
		MatchDTO match = matchDAO.getMatch(field_res_id);
		
		int match_pay_id = match.getMatch_pay_id();
		
		model.addAttribute("matchRoomList", matchDAO.matchRoomList());
		
		return"redirect:TeamSchedule.action";
	}
	
	// 매치방 상세 페이지
	@RequestMapping(value = "/MatchEnterCheckForm.action", method =RequestMethod.POST)
	public String matchEnterCheckForm(Model model, @RequestParam("match_date") String match_date,
	@RequestParam("start_time") String start_time,@RequestParam("end_time") String end_time,@RequestParam("home_team_id") int home_team_id
	,@RequestParam("pay_amount") int pay_amount,@RequestParam("match_inwon") String match_inwon
	,@RequestParam("field_res_id") int field_res_id,@RequestParam("field_code_id") int field_code_id)
	{
		String result = null;
		
		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		
		TeamDTO team = teamDAO.getTeamInfo(home_team_id); 
		
		pay_amount = pay_amount/2;
		int start_time_check = Integer.parseInt(start_time.substring(0, 2));
		int end_time_check = Integer.parseInt(end_time.substring(0, 2))+1;
		
		int hour_amount = pay_amount/((end_time_check - start_time_check)/2) ;
		
		model.addAttribute("match_date", match_date);
		model.addAttribute("start_time", start_time);
		model.addAttribute("end_time", end_time);
		model.addAttribute("pay_amount", pay_amount);
		model.addAttribute("hour_amount", hour_amount);
		model.addAttribute("match_inwon", match_inwon);
		model.addAttribute("field_res_id", field_res_id);
		model.addAttribute("field_code_id", field_code_id);
		model.addAttribute("team", team);
		
		result = "/match/MatchEnterCheckForm";
		return result;
	}
	
	
	// 어웨이팀 매칭 참여
	@RequestMapping(value ="/MatchAwayTeamInsert.action")
	public String matchAwayTeamInsert(MatchDTO dto,HttpServletRequest request)
	{
		String message = "";
		
		HttpSession session = request.getSession();
		IMatchDAO matchDAO = sqlSession.getMapper(IMatchDAO.class);
		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		
		int temp_team_id = (int) session.getAttribute("team_id");
		
		TeamDTO team = teamDAO.getTeamInfo(temp_team_id);
		int team_id  =team.getTeam_id();
		System.out.println("팀 아이디 디버그 코드 : " + team_id);
		
		if(team_id == 0 ) {
			
			message =  "ERROR_DUPLICATE_JOIN: 임시 동호회임으로 매치에 참여할 수 없습니다.";
			session.setAttribute("message", message);
			return "redirect:MainPage.action";
		}
		
		dto.setAway_team_id(team_id);
		
		matchDAO.matchAwayTeamInsert(dto);
		
		message = "SUCCESS_INSERT: 매치 신청이 완료 되었습니다.";
		session.setAttribute("message", message);
		
		return "redirect:MainPage.action";
	}
	
}
