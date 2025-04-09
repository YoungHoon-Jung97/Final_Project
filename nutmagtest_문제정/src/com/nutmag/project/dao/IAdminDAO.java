package com.nutmag.project.dao;


import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.AdminDTO;
import com.nutmag.project.dto.AdminFieldApprDTO;
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
	
	public int fieldApprInsert(AdminFieldApprDTO dto);
	
}
