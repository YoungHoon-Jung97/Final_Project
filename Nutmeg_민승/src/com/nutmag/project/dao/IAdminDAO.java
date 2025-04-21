package com.nutmag.project.dao;


import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.AdminDTO;
import com.nutmag.project.dto.AdminFieldApprDTO;
import com.nutmag.project.dto.AdminFieldCancelDTO;
import com.nutmag.project.dto.FieldRegSearchDTO;
import com.nutmag.project.dto.UserBanDTO;
import com.nutmag.project.dto.AdminFieldApprCancelTypeDTO;
import com.nutmag.project.dto.UserDTO;

public interface IAdminDAO
{

	// 관리자 정보 입력
	public int adminInsert (AdminDTO Admin);

	// 관리자 이메일 찾기
	public int searchEmail(@Param("email") String email);
	
	// 관리자 닉네임 찾기
	public int searchnickName(@Param("nickName") String nickName);

	// 관리자 로그인
	public AdminDTO adminLoginKo(@Param("logEmailKo") String logEmailKo, @Param("logPwKo") String logPwKo);
	public AdminDTO adminLoginEn(@Param("logEmailEn") String logEmailEn, @Param("logPwEn") String logPwEn);
	
	public ArrayList<AdminDTO> adminLoginInfo (int admin_id);
	
	
	public ArrayList<AdminFieldApprCancelTypeDTO> fieldApprCancelTypeList();
	public int fieldApprInsert(AdminFieldApprDTO dto);
	public int fieldApprCancelInsert(AdminFieldCancelDTO dto);
	
//====================================민승======================================	
	// 사용자 전체 조회
	List<UserDTO> selectUserList();
	
	// 관리자 대시보드
    public int getTotalUserCount();
    public int getTotalFieldCount();
    public int getPendingFieldCount();

    // 최근 등록된 경기장
    public ArrayList<FieldRegSearchDTO> getRecentFieldRegList();  
    // 최근 가입한 사용자
    public ArrayList<UserDTO> getRecentUserList();                
    


    // 사용자 차단 처리
    public int insertUserBan(UserBanDTO dto);

    // 차단 기한 리스트 조회
    public List<UserBanDTO> getBanDeadlineList();
    public int unbanUser(int user_id);
    public int deleteUser(int user_id);

    //정지된 사용자 찾기
    public UserDTO searchBannedUser(@Param("user_code_id") int user_code_id);
    

//==============================================================================
}
