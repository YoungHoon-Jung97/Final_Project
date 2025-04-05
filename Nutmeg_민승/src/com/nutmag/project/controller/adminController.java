package com.nutmag.project.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.nutmag.project.dao.IAdminDAO;
import com.nutmag.project.dto.AdminDTO;


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
	
	//관리자 회원가입 이메일 중복검사
	@RequestMapping(value="/AdminCheckEmail.action", method = RequestMethod.GET)
	public void checkEmail(@RequestParam("email") String email, HttpServletResponse response) throws IOException {
	    
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
	    int count = dao.searchEmail(email);
	    
	    response.setCharacterEncoding("UTF-8");
	    response.setContentType("text/plain;charset=UTF-8");
	    
	    //이메일을 아무것도 안적었을 경우
	    if(email.equals("") || email.isEmpty()) {
	    	
	    	//error 발생
	    	response.setStatus(HttpServletResponse.SC_NOT_FOUND);

	    }
	    
	    if (count >0) {
	        response.getWriter().write("이미 사용중인 이메일 입니다.");
	    }
	    else {
	        response.getWriter().write("사용 가능한 이메일 입니다.");
	    }
	}
	
	//관리자 회원가입 닉네임 중복검사
	@RequestMapping(value="/AdminCheckNickName.action", method = RequestMethod.GET)
	public void checkNickName(@RequestParam("nickName") String nickName,HttpServletResponse response) throws IOException{
		
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
		int count =dao.searchnickName(nickName);
		
		response.setCharacterEncoding("UTF-8");
	    response.setContentType("text/plain;charset=UTF-8");
		
		  //닉네임을 아무것도 안적었을 경우
	    if(nickName.equals("") || nickName.isEmpty()) {
	    	
	    	//error 발생
	    	response.setStatus(HttpServletResponse.SC_NOT_FOUND);

	    }
	    
	    if (count >0) {
	        response.getWriter().write("이미 사용중인 닉네임 입니다.");
	    }
	    else {
	        response.getWriter().write("사용 가능한 닉네임 입니다.");
	    }
		
	}
	
	
	

	
	
}
