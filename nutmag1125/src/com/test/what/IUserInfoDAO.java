/*====================
   ISampleDAO.java
   - 인터페이스
======================*/

package com.test.what;

public interface IUserInfoDAO
{
	public int userInsert(UserInfoDTO user);
	public int userInsert(TempTeamDTO user);
}
