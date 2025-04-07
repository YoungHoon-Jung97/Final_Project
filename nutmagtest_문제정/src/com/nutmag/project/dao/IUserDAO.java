package com.nutmag.project.dao;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.OperatorDTO;
import com.nutmag.project.dto.UserDTO;


public interface IUserDAO
{
	//유저 정보 입력
	public int userInsert(UserDTO user);
	
	//유저 이메일 비밀번호 찾기
	/*
	 * public UserDTO userLogin(@Param("logEmailKo") String email, @Param("logPwKo")
	 * String pw);
	 */
	UserDTO userLoginKo(@Param("logEmailKo") String logEmailKo, @Param("logPwKo") String logPwKo);
	UserDTO userLoginEn(@Param("logEmailEn") String logEmailEn, @Param("logPwEn") String logPwEn);
	
	//유저 이메일 찾기
	public int searchEmail(@Param("email") String email);
	
	//유저 닉네임 찾기
	public int searchnickName(@Param("nickName") String nickName);
	
	//구장 운영자 이메일 찾기
	public int searchEmailOperator(@Param("email") String email);
	
	//구장 운영자 계좌번호
	public int searchAccountOperator(@Param("accountNo") String accountNo);
	
	public int operatorInsert(OperatorDTO operator);
	
}
