package com.nutmag.project.controller;

import java.io.File;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import com.nutmag.project.dao.IFieldDAO;
import com.nutmag.project.dao.IRegionDAO;
import com.nutmag.project.dao.IStadiumDAO;
import com.nutmag.project.dao.ITeamDAO;
import com.nutmag.project.dto.CityDTO;
import com.nutmag.project.dto.FieldEnvironmentDTO;
import com.nutmag.project.dto.FieldRegInsertDTO;
import com.nutmag.project.dto.FieldRegSearchDTO;
import com.nutmag.project.dto.FieldResMainPageDTO;
import com.nutmag.project.dto.FieldTypeDTO;
import com.nutmag.project.dto.StadiumHolidayInsertDTO;
import com.nutmag.project.dto.StadiumRegInsertDTO;

import util.Path;



@Controller
public class StadiumController
{
	@Autowired
	private SqlSession sqlSession;
	
	
	// 구장 인서트 폼
	@RequestMapping(value = "/StadiumRegInsertForm.action", method = RequestMethod.GET)
	public String stadiumInsertForm(Model model, HttpServletRequest request, HttpServletResponse response) throws SQLException
	{
		String result =null;
		
		
		IStadiumDAO stadiumDAO = sqlSession.getMapper(IStadiumDAO.class);
		
		String message= "";
		HttpSession session = request.getSession();
		Integer user_code_id = (Integer)session.getAttribute("user_code_id");
		Integer operator_id = (Integer)session.getAttribute("operator_id");
		
		// 로그인 여부
		if(user_code_id == null) {
			message = "로그인을 해야 합니다.";
			model.addAttribute("message", message);
			return "redirect:MainPage.action";
		}
		
		// 구장 운영자 여부
		if(operator_id == null) {
			message = "구장 운영자 가입을 해야 합니다.";
			model.addAttribute("message", message);
			return "redirect:MainPage.action";
		}
		
		
		
		model.addAttribute("stadiumTimeList", stadiumDAO.stadiumTimeList());
		model.addAttribute("message", message);
		
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
	                            HttpServletRequest request, HttpServletResponse response,HttpSession session,
	                            Model model) throws SQLException
	{
	    String result = null;
	    String message= "";
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
	            System.out.println("데이터 베이스에 저장된 경로(fileWebPath) : "+fileWebPath);
	        }

	        // 3. DB 저장
	        IStadiumDAO stadiumDAO = sqlSession.getMapper(IStadiumDAO.class);
	        int row = stadiumDAO.stadiumInsert(stadiumDTO);
	       
	        
	        // 4. 결과 처리
	        if (row > 0)
	        {
	        	message = "구장 개설이 완료 되었습니다.";
	        	model.addAttribute("message",message);
	            result = "redirect:MainPage.action";
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
	    	//System.out.println(e.toString());
	    	e.printStackTrace();
	    }

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
	
	// 구장 리스트 불러오기
	@RequestMapping("/StadiumList.action")
	public String stadiumList(Model model) 
	{
		String result = null;
	    
		IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class);
		ArrayList<StadiumRegInsertDTO> list = dao.stadiumAllList();
	    
	    model.addAttribute("stadiumAllList", list);
	    
	    result = "/stadium/StadiumList";
	    return result;
	}
	
	// 구장 전체 리스트 확인용 폼
	@RequestMapping("/StadiumListForm.action")
	public String stadiumListForm(Model model,HttpServletRequest request, HttpServletResponse response)
	{
		String result = null;
	    HttpSession session = request.getSession();
		
	    IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class);
	    
	    String message= "";
		Integer user_code_id = (Integer)session.getAttribute("user_code_id");
		
		// 로그인 여부
		if(user_code_id == null) {
			message = "로그인을 해야 합니다.";
			model.addAttribute("message", message);
			return "redirect:MainPage.action";
		}
		
		// 카운트 메소드 결과 확인용
		// 결과값 없으면 0으로 반환
		//System.out.println(dao.stadiumSearchCount(user_code_id));
		
		if (dao.stadiumSearchCount(user_code_id)==0)
		{
			message = "구장을 먼저 등록해야 합니다.";
			model.addAttribute("message", message);
			return "redirect:MainPage.action";
		};
	    
	    
		ArrayList<StadiumRegInsertDTO> list = dao.stadiumSearchList(user_code_id);
		int count = dao.stadiumSearchCount(user_code_id);
		
		model.addAttribute("stadiumCount",count);
	    model.addAttribute("stadiumSearchList", list);
	    
	    result = "/stadium/StadiumListForm";
	    return result;
	    
	}
	
	// 구장에 포함 된 경기장 리스트 확인용 폼
	@RequestMapping("/StadiumFieldCheckForm.action")
	public String stadiumFieldCheckForm(Model model,HttpServletRequest request, HttpServletResponse response)
	{
		String result = null;
	    HttpSession session = request.getSession();
		
	    IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class);
	    IFieldDAO fielddao = sqlSession.getMapper(IFieldDAO.class);
	    
	    String message= "";
		Integer user_code_id = (Integer)session.getAttribute("user_code_id");
		
		int stadium_reg_id = Integer.parseInt(request.getParameter("stadium_reg_id"));
		
		// 로그인 여부
		if(user_code_id == null) {
			message = "로그인을 해야 합니다.";
			model.addAttribute("message", message);
			return "redirect:MainPage.action";
		}
		
		// 구장 등록 여부
		if (dao.stadiumSearchCount(user_code_id)==0)
		{
			message = "구장을 먼저 등록해야 합니다.";
			model.addAttribute("message", message);
			return "redirect:MainPage.action";
		};
	    
	    
		ArrayList<StadiumRegInsertDTO> stadiumList = dao.stadiumSearchId(stadium_reg_id);
		ArrayList<FieldRegSearchDTO> fieldList = fielddao.fieldSearchList(stadium_reg_id);
		
	    model.addAttribute("stadiumSearchId", stadiumList);
	    model.addAttribute("fieldSearchId", fieldList);
	    
	    result = "/stadium/StadiumFieldCheckForm";
	    return result;
	    
	}
	
	
	
	@RequestMapping(value = "/FieldRegInsertForm.action", method = RequestMethod.POST)
	public String fieldInsertForm(Model model,HttpServletRequest request,HttpServletResponse response) throws SQLException
	{
		String result =null;
		
		IStadiumDAO fieldDAO = sqlSession.getMapper(IStadiumDAO.class);
		
		HttpSession session = request.getSession();
	    String message= "";
		Integer user_code_id = (Integer)session.getAttribute("user_code_id");
		
		// 로그인 여부
		if(user_code_id == null) {
			message = "로그인을 해야 합니다.";
			model.addAttribute("message", message);
			return "redirect:MainPage.action";
		}
		
		int stadium_reg_id = Integer.parseInt(request.getParameter("stadium_reg_id"));
		System.out.println(stadium_reg_id);
		
		model.addAttribute("fieldTypeList", fieldDAO.fieldTypeList());
		model.addAttribute("fieldEnviromentList", fieldDAO.fieldEnviromentList());
		model.addAttribute("stadium_reg_id",stadium_reg_id);
		
		result = "/stadium/FieldRegInsertForm";
		return result;
	}
	
	
	@RequestMapping(value = "/FieldRegInsert.action", method = RequestMethod.POST)
	public String fieldInsert(FieldRegInsertDTO fieldDTO, HttpServletRequest request) {

	    MultipartFile file = fieldDTO.getField_reg_image();

	    System.out.println("===================================================================================================");
	    System.out.println("파일 업로드 시작: " + (file != null ? file.getOriginalFilename() : "파일 없음"));

	    // 파일이 있을 시
	    if (file != null && !file.isEmpty()) {
	        try {
	            System.out.println("======= [DEBUG] 폼 파라미터 로그 =======");
	            if (fieldDTO != null) {
	                System.out.println("Field_reg_name (경기장 이름) = " + fieldDTO.getField_reg_name());
	                System.out.println("Field_reg_price(경기장 가격) = " + fieldDTO.getField_reg_price());
	                System.out.println("Field_reg_garo(가로) = " + fieldDTO.getField_reg_garo());
	                System.out.println("Field_reg_sero(세로) = " + fieldDTO.getField_reg_sero());
	                System.out.println("Field_reg_at(등록일) = " + fieldDTO.getField_reg_at());
	            }

	            System.out.println("======= 파일 업로드 상태 =======");
	            System.out.println("파일 비어 있음? : " + file.isEmpty());
	            System.out.println("파일 원래 이름 : " + file.getOriginalFilename());

	            // 웹 애플리케이션 루트 경로
	            String root = request.getServletContext().getRealPath("");
	            String uploadDir = Path.getUploadFieldDir();  // 예: "resources/uploads/fields/"
	            
	            // 전체 업로드 경로 생성
	            String uploadPath = root + uploadDir;
	            if (!uploadDir.endsWith(File.separator)) {
	                uploadPath = root + uploadDir + File.separator;
	            }
	            
	            
	            // 폴더 없으면 생성
	            File uploadDirFile = new File(uploadPath);
	            if (!uploadDirFile.exists()) {
	                boolean created = uploadDirFile.mkdirs();
	                System.out.println("디렉토리 생성 결과: " + created);
	            }

	            // 파일명 생성 및 저장
	            String originalFileName = file.getOriginalFilename();
	            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
	            String fieldFileName = fieldDTO.getField_reg_name() + "_" + System.currentTimeMillis() + fileExtension;

	            String filePath = uploadPath + fieldFileName;
	            
	            System.out.println("저장될 파일 경로: " + filePath);
	            File dest = new File(filePath);
	            file.transferTo(dest);
	            System.out.println("파일 저장 완료");
	            
	            System.out.println("웹 애플리케이션 루트: " + root);
	            
	            // DB 저장용 웹 경로 설정 (슬래시로 바꾸고, / 붙여줌)
	            String dbFilePath = uploadDir;
	            if (!uploadDir.endsWith("/") && !uploadDir.endsWith("\\")) {
	                dbFilePath += "/";
	            }
	            dbFilePath += fieldFileName;
	            
	            System.out.println("/n=====[파일 업로드]=====");
	            System.out.println("전체 업로드 경로: " + uploadPath);
	            System.out.println("설정된 업로드 경로: " + uploadDir);
	            System.out.println("DB에 저장할 파일 경로: " + dbFilePath);

	            fieldDTO.setField_image(dbFilePath);	
	        } catch (Exception e) {
	            System.out.println("파일 저장 중 오류 발생:");
	            e.printStackTrace();
	        }
	    }
	    else {
	    	fieldDTO.setField_image("/");
	    }

	    try {
	        IFieldDAO dao = sqlSession.getMapper(IFieldDAO.class);
	        dao.fieldInsert(fieldDTO);
	        System.out.println("DB 저장 완료");
	    } catch (Exception e) {
	        System.out.println("DB 저장 중 오류 발생:");
	        e.printStackTrace();
	    }
	    
	    System.out.println("===================================================================================================");

	    return "redirect:MainPage.action";
	}
	
	/* 구장 휴무 */
	@RequestMapping(value = "/StadiumHoliday.action", method = RequestMethod.POST)
	public String stadiumHoliday(Model model, StadiumHolidayInsertDTO stadiumHolidayDTO)
	{
		String result = null;
		
		IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class);
		
		dao.stadiumHolidayInsert(stadiumHolidayDTO);
		
		result = "/main/mainPage";
		
		return result;
	}
	
	// 경기장 예약 메인페이지 연결
	@RequestMapping(value = "/StadiumMainPage.action",method = RequestMethod.GET)
	public String stadiumMainPage(Model model)
	{
		String result = null;
		
		IRegionDAO regionDAO = sqlSession.getMapper(IRegionDAO.class);
		IFieldDAO fieldDAO = sqlSession.getMapper(IFieldDAO.class);
		
		model.addAttribute("regionList", regionDAO.regionList());
		model.addAttribute("fieldApprOkList", fieldDAO.fieldApprOkList());
		
		result = "/stadium/StadiumMainPage";
		return result;
	}
	
	// 지역 선택 시 도시 목록 반환
	@RequestMapping(value = "/GetCityListByRegionId.action", method = RequestMethod.GET)
	public String getCityListByRegionId(@RequestParam("region_id") int regionId, Model model) 
	{
	    ArrayList<CityDTO> cityList = sqlSession.getMapper(IRegionDAO.class).cityList(regionId);
	    model.addAttribute("cityList", cityList);
	    return "/stadium/CityTabList"; // → 도시 탭 JSP 조각
	}

	// 검색 조건에 따라 경기장 목록 반환
	@RequestMapping(value = "/SearchStadiumList.action", method = RequestMethod.GET)
	public String searchStadiumList(Model model,
	    @RequestParam(value = "region_name", required = false) String regionName,
	    @RequestParam(value = "city_name", required = false) String cityName,
	    @RequestParam(value = "keyword", required = false) String keyword
	    ) 
	{

	    Map<String, Object> params = new HashMap<>();
	    if (regionName != null && !regionName.isEmpty()) params.put("region_name", regionName);
	    if (cityName != null && !cityName.isEmpty()) params.put("city_name", cityName);
	    if (keyword != null && !keyword.isEmpty()) params.put("keyword", "%" + keyword + "%");

	    ArrayList<FieldResMainPageDTO> fieldList = sqlSession.getMapper(IFieldDAO.class).searchFieldList(params);
	    model.addAttribute("fieldList", fieldList);
	    return "/stadium/FieldCardList";
	}
	
	
	// 클릭한 경기장 예약 페이지로 이동
	@RequestMapping(value = "/FieldReservationForm.action", method = RequestMethod.POST)
	public String fieldReservation(@RequestParam("field_code_id") int field_code_id, Model model) 
	{
		String result = null;
		IFieldDAO fieldDAO = sqlSession.getMapper(IFieldDAO.class);
		
		model.addAttribute("fieldApprOkSearchList", fieldDAO.fieldApprOkSearchList(field_code_id));
		model.addAttribute("field_code_id", field_code_id);
		
		result = "/stadium/FieldReservationForm";
	    return result;
	}
	
	@RequestMapping(value = "/GetUnavailableTimeRange.action", method = RequestMethod.GET,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<Map<String, Object>> getUnavailableTimeRange(
	        @RequestParam("field_code_id") int fieldCodeId,
	        @RequestParam("match_date") String matchDate) 
	{
		System.out.println("🟡 [컨트롤러] 예약 불가능 시간 조회 요청 도착");
	    System.out.println("➡️ field_code_id: " + fieldCodeId);
	    System.out.println("➡️ match_date: " + matchDate);

		
	    Map<String, Object> params = new HashMap<>();
	    params.put("field_code_id", fieldCodeId);
	    params.put("match_date", matchDate);
	    
	    List<Map<String, Object>> result = sqlSession.getMapper(IFieldDAO.class).FieldUnavailableTime(params);
	    
	    System.out.println("🟢 조회된 예약 불가 시간 개수: " + result.size());
	    for (Map<String, Object> row : result) {
	        System.out.println("🧾 결과 row: " + row);
	    }
	    

	    return sqlSession.getMapper(IFieldDAO.class).FieldUnavailableTime(params);
	}
	
}