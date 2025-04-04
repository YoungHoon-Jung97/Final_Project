package com.project.info.mapper;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.info.IUserDAO;
import com.project.info.UserDTO;

@Controller
public class UserController
{


	@Autowired 
	private SqlSession sqlSession;

	
	@RequestMapping(value = "/MainPage.action",method=RequestMethod.GET)
	public String mainPage()
	{
		String result ="";
		
		
		result = "/WEB-INF/view/MainPage.jsp";
		return result;
	};
	

	@RequestMapping(value = "/UserSignupForm.action",method=RequestMethod.GET)
	public String userSignupForm()
	{
		String result ="";
		
		
		result = "/WEB-INF/view/UserSignupForm.jsp";
		return result;
	};
	
	
	@RequestMapping(value = "/UserInsert.action", method=RequestMethod.POST)
	public String userInsert(UserDTO user)
	{
		String result = null;
		
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		
		dao.userInsert(user);
		
		result = "redirect:MainPage.action";
		return result;
	};
	
	
}
