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

import com.nutmag.project.dao.IMatchDAO;
import com.nutmag.project.dao.ITeamDAO;
import com.nutmag.project.dto.MatchDTO;
import com.nutmag.project.dto.TeamApplyDTO;

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
		
		return "redirect:MyTeamSchedule.action";
	}
	
	//매치 참여자 출력 페이지 호출
	@RequestMapping(value = "/Participant.action", method = RequestMethod.GET)
	public String paticipateMember(HttpServletRequest request, Model model)
	{
		HttpSession session = request.getSession();
		
		Integer user_code_id = (Integer) session.getAttribute("user_code_id"); 	//사용자 정보
		String strField_res_id =(String)request.getParameter("field_res_id");	//예약 정보
		int field_res_id = Integer.parseInt(strField_res_id);
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
}
