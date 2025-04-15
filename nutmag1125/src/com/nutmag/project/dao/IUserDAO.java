package com.nutmag.project.dao;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.MyInfoDTO;
import com.nutmag.project.dto.OperatorDTO;
import com.nutmag.project.dto.UserDTO;


public interface IUserDAO
{
	//유저 정보 입력
	public int userInsert(UserDTO user);
	
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
	
	//구장 운영자 가입
	public int operatorInsert(OperatorDTO operator);
	
	//구장 운영자 인증
	public Integer operatorSearchId(int user_code_id);
	
	// 마이페이지 내 정보 출력
	public UserDTO getUser(int user_code_id);
	
	//유저 정보 업데이트 입력
	public UserDTO userUpdate(int user_code_id);

	void updateUser(UserDTO userDTO);
    
	
}
