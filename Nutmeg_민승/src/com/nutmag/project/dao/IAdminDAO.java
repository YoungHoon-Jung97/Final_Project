package com.nutmag.project.dao;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.AdminDTO;

public interface IAdminDAO
{
	// 관리자 정보 입력
	public int adminInsert (AdminDTO Admin);

	//유저 이메일 찾기
	public int searchEmail(@Param("email") String email);
	
	//유저 닉네임 찾기
	public int searchnickName(@Param("nickName") String nickName);

}
