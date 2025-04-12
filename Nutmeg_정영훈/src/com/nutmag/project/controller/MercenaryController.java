package com.nutmag.project.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
import org.springframework.web.bind.annotation.RequestParam;

import com.nutmag.project.dao.IMercenaryDAO;
import com.nutmag.project.dao.IPositionDAO;
import com.nutmag.project.dao.IRegionDAO;
import com.nutmag.project.dto.MercenaryDTO;
import com.nutmag.project.dto.PositionDTO;

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
		
		mercenaryDAO.insertMercenary(dto);
        return "redirect:/MainPage.action";
    }
    

    //용병 게시판 호출
    @RequestMapping("/MercenaryOffer.action")
    public String mercenaryList(Model model, HttpServletRequest request, 
                               @RequestParam(required = false) String searchDate)
    {
        HttpSession session = request.getSession();
        
        // 로그인 여부 체크
        Integer user_code_id = (Integer)session.getAttribute("user_code_id");
        if(user_code_id == null || user_code_id < 0) {
            String message = "로그인을 해야 합니다.";
            model.addAttribute("message", message);
            return "redirect:MainPage.action";
        }
        
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
        
        IMercenaryDAO mercenaryDAO = sqlSession.getMapper(IMercenaryDAO.class);
        List<MercenaryDTO> mercenaryList = mercenaryDAO.mercenaryList(time); 
        
        // 포지션 정보 가져오기
        IPositionDAO positionDAO = sqlSession.getMapper(IPositionDAO.class);        
        IRegionDAO regionDAO = sqlSession.getMapper(IRegionDAO.class);
        
        model.addAttribute("regionList", regionDAO.regionList());
        model.addAttribute("positionList", positionDAO.positionList());
        model.addAttribute("mercenaryList", mercenaryList);
        
        return "/MercenaryOffer";
    }
	
}
    
   
