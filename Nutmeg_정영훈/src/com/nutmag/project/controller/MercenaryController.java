package com.nutmag.project.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nutmag.project.dao.IFieldDAO;
import com.nutmag.project.dao.IMercenaryDAO;
import com.nutmag.project.dao.INotificationDAO;
import com.nutmag.project.dao.IPositionDAO;
import com.nutmag.project.dao.IRegionDAO;
import com.nutmag.project.dao.ITeamDAO;
import com.nutmag.project.dto.FieldResMainPageDTO;
import com.nutmag.project.dto.MatchDTO;
import com.nutmag.project.dto.MercenaryDTO;
import com.nutmag.project.dto.NotificationDTO;
import com.nutmag.project.dto.PositionDTO;
import com.nutmag.project.dto.RegionDTO;
import com.nutmag.project.dto.TeamDTO;

@Controller
public class MercenaryController
{
	@Autowired
	private SqlSession sqlSession;
    
	//용병 등록
    @RequestMapping(value = "/MercenaryInsert.action", method = RequestMethod.POST)
    public String insertMercenary(MercenaryDTO dto,HttpServletRequest request,Model model)
    {
		HttpSession session = request.getSession();
		
		IMercenaryDAO mercenaryDAO = sqlSession.getMapper(IMercenaryDAO.class);
		
		Integer  user_code_id = (Integer)session.getAttribute("user_code_id");
		dto.setUser_code_id(user_code_id);
		
		String message = "SUCCESS_INSERT: 용병등록이 되었습니다.";
		session.setAttribute("message", message);
		
		mercenaryDAO.insertMercenary(dto);
        return "redirect:/MainPage.action";
    }
    
    //용병 등록폼 호출
    @RequestMapping(value = "/MercenaryInsertForm.action", method = RequestMethod.GET)
    public String insertFromMercenary(HttpServletRequest request,Model model)
    {
		HttpSession session = request.getSession();
		
		Integer  user_code_id = (Integer)session.getAttribute("user_code_id");
		
		//용병 가입 확인 
        IMercenaryDAO mercenaryDAO = sqlSession.getMapper(IMercenaryDAO.class);
        if (mercenaryDAO.checkedMercenary(user_code_id) >0) {
        	String message = "ERROR_AUTH_REQUIRED: 이미 용병에 등록되어 있습니다.";
            session.setAttribute("message", message);
            return "redirect:MainPage.action";
		} 
        
        // 포지션 정보 가져오기
        IPositionDAO positionDAO = sqlSession.getMapper(IPositionDAO.class);        
        IRegionDAO regionDAO = sqlSession.getMapper(IRegionDAO.class);
        
        ArrayList<RegionDTO> regionList = regionDAO.regionList();
        ArrayList<PositionDTO> positionList = positionDAO.positionList();
        
        /* 디버깅 코드
        System.out.println("===================확인[00]===================");
        for (PositionDTO positionDTO : positionList) {
			System.out.println("포지션 번호 = "+positionDTO.getPosition_id());
			System.out.println("포지션 이름 = "+positionDTO.getPosition_name());
		}
        System.out.println("==============================================");
        
        System.out.println("===================확인[001]===================");
        for (RegionDTO regionDTO : regionList) {
			System.out.println("지역 번호 = "+regionDTO.getRegion_id());
			System.out.println("지역 이름 = "+regionDTO.getRegion_name());
		}
        System.out.println("==============================================");
         */
        
        model.addAttribute("regionList", regionList);
        model.addAttribute("positionList", positionList);
        
        
        return "/mercenary/MercenaryInsertForm";
    }
    

    //용병 게시판 호출
    @RequestMapping("/MercenaryOffer.action")
    public String mercenaryList(Model model, HttpServletRequest request, 
                               @RequestParam(required = false) String searchDate)
    {
        HttpSession session = request.getSession();      
       
        Integer user_code_id = (Integer)session.getAttribute("user_code_id");
        Integer temp_team_id = (Integer)session.getAttribute("team_id");
        
        // 로그인 여부
		if (user_code_id == -1)
		{
			String message = "ERROR_AUTH_REQUIRED: 로그인을 해야 합니다.";
			session.setAttribute("message", message);
			return "redirect:MainPage.action";
		}
		
		IMercenaryDAO mercenaryDAO = sqlSession.getMapper(IMercenaryDAO.class);
		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		
		TeamDTO team =teamDAO.getTeamInfo(temp_team_id);
		int team_id = team.getTeam_id();
		
		
		ArrayList<MatchDTO> teamMatchList =mercenaryDAO.searchTeamMatch(team_id);
		
        // 날짜 처리
        String time;
        if (searchDate != null && !searchDate.isEmpty()) {
            // 사용자가 검색 날짜를 지정한 경우 해당 날짜의 12시(정오)로 설정
            time = searchDate + " 12:00:00";
        } else {
            // 지금 시간
            LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            time = now.format(formatter);
        }
        
        List<MercenaryDTO> mercenaryList = mercenaryDAO.searchTimeMercenary(time); 
        
        // 포지션 정보 가져오기
        IPositionDAO positionDAO = sqlSession.getMapper(IPositionDAO.class);        
        IRegionDAO regionDAO = sqlSession.getMapper(IRegionDAO.class);
        
        model.addAttribute("teamMatchList", teamMatchList);
        model.addAttribute("regionList", regionDAO.regionList());
        model.addAttribute("positionList", positionDAO.positionList());
        model.addAttribute("mercenaryList", mercenaryList);
        
        return "mercenary/MercenaryOffer";
    }
	
    //용병 시간 업데이트
    @RequestMapping("/MercenaryTimeUpdate.action")
    public String mercenaryTimeUpdate(MercenaryDTO mercenary,Model model, HttpServletRequest request)
    {
    	HttpSession session = request.getSession();
    	String message ="";
    	Integer  user_code_id = (Integer)session.getAttribute("user_code_id");
    	
    	//용병 가입 확인 
        IMercenaryDAO mercenaryDAO = sqlSession.getMapper(IMercenaryDAO.class);
        int mercenaryCode = mercenaryDAO.checkedMercenary(user_code_id);
        
        mercenary.setMercenary_id(mercenaryCode);
        if (mercenaryCode == 0 ) {
        	message = "ERROR_AUTH_REQUIRED: 용병 등록이 안되어있습니다.";
            session.setAttribute("message", message);
            return "redirect:MainPage.action";
		} 
        
        mercenaryDAO.updateMercenaryTime(mercenary);
        
        message = "SUCCESS_INSERT: 시간이 변경 되었습니다.";
		session.setAttribute("message", message);
    	
    	return "redirect:/MainPage.action";
    }
    
    //용병 지역 검색
    @RequestMapping(value ="/SearchMercenary.action", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public List<MercenaryDTO> searchRegionMercenary(Model model, 
            @RequestParam(value = "region_name", required = false) String regionName,
            @RequestParam(value = "city_name", required = false) String cityName,
            @RequestParam(value = "time", required = false) String time)
    {
        Map<String, Object> params = new HashMap<>();
        if (regionName != null && !regionName.isEmpty()) params.put("region_name", regionName);
        if (cityName != null && !cityName.isEmpty()) params.put("city_name", cityName);
        if (time != null && !time.isEmpty()) params.put("time", time);
        
        IMercenaryDAO dao = sqlSession.getMapper(IMercenaryDAO.class);
        ArrayList<MercenaryDTO> mercenaryList = dao.searchMercenary(params);
        System.out.println("======================확인[00]=====================");
        System.out.println("regionName : " +regionName);
        System.out.println("cityName : "+ cityName);
        System.out.println("time : "+ time);
        System.out.println("params: " + params); 
        System.out.println("반환 값 : " +mercenaryList.size());
        System.out.println("===================================================");
        
       
        return mercenaryList;
    }
    
    
    //용병 고용 메시지
    @RequestMapping(value ="/SendMercenary.action", method = RequestMethod.GET,
	produces = "application/json")
	public String sendMercenary(MercenaryDTO mercenary,HttpServletRequest request){
	  
    	HttpSession session = request.getSession();
    	String message ="";
    	Integer temp_team_id = (Integer)session.getAttribute("team_id");
    	
    	ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
    	IMercenaryDAO mercenaryDAO = sqlSession.getMapper(IMercenaryDAO.class);
    	
    	int mercenary_id = mercenary.getMercenary_id();
    	
    	MercenaryDTO userMercenary = mercenaryDAO.searchUsercode(mercenary_id);
		TeamDTO team =teamDAO.getTeamInfo(temp_team_id);
		int team_id = team.getTeam_id();
		
		//용병 사용자 코드
		int user_code_id = userMercenary.getUser_code_id();
		
		System.out.println("====================용병 사용자 코드 확인======================");
		System.out.println("user_code_id = " + user_code_id);
		System.out.println("=================================================");
		
		INotificationDAO notificationDAO = sqlSession.getMapper(INotificationDAO.class);
		NotificationDTO notification = new NotificationDTO();
		
		notification.setUser_code_id(user_code_id);
		notification.setNotification_type_id(3);
		//알림 메시지 등록
		notification.setMessage(team.getTemp_team_name() + " 동호회에서 용병신청이 왔습니다.");
		notificationDAO.addNotification(notification);
		
		mercenary.setTeam_id(team_id);
		System.out.println("====================확인======================");
		System.out.println("FIELD_RES_ID = " + mercenary.getField_res_id());
		System.out.println("MERCENARY_ID = " + mercenary_id);
		System.out.println("TEAM_ID = " + mercenary.getTeam_id());
		System.out.println("=================================================");
		
		mercenaryDAO.sendMercenary(mercenary);
    	
		message = "SUCCESS_INSERT: 용병 신청이 완료되었습니다.";
		session.setAttribute("message", message);
		return "redirect:MercenaryOffer.action";
	 
	}
    
    //용병 응답
    @RequestMapping(value ="/MercenaryResponse.action", method = RequestMethod.GET, produces = "application/json")
  
    public String mercenaryResponse(Model model,HttpServletRequest request ,MercenaryDTO mercenary)
    {
    	HttpSession session = request.getSession();
        
        IMercenaryDAO mercenaryDAO = sqlSession.getMapper(IMercenaryDAO.class);
       
    	mercenaryDAO.mercenaryResponse(mercenary);
    	
        return "redirect:UserMercenary.action";
    }
	
    
    

}
    
   
