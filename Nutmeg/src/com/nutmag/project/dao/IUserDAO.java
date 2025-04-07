package com.nutmag.project.dao;

import org.apache.ibatis.annotations.Param;
import com.nutmag.project.dto.UserDTO;

public interface IUserDAO
{
	//유저 정보 입력
	public int userInsert(UserDTO user);
	
	//유저 이메일 비밀번호 찾기
	public UserDTO userLogin(@Param("logEmailKo") String email, @Param("logPwKo") String pw);
	
	//유저 이메일 찾기
	public int searchEmail(@Param("email") String email);
	
	//유저 닉네임 찾기
	public int searchnickName(@Param("nickName") String nickName);
}
