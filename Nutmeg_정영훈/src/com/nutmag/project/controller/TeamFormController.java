package com.nutmag.project.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

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
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nutmag.project.dao.IBankDAO;
import com.nutmag.project.dao.IRegionDAO;
import com.nutmag.project.dao.ITeamDAO;
import com.nutmag.project.dao.IUserDAO;
import com.nutmag.project.dto.CityDTO;
import com.nutmag.project.dto.TeamDTO;
import com.nutmag.project.dto.UserDTO;

import util.Emblem;

@Controller
public class TeamFormController
{
	@Autowired 
	private SqlSession sqlSession;
	
	//동호회 개설 페이지 호출
	@RequestMapping(value="/TempOpen.action", method = RequestMethod.GET)
	public String createTeam(Model model, HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		
		if (session.getAttribute("user_email") == null)		//로그인 안되어 있을 경우
		{
			return "redirect:Login.action";
		}
		
		IBankDAO bankDAO = sqlSession.getMapper(IBankDAO.class);
		IRegionDAO regionDAO = sqlSession.getMapper(IRegionDAO.class);
		
		model.addAttribute("bankList", bankDAO.bankList());
		model.addAttribute("regionList", regionDAO.regionList());
		
		return "/team/TeamOpen";
	}
	
	//구 선택지 리스트
	@RequestMapping(value="/SearchCity.action", method = RequestMethod.GET)
	@ResponseBody
	public void getCityList(@RequestParam("region") int region, HttpServletResponse response) throws IOException {
	    IRegionDAO dao = sqlSession.getMapper(IRegionDAO.class);
	    
	    ArrayList<CityDTO> cityList = new ArrayList<>();
	    if (region != 0) {
	        cityList = dao.cityList(region);
	    }

	    // JSON 응답 설정
	    response.setContentType("application/json; charset=UTF-8");
	    PrintWriter out = response.getWriter();

	    // Jackson을 사용하여 객체를 JSON 문자열로 변환
	    ObjectMapper objectMapper = new ObjectMapper();
	    String json = objectMapper.writeValueAsString(cityList);
	    out.print(json);
	    out.flush();
	}
	
	//동호회 이름 중복검사
	@RequestMapping(value="/CheckTeamName.action", method = RequestMethod.GET)
	public void checkEmail(@RequestParam("teamName") String teamName, HttpServletResponse response) throws IOException {
	    
	    ITeamDAO dao = sqlSession.getMapper(ITeamDAO.class);

	    String searchTeamName = dao.searchTeamName(teamName);
	    
	    response.setCharacterEncoding("UTF-8");
	    response.setContentType("text/plain;charset=UTF-8");
	    
	    //이메일을 아무것도 안적었을 경우
	    if(searchTeamName==null || searchTeamName.isEmpty()) {
	    	
	    	response.getWriter().write("사용 가능한 팀네임 입니다.");

	    }
	    else {
	        response.getWriter().write("이미 사용중인 팀네임 입니다.");
	    }
	}
	
	
	//동호회 등록
	@RequestMapping(value = "/TeamInsert.action", method = RequestMethod.POST)
	public String insertTeam(TeamDTO team ,HttpServletRequest request){
		System.out.println("파일 경로 : "+ 1);
		
		MultipartFile file = team.getTemp_team_emblem();
		
		//파일이 있을 시
		if(file !=null && !file.isEmpty()) {
			try {
				//웹 애플리케이션 루트 경로 가져오기
				String root = request.getServletContext().getRealPath("");
				
				//업로드 디렉토리 생성
				String uploadPath = root + Emblem.getUploadDir();
				File uploadDir = new File(uploadPath);
				//파일 경로 없을 시 폴더 생성
				if(!uploadDir.exists()) {
					uploadDir.mkdirs();
				}
				
				//파일명 충동 방지를 위한 고유 파일명 생성
				String originalFileName = file.getOriginalFilename();
				String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				String teamFileName = team.getTemp_team_name()+fileExtension;
				
				//파일 저장
				String filePath = uploadPath + teamFileName;
				File dest = new File(filePath);
				file.transferTo(dest);
				
				//DB에 저장할 상대 경로 설정
				String dbFilePath = Emblem.getUploadDir() + teamFileName;
				
				System.out.println("파일 경로 : "+ dbFilePath);
				
				team.setEmblem(dbFilePath);
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}
		
		ITeamDAO dao = sqlSession.getMapper(ITeamDAO.class);
		
		dao.teamInsert(team);
		
		return "redirect:/MainPage.action";
	}

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
