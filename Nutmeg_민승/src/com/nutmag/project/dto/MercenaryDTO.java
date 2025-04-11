package com.nutmag.project.dto;

public class MercenaryDTO
{
	private int mercenary_id,region_id;
	private String user_name,position_name,region_name,city_name,mercenary_time_start_at;
	public int getMercenary_id()
	{
		return mercenary_id;
	}
	public void setMercenary_id(int mercenary_id)
	{
		this.mercenary_id = mercenary_id;
	}
	public String getUser_name()
	{
		return user_name;
	}
	public void setUser_name(String user_name)
	{
		this.user_name = user_name;
	}
	public String getPosition_name()
	{
		return position_name;
	}
	public void setPosition_name(String position_name)
	{
		this.position_name = position_name;
	}
	public String getRegion_name()
	{
		return region_name;
	}
	public void setRegion_name(String region_name)
	{
		this.region_name = region_name;
	}
	public String getMercenary_time_start_at()
	{
		return mercenary_time_start_at;
	}
	public void setMercenary_time_start_at(String mercenary_time_start_at)
	{
		this.mercenary_time_start_at = mercenary_time_start_at;
	}

	
    

   
}
