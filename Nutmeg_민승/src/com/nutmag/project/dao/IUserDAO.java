package com.nutmag.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.OperatorDTO;
import com.nutmag.project.dto.UserDTO;


public interface IUserDAO
{
	//유저 정보 입력
	public int userInsert(UserDTO user);
	
	//===========================================민승================================================
	// 유저 생년월일,전화번호 확인 
	List<String> findEmailsByBirthAndTel(@Param("tel") String tel, @Param("birth") String birth);
	
	// 유저 이메일,전화번호 확인
    public int checkUserForPwd(@Param("email") String email, @Param("tel") String tel);
    
    // 유저 비밀번호 업데이트
    public void updateTempPassword(@Param("email") String email, @Param("pwd") String pwd);
  //===========================================================================================
    
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
	
	//구장 운영자 가입
	public int operatorInsert(OperatorDTO operator);
	
	//구장 운영자 인증
	public Integer operatorSearchId(int user_code_id);

	public UserDTO getUser(Integer user_code_id);

	public UserDTO userUpdate(Integer user_code_id);
	
}
