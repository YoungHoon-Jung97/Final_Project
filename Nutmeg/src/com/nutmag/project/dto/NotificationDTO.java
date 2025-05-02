package com.nutmag.project.dto;

public class NotificationDTO
{
	int user_code_id,notification_id,notification_type_id;
	String is_read;
	
	String message, created_at,notification_type;
	
	
	public int getNotification_type_id()
	{
		return notification_type_id;
	}
	public void setNotification_type_id(int notification_type_id)
	{
		this.notification_type_id = notification_type_id;
	}
	public String getNotification_type()
	{
		return notification_type;
	}
	public void setNotification_type(String notification_type)
	{
		this.notification_type = notification_type;
	}
	
	public int getUser_code_id()
	{
		return user_code_id;
	}
	public void setUser_code_id(int user_code_id)
	{
		this.user_code_id = user_code_id;
	}
	public int getNotification_id()
	{
		return notification_id;
	}
	public void setNotification_id(int notification_id)
	{
		this.notification_id = notification_id;
	}
	public String getMessage()
	{
		return message;
	}
	public void setMessage(String message)
	{
		this.message = message;
	}
	public String getCreated_at()
	{
		return created_at;
	}
	public void setCreated_at(String created_at)
	{
		this.created_at = created_at;
	}
	public String getIs_read()
	{
		return is_read;
	}
	public void setIs_read(String is_read)
	{
		this.is_read = is_read;
	}
	
	
}
