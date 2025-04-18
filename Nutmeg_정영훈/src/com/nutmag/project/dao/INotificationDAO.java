package com.nutmag.project.dao;

import java.util.ArrayList;

import com.nutmag.project.dto.NotificationDTO;

public interface INotificationDAO
{
	//메시지 등록
	public void addNotification(NotificationDTO notification);
	
	//메시지 출력
	public ArrayList<NotificationDTO> getNotificationList(int user_code_id);
	
	//메시지 확인
	public void readNotification(int notification_id);
	
	//안 읽은 메시지 수
	public int notificationCount(int user_code_id);
}
