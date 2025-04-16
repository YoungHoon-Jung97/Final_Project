package com.nutmag.project.controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nutmag.project.dao.IMatchDAO;

@Controller
public class MatchController
{
	@Autowired
	private SqlSession sqlSession;
    
	
	@RequestMapping(value ="/Match.action", method = RequestMethod.GET )
	public String matchMainPage(Model model)
	{
		String result = null;
		
		IMatchDAO dao = sqlSession.getMapper(IMatchDAO.class);
		
		model.addAttribute("matchRoomList", dao.matchRoomList());
		
		result = "/main/test123";
		return result;
	}
    

}
    
   
