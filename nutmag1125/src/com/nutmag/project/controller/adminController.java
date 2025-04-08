package com.nutmag.project.controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class adminController
{
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/AdminSignUp.action",method=RequestMethod.GET)
	public String adminSignUp()
	{
		String result ="";
		
		
		result = "/admin/AdminSignUp";
		return result;
	};
	
	
	
	

	
	
}
