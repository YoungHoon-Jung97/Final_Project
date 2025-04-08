package com.nutmag.project.controller;

import java.sql.SQLException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nutmag.project.dao.IFieldDAO;
import com.nutmag.project.dao.IStadiumDAO;
import com.nutmag.project.dto.FieldEnvironmentDTO;
import com.nutmag.project.dto.FieldTypeDTO;
import com.nutmag.project.dto.StadiumRegInsertDTO;



@Controller
public class StadiumController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/FieldRegInsertForm.action", method = RequestMethod.GET)
	public String fieldInsert(Model model,FieldTypeDTO fieldType, FieldEnvironmentDTO environment) throws SQLException
	{
		String result =null;
		
		IFieldDAO fieldDAO = sqlSession.getMapper(IFieldDAO.class);
		
		/* 디버그
		 * System.out.println(">>> fieldTypeList() 호출 시작"); List<FieldTypeDTO> list =
		 * fieldDAO.fieldTypeList(); System.out.println(">>> fieldTypeList() 호출 완료");
		 * 
		 * System.out.println(">>> fieldDAO: " + fieldDAO);
		 * 
		 * System.out.println(">> field_type_list size: " + list.size());
		 * 
		 * System.out.println(">> field_type_list 조회 결과:"); for (FieldTypeDTO dto :
		 * fieldDAO.fieldTypeList()) { System.out.println("ID: " +
		 * dto.getField_type_id() + ", NAME: " + dto.getField_type()); }
		 */
		
		model.addAttribute("fieldTypeList", fieldDAO.fieldTypeList());
		model.addAttribute("fieldEnviromentList", fieldDAO.fieldEnviromentList());
		
		result = "/stadium/FieldRegInsertForm";
		return result;
	}
	@RequestMapping(value="/stadiumRegInsert.action", method = RequestMethod.GET)
		public String stadiuminsert() {
			return "/main/MainPage.action";
	}

	
	
}
