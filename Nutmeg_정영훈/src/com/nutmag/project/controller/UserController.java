package com.nutmag.project.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.http.Cookie;
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

import com.nutmag.project.dao.IAdminDAO;
import com.nutmag.project.dao.IBankDAO;
import com.nutmag.project.dao.IFieldDAO;
import com.nutmag.project.dao.INotificationDAO;
import com.nutmag.project.dao.IStadiumDAO;
import com.nutmag.project.dao.ITeamDAO;
import com.nutmag.project.dao.IUserDAO;
import com.nutmag.project.dto.FieldRegInsertDTO;
import com.nutmag.project.dto.FieldRegSearchDTO;
import com.nutmag.project.dto.FieldResMainPageDTO;
import com.nutmag.project.dto.NotificationDTO;
import com.nutmag.project.dto.OperatorDTO;
import com.nutmag.project.dto.OperatorResCancelDTO;
import com.nutmag.project.dto.StadiumHolidayInsertDTO;
import com.nutmag.project.dto.StadiumRegInsertDTO;
import com.nutmag.project.dto.StadiumTimeDTO;
import com.nutmag.project.dto.UserDTO;

import util.MailUtil;
import util.Path;

@Controller
public class UserController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 유저 회원가입 폼
	@RequestMapping(value = "/UserSignupForm.action", method = RequestMethod.GET)
	public String userSignupForm(Model model)
	{
		return "/user/UserSignupForm";
	}
	
	// 유저 회원가입 이메일 중복검사
	@RequestMapping(value = "/CheckEmail.action", method = RequestMethod.GET)
	public void checkEmail(@RequestParam("email") String email, HttpServletResponse response) throws IOException
	{
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		int count = dao.searchEmail(email);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain;charset=UTF-8");
		
		// 이메일을 아무것도 안적었을 경우
		if (email.equals("") || email.isEmpty())
			// error 발생
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		
		if (count > 0)
			response.getWriter().write("이미 사용중인 이메일 입니다.");
		
		else
			response.getWriter().write("사용 가능한 이메일 입니다.");
	}
	
	// 유저 회원가입 이메일 중복검사
	@RequestMapping(value = "/CheckNickName.action", method = RequestMethod.GET)
	public void checkNickName(@RequestParam("nickName") String nickName, HttpServletResponse response) throws IOException
	{
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		int count = dao.searchnickName(nickName);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain;charset=UTF-8");
		
		// 이메일을 아무것도 안적었을 경우
		if (nickName.equals("") || nickName.isEmpty())
			// error 발생
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		
		if (count > 0)
			response.getWriter().write("이미 사용중인 닉네임 입니다.");
		
		else
			response.getWriter().write("사용 가능한 닉네임 입니다.");
	}
	
	// 유저 회원가입 인서트
	@RequestMapping(value = "/UserInsert.action", method = RequestMethod.POST)
	public String userInsert(UserDTO user)
	{
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		
		dao.userInsert(user);
		
		return "redirect:MainPage.action";
	};
	
	
	//===============================================================================	
	
	// 구장 운영자 회원가입 폼
	@RequestMapping(value = "/OperatorSignupForm.action", method = RequestMethod.GET)
	public String operatorSignupForm(Model model, HttpServletRequest request)
	{
		IBankDAO bankDAO = sqlSession.getMapper(IBankDAO.class);
		
		model.addAttribute("bankList", bankDAO.bankList());
		
		return "/user/OperatorSignupForm";
	}
	
	// 구장 운영자 회원가입 이메일 중복검사
	@RequestMapping(value = "/CheckEmailOperator.action", method = RequestMethod.GET)
	public void checkEmailOperator(@RequestParam("email") String email, HttpServletResponse response) throws IOException
	{
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		int count = dao.searchEmailOperator(email);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain;charset=UTF-8");
		
		// 이메일을 아무것도 안적었을 경우
		if (email.equals("") || email.isEmpty())
			// error 발생
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		
		if (count > 0)
			response.getWriter().write("이미 사용중인 이메일 입니다.");
		
		else
			response.getWriter().write("사용 가능한 이메일 입니다.");
	}
	
	// 구장 운영자 회원가입 계좌 중복검사
	@RequestMapping(value = "/CheckAccountNo.action", method = RequestMethod.GET)
	public void checkAccountNo(@RequestParam("accountNo") String accountNo, HttpServletResponse response) throws IOException
	{
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		int count = dao.searchAccountOperator(accountNo);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain;charset=UTF-8");
		
		// 이메일을 아무것도 안적었을 경우
		if (accountNo.equals("") || accountNo.isEmpty())
			// error 발생
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		
		if (count > 0)
			response.getWriter().write("이미 사용중인 계좌번호 입니다.");
		
		else
			response.getWriter().write("사용 가능한 계좌번호 입니다.");
	}
	
	// 구장 운영자 회원가입 인서트
	@RequestMapping(value = "/OperatorInsert.action", method = RequestMethod.POST)
	public String operatorInsert(OperatorDTO operator, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		
		dao.operatorInsert(operator);
		
		String message = "SUCCESS_INSERT: 구장 운영자 회원가입이 완료되었습니다.";
		session.setAttribute("message", message);
		
		return "redirect:MainPage.action";
	};
	
	// 구장 운영자 메인 페이지
		@RequestMapping(value = "/OperatorMainPage.action", method = RequestMethod.GET)
		public String operatorMainPage(Model model,HttpServletRequest request)
		{
			String result = null;

			IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
			HttpSession session = request.getSession();
			int user_code_id = (int) session.getAttribute("user_code_id");
			int operator_id = (int) session.getAttribute("operator_id");
			
			model.addAttribute("operatorInfo", dao.operatorLoginInfo(user_code_id));
			
			//System.out.println(operator_id);
			result = "/user/OperatorMainPage";
			return result;
		}

		// 경기장 승인 처리 페이지
		@RequestMapping(value="OperatorFieldResApprForm.action", method = {RequestMethod.POST, RequestMethod.GET})
		public String operatorFieldApprForm(Model model,HttpServletRequest request, HttpServletResponse response)
		{
			String result = null;
			
			HttpSession session = request.getSession();
			
			int operator_id = (int) session.getAttribute("operator_id");
			IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
			
			//System.out.println(operator_id);
			model.addAttribute("fieldBeforeResApprList", dao.fieldBeforeResApprList(operator_id));
			
			result = "/user/OperatorFieldResApprForm";
			return result;
		}
		
		// 구장 운영자 경기장 예약 승인 처리
		@RequestMapping(value = "FieldResApprInsert.action",method = RequestMethod.POST)
		public String operatorFieldResAppr(@RequestParam("field_res_id") int field_res_id ,Model model,HttpServletRequest request)
		{
			String result = null;
			IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
			
			//System.out.println(field_res_id);
			dao.fieldResApprInsert(field_res_id);
			
			result="redirect:OperatorFieldResApprForm.action";
			
			return result;
		}
		
		// 경기장 예약 반려 처리 폼
		@RequestMapping(value = "FieldResApprCancelForm.action", method = {RequestMethod.POST, RequestMethod.GET})
		public String adminResFieldApprCancel(Model model,HttpServletRequest request,@RequestParam("field_res_id") String field_res_id)
		{
			String result = null;
			
		    model.addAttribute("field_res_id", field_res_id);
			result = "/user/OperatorFieldResApprCancelForm";
			
			return result;
		}
			
		// 경기장 예약 반려 처리
		@RequestMapping(value="FieldResApprCancelInsert.action", method = {RequestMethod.POST, RequestMethod.GET})
		public String adminFieldApprCancelInsert(Model model,OperatorResCancelDTO dto,HttpServletRequest request)
		{
			String result = null;
			
			IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
			
			System.out.println("[DEBUG] 반려 요청 수신");
			System.out.println("reason : " + request.getParameter("field_pay_cancel_reason"));
			System.out.println("field_res_id : " + request.getParameter("field_res_id"));
			
			dao.fieldResApprCancelInsert(dto);
			
			result = "/user/OperatorFieldResApprForm";
			
			return result;
		}
		
		// 구장 운영자 페이지 구장 리스트
		@RequestMapping(value = "OperatorStadiumListForm.action", method = RequestMethod.GET)
		public String OperatorStadiumListForm(Model model,HttpServletRequest request)
		{
			String result= null;
			
			IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class); 
			HttpSession session = request.getSession();
			
			int user_code_id = (int) session.getAttribute("user_code_id");
			
			ArrayList<StadiumRegInsertDTO> list = dao.stadiumSearchList(user_code_id);
			
			/* 디버그
			 * System.out.println("유저 코드 아이디 확인 : " + user_code_id);
			 * System.out.println("리스트 사이즈 : " + list.size());
			 * 
			 * for (StadiumRegInsertDTO stadiumRegInsertDTO : list) {
			 * System.out.println("지금 검색이 되냐 안되냐 :" +
			 * stadiumRegInsertDTO.getStadium_reg_name()); }
			 */
			
			model.addAttribute("stadiumSearchList", list);
			model.addAttribute("stadiumCount", dao.stadiumSearchCount(user_code_id));
			
			
			result = "/user/OperatorStadiumListForm";
			return result;
		}
		
		// 구장 운영자 구장 에서 경기장 클릭시 표시되는 경기장
		@RequestMapping(value = "/OperatorFieldListForm.action",method = RequestMethod.POST)
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
			
			return "/user/OperatorFieldListForm";
		}
		
		
		// 구장 운영자 페이지 구장 리스트
		@RequestMapping(value = "OperatorStadiumUpdateList.action", method = RequestMethod.GET)
		public String OperatorStadiuUpdateForm(Model model,HttpServletRequest request)
		{
			String result= null;
			
			IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class); 
			HttpSession session = request.getSession();
			
			int user_code_id = (int) session.getAttribute("user_code_id");
			
			ArrayList<StadiumRegInsertDTO> list = dao.stadiumSearchList(user_code_id);
			
			model.addAttribute("stadiumSearchList", list);
			model.addAttribute("stadiumCount", dao.stadiumSearchCount(user_code_id));
			
			
			result = "/user/OperatorStadiumUpdateList";
			return result;
		}
		
		
		// 구장 업데이트 폼 불러오기
		@RequestMapping(value = "/OperatorStadiumUpdateForm.action",method = {RequestMethod.GET, RequestMethod.POST})
		public String OperatorStadiumUpdateForm(Model model, HttpServletRequest request) {
		    HttpSession session = request.getSession();

		    IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class);
		    
		    
		    String param = request.getParameter("stadium_reg_id");

		    int stadium_reg_id = Integer.parseInt(param);
		    
		    
		    
		    ArrayList<StadiumRegInsertDTO> stadiumList = dao.stadiumSearchId(stadium_reg_id);
		    ArrayList<StadiumTimeDTO> stadiumTimeList = dao.stadiumTimeList();
		    
		    model.addAttribute("stadiumSearchList", stadiumList);
		    model.addAttribute("stadiumTimeList", stadiumTimeList);
		    return "/user/OperatorStadiumUpdateForm"; 
		}
		
		
		// 파일 업로드 예외처리 방지
		@InitBinder
		protected void initBinder(WebDataBinder binder) {
		    binder.setDisallowedFields("stadium_reg_image");
		}

		// 구장 수정
		@RequestMapping(value = "/OperatorStadiumUpdate.action", method = RequestMethod.POST)
		public String stadiumUpdate(StadiumRegInsertDTO stadiumDTO,
		                             @RequestParam(value = "stadium_reg_image", required = false) MultipartFile uploadFile,
		                             HttpServletRequest request,
		                             HttpSession session) {
		    String message = "";

		    try {
		        System.out.println("======= [DEBUG] 폼 파라미터 로그 (수정) =======");
		        System.out.println("stadium_reg_id = " + stadiumDTO.getStadium_reg_id());
		        System.out.println("stadium_reg_name = " + stadiumDTO.getStadium_reg_name());

		        String root = request.getServletContext().getRealPath("");
		        String uploadPath = root + Path.getUploadStadiumDir();
		        File uploadDir = new File(uploadPath);

		        if (!uploadDir.exists()) {
		            uploadDir.mkdirs();
		        }

		        // 기존 파일 유지
		        String currentImagePath = stadiumDTO.getStadium_reg_image(); // 기존 이미지 경로 (히든 필드나 조회값)

		        if (uploadFile != null && !uploadFile.isEmpty()) {
		            // 새 파일이 업로드되었으면 저장
		            String originalFileName = uploadFile.getOriginalFilename();
		            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
		            String savedFileName = stadiumDTO.getStadium_reg_name() + "_" + System.currentTimeMillis() + fileExtension;
		            File saveFile = new File(uploadPath, savedFileName);
		            uploadFile.transferTo(saveFile);

		            // 새 파일 경로로 세팅
		            String fileWebPath = Path.getUploadStadiumDir() + savedFileName;
		            stadiumDTO.setStadium_reg_image(fileWebPath);

		            // (선택) 기존 파일 삭제 처리
		            if (currentImagePath != null && !currentImagePath.isEmpty()) {
		                File oldFile = new File(root + currentImagePath);
		                if (oldFile.exists()) oldFile.delete();
		            }
		        }
		        else {
		            // 새 파일이 없으면 기존 이미지 경로 유지
		            stadiumDTO.setStadium_reg_image(currentImagePath);
		        }

		        // DB 업데이트
		        IStadiumDAO stadiumDAO = sqlSession.getMapper(IStadiumDAO.class);
		        int row = stadiumDAO.stadiumUpdate(stadiumDTO);

		        if (row > 0) {
		            message = "SUCCESS_INSERT: 구장 수정이 완료되었습니다.";
		            session.setAttribute("message", message);
		            return "redirect:OperatorMainPage.action";
		        } else {
		            System.out.println("DB 업데이트 실패");
		        }
		    }
		    catch (Exception e) {
		        e.printStackTrace();
		    }

		    return "redirect:/Error.action";
		}
		
		// 경기장 업데이트 리스트
		@RequestMapping(value = "OperatorFieldUpdateListForm.action", method = RequestMethod.GET)
		public String operatorFieldUpdateListForm(Model model,HttpServletRequest request)
		{
			String result = null;
			HttpSession session = request.getSession();
			IFieldDAO dao = sqlSession.getMapper(IFieldDAO.class);
			
			int user_code_id = (int) session.getAttribute("user_code_id");
			
			model.addAttribute("fieldList", dao.fieldApprOkSearchIdList(user_code_id));
			
			result = "/user/OperatorFieldUpdateListForm";
			return result;
		}
		

		// 경기장 업데이트 폼 불러오기
		@RequestMapping(value = "/OperatorFieldUpdateForm.action",method = {RequestMethod.GET, RequestMethod.POST})
		public String OperatorFieldUpdateForm(Model model, HttpServletRequest request) {

		    IFieldDAO dao = sqlSession.getMapper(IFieldDAO.class);
		    
		    String param = request.getParameter("field_code_id");

		    int field_code_id = Integer.parseInt(param);
		    
		    System.out.println("필드 코드 아이디 : "+field_code_id);
		    
		    ArrayList<FieldResMainPageDTO> fieldList = dao.fieldApprOkSearchList(field_code_id);
		    
		    
		    
		    model.addAttribute("fieldList", fieldList);
		    model.addAttribute("fieldTypeList", dao.fieldTypeList());
			model.addAttribute("fieldEnviromentList", dao.fieldEnviromentList());
		    
		    return "/user/OperatorFieldUpdateForm"; 
		}
		
				
	
		// 경기장 등록
		@RequestMapping(value = "/OperatorFieldUpate.action", method = RequestMethod.POST)
		public String operatorFieldUpdate(FieldRegInsertDTO fieldDTO, HttpServletRequest request)
		{
			HttpSession session = request.getSession();
			MultipartFile file = fieldDTO.getField_reg_image();
			
			String oldImagePath = request.getParameter("oldFieldImage"); // 기존 이미지 경로
			
			System.out.println("파일 업로드 시작: " + (file != null ? file.getOriginalFilename() : "파일 없음"));
			
			if (file != null && !file.isEmpty())
			{
				try
				{
					// 파일 저장 로직 동일
					String root = request.getServletContext().getRealPath("");
					String uploadDir = Path.getUploadFieldDir();
					String uploadPath = root + (uploadDir.endsWith(File.separator) ? uploadDir : uploadDir + File.separator);
					
					File uploadDirFile = new File(uploadPath);
					if (!uploadDirFile.exists()) uploadDirFile.mkdirs();
					
					String originalFileName = file.getOriginalFilename();
					String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
					String savedFileName = fieldDTO.getField_reg_name() + "_" + System.currentTimeMillis() + fileExtension;
					String saveFullPath = uploadPath + savedFileName;
					
					file.transferTo(new File(saveFullPath));
					
					String dbWebPath = (uploadDir + savedFileName).replace("\\", "/");
					fieldDTO.setField_image(dbWebPath); // 새 이미지로 갱신
				}
				catch (Exception e)
				{
					System.out.println("파일 저장 중 오류 발생:");
					e.printStackTrace();
				}
			}
			else
			{
				// 새 이미지 없으면 기존 이미지 유지
				fieldDTO.setField_image(oldImagePath);
			}
			
			try
			{
				IFieldDAO dao = sqlSession.getMapper(IFieldDAO.class);
				dao.fieldUpdate(fieldDTO);  // UPDATE 쿼리 수행
				session.setAttribute("message", "SUCCESS_INSERT: 경기장 정보가 수정되었습니다.");
			}
			catch (Exception e)
			{
				System.out.println("DB 업데이트 중 오류:");
				e.printStackTrace();
			}
			
			return "redirect:MainPage.action";
		}
		
		
		// 구장 휴무일 인서트용 리스트
		@RequestMapping(value = "OperatorStadiumHolidayInsertListForm.action", method = RequestMethod.GET)
		public String OperatorStadiumHolidayInsertForm(Model model,HttpServletRequest request)
		{
			String result= null;
			
			IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class); 
			HttpSession session = request.getSession();
			
			int user_code_id = (int) session.getAttribute("user_code_id");
			
			ArrayList<StadiumRegInsertDTO> list = dao.stadiumSearchList(user_code_id);
			
			model.addAttribute("stadiumSearchList", list);
			model.addAttribute("stadiumCount", dao.stadiumSearchCount(user_code_id));
			
			
			result = "/user/OperatorStadiumHolidayInsertListForm";
			return result;
		}
		
		// 구장 휴무일 인서트 폼
		@RequestMapping(value = "/OperatorStadiumHolidayInsertForm.action", method = {RequestMethod.GET, RequestMethod.POST} )
		public String operatorStadiumHolidayInsertForm(Model model,HttpServletRequest request)
		{
			String result = null;
			IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class);		
			
			String param = request.getParameter("stadium_reg_id");
	
		    int stadium_reg_id = Integer.parseInt(param);
			
	
		    model.addAttribute("stadium_reg_id", stadium_reg_id);
			model.addAttribute("HolidayTypeList", dao.stadiumHolidayTypeList());
			
			result = "/user/OperatorStadiumHolidayInsertForm";
			return result;
		}
		
		// 구장 휴무일 인서트
		@RequestMapping(value = "/OperatorStadiumHolidayInsert.action", method = RequestMethod.POST)
		public String operatorStadiumHolidayInsert(StadiumHolidayInsertDTO dto)
		{
			String result = null;
			IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class);
			
			dao.stadiumHolidayInsert(dto);
			
			result = "redirect:OperatorMainPage.action";
			return result;
		}
		
		
		// 구장 휴무일 딜리트용 리스트
		@RequestMapping(value = "OperatorStadiumHolidayDeleteListForm.action", method = RequestMethod.GET)
		public String OperatorStadiumHolidayDeleteListForm(Model model,HttpServletRequest request)
		{
			String result= null;
			
			IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class); 
			HttpSession session = request.getSession();
			
			int user_code_id = (int) session.getAttribute("user_code_id");
			
			ArrayList<StadiumRegInsertDTO> list = dao.stadiumSearchList(user_code_id);
			
			model.addAttribute("stadiumSearchList", list);
			model.addAttribute("stadiumCount", dao.stadiumSearchCount(user_code_id));
			
			
			result = "/user/OperatorStadiumHolidayDeleteListForm";
			return result;
		}
		
		
		// 구장 휴무일 딜리트 폼
		@RequestMapping(value = "/OperatorStadiumHolidayDeleteForm.action", method = {RequestMethod.GET, RequestMethod.POST} )
		public String operatorStadiumHolidayDeleteForm(Model model,HttpServletRequest request)
		{
			String result = null;
			IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class);		
			
			HttpSession session = request.getSession();
			
			int user_code_id = (int) session.getAttribute("user_code_id");
			
			//System.out.println("유저코드 아이디" + user_code_id);
			ArrayList<StadiumHolidayInsertDTO> holidayList = dao.stadiumHolidaySearchList(user_code_id);
	
			// 디버깅 출력
			System.out.println("=== [DEBUG] 휴무 리스트 ===");
			for (StadiumHolidayInsertDTO dto : holidayList)
			{
			    System.out.println("ID: " + dto.getStadium_holiday_id()
			        + ", 시작일: " + dto.getStadium_holiday_start_at()
			        + ", 종료일: " + dto.getStadium_holiday_end_at()
			        + ", 설명: " + dto.getStadium_holiday_desc());
			}
	
			model.addAttribute("HolidayList", holidayList);
			
			result = "/user/OperatorStadiumHolidayDeleteForm";
			return result;
		}
		
		// 구장 휴무일 삭제 
		@RequestMapping(value = "/OperatorStadiumHolidayDelete.action", method = {RequestMethod.GET, RequestMethod.POST} )
		@ResponseBody
		public String operatorStadiumHolidayDelete(Model model,HttpServletRequest request)
		{
			IStadiumDAO dao = sqlSession.getMapper(IStadiumDAO.class);		
			String param = request.getParameter("stadium_holiday_id");
		    int stadium_holiday_id = Integer.parseInt(param);
			
		    dao.stadiumHolidayDelete(stadium_holiday_id);
		    
			return "success";
		}
		
		// 구장 승인,반려 히스토리 출력
		@RequestMapping(value = "/OperatorFieldApprList.action")
		public String operatorFieldApprList(Model model,HttpServletRequest request)
		{
			String result = null;
			HttpSession session = request.getSession();
			IFieldDAO dao = sqlSession.getMapper(IFieldDAO.class);
			
			int user_code_id = (int) session.getAttribute("user_code_id");
			
			model.addAttribute("fieldApprOkList", dao.operatorFieldApprOkSearchList(user_code_id));
			model.addAttribute("fieldApprCancelList", dao.operatorFieldApprCancelSearchList(user_code_id));
			
			result = "/user/OperatorFieldApprList";
			return result;
		}
	
	//==================================================================
	
	// 로그인
	@RequestMapping(value = "/Login.action", method = RequestMethod.GET)
	public String login(Model model)
	{
		return "/login/Login";
	}
	
	// 로그인 체크
	@RequestMapping("/LoginCheck.action")
	public String login(@RequestParam(value = "logEmailKo", required = false) String logEmailKo,
						@RequestParam(value = "logPwKo", required = false) String logPwKo,
						@RequestParam(value = "saveEmailKo", required = false) String saveEmail,
						@RequestParam(value = "logEmailEn", required = false) String logEmailEn,
						@RequestParam(value = "logPwEn", required = false) String logPwEn,
						@RequestParam("lang") String lang, HttpSession session, HttpServletResponse response) throws Exception
	{
		IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);
		ITeamDAO teamDAO = sqlSession.getMapper(ITeamDAO.class);
		INotificationDAO notificationDAO = sqlSession.getMapper(INotificationDAO.class);
		IAdminDAO adminDAO = sqlSession.getMapper(IAdminDAO.class);
		
		UserDTO dto = null;
		
		if ("ko".equals(lang))
			dto = userDAO.userLoginKo(logEmailKo, logPwKo);
		
		else
			dto = userDAO.userLoginEn(logEmailEn, logPwEn);
		
		if (dto != null && dto.getUser_id() > 0)
		{
			//=========================민승=================================
			if (adminDAO.searchBannedUser(user_code_id) !=null) {
	            // 차단된 계정이면 로그인 화면으로 돌려보내기
				String message = "ERROR_DUPLICATE_JOIN: 정지된 회원입니다.";
				session.setAttribute("message", message);
				return "redirect:/MainPage.action";
	        }
			//==============================================================
			
			// 로그인 성공
			session.setAttribute("user_name", dto.getUser_name());
			session.setAttribute("user_email", dto.getUser_email());
			session.setAttribute("user_code_id", dto.getUser_code_id());
			session.setAttribute("operator_id", userDAO.operatorSearchId(dto.getUser_code_id()));
			session.setAttribute("user_nick_name", dto.getUser_nick_name());
			session.setAttribute("notification_count", notificationDAO.notificationCount(dto.getUser_code_id()));
			
			if (teamDAO.searchMyTempTeam(dto.getUser_code_id()) != null)
				session.setAttribute("team_id", teamDAO.searchMyTempTeam(dto.getUser_code_id()));
			
			else if (teamDAO.searchMyTeam(dto.getUser_code_id()) != null)
				session.setAttribute("team_id", teamDAO.searchMyTeam(dto.getUser_code_id()));
			
			else
				session.setAttribute("team_id", 0);
			
			
			// 로그인 상태 플래그 남기기
			session.setAttribute("loginFlag", "1");
			
			teamDAO.searchMyTeam(dto.getUser_code_id());
			teamDAO.searchMyTempTeam(dto.getUser_code_id());
			
			if ("on".equals(saveEmail))
			{
				if ("ko".equals(lang))
				{
					Cookie c = new Cookie("key", URLEncoder.encode(logEmailKo, "UTF-8"));
					c.setMaxAge(399 * 24 * 60 * 60);
					response.addCookie(c);
				}
				
				else
				{
					Cookie c = new Cookie("key", URLEncoder.encode(logEmailEn, "UTF-8"));
					c.setMaxAge(399 * 24 * 60 * 60);
					response.addCookie(c);
				}
			}
			
			String previousPage = (String) session.getAttribute("previousPage");
			
			if (previousPage != null)
			{
				session.removeAttribute("previousPage"); // 이전 페이지 정보 삭제
				
				// 만약 잘못된 JSP 경로가 저장된 경우 .action 경로로 변경
				if (previousPage.contains("/WEB-INF/view"))
					previousPage = previousPage.replaceAll(".*/", "/Nutmeg/").replace(".jsp", ".action");
				
				// 응답이 이미 커밋된 경우를 체크
				if (!response.isCommitted())
				{
					response.sendRedirect(previousPage); // 이전 페이지로 이동
					return null; // 이후 코드 실행 방지
				}
				
				else
					return "redirect:" + previousPage;
			}
			
			else
				return "redirect:/Error.action";
		}
		
		else
		{
			// 로그인 실패
			session.setAttribute("lang", lang);
			return "redirect:/Login.action?msg=fail";
		}
	}
	
	// 로그아웃
	@RequestMapping(value = "/Logout.action", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession();
		
		// 세션 삭제
		session.removeAttribute("user_name");
		session.removeAttribute("user_email");
		session.removeAttribute("user_code_id");
		session.removeAttribute("operator_id");
		session.removeAttribute("user_nick_name");
		session.removeAttribute("team_id");
		
		// 로그아웃 상태 플래그 남기기
		session.setAttribute("logoutFlag", "1");
		
		return "redirect:/MainPage.action";
	}
	
	
	// 이메일 찾기 폼 띄우기(get)
   @RequestMapping(value="/ForgotEmail.action", method = RequestMethod.GET)
   public String forgotEmail(Model model)
   {
	  model.addAttribute("searched", true);
      return "/user/ForgotEmail";
   }
   
   // 이메일 찾기 처리 (POST)
   @RequestMapping(value = "/ForgotEmail.action", method = RequestMethod.POST)
   public String forgotEmail(HttpServletRequest request, Model model)
   {
       String birth = request.getParameter("birth");
       String tel = request.getParameter("tel");
       System.out.println("입력값 확인 → birth: " + birth + ", tel: " + tel);

       IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
       List<String> emailList = dao.findEmailsByBirthAndTel(tel, birth);
       
       System.out.println("조회된 이메일 수: " + emailList.size());

       if (emailList == null || emailList.isEmpty()) {
           model.addAttribute("message", "입력하신 정보와 일치하는 이메일이 없습니다.");
           model.addAttribute("emailList", null);
       } else {
           model.addAttribute("emailList", emailList);
       }  	
	       return "/user/ForgotEmailResult";
	   }

   
   
	// 비밀번호 찾기 폼 띄우기 (GET)
	@RequestMapping(value = "/ForgotPassword.action", method = RequestMethod.GET)
	public String forgotPasswordForm(HttpServletRequest request,Model model) 
	{
		String user_email =(String)request.getParameter("user_email");
		
		model.addAttribute("user_email", user_email);
	    return "/user/ForgotPassword";
	}
	
	// 비밀번호 찾기 처리 (POST)
	@RequestMapping(value = "/ForgotPassword.action", method = RequestMethod.POST)
	public String forgotPassword(HttpServletRequest request, Model model) {

	    String email = request.getParameter("email");
	    String tel = request.getParameter("tel");
	    

	    System.out.println("비밀번호 찾기 요청 도착!");
	    System.out.println("email = " + email);
	    System.out.println("tel = " + tel);

	    // DAO 꺼내오기
	    IUserDAO dao = sqlSession.getMapper(IUserDAO.class);

	    // 사용자 유효성 검사
	    int result = dao.checkUserForPwd(email, tel);
	    boolean isValid = result > 0;

	    if (isValid) {
	        // 임시 비밀번호 생성
	        String tempPwd = createTempPassword();

	        // 비밀번호 업데이트
	        dao.updateTempPassword(email, tempPwd);
	        
	        // 이메일 전송
	        MailUtil.sendEmail(email, tempPwd);

	        // 안내 메시지 출력
	        model.addAttribute("message", "임시 비밀번호가 이메일로 전송되었습니다.");
	    } else {
	        model.addAttribute("message", "입력하신 정보와 일치하는 회원이 없습니다.");
	    }

	    return "/user/ForgotPassword"; // 결과 출력용 JSP
	}


	// 임시 비밀번호 생성
	private String createTempPassword() {
	    String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	    StringBuilder sb = new StringBuilder();
	    Random rnd = new Random();
	    for (int i = 0; i < 10; i++) {
	        sb.append(chars.charAt(rnd.nextInt(chars.length())));
	    }
	    return sb.toString();
	}
	
	//마이페이지
	@RequestMapping(value = "/Mypage.action" , method = RequestMethod.GET)
	public String Mypage(Model model, HttpServletRequest request)
	{
	    HttpSession session = request.getSession();
	    String message = "";

	    Integer user_code_id = (Integer) session.getAttribute("user_code_id");

	    // 로그인 체크
	    if (user_code_id == null) {
	        message = "로그인을 해야 합니다.";
	        model.addAttribute("message", message);
	        return "redirect:MainPage.action";  // 로그인 페이지나 메인 페이지
	    }

	    System.out.println("===========================[확인]==========================");
	    System.out.println("user_code_id = "+ user_code_id);
	    
	    INotificationDAO notificationDAO = sqlSession.getMapper(INotificationDAO.class); // DAO 호출
	    
	    List<NotificationDTO> notificationList= notificationDAO.getNotificationList(user_code_id);
	    for (NotificationDTO notificationDTO : notificationList)
		{
			System.out.println("메시지 : " +notificationDTO.getMessage());
		}

	    System.out.println("=============================================================");
	    model.addAttribute("notificationList", notificationList);

	    return "/user/UserMainPage"; // 유저 정보 보여줄 페이지
	}
	

	// 내 정보
	@RequestMapping("/MyInformation.action")
	public String MyInformation(Model model, HttpServletRequest request)
	{
	    HttpSession session = request.getSession();
	    String message = "";

	    Integer user_code_id = (Integer) session.getAttribute("user_code_id");

	    // 로그인 체크
	    if (user_code_id == null) {
	        message = "로그인을 해야 합니다.";
	        model.addAttribute("message", message);
	        return "redirect:MainPage.action";  // 로그인 페이지나 메인 페이지
	    }

	    IUserDAO dao = sqlSession.getMapper(IUserDAO.class); // DAO 호출
	    UserDTO userInfo = dao.getUser(user_code_id);   // 정보 불러오기

	    if (userInfo == null) {
	        message = "회원 정보를 찾을 수 없습니다.";
	        model.addAttribute("message", message);
	        return "redirect:MainPage.action";
	    }

	    model.addAttribute("userInfo", userInfo);

	    return "/user/UserMyinfo"; // 유저 정보 보여줄 페이지
	}
		
	// 내 정보 수정 폼 페이지 들어가기 전 비밀번호 확인
	@RequestMapping(value = "/CheckPassword.action", method = RequestMethod.GET)
	public String checkPasswordForm(HttpSession session) {
		
		  if (session.getAttribute("user_code_id") == null) return
		  "redirect:/Login.action";
		 
	    return "/user/CheckPassword";
	}

	@RequestMapping(value = "/CheckPassword.action", method = RequestMethod.POST)
	public String checkPasswordSubmit(HttpSession session, HttpServletRequest request, Model model) {
	    String inputPw = request.getParameter("user_pwd");
	    System.out.println("입력된 비밀번호: " + inputPw);
	    Object userCodeObj = session.getAttribute("user_code_id");

	    String userCode = userCodeObj.toString();

	    IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
	    String dbPw = dao.getPasswordByUserCode(userCode);

	    if (dbPw != null && dbPw.equals(inputPw)) {
	        return "redirect:/UserInfoEdit.action";
	    } else {
	        model.addAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
	        return "/user/CheckPassword";
	    }
	}
	
	// 내 정보 수정 폼 페이지 요청
	@RequestMapping(value = "/UserInfoEdit.action")
	public String userInfoEdit(Model model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
	    String message = "";

	    Integer user_code_id = (Integer) session.getAttribute("user_code_id");

	    // 로그인 체크
	    if (user_code_id == null) {
	        message = "로그인을 해야 합니다.";
	        model.addAttribute("message", message);
	        return "redirect:MainPage.action";  // 로그인 페이지나 메인 페이지
	    }

	    IUserDAO dao = sqlSession.getMapper(IUserDAO.class); // DAO 호출
	    UserDTO userEdit = dao.userUpdate(user_code_id);   // 정보 불러오기

	    if (userEdit == null) {
	        message = "회원 정보를 찾을 수 없습니다.";
	        model.addAttribute("message", message);
	        return "redirect:MainPage.action";
	    }

	    model.addAttribute("userInfo", userEdit);

	    return "/user/UserInfoEdit"; // 수정 폼 JSP로 이동
	}
	
	//사용자 정보 업데이트
	@RequestMapping(value = "/UserUpdate.action", method = RequestMethod.POST)
	   public String updateUser(UserDTO userDTO, HttpServletRequest request, Model model) {

	       HttpSession session = request.getSession();
	       Integer user_code_id = (Integer) session.getAttribute("user_code_id");
	       userDTO.setUser_code_id(user_code_id);

	       // 기존 비밀번호와 새로운 비밀번호를 비교
	       String currentPwd = request.getParameter("current_pwd");  // hidden으로 받은 기존 비밀번호
	       String newPwd = request.getParameter("user_pwd");         // 새 비밀번호
	       String confirmPwd = request.getParameter("password2");    // 새 비밀번호 확인

	       // 비밀번호가 다르면 수정 페이지로 돌아가기
	       if (!newPwd.equals(confirmPwd)) {  // equals()로 비밀번호 비교
	           return "redirect:UserInfoEdit.action";  // 수정 페이지로 돌아감
	       }

	       // 비밀번호가 일치하면 DB에 업데이트
	       if (newPwd != null && !newPwd.trim().equals("")) {
	           userDTO.setUser_pwd(newPwd);  // 새 비밀번호로 업데이트
	       } else {
	           userDTO.setUser_pwd(currentPwd); // 비밀번호 변경 없으면 기존 비밀번호 사용
	       }

	       // DB 업데이트
	       IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);
	       userDAO.updateUser(userDTO);  // 비밀번호 포함한 전체 정보 업데이트

	       // 메인 페이지로 리다이렉트
	       return "redirect:MainPage.action";
	   }
}