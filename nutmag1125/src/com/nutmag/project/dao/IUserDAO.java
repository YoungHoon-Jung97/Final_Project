package com.nutmag.project.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.FieldResMainPageDTO;
import com.nutmag.project.dto.OperatorDTO;
import com.nutmag.project.dto.OperatorResCancelDTO;
import com.nutmag.project.dto.UserDTO;


public interface IUserDAO
{
	//유저 정보 입력
	public int userInsert(UserDTO user);
	
	//유저 이메일 비밀번호 찾기
	
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
	
	//구장 운영자 정보
	public ArrayList<OperatorDTO> operatorLoginInfo (int user_code_id);
	
	// 구장 운영자 경기장 미승인 리스트
 	public ArrayList<FieldResMainPageDTO> fieldBeforeResApprList(int operator_id);
	
 	// 구장 운영자 경기장 예약 승인
 	public int fieldResApprInsert(int field_res_id);
 	
 	// 구장 운영자 경기장 반려 인서트
 	public int fieldResApprCancelInsert(OperatorResCancelDTO dto);
	
	
	//가입중인 이메일 출력
    public List<String> findEmailsByBirthAndTel(@Param("tel") String tel, @Param("birth") String birth);
	
	// 유저 이메일,전화번호 확인
    public int checkUserForPwd(@Param("email") String email, @Param("tel") String tel);
    
    // 유저 비밀번호 업데이트
    public void updateTempPassword(@Param("email") String email, @Param("pwd") String pwd);
    
    // 마이페이지 내 정보 출력
 	public UserDTO getUser(int user_code_id);
 	
 	// 사용자 비밀번호 조회
 	public String getPasswordByUserCode(String userCode);
 	
 	//유저 정보 업데이트 입력
 	public UserDTO userUpdate(int user_code_id);

 	public void updateUser(UserDTO userDTO);
	
}
