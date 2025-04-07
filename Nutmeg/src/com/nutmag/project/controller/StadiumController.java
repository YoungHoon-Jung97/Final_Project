package com.nutmag.project.controller;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.nutmag.project.dao.IStadiumDAO;
import com.nutmag.project.dto.FieldEnvironmentDTO;
import com.nutmag.project.dto.FieldTypeDTO;
import com.nutmag.project.dto.StadiumRegInsertDTO;

import util.Path;



@Controller
public class StadiumController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/FieldRegInsertForm.action", method = RequestMethod.GET)
	public String fieldInsertForm(Model model,FieldTypeDTO fieldType, FieldEnvironmentDTO environment) throws SQLException
	{
		String result =null;
		
		IStadiumDAO fieldDAO = sqlSession.getMapper(IStadiumDAO.class);
		
		/*
		System.out.println(">>> fieldTypeList() 호출 시작"); List<FieldTypeDTO> list =
		fieldDAO.fieldTypeList(); System.out.println(">>> fieldTypeList() 호출 완료");
		 
		System.out.println(">>> fieldDAO: " + fieldDAO);
		  
		System.out.println(">> field_type_list size: " + list.size());
		 
		System.out.println(">> field_type_list 조회 결과:"); for (FieldTypeDTO dto :
		fieldDAO.fieldTypeList()) { System.out.println("ID: " +
		dto.getField_type_id() + ", NAME: " + dto.getField_type()); }
		*/	 
		
		model.addAttribute("fieldTypeList", fieldDAO.fieldTypeList());
		model.addAttribute("fieldEnviromentList", fieldDAO.fieldEnviromentList());
		
		result = "/stadium/FieldRegInsertForm";
		return result;
	}
	
	// 구장 인서트 폼
	@RequestMapping(value = "/StadiumRegInsertForm.action", method = RequestMethod.GET)
	public String stadiumInsertForm(Model model) throws SQLException
	{
		String result =null;
		
		IStadiumDAO stadiumDAO = sqlSession.getMapper(IStadiumDAO.class);
		
		
		
		model.addAttribute("stadiumTimeList", stadiumDAO.stadiumTimeList());
		
		result = "/stadium/StadiumRegInsertForm";
		return result;
	}
	
	// 이미지 바인딩 예외 처리
	@InitBinder
	protected void initBinder(WebDataBinder binder)
	{
	    binder.setDisallowedFields("stadium_reg_image");
	}
	
	// 구장 등록
	@RequestMapping(value = "/StadiumRegInsert.action", method = RequestMethod.POST)
	public String stadiumInsert(StadiumRegInsertDTO stadiumDTO,
	                            @RequestParam("stadium_reg_image") MultipartFile uploadFile,
	                            HttpServletRequest request,
	                            Model model) throws SQLException
	{
	    String result = null;

	    try
	    {
	        // 디버그 코드
	        System.out.println("======= [DEBUG] 폼 파라미터 로그 =======");
	        
	        if (stadiumDTO != null)
	        {
	            System.out.println("stadium_reg_name = " + stadiumDTO.getStadium_reg_name());
	            System.out.println("stadium_reg_postal_addr = " + stadiumDTO.getStadium_reg_postal_addr());
	            System.out.println("stadium_reg_addr = " + stadiumDTO.getStadium_reg_addr());
	            System.out.println("stadium_reg_detailed_addr = " + stadiumDTO.getStadium_reg_detailed_addr());
	            System.out.println("user_code_id = " + stadiumDTO.getUser_code_id());
	            System.out.println("stadium_time_id1 = " + stadiumDTO.getStadium_time_id1());
	            System.out.println("stadium_time_id2 = " + stadiumDTO.getStadium_time_id2());
	        }
	        else
	        {
	            System.out.println("stadiumDTO is null");
	        }

	        System.out.println("======= 파일 업로드 상태 =======");
	        if (uploadFile != null)
	        {
	            System.out.println("파일 비어 있음? : " + uploadFile.isEmpty());
	            System.out.println("파일 원래 이름 : " + uploadFile.getOriginalFilename());
	        }
	        else
	        {
	            System.out.println("uploadFile is null");
	        }

	        String root = request.getServletContext().getRealPath("");
	        // 1. 업로드 경로 설정
			String uploadPath = root + Path.getUploadStadiumDir();
			File uploadDir = new File(uploadPath);
			//파일 경로 없을 시 폴더 생성
			if(!uploadDir.exists()) {
				uploadDir.mkdirs();
			}
	        
	        // 2. 파일 저장
	        if (uploadFile != null && !uploadFile.isEmpty())
	        {
	        	
	            String originalFileName = uploadFile.getOriginalFilename();
	            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
	            String savedFileName = stadiumDTO.getStadium_reg_name() + "_" + System.currentTimeMillis() + fileExtension;
	            File saveFile = new File(uploadPath, savedFileName);
	            uploadFile.transferTo(saveFile);
	            
	           
	            String fileWebPath = Path.getUploadStadiumDir() + savedFileName;
	            stadiumDTO.setStadium_reg_image(fileWebPath);
	            // 디버그
	            
	            System.out.println("/n=====[파일 경로]=====");
	            System.out.println("파일 저장 경로 (uploadPath) : " + uploadPath);
	            System.out.println("파일 이름 (savedFileName) : " + savedFileName);
	            System.out.println("데이터 베이스에 저장된 경고(fileWebPath) : "+fileWebPath);
	        }

	        // 3. DB 저장
	        IStadiumDAO stadiumDAO = sqlSession.getMapper(IStadiumDAO.class);
	        int row = stadiumDAO.stadiumInsert(stadiumDTO);
	       
	        
	        // 4. 결과 처리
	        if (row > 0)
	        {
	            result = "redirect:/StadiumRegInsertForm.action";
	        }
	        else
	        {
	        	/*
	            model.addAttribute("message", "등록에 실패했습니다.");
	            result = "error";
	            */
	        	System.out.println("오류 발생");
	        }
	    }
	    catch (Exception e)
	    {
	    	/*
	        model.addAttribute("message", "오류 발생: " + e.toString());
	        result = "error";
	        */
	    	System.out.println(e.toString());
	    }

	    return result;
	}
	
	// 구장 리스트 불러오기
	@RequestMapping("/StadiumList.action")
	public String stadiumList(Model model) 
	{
		String result = null;
	    
		IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class);
		ArrayList<StadiumRegInsertDTO> list = dao.stadiumList();
	    
	    model.addAttribute("stadiumList", list);
	    
	    result = "/stadium/StadiumList";
	    return result;
	}
	
	// 중복 확인용
	@RequestMapping(value = "/CheckStadiumName.action", method = RequestMethod.GET)
	@ResponseBody
	public String checkStadiumName(@RequestParam("stadium_reg_name") String name) throws SQLException 
	{
		String result = null;
	   
		IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class);
	    int count = dao.stadiumNameCheck(name);
	   
	    result = (count > 0) ? "duplicate" : "available";
	    return result;
	}
	
	
}