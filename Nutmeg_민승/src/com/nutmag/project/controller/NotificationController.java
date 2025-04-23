package com.nutmag.project.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nutmag.project.dao.INotificationDAO;

@Controller
public class NotificationController
{
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/IsRead.action",method=RequestMethod.GET)
	public String isReadNotification(HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		INotificationDAO notificationDAO = sqlSession.getMapper(INotificationDAO.class);
		int notification_id =  Integer.parseInt(request.getParameter("notification_id"));
		
		notificationDAO.readNotification(notification_id);
		
		int user_code_id = (int) session.getAttribute("user_code_id");
		
		session.setAttribute("notification_count", notificationDAO.notificationCount(user_code_id));
		
		return "redirect:/UserNotification.action";
	};
	
	@RequestMapping(value = "/DeleteNotification.action", method = RequestMethod.GET)
	public String deleteNotification(HttpServletRequest request)
	{
	    HttpSession session = request.getSession();
	    INotificationDAO notificationDAO = sqlSession.getMapper(INotificationDAO.class);

	    int notification_id = Integer.parseInt(request.getParameter("notification_id"));

	    // 삭제 실행
	    notificationDAO.deletefication(notification_id);

	    // 사용자 알림 개수 갱신
	    int user_code_id = (int) session.getAttribute("user_code_id");
	    session.setAttribute("notification_count", notificationDAO.notificationCount(user_code_id));

	    return "redirect:/UserNotification.action";
	}


	
	
	
}

