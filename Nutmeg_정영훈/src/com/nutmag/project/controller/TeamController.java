package com.nutmag.project.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nutmag.project.dao.IBankDAO;
import com.nutmag.project.dao.IMatchDAO;
import com.nutmag.project.dao.INotificationDAO;
import com.nutmag.project.dao.IPositionDAO;
import com.nutmag.project.dao.IRegionDAO;
import com.nutmag.project.dao.ITeamDAO;
import com.nutmag.project.dao.ITeamFeeDAO;
import com.nutmag.project.dto.CityDTO;
import com.nutmag.project.dto.MatchDTO;
import com.nutmag.project.dto.NotificationDTO;
import com.nutmag.project.dto.PositionDTO;
import com.nutmag.project.dto.TeamApplyDTO;
import com.nutmag.project.dto.TeamDTO;
import com.nutmag.project.dto.TeamFeeDTO;

import util.PageUtil;
import util.Path;

@Controller
public class TeamController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 메인 페이지
	@RequestMapping(value = "/MainPage.action", method = RequestMethod.GET)
	public String mainPage(Model model)
	{
		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		List<TeamDTO> teamList = teamDAO.getTeamList();
		
		for (TeamDTO team : teamList) {
			
			//동호회 정보확인
			int team_id = team.getTeam_id();
			int temp_team_id = team.getTemp_team_id();
			
			//임시 동호회
			if (team_id == 0) {
				int temp_team_member_count =teamDAO.tempTeamMemberCount(temp_team_id);
				team.setMember_count(temp_team_member_count);
			}
			//정식 동호회
			else if(team_id !=0) {
				int team_member_count = teamDAO.teamMemberCount(team_id);
				team.setMember_count(team_member_count);
			}
			
		}
		model.addAttribute("teamList", teamList);
		
		return "main/MainPage";
	};
	
	// 동호회 개설 페이지 호출
	@RequestMapping(value = "/TeamOpen.action", method = RequestMethod.GET)
	public String createTeam(Model model, HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession();
		
		Integer user_code_id = (Integer) session.getAttribute("user_code_id");
		String message = "";
		
		// 동호회 가입여부 확인
		ITeamDAO dao = sqlSession.getMapper(ITeamDAO.class);
		
		int TeamTeam = dao.searchTempTeamMember(user_code_id);
		int Team = dao.searchTeamMember(user_code_id);
		int countMember = TeamTeam + Team;
		
		if (countMember > 0)
		{
			message = "ERROR_DUPLICATE_JOIN: 이미 가입중인 동호회가 있습니다.";
			session.setAttribute("message", message);
			return "redirect:MainPage.action";
		}
		
		// 동호회 개설 페이지 출력
		IBankDAO bankDAO = sqlSession.getMapper(IBankDAO.class);
		model.addAttribute("bankList", bankDAO.bankList());
		
		IRegionDAO regionDAO = sqlSession.getMapper(IRegionDAO.class);
		model.addAttribute("regionList", regionDAO.regionList());
		
		return "/team/TeamOpen";
	}
	
	// 동호회 참여 페이지 호출
	@RequestMapping(value = "/TeamApply.action", method = RequestMethod.GET)
	public String applyOpenTeam(HttpServletRequest request, Model model)
	{
		// 필요 정보 가져오기
		HttpSession session = request.getSession();
		
		Integer user_code_id = (Integer) session.getAttribute("user_code_id");
		String strTeam_id = (String) request.getParameter("team_id");
		int team_id = Integer.parseInt(strTeam_id);
		
		model.addAttribute("team_id", team_id);
		
		System.out.println("==========[동호회 참여 페이지 호출]==========");
		System.out.println("user_code_id = " + user_code_id);
		System.out.println("team_id = " + team_id);
		System.out.println("============================================");
		
		String message = "";

		// 로그인 여부
		if (user_code_id == -1)
		{
			message = "ERROR_AUTH_REQUIRED: 로그인을 해야 합니다.";
			session.setAttribute("message", message);
			return "redirect:MainPage.action";
		}
		
		// 동호회 가입여부 확인
		ITeamDAO dao = sqlSession.getMapper(ITeamDAO.class);
		
		int TeamTeam = dao.searchTempTeamMember(user_code_id);
		int Team = dao.searchTeamMember(user_code_id);
		int countMember = TeamTeam + Team;
		
		if (countMember > 0)
		{	
			message = "ERROR_DUPLICATE_JOIN: 이미 가입중인 동호회가 있습니다.";
			session.setAttribute("message", message);
			return "redirect:MainPage.action";
		}
		
		// 동호회 정보 가져오기
		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		
		TeamDTO team = teamDAO.getTeamInfo(team_id);
		
		model.addAttribute("team", team);
		
		// 포지션 정보 가져오기
		IPositionDAO positionDAO = sqlSession.getMapper(IPositionDAO.class);
		
		ArrayList<PositionDTO> positionList = new ArrayList<PositionDTO>();
		
		positionList = positionDAO.positionList();
		model.addAttribute("positionList", positionList);
		
		// 동호회원 가져오기
		if (team.getTeam_id() == 0)
		{	
			// 임시동호회 인원 찾기
			List<TeamApplyDTO> teamMemberList = dao.tempTeamMemberList(team_id);
			System.out.println("==========[임시 동호회 인원 찾기]==========");
			System.out.println("teamMemberList.size() = " + teamMemberList.size());
			System.out.println("============================================");
			
			// 동호회장 찾기
			for (TeamApplyDTO member : teamMemberList)
			{
				if (member.getUser_code_id() == team.getUser_code_id())
					member.setMember_status("회장");
			}
			
			model.addAttribute("teamMemberList", teamMemberList);
			return "/team/TeamApply";
		}
		
		else if (team.getTeam_id() != 0)
		{
			// 정식동호회 인원 찾기
			List<TeamApplyDTO> teamMemberList = dao.teamMemberList(team.getTeam_id());
			System.out.println("==========[정식 동호회 인원 찾기]==========");
			System.out.println("teamMemberList.size() = " + teamMemberList.size());
			System.out.println("============================================");
			
			// 동호회장 찾기
			for (TeamApplyDTO member : teamMemberList)
			{
				if (member.getUser_code_id() == team.getUser_code_id())
					member.setMember_status("회장");
			}
			
			model.addAttribute("teamMemberList", teamMemberList);
			return "/team/TeamApply";
		}
		
		return "redirect:/MainPage.action";
	}
	
	// 동호회 가입 신청
	@RequestMapping(value="/TeamApplyInsert.action", method = RequestMethod.POST)
	public String applyTeam(TeamApplyDTO teamApply, HttpServletRequest request,Model model)
	{
		HttpSession session = request.getSession();
		
		//데이터베이스 연력 객체 생성
		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		
		//가입 유저 코드
		Integer user_code_id = (Integer)session.getAttribute("user_code_id");
		
		//임시 동호회 코드(동호호 정보을 알아내기 위함)
		int temp_team_id =Integer.parseInt(request.getParameter("team_id"));
		
		//디버그 코드
		System.out.println("==========[동호회 가입]==========");
		System.out.println("user_code_id = " + user_code_id);
		System.out.println("temp_team_apply_desc = " + teamApply.getTeam_apply_desc());
		System.out.println("team_id = " + temp_team_id);
		System.out.println("position_id = " + teamApply.getPosition_id());
		System.out.println("===============================");
		
		TeamDTO team = teamDAO.getTeamInfo(temp_team_id);
		teamApply.setUser_code_id(user_code_id);
		
		// 임시 동호회 가입
		if (team.getTeam_id() == 0)
		{
			System.out.println("확인===============================================================================================");
			System.out.println(teamDAO.checkedTempTeamApply(user_code_id,team.getTemp_team_id()));
			System.out.println("===================================================================================================");
			
			// 가입 신청 중복 방지
			if(teamDAO.checkedTempTeamApply(user_code_id,team.getTemp_team_id()) > 0)
			{
				String message = "ERROR_DUPLICATE_REQUEST: 이미 접수된 동호회입니다.";
				session.setAttribute("message", message);
				
				return "redirect:MainPage.action";
			}
			
			
			teamApply.setTeam_id(temp_team_id);
			teamDAO.applyedTempTeam(teamApply);
			
		}
		
		// 정식 동호회 가입
		else if(team.getTeam_id() !=0)
		{
			// 가입 신청 중복 방지
			if(teamDAO.checkedTeamApply(user_code_id,team.getTeam_id()) > 0)
			{
				String message = "ERROR_DUPLICATE_REQUEST: 이미 접수된 동호회입니다.";
				session.setAttribute("message", message);
				
				return "redirect:MainPage.action";
			}
			
			teamApply.setTeam_id(team.getTeam_id());
			teamDAO.applyedTeam(teamApply);

		}
		
		String message = "SUCCESS_APPLY: 동호회 신청이 완료되었습니다.";
		session.setAttribute("message", message);
		
		return "redirect:MainPage.action";
	}
	
	// 구 선택지 리스트
	@RequestMapping(value = "/SearchCity.action", method = RequestMethod.GET)
	@ResponseBody
	public void getCityList(@RequestParam("region") int region, HttpServletResponse response) throws IOException
	{
		IRegionDAO regionDao = sqlSession.getMapper(IRegionDAO.class);
		
		ArrayList<CityDTO> cityList = new ArrayList<>();
		
		if (region != 0)
			cityList = regionDao.cityList(region);
		
		// JSON 응답 설정
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		// Jackson을 사용하여 객체를 JSON 문자열로 변환
		ObjectMapper objectMapper = new ObjectMapper();
		String json = objectMapper.writeValueAsString(cityList);
		out.print(json);
		out.flush();
	}
	
	// 동호회 이름 중복검사
	@RequestMapping(value = "/CheckTeamName.action", method = RequestMethod.GET)
	public void checkEmail(@RequestParam("teamName") String teamName, HttpServletResponse response) throws IOException
	{
		ITeamDAO dao = sqlSession.getMapper(ITeamDAO.class);
		
		String searchTeamName = dao.searchTeamName(teamName);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain;charset=UTF-8");
		
		// 이메일을 아무것도 안적었을 경우
		if (searchTeamName == null || searchTeamName.isEmpty())
			response.getWriter().write("사용 가능한 팀네임 입니다.");
		
		else
			response.getWriter().write("이미 사용중인 팀네임 입니다.");
	}
	
	// 동호회 등록(파일 등록)
	@RequestMapping(value = "/TeamInsert.action", method = RequestMethod.POST)
	public String insertTeam(TeamDTO team, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		MultipartFile file = team.getTemp_team_emblem();
		
		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		
		Integer user_code_id = (Integer)session.getAttribute("user_code_id");
		
		System.out.println("/n===================================================================================================");
		
		System.out.println("파일 업로드 시작: " + (file != null ? file.getOriginalFilename() : "파일 없음"));
		
		// 파일이 있을 시
		if (file != null && !file.isEmpty())
		{
			try
			{
				// 디버그 코드
				System.out.println("\n==================================동호회 등록==================================");
				
				if (team != null)
				{
					System.out.println("TEMP_TEAM_NAME(팀 이름) = " + team.getTemp_team_name());
					System.out.println("TEMP_TEAM_DESC(팀 설명) = " + team.getTemp_team_desc());
					System.out.println("TEMP_TEAM_EMBLEM(팀 엠블럼) = " + team.getTemp_team_emblem());
					System.out.println("TEMP_TEAM_ACCOUNT(팀 계좌번호) = " + team.getTemp_team_account());
					System.out.println("TEMP_TEAM_ACCOUNT_HOLDER(팀 예금주) = " + team.getTemp_team_account_holder());
					System.out.println("BANK_ID(팀 은행) = " + team.getBank_id());
					System.out.println("REGION_ID(팀 지역) = " + team.getRegion_id());
					System.out.println("CITY_ID(팀 도시) = " + team.getCity_id());
					System.out.println("TEMP_TEAM_PERSON_COUNT(팀 인원수) = " + team.getTemp_team_persom_count());
				}
				System.out.println("=================================================================================");
				System.out.println("\n==================================파일 업로드 상태 ==================================");
				
				if (file != null)
				{
					System.out.println("파일 비어 있음? : " + file.isEmpty());
					System.out.println("파일 원래 이름 : " + file.getOriginalFilename());
				}
				System.out.println("=======================================================================================");
				// 웹 애플리케이션 루트 경로 가져오기
				String root = request.getServletContext().getRealPath("");
				
				// 업로드 디렉토리 경로
				String uploadDir = Path.getUploadEmblemDir();
				
				// 전체 업로드 경로 생성
				String uploadPath = root + uploadDir;
				if (!uploadDir.endsWith(File.separator))
					uploadPath = root + uploadDir + File.separator;
				
				File uploadDirFile = new File(uploadPath);
				// 파일 경로 없을 시 폴더 생성
				if (!uploadDirFile.exists())
				{
					boolean created = uploadDirFile.mkdirs();
					System.out.println("디렉토리 생성 결과: " + created);
				}
				
				// 파일명 충돌 방지를 위한 고유 파일명 생성
				String originalFileName = file.getOriginalFilename();
				String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				String teamFileName = team.getTemp_team_name() + "_" + System.currentTimeMillis() + fileExtension;
				
				// 파일 저장
				String filePath = uploadPath + teamFileName;
				System.out.println("저장될 파일 경로: " + filePath);
				
				File dest = new File(filePath);
				file.transferTo(dest);
				System.out.println("파일 저장 완료");
				
				System.out.println("웹 애플리케이션 루트: " + root);
				// DB에 저장할 상대 경로 설정
				String dbFilePath = uploadDir;
				if (!uploadDir.endsWith("/") && !uploadDir.endsWith("\\"))
					dbFilePath += "/";
				
				dbFilePath += teamFileName;
				
				System.out.println("/n===================================[파일 업로드]===================================");
				System.out.println("전체 업로드 경로: " + uploadPath);
				System.out.println("설정된 업로드 경로: " + uploadDir);
				System.out.println("DB에 저장할 파일 경로: " + dbFilePath);
				System.out.println("=====================================================================================");
				
				team.setEmblem(dbFilePath);
			}
			catch (Exception e)
			{
				System.out.println("파일 저장 중 오류 발생:");
				e.printStackTrace();
				
				String message = "ERROR: 동호회 설명이 너무 깁니다.";
				session.setAttribute("message", message);
			}
		}
		
		else
			team.setEmblem("/");
		
		try
		{
			ITeamDAO dao = sqlSession.getMapper(ITeamDAO.class);
			dao.teamInsert(team);
			System.out.println("DB 저장 완료");
			
			String message = "SUCCESS_INSERT: 동호회 개설이 완료되었습니다.";
			session.setAttribute("message", message);
			
			if (teamDAO.searchMyTempTeam(user_code_id) != null)
				session.setAttribute("team_id", teamDAO.searchMyTempTeam(user_code_id));
		}
		catch (Exception e)
		{
			System.out.println("DB 저장 중 오류 발생:");
			e.printStackTrace();
			
			String message = "ERROR: 동호회 설명이 너무 깁니다.";
			session.setAttribute("message", message);
		}
		
		System.out.println("\n===================================================================================================");
		
		return "redirect:/MainPage.action";
	}

	// 내 동호회 메인 페이지 호출
	@RequestMapping(value = "/TeamMain.action", method = RequestMethod.GET)
	public String teamMain(HttpServletRequest request, Model model)
	{
		HttpSession session = request.getSession();
		
		Integer team_id = (Integer) session.getAttribute("team_id");
		Integer user_code_id = (Integer) session.getAttribute("user_code_id");
		
		// 동호회 정보 가져오기
		ITeamDAO dao = sqlSession.getMapper(ITeamDAO.class);
		TeamDTO team = dao.getTeamInfo(team_id);
		
		if (user_code_id == team.getUser_code_id())
			team.setStatus(1);
			
		else
			team.setStatus(0);
		
		model.addAttribute("team", team);
		// 동호회원 가져오기
		if (team.getTeam_id() == 0)
		{
			// 임시동호회 인원 찾기
			List<TeamApplyDTO> teamMemberList = dao.tempTeamMemberList(team_id);
			// 동호회장 찾기
			for (TeamApplyDTO member : teamMemberList)
			{
				if (member.getUser_code_id() == team.getUser_code_id())
					member.setMember_status("회장");
			}
			System.out.println("\n\n확인[04]\n\n");
			model.addAttribute("teamMemberList", teamMemberList);
			return "/team/TeamMain";
		}
		
		else if (team.getTeam_id() != 0)
		{
			// 정식동호회 인원 찾기
			List<TeamApplyDTO> teamMemberList = dao.teamMemberList(team.getTeam_id());
			
			// 동호회장 찾기
			for (TeamApplyDTO member : teamMemberList)
			{
				if (member.getUser_code_id() == team.getUser_code_id())
					member.setMember_status("회장");
			}
			
			model.addAttribute("teamMemberList", teamMemberList);
			return "/team/TeamMain";
		}
		
		return "redirect:/MainPage.action";
	}
	
	// 동호회 일정 페이지
	@RequestMapping(value = "/TeamSchedule.action", method = RequestMethod.GET)
	public String teamSchedule(HttpServletRequest request, Model model)
	{
		HttpSession session = request.getSession();
		
		Integer user_code_id = (Integer) session.getAttribute("user_code_id");
		Integer temp_team_id = (Integer) session.getAttribute("team_id");
		
		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		
		//==========[동호회 회장 접속 확인]==========
		TeamDTO team = teamDAO.getTeamInfo(temp_team_id);
		
		int captin_code_id = team.getUser_code_id();
		
		int team_status = 0;
		
		//동호회 회장인지를 확인하기 위한 목적
		if (captin_code_id == user_code_id) {
			team_status = 1;				
		}
		
		//=============================================
		
		if (user_code_id == -1)
		{
			String message = "ERROR_AUTH_REQUIRED: 로그인을 해야 합니다.";
			session.setAttribute("message", message);
			return "redirect:MainPage.action";
		}
		session.setAttribute("team_status", team_status);
		return "/team/TeamSchedule";
	}
	
	
	// 일정 불러오기
	@RequestMapping(value = "/MatchList.action", method = RequestMethod.GET)
	@ResponseBody  // 중요: JSON 응답을 자동으로 처리
	public List<MatchDTO> getMatches(HttpServletRequest request) {
	    HttpSession session = request.getSession();
	    Integer teamId = (Integer) session.getAttribute("team_id");
	    
	    // 동호회 정보 가져오기
	    ITeamDAO dao = sqlSession.getMapper(ITeamDAO.class);
	    TeamDTO team = dao.getTeamInfo(teamId);
	    IMatchDAO matchDAO = sqlSession.getMapper(IMatchDAO.class);
	    int team_id = team.getTeam_id();
	    
	    // 매치 목록 가져오기
	    List<MatchDTO> matchList = matchDAO.matchList(team_id);
	    
	    // 디버깅
	    for (MatchDTO match : matchList) {
	        System.out.println("홈 팀 이름: " + match.getHome_team_name());
	        System.out.println("어웨이 팀 이름: " + match.getAway_team_name());
	    }
	    
	    return matchList; // Spring이 자동으로 JSON으로 변환
	}

	
	// 팀원 승인 호출
	@RequestMapping(value = "/MemberAppr.action", method = RequestMethod.GET)
	public String approveMember(HttpServletRequest request, Model model)
	{
		HttpSession session = request.getSession();
		Integer temp_team_id = (Integer) session.getAttribute("team_id");
		
		System.out.println("\n==========[동호회 승인 페이지 호출]==========");
		System.out.println("temp_team_id = " + temp_team_id);
		System.out.println("============================================");
		
		// 동호회 정보 가져오기
		ITeamDAO dao = sqlSession.getMapper(ITeamDAO.class);
		TeamDTO team = dao.getTeamInfo(temp_team_id);
		int team_id = team.getTeam_id();
		model.addAttribute("team", team);
		
		// 동호회원 가져오기
		if (team_id == 0)
		{
			// 임시동호회 인원 찾기
			List<TeamApplyDTO> teamApplyList = dao.tempTeamApplyList(temp_team_id);
			model.addAttribute("teamApplyList", teamApplyList);
			System.out.println("\n=======[임시 동호회 팀원 승인 호출]=======");
			System.out.println("팀 정보_id = " + temp_team_id);
			System.out.println("리스트 길이 = " + teamApplyList.size());
			System.out.println("============================================");
			
			System.out.println("\n\n=====[데이터 확인]=====");
			for (TeamApplyDTO teamApplyDTO : teamApplyList)
			{
				System.out.println("사용자 이름 : " + teamApplyDTO.getUser_nick_name());
				System.out.println("팀 이름 : " + teamApplyDTO.getTeam_name());
				System.out.println("설명 : " + teamApplyDTO.getTeam_apply_desc());
				System.out.println("---------------------------------");
			}
			
			System.out.println("===========================");
			
		}
		
		else if (team_id != 0)
		{
			
			// 정식동호회 인원 찾기
			List<TeamApplyDTO> teamApplyList = dao.teamApplyList(team_id);
			model.addAttribute("teamApplyList", teamApplyList);
			System.out.println("\n=======[정식 동호회 팀원 승인 호출]=======");
			System.out.println("팀 정보_id = " + team_id);
			System.out.println("리스트 길이 = " + teamApplyList.size());
			System.out.println("============================================");
		}
		
		return "/team/MemberAppr";
	}
	
	// 동호회 멤버 수락
	@RequestMapping(value = "/AddMember.action", method = RequestMethod.GET)
	public String addMember(HttpServletRequest request, Model model)
	{
		HttpSession session = request.getSession();
		String message = "";
		
		Integer team_id = (Integer) session.getAttribute("team_id");
		
		// 신청 코드
		String strTeam_apply_id = (String) request.getParameter("team_apply_id");
		int team_apply_id = Integer.parseInt(strTeam_apply_id);
		
		// 신청자 유저 코드
		int user_code_id = Integer.parseInt( request.getParameter("user_code_id"));

		// 동호회 가입여부 확인
		ITeamDAO dao = sqlSession.getMapper(ITeamDAO.class);
		
		int TeamTeam = dao.searchTempTeamMember(user_code_id);
		int Team = dao.searchTeamMember(user_code_id);
		int countMember = TeamTeam + Team;
		
		
		//알림 전송
		INotificationDAO notificationDAO = sqlSession.getMapper(INotificationDAO.class);
		NotificationDTO notification = new NotificationDTO();
		notification.setUser_code_id(user_code_id);
		
		if (countMember > 0)
		{
			message = "ERROR_DUPLICATE_JOIN: 이미 가입중인 동호회가 있습니다.";
			session.setAttribute("message", message);
			return "redirect:MainPage.action";
		}
		
		System.out.println("\n==========[동호회 멤버 수락]==========");
		System.out.println("신청자_id = " + user_code_id);
		System.out.println("팀신청_id = " + team_apply_id);
		System.out.println("팀_id = " + team_id);
		System.out.println("============================================");
		
		// 동호회 정보 가져오기
		TeamDTO team = dao.getTeamInfo(team_id);
		
		// 임시/정식 동호회 확인
		if (team.getTeam_id() == 0) {
			
			// 임시동호회 멤버 추가
			dao.addtempTeamMember(team_apply_id);
			
			//알림 메시지 등록
			notification.setMessage(team.getTemp_team_name() + " 동호회 가입에 성공하셨습니다.");
			notification.setNotification_type_id(1);
			notificationDAO.addNotification(notification);
		}
		else if (team.getTeam_id() != 0) {
			
			// 정식동호회 멤버 추가
			dao.addteamMember(team_apply_id);
			
			
			//알림 메시지 등록
			notification.setMessage(team.getTemp_team_name() + " 동호회 가입에 성공하셨습니다.");
			notification.setNotification_type_id(1);
			notificationDAO.addNotification(notification);
		}
		
		return "redirect:/MemberAppr.action";
	}
	
	//동호회 회원 요청 취소
	@RequestMapping(value = "/CancelApply.action" , method = RequestMethod.GET)
	public String concelApply(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		Integer team_id = (Integer)session.getAttribute("team_id");
		
		int team_apply_id = Integer.parseInt(request.getParameter("team_apply_id"));
		
		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		INotificationDAO notificationDAO = sqlSession.getMapper(INotificationDAO.class);
		
		NotificationDTO notification = new NotificationDTO();
		
		TeamDTO team = teamDAO.getTeamInfo(team_id);
		
		// 정식/임시 동호회 확인
		if (team.getTeam_id() == 0) {
			
			int user_code_id = teamDAO.searchTempTeamApplyUser(team_apply_id).getUser_code_id();
			
			System.out.println("==============================[확인00]==============================");
			System.out.println("동호회 신청자 코드 = "+ user_code_id);
			System.out.println("====================================================================");
					
			teamDAO.canceledApplyTempTeam(team_apply_id);
			
			notification.setUser_code_id(user_code_id);
			notification.setNotification_type_id(1);
			//알림 메시지 등록
			notification.setMessage(team.getTemp_team_name() + " 동호회 승인이 취소되었습니다.");
			notificationDAO.addNotification(notification);
			
		}else if(team.getTeam_id() != 0) {
			
			int user_code_id = teamDAO.searchTempTeamApplyUser(team_apply_id).getUser_code_id();
			
			System.out.println("==============================[확인00]==============================");
			System.out.println("동호회 신청자 코드 = "+ user_code_id);
			System.out.println("====================================================================");
			
			teamDAO.canceledApplyTeam(team_apply_id);
			
			notification.setUser_code_id(user_code_id);
			notification.setNotification_type_id(1);
			//알림 메시지 등록
			notification.setMessage(team.getTemp_team_name() + " 동호회 승인이 취소되었습니다.");
			notificationDAO.addNotification(notification);
		}
		
		return "redirect:/MemberAppr.action";
	}
	
	//동호회 회원 강퇴
	@RequestMapping(value = "/DropMember.action" , method = RequestMethod.GET)
	public String dropMember(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		Integer temp_team_id = (Integer)session.getAttribute("team_id");
		int team_member_id =  Integer.parseInt(request.getParameter("team_member_id"));

		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		INotificationDAO notificationDAO = sqlSession.getMapper(INotificationDAO.class);
		
		NotificationDTO notification = new NotificationDTO();
		
		//팀정보
		TeamDTO team = teamDAO.getTeamInfo(temp_team_id);
		
		// 정식/임시 동호회 확인
		if (team.getTeam_id() == 0) {
			//동호회 회원 사용자 코드
			int user_code_id = teamDAO.searchTempTeamUeserCode(team_member_id).getUser_code_id();
			System.out.println("==============================[확인00]==============================");
			System.out.println("동호회 회원 사용자 코드 = "+ user_code_id);
			System.out.println("====================================================================");

			teamDAO.dropTempTeamMember(team_member_id);
			
			notification.setUser_code_id(user_code_id);
			notification.setNotification_type_id(1);
			//알림 메시지 등록
			notification.setMessage(team.getTemp_team_name() + " 동호회에서 강퇴되었습니다.");
			notificationDAO.addNotification(notification);
			
			
		}else if(team.getTeam_id() != 0) {
			
			
			
			//동호회 회원 사용자 코드
			int user_code_id = teamDAO.searchTeamUeserCode(team_member_id).getUser_code_id();
			System.out.println("==============================[확인00]==============================");
			System.out.println("동호회 회원 사용자 코드 = "+ user_code_id);
			System.out.println("====================================================================");

			teamDAO.dropTeamMember(team_member_id);
			
			notification.setUser_code_id(user_code_id);
			notification.setNotification_type_id(1);
			//알림 메시지 등록
			notification.setMessage(team.getTemp_team_name() + " 동호회에서 강퇴되었습니다.");
			notificationDAO.addNotification(notification);
		}
		
		return "redirect:/TeamMain.action";
	}
	
	// 동호회 정보 수정
	@RequestMapping(value = "/TeamUpdate.action", method = RequestMethod.GET)
	public String teamUpdate()
	{
		return "/team/TeamUpdate";
	}
	
	// 동호회 해체
	@RequestMapping(value = "/DisbandTeam.action", method = RequestMethod.POST)
	public String disbandTeam(HttpSession session, Model model) {
	    Integer temp_team_id = (Integer) session.getAttribute("team_id");
	    System.out.println("[DEBUG] disbandTeam 호출됨. session.team_id = " + temp_team_id);
	    
		// 동호회 정보 가져오기
		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		TeamDTO team = teamDAO.getTeamInfo(temp_team_id);
		
		INotificationDAO notificationDAO = sqlSession.getMapper(INotificationDAO.class);
		NotificationDTO notification = new NotificationDTO();
		
		int team_id = team.getTeam_id();
		
		// 동호회원 가져오기
		if (team_id == 0)
		{
			// 임시동호회 인원 찾기
			teamDAO.tempTempDrop(temp_team_id);
			String message = "SUCCESS_APPLY: 해체가 성공적으로 완료되었습니다.";
			session.setAttribute("message", message);
			
			team_id =temp_team_id;
			ArrayList<TeamApplyDTO> teamMemberList =  teamDAO.tempTeamMemberList(team_id);
			
			for (TeamApplyDTO teamMember : teamMemberList)
			{
				int user_code_id = teamMember.getUser_code_id();
				notification.setUser_code_id(user_code_id);
				notification.setNotification_type_id(1);
				//알림 메시지 등록
				notification.setMessage(team.getTemp_team_name() + " 동호회에서 강퇴되었습니다.");
				notificationDAO.addNotification(notification);
			}
			
			
		}
		else if (team_id != 0)
		{
			// 임시동호회 인원 찾기
			teamDAO.teamDrop(team_id);
			String message = "SUCCESS_APPLY: 해체가 성공적으로 완료되었습니다.";
			session.setAttribute("message", message);
			
			ArrayList<TeamApplyDTO> teamMemberList =  teamDAO.teamMemberList(team_id);
			
			for (TeamApplyDTO teamMember : teamMemberList)
			{
				int user_code_id = teamMember.getUser_code_id();
				notification.setUser_code_id(user_code_id);
				notification.setNotification_type_id(1);
				//알림 메시지 등록
				notification.setMessage(team.getTemp_team_name() + " 동호회에서 강퇴되었습니다.");
				notificationDAO.addNotification(notification);
			}
			
		}
		
	    return "redirect:/MainPage.action";
	}
}
