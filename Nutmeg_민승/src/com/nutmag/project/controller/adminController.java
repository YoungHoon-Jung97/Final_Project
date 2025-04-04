package com.nutmag.project.controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class AdminController
{
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/AdminInsert.action",method=RequestMethod.GET)
	public String AdminInsert()
	{
		String result ="";
		
		
		result = "/admin/AdminInsertForm";
		return result;
	};
	
	
	
	

	
	
}
