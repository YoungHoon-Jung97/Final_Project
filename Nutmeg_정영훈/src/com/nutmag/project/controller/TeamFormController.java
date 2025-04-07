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
import javax.servlet.jsp.PageContext;

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

import util.Path;

@Controller
public class TeamFormController
{
	@Autowired 
	private SqlSession sqlSession;
	
	// 메인 페이지
	@RequestMapping(value = "/MainPage.action",method=RequestMethod.GET)
	public String mainPage()
	{
		
	
		return "main/MainPage";
	};
	
	
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
	    IRegionDAO regionDao = sqlSession.getMapper(IRegionDAO.class);
	    ITeamDAO teamDao = sqlSession.getMapper(ITeamDAO.class);
	    
	    
	    ArrayList<CityDTO> cityList = new ArrayList<>();
	    if (region != 0) {
	        cityList = regionDao.cityList(region);
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
	
	
	//동호회 등록(파일 등록)
	@RequestMapping(value = "/TeamInsert.action", method = RequestMethod.POST)
	public String insertTeam(TeamDTO team, HttpServletRequest request) {
	    MultipartFile file = team.getTemp_team_emblem();
	    
	    System.out.println("===================================================================================================");
	    
	    System.out.println("파일 업로드 시작: " + (file != null ? file.getOriginalFilename() : "파일 없음"));
	    
	    // 파일이 있을 시
	    if (file != null && !file.isEmpty()) {
	        try {
	        	
	        	 // 디버그 코드
		        System.out.println("======= [DEBUG] 폼 파라미터 로그 =======");
		        
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
		        else
		        {
		            System.out.println("stadiumDTO is null");
		        }

		        System.out.println("======= 파일 업로드 상태 =======");
		        if (file != null)
		        {
		            System.out.println("파일 비어 있음? : " + file.isEmpty());
		            System.out.println("파일 원래 이름 : " + file.getOriginalFilename());
		        }
		        else
		        {
		            System.out.println("uploadFile is null");
		        }
	        	
	        	
	        	
	            // 웹 애플리케이션 루트 경로 가져오기
	            String root = request.getServletContext().getRealPath("");
	            
	            // 업로드 디렉토리 경로
	            String uploadDir = Path.getUploadEmblemDir();
	            
	            // 전체 업로드 경로 생성
	            String uploadPath = root + uploadDir;
	            if (!uploadDir.endsWith(File.separator)) {
	                uploadPath = root + uploadDir + File.separator;
	            }
	            
	            File uploadDirFile = new File(uploadPath);
	            // 파일 경로 없을 시 폴더 생성
	            if (!uploadDirFile.exists()) {
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
	            if (!uploadDir.endsWith("/") && !uploadDir.endsWith("\\")) {
	                dbFilePath += "/";
	            }
	            dbFilePath += teamFileName;
	            
	            System.out.println("/n=====[파일 업로드]=====");
	            System.out.println("전체 업로드 경로: " + uploadPath);
	            System.out.println("설정된 업로드 경로: " + uploadDir);
	            System.out.println("DB에 저장할 파일 경로: " + dbFilePath);
	            
	            team.setEmblem(dbFilePath);
	        } catch (Exception e) {
	            System.out.println("파일 저장 중 오류 발생:");
	            e.printStackTrace();
	        }
	    }
	    else {
	    	team.setEmblem("/");
	    }
	    try {
	        ITeamDAO dao = sqlSession.getMapper(ITeamDAO.class);
	        dao.teamInsert(team);
	        System.out.println("DB 저장 완료");
	    } catch (Exception e) {
	        System.out.println("DB 저장 중 오류 발생:");
	        e.printStackTrace();
	    }
	    System.out.println("===================================================================================================");
	    
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
