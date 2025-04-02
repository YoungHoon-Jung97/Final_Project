package com.project.mvc;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class UserController
{
	@RequestMapping(value = "/MainPage.action",method=RequestMethod.GET)
	public String mainPage()
	{
		String result ="";
		
		
		result = "/WEB-INF/view/MainPage";
		return result;
	};
	
	
	
	@RequestMapping(value = "/UserInsert.action",method=RequestMethod.GET)
	public String userInsert()
	{
		String result ="";
		
		
		result = "redirect:MainPage.action";
		return result;
	};
	
	
}
