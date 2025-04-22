package com.nutmag.project.dto;

public class UserBanDTO
{
	private int userBanId, banDeadlineId,userCodeId1,userCodeId2;
	private String userBanStartdate,userBanReason,ban_deadline_term;
	
	public int getUserBanId()
	{
		return userBanId;
	}
	public void setUserBanId(int userBanId)
	{
		this.userBanId = userBanId;
	}
	public int getBanDeadlineId()
	{
		return banDeadlineId;
	}
	public void setBanDeadlineId(int banDeadlineId)
	{
		this.banDeadlineId = banDeadlineId;
	}
	public int getUserCodeId1()
	{
		return userCodeId1;
	}
	public void setUserCodeId1(int userCodeId1)
	{
		this.userCodeId1 = userCodeId1;
	}
	public int getUserCodeId2()
	{
		return userCodeId2;
	}
	public void setUserCodeId2(int userCodeId2)
	{
		this.userCodeId2 = userCodeId2;
	}
	public String getUserBanStartdate()
	{
		return userBanStartdate;
	}
	public void setUserBanStartdate(String userBanStartdate)
	{
		this.userBanStartdate = userBanStartdate;
	}
	public String getUserBanReason()
	{
		return userBanReason;
	}
	public void setUserBanReason(String userBanReason)
	{
		this.userBanReason = userBanReason;
	}
	public String getBan_deadline_term()
	{
		return ban_deadline_term;
	}
	public void setBan_deadline_term(String ban_deadline_term)
	{
		this.ban_deadline_term = ban_deadline_term;
	}

}
