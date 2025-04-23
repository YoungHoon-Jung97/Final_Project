package com.nutmag.project.controller;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.nutmag.project.dao.IFieldDAO;
import com.nutmag.project.dao.IPositionDAO;
import com.nutmag.project.dao.IRegionDAO;
import com.nutmag.project.dao.IStadiumDAO;
import com.nutmag.project.dao.ITeamDAO;
import com.nutmag.project.dto.CityDTO;
import com.nutmag.project.dto.FieldRegInsertDTO;
import com.nutmag.project.dto.FieldRegSearchDTO;
import com.nutmag.project.dto.FieldResInsertDTO;
import com.nutmag.project.dto.FieldResMainPageDTO;
import com.nutmag.project.dto.FieldResOperatorDTO;
import com.nutmag.project.dto.PositionDTO;
import com.nutmag.project.dto.StadiumHolidayInsertDTO;
import com.nutmag.project.dto.StadiumRegInsertDTO;
import com.nutmag.project.dto.TeamApplyDTO;
import com.nutmag.project.dto.TeamDTO;

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
		IStadiumDAO stadiumDAO = sqlSession.getMapper(IStadiumDAO.class);
		
		model.addAttribute("stadiumTimeList", stadiumDAO.stadiumTimeList());
		
		return "/stadium/StadiumRegInsertForm";
	}
	
	@Configuration
	@EnableWebMvc
	public class WebConfig implements WebMvcConfigurer
	{
	    @Override
	    public void addResourceHandlers(ResourceHandlerRegistry registry)
	    {
	        registry.addResourceHandler("/resources/**")
	                .addResourceLocations("/resources/");
	    }
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
								HttpServletRequest request, HttpServletResponse response,
								HttpSession session, Model model) throws SQLException
	{
		String message = "";
		
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
				System.out.println("stadiumDTO is null");
			
			System.out.println("======= 파일 업로드 상태 =======");
			
			if (uploadFile != null)
			{
				System.out.println("파일 비어 있음? : " + uploadFile.isEmpty());
				System.out.println("파일 원래 이름 : " + uploadFile.getOriginalFilename());
			}
			
			else
				System.out.println("uploadFile is null");
			
			
			// 1. 업로드 경로 설정
			String uploadPath = Path.getUploadStadiumDir();
			File uploadDir = new File(uploadPath);
			
			// 파일 경로 없을 시 폴더 생성
			if (!uploadDir.exists())
				uploadDir.mkdirs();
			
			// 2. 파일 저장
			if (uploadFile != null && !uploadFile.isEmpty())
			{
				 String originalFileName = uploadFile.getOriginalFilename();
				    String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				    String savedFileName = stadiumDTO.getStadium_reg_name().replaceAll("[^a-zA-Z0-9가-힣_\\-]", "_")
				                             + "_" + System.currentTimeMillis() + fileExtension;

				    // 공유폴더 저장
				    File saveFile = new File(uploadPath, savedFileName);
				    uploadFile.transferTo(saveFile);

				    // 정적 리소스 경로 복사
				    String staticPath = request.getServletContext().getRealPath("/resources/uploads/stadiums/");
				    File staticFile = new File(staticPath, savedFileName);

				    if (!staticFile.getParentFile().exists())
				        staticFile.getParentFile().mkdirs();

				    FileUtils.copyFile(saveFile, staticFile); // org.apache.commons.io.FileUtils 필요

				    // DB에는 웹 접근 가능한 경로 저장
				    String fileWebPath = "resources/uploads/stadiums/" + savedFileName;
				    stadiumDTO.setStadium_reg_image(fileWebPath);

				    // 디버그
				    System.out.println("\n=====[파일 경로]=====");
				    System.out.println("공유폴더 저장경로 : " + saveFile.getAbsolutePath());
				    System.out.println("정적리소스 복사경로 : " + staticFile.getAbsolutePath());
				    System.out.println("DB 저장 웹경로 : " + fileWebPath);
			}
			
			// 3. DB 저장
			IStadiumDAO stadiumDAO = sqlSession.getMapper(IStadiumDAO.class);
			int row = stadiumDAO.stadiumInsert(stadiumDTO);
			
			// 4. 결과 처리
			if (row > 0)
			{
				message = "SUCCESS_INSERT: 구장 개설이 완료 되었습니다.";
				session.setAttribute("message", message);
				return "redirect:MainPage.action";
			}
			
			else
				System.out.println("오류 발생");
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}

		return "redirect:/Error.action";
	}
	
	// 중복 확인용
	@RequestMapping(value = "/CheckStadiumName.action", method = RequestMethod.GET)
	@ResponseBody
	public String checkStadiumName(@RequestParam("stadium_reg_name") String name) throws SQLException
	{
		IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class);
		int count = dao.stadiumNameCheck(name);
		
		return (count > 0) ? "duplicate" : "available";
	}
	
	// 구장 리스트 불러오기
	@RequestMapping("/StadiumList.action")
	public String stadiumList(Model model)
	{
		IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class);
		ArrayList<StadiumRegInsertDTO> list = dao.stadiumAllList();
		
		model.addAttribute("stadiumAllList", list);
		
		return "/stadium/StadiumList";
	}
	
	// 구장 전체 리스트 확인용 폼
	@RequestMapping("/StadiumListForm.action")
	public String stadiumListForm(Model model, HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession();
		
		IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class);
		
		String message = "";
		Integer user_code_id = (Integer) session.getAttribute("user_code_id");
		
		// 카운트 메소드 결과 확인용
		// 결과값 없으면 0으로 반환
		// System.out.println(dao.stadiumSearchCount(user_code_id));
		
		if (dao.stadiumSearchCount(user_code_id) == 0)
		{
			message = "NEED_REGISTER_STADIUM: 구장을 먼저 등록해야 합니다.";
			session.setAttribute("message", message);
			return "redirect:MainPage.action";
		}
		
		ArrayList<StadiumRegInsertDTO> list = dao.stadiumSearchList(user_code_id);
		int count = dao.stadiumSearchCount(user_code_id);
		
		model.addAttribute("stadiumCount", count);
		model.addAttribute("stadiumSearchList", list);
		
		return "/stadium/StadiumListForm";
	}
	
	// 구장에 포함 된 경기장 리스트 확인용 폼
	@RequestMapping("/StadiumFieldCheckForm.action")
	public String stadiumFieldCheckForm(Model model, HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession();
		
		IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class);
		IFieldDAO fielddao = sqlSession.getMapper(IFieldDAO.class);
		
		String message = "";
		Integer user_code_id = (Integer) session.getAttribute("user_code_id");
		
		int stadium_reg_id = Integer.parseInt(request.getParameter("stadium_reg_id"));
		
		// 구장 등록 여부
		if (dao.stadiumSearchCount(user_code_id) == 0)
		{
			message = "NEED_REGISTER_STADIUM: 구장을 먼저 등록해야 합니다.";
			session.setAttribute("message", message);
			return "redirect:MainPage.action";
		}
		
		ArrayList<StadiumRegInsertDTO> stadiumList = dao.stadiumSearchId(stadium_reg_id);
		ArrayList<FieldRegSearchDTO> fieldList = fielddao.fieldSearchList(stadium_reg_id);
		
		model.addAttribute("stadiumSearchId", stadiumList);
		model.addAttribute("fieldSearchId", fieldList);
		
		return "/stadium/StadiumFieldCheckForm";
	}
	
	// 경기장 인서트 폼
	@RequestMapping(value = "/FieldRegInsertForm.action", method = RequestMethod.POST)
	public String fieldInsertForm(Model model, HttpServletRequest request, HttpServletResponse response) throws SQLException
	{
		IStadiumDAO fieldDAO = sqlSession.getMapper(IStadiumDAO.class);
		
		int stadium_reg_id = Integer.parseInt(request.getParameter("stadium_reg_id"));
		System.out.println(stadium_reg_id);
		
		model.addAttribute("fieldTypeList", fieldDAO.fieldTypeList());
		model.addAttribute("fieldEnviromentList", fieldDAO.fieldEnviromentList());
		model.addAttribute("stadium_reg_id", stadium_reg_id);
		
		return "/stadium/FieldRegInsertForm";
	}
	
	// 경기장 등록
	@RequestMapping(value = "/FieldRegInsert.action", method = RequestMethod.POST)
	public String fieldInsert(FieldRegInsertDTO fieldDTO, HttpServletRequest request) {
	    HttpSession session = request.getSession();
	    MultipartFile file = fieldDTO.getField_reg_image();

	    System.out.println("=================================================================================");
	    System.out.println("파일 업로드 시작: " + (file != null ? file.getOriginalFilename() : "파일 없음"));

	    try {
	        if (fieldDTO != null) {
	            System.out.println("======= [DEBUG] 폼 파라미터 로그 =======");
	            System.out.println("Field_reg_name = " + fieldDTO.getField_reg_name());
	            System.out.println("Field_reg_price = " + fieldDTO.getField_reg_price());
	            System.out.println("Field_reg_garo = " + fieldDTO.getField_reg_garo());
	            System.out.println("Field_reg_sero = " + fieldDTO.getField_reg_sero());
	            System.out.println("Field_reg_at = " + fieldDTO.getField_reg_at());
	            System.out.println("Field_reg_fac = " + fieldDTO.getField_reg_facilities());
	        }

	        // 1. 업로드 경로 설정
	        String uploadPath = Path.getUploadFieldDir();  // 공유폴더 저장경로
	        File uploadDir = new File(uploadPath);

	        if (!uploadDir.exists())
	            uploadDir.mkdirs();

	        // 2. 파일 저장
	        if (file != null && !file.isEmpty()) {
	            String originalFileName = file.getOriginalFilename();
	            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
	            String savedFileName = fieldDTO.getField_reg_name().replaceAll("[^a-zA-Z0-9가-힣_\\-]", "_")
	                                    + "_" + System.currentTimeMillis() + fileExtension;

	            // 공유폴더 저장
	            File saveFile = new File(uploadPath, savedFileName);
	            file.transferTo(saveFile);

	            // 정적 리소스 경로 복사
	            String staticPath = request.getServletContext().getRealPath("/resources/uploads/fields/");
	            File staticFile = new File(staticPath, savedFileName);

	            if (!staticFile.getParentFile().exists())
	                staticFile.getParentFile().mkdirs();

	            FileUtils.copyFile(saveFile, staticFile); // commons-io 필요

	            // DB 저장용 경로 설정
	            String fileWebPath = "resources/uploads/fields/" + savedFileName;
	            fieldDTO.setField_image(fileWebPath);

	            // 디버그 출력
	            System.out.println("\n=====[파일 경로]=====");
	            System.out.println("공유폴더 저장경로 : " + saveFile.getAbsolutePath());
	            System.out.println("정적리소스 복사경로 : " + staticFile.getAbsolutePath());
	            System.out.println("DB 저장 웹경로 : " + fileWebPath);
	        } else {
	            // 파일이 없는 경우 기본 이미지 경로 설정
	            fieldDTO.setField_image("resources/uploads/fields/default.png");
	        }

	        // 3. DB 저장
	        IFieldDAO dao = sqlSession.getMapper(IFieldDAO.class);
	        dao.fieldInsert(fieldDTO);

	        // 4. 완료 메시지
	        String message = "SUCCESS_INSERT: 경기장 등록이 완료 되었습니다.";
	        session.setAttribute("message", message);
	    } catch (Exception e) {
	        System.out.println("파일 처리 또는 DB 저장 중 오류:");
	        e.printStackTrace();
	    }

	    System.out.println("=================================================================================");
	    return "redirect:MainPage.action";
	}

	// 구장 휴무
	@RequestMapping(value = "/StadiumHoliday.action", method = RequestMethod.POST)
	public String stadiumHoliday(Model model, StadiumHolidayInsertDTO stadiumHolidayDTO)
	{
		IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class);
		
		dao.stadiumHolidayInsert(stadiumHolidayDTO);
		
		return "/main/mainPage";
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
	@ResponseBody
	public List<CityDTO> getCityListByRegionId(@RequestParam("region_id") int regionId)
	{
		// DAO를 통해 도시 목록 가져오기
		List<CityDTO> cityList = sqlSession.getMapper(IRegionDAO.class).cityList(regionId);
		
		// 도시 목록을 반환
		return cityList;
	}

	// 검색 조건에 따라 경기장 목록 반환
	@RequestMapping(value = "/FieldCardList.action", method = RequestMethod.GET)
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
	@RequestMapping(value = "/FieldReservationForm.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String fieldReservation(@RequestParam("field_code_id") int field_code_id, Model model
			, HttpServletRequest request) 
	{
		String result = null;
		String message = "";
		// 동호회 유무 따지기
	    HttpSession session = request.getSession();
	    Integer team_id = (Integer) session.getAttribute("team_id");
	    Integer user_code_id = (Integer) session.getAttribute("user_code_id");
	    System.out.println("team_id in session: " + team_id);
	    System.out.println("user_code_id in session: " + user_code_id);
	    
	    if (user_code_id == null || user_code_id == -1)
		{
	    	message = "ERROR_AUTH_REQUIRED: 로그인을 해야 합니다.";
			session.setAttribute("message", message);
			
			return "redirect:MainPage.action";
		}
	    
	    
	    ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		
		TeamDTO team = teamDAO.getTeamInfo(team_id);
		
		
		// 동호회원 가져오기
		if (team == null || team.getTeam_id() == 0)
		{	
			message = "ERROR_AUTH_REQUIRED: 정식 동호회만 예약 가능합니다.";
			session.setAttribute("message", message);
			
			return "redirect:MainPage.action";
		}
		
		else if (team.getTeam_id() != 0)
		{
			if (user_code_id == team.getUser_code_id()) {

			IFieldDAO fieldDAO = sqlSession.getMapper(IFieldDAO.class);
			ArrayList<FieldResMainPageDTO> fieldList = fieldDAO.fieldApprOkSearchList(field_code_id);
			
			String addr = null;
			
			// JSON → Map 변환
			ObjectMapper mapper = new ObjectMapper();
			for (FieldResMainPageDTO field : fieldList)
			{
			    try {
			    	// JSON 형태로 받은 문자열 Map에 넣어서 형태 변환
			    	// 이후 key value로 꺼내서 jsp에 표현 key= 샤워실 , value=true or false
			        String json = field.getField_reg_facilities(); // JSON 문자열
			        if (json != null && !json.isEmpty()) {
			            Map<String, Boolean> facilitiesMap = mapper.readValue(json, Map.class);
			            field.setFacilitiesMap(facilitiesMap);
			        }
			    } catch (Exception e) {
			        e.printStackTrace(); // 에러는 로그로 출력
			    }
			    
			    // 이건 줄 바꾼거 반영하는 코드
			    // jsp가 아니라 자바에서 바로 줄 바꿔서 보냄
			    String notice = field.getField_reg_notice();
				if (notice != null) {
					field.setField_reg_notice(notice.replace("\n", "<br/>"));
				}
				addr = field.getStadium_reg_addr();
				
			}
			System.out.println("주소 확인용 : " + addr);
			model.addAttribute("field_addr",addr);
			model.addAttribute("fieldApprOkSearchList", fieldList);
			model.addAttribute("field_code_id", field_code_id);
			
			result = "/stadium/FieldReservationForm";
		    
			return result;
			}
		}

	    message = "ERROR_AUTH_REQUIRED: 동호 회장만 예약 가능합니다.";
		session.setAttribute("message", message);
		
		result ="redirect:MainPage.action";
		
		return result;

	}
	
	// 구장 예약 가능 여부 판단
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
	
	// 예약 전 확인 페이지
	@RequestMapping(value = "/FieldReservationCheckForm.action",method = {RequestMethod.GET, RequestMethod.POST})
	public String checkReservation(
	    @RequestParam("field_code_id") int field_code_id,
	    @RequestParam("match_date") String match_date,
	    @RequestParam("start_time_id") int start_time_id,
	    @RequestParam("end_time_id") int end_time_id,
	    @RequestParam("start_time_text") String start_time_text,
	    @RequestParam("end_time_text") String end_time_text,
	    @RequestParam("field_reg_price") int field_reg_price,
	    Model model,
	    HttpServletRequest request)
	{
	    IFieldDAO dao = sqlSession.getMapper(IFieldDAO.class);

	    //  디버그 시작
	    System.out.println("===== [DEBUG] 예약 확인 요청 수신 =====");
	    System.out.println("field_code_id: " + field_code_id);
	    System.out.println("match_date   : " + match_date);
	    System.out.println("start_time_id: " + start_time_id);
	    System.out.println("end_time_id  : " + end_time_id);

	    //  DAO 호출 및 결과 
	    FieldResOperatorDTO operator = dao.fieldOperatorInfo(field_code_id);
	    
	    if (operator != null)
	    {
	        System.out.println("===== [DEBUG] 운영자 정보 조회 성공 =====");
	        System.out.println("이름        : " + operator.getOperator_name());
	        System.out.println("계좌번호     : " + operator.getOperator_account_no());
	        System.out.println("예금주       : " + operator.getOperator_account_holder());
	        System.out.println("은행명       : " + operator.getBank_name());
	    }
	    else
	    {
	        System.out.println("===== [DEBUG] 운영자 정보 조회 실패 (null) =====");
	    }
	    
	    
	    ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
	    HttpSession session = request.getSession();
	    
	    Integer temp_team_id = (Integer) session.getAttribute("team_id");
		TeamDTO team = teamDAO.getTeamInfo(temp_team_id);
		
		model.addAttribute("team_id", team.getTeam_id());
	    
	    int totalPrice = ((end_time_id-start_time_id)+1)*field_reg_price;
	    
	    model.addAttribute("field_code_id", field_code_id);
	    model.addAttribute("match_date", match_date);
	    model.addAttribute("start_time_id", start_time_id);
	    model.addAttribute("end_time_id", end_time_id);
	    model.addAttribute("start_time_text", start_time_text);
	    model.addAttribute("end_time_text", end_time_text);
	    model.addAttribute("operator", operator);
	    model.addAttribute("field_reg_price", field_reg_price);
	    model.addAttribute("totalPrice", totalPrice);
	    model.addAttribute("inwonList", dao.inwonList());
		

	    return "/stadium/FieldReservationCheckForm";

	}
	
	
	// 경기장 예약 인서트
	@RequestMapping(value = "/FieldReservationInsert.action", method =
	{RequestMethod.GET, RequestMethod.POST}) 
	public String fieldReservationInsert(Model model,FieldResInsertDTO dto,HttpServletRequest request) 
	{
		String result = null;
		String message = "";
		HttpSession session = request.getSession();
		IFieldDAO dao = sqlSession.getMapper(IFieldDAO.class);
		
		
		dao.fieldResInsert(dto);
		
		message = "SUCCESS_INSERT: 구장 예약이 완료 되었습니다.";
		session.setAttribute("message", message);
		
		
		
		result = "redirect:MainPage.action";
		
		return result;
	}
 
	
	
	
}