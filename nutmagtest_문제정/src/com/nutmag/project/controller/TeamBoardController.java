package com.nutmag.project.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nutmag.project.dao.IMatchDAO;
import com.nutmag.project.dao.ITeamBoardDAO;
import com.nutmag.project.dao.ITeamDAO;
import com.nutmag.project.dao.ITeamFeeDAO;
import com.nutmag.project.dto.TeamApplyDTO;
import com.nutmag.project.dto.TeamBoardDTO;
import com.nutmag.project.dto.TeamDTO;

import util.PageUtil;

@Controller	
public class TeamBoardController {

	@Autowired
	private SqlSession sqlSession;
    
	// 팀 게시판 호출
	@RequestMapping(value = "/TeamBoard.action", method = RequestMethod.GET)
	public String teamBoard(HttpServletRequest request, Model model)
	{
		HttpSession session = request.getSession();
		Integer temp_team_id = (Integer) session.getAttribute("team_id");
		
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
		
		ITeamBoardDAO teamBoardDAO = sqlSession.getMapper(ITeamBoardDAO.class);
		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		
		TeamDTO team = teamDAO.getTeamInfo(temp_team_id);
		int team_id = team.getTeam_id();
		
		// 전체 게시글 수 조회
        int totalCount = teamBoardDAO.getTotalCount(team_id);
        
        // 페이징 유틸 생성 (한 페이지에 10개씩, 5개 페이지 번호)
        PageUtil pageUtil = new PageUtil(currentPage, totalCount, 10, 5);
        
        int start =pageUtil.getStart();
        int end = pageUtil.getEnd();
        // 페이징된 게시글 목록 조회
        List<TeamBoardDTO> teamBoardList = teamBoardDAO.getList(start, end,team_id);
        
        System.out.println("============================[확인]============================");
        for (TeamBoardDTO teamBoardDTO : teamBoardList) {
			System.out.println("team_board_title = " + teamBoardDTO.getTeam_board_title());
			System.out.println("team_board_content = " + teamBoardDTO.getTeam_board_content());
			System.out.println("team_board_create_at = " + teamBoardDTO.getTeam_board_create_at());
		}
        System.out.println("==============================================================");
        // 페이징 HTML 생성
        String pageHtml = pageUtil.getPageHtml("MyTeamBoard.action?page=%d");
        
        // 요청 속성에 데이터 설정
        model.addAttribute("teamBoardList", teamBoardList);
        model.addAttribute("pageHtml", pageHtml);
        model.addAttribute("totalCount", totalCount);
		
		return "/team/TeamBoard";
	}

	// 게시글 상세 조회
	@RequestMapping(value = "/SearchTeamBoard.action", method = RequestMethod.GET)
	public String teamBoardView(HttpServletRequest request, Model model)
	{
		HttpSession session = request.getSession();
		Integer user_code_id = (Integer) session.getAttribute("user_code_id");
		Integer temp_team_id = (Integer) session.getAttribute("team_id");
		
		// 게시글 ID 파라미터 처리
		String idParam = request.getParameter("id");
		if (idParam == null || idParam.isEmpty()) 
		{
			return "redirect:/MyTeamBoard.action";
		}
		int team_board_id = Integer.parseInt(idParam);
		
		ITeamBoardDAO teamBoardDAO = sqlSession.getMapper(ITeamBoardDAO.class);
		
		// 게시글 상세 조회
        TeamBoardDTO teamBoard = teamBoardDAO.getTeamBoard(team_board_id);
        if (teamBoard == null) 
        {
        	return "redirect:/TeamBoard.action";
        }
        
        
        //동호회 멤버 코드 추출
        ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		TeamDTO team = teamDAO.getTeamInfo(temp_team_id);
		int team_id = team.getTeam_id();
		
		TeamApplyDTO teamApply= teamDAO.searchTeamMemberCode(team_id, user_code_id);
	
		int team_member_id =teamApply.getTeam_member_id();
		
        model.addAttribute("teamBoard", teamBoard);
        model.addAttribute("team_member_id", team_member_id);
        
        return "team/MyTeamBoardView";
	}
	
	// 게시글 작성 페이지
	@RequestMapping(value = "/MyTeamBoardWrite.action", method = RequestMethod.GET)
	public String teamBoardWriteForm()
	{	
		return "team/MyTeamBoardWrite";
	}
	
	// 게시글 수정 페이지
	@RequestMapping(value = "/MyTeamBoardUpdate.action", method = RequestMethod.GET)
	public String teamBoardUpdateForm()
	{	
		return "team/MyTeamBoardUpdate";
	}
   
	// 게시글 등록
	@RequestMapping(value = "/TeamBoardInsert.action", method = RequestMethod.POST)
	public String teamBoardInsert(TeamBoardDTO teamBoard,HttpServletRequest request, Model model)
	{	
		HttpSession session = request.getSession();
		Integer temp_team_id = (Integer) session.getAttribute("team_id");
		Integer user_code_id = (Integer) session.getAttribute("user_code_id");
		
		ITeamBoardDAO teamBoardDAO = sqlSession.getMapper(ITeamBoardDAO.class);
		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		
		//동호회 멤버 코드 추출
		TeamDTO team = teamDAO.getTeamInfo(temp_team_id);
		int team_id = team.getTeam_id();
		
		TeamApplyDTO teamApply= teamDAO.searchTeamMemberCode(team_id, user_code_id);
	
		int team_member_id =teamApply.getTeam_member_id();
		
		
		teamBoard.setTeam_member_id(team_member_id);
		teamBoard.setTeam_id(team_id);
		
		teamBoardDAO.insertTeamBoard(teamBoard);
		
		return "redirect:/TeamBoard.action";
	}
    

}
