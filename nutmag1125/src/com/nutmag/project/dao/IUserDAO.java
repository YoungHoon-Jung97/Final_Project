package com.nutmag.project.dao;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.LoginDTO;
import com.nutmag.project.dto.UserDTO;

public interface IUserDAO
{
	public int userInsert(UserDTO user);
	LoginDTO userLogin(@Param("logEmailKo") String email, @Param("logPwKo") String pw);
}
