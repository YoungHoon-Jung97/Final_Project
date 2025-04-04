package com.test.what.mapper;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.test.what.*;

@Controller
public class UserInfoController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/hello.action", method = RequestMethod.GET)
	public String hello()
	{
		String result = "";
		
		result = "/WEB-INF/view/TeamInfo.jsp";
		
		return result;
	};
	
	@RequestMapping(value = "/temp.action", method = RequestMethod.GET)
	public String temp()
	{
		String result = "";
		
		result = "/WEB-INF/view/TeamAll.jsp";
		
		return result;
	};
	@RequestMapping(value = "/insert.action", method = RequestMethod.GET)
	public String insert(Model model)
	{
		String result = "";
		
		IRegionDAO dao = sqlSession.getMapper(IRegionDAO.class);
		
		
		model.addAttribute("regionList", dao.regionList());
		
		result = "/WEB-INF/view/OpenTeam.jsp";
		
		return result;
	};
	
}
