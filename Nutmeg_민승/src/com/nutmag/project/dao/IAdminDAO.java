package com.nutmag.project.dao;

<<<<<<< HEAD
import org.apache.ibatis.annotations.Param;

=======
>>>>>>> c6073aca0348adfe2fdf1a94e187a96ae165c74b
import com.nutmag.project.dto.AdminDTO;

public interface IAdminDAO
{
<<<<<<< HEAD
	// 관리자 정보 입력
	public int adminInsert (AdminDTO Admin);

	//유저 이메일 찾기
	public int searchEmail(@Param("email") String email);
	
	//유저 닉네임 찾기
	public int searchnickName(@Param("nickName") String nickName);

=======
	public int adminInsert (AdminDTO Admin);
>>>>>>> c6073aca0348adfe2fdf1a94e187a96ae165c74b
}
