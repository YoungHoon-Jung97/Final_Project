package com.nutmag.project.dao;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.LoginDTO;
import com.nutmag.project.dto.UserDTO;

public interface IUserDAO
{
	public int userInsert(UserDTO user);
	LoginDTO userLoginKo(@Param("logEmailKo") String logEmailKo, @Param("logPwKo") String logPwKo);
	LoginDTO userLoginEn(@Param("logEmailEn") String logEmailEn, @Param("logPwEn") String logPwEn);
}
