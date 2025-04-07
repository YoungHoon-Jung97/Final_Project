package com.nutmag.project.dto;

public class LoginDTO
{
	private int user_id;
	private String user_name, user_email, user_pwd;
	
	public int getUser_id()
	{
		return user_id;
	}
	public void setUser_id(int user_id)
	{
		this.user_id = user_id;
	}
	public String getUser_name()
	{
		return user_name;
	}
	public void setUser_name(String user_name)
	{
		this.user_name = user_name;
	}
	public String getUser_email()
	{
		return user_email;
	}
	public void setUser_email(String user_email)
	{
		this.user_email = user_email;
	}
	public String getUser_pwd()
	{
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd)
	{
		this.user_pwd = user_pwd;
	}
}