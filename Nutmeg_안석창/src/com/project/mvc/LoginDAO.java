package com.project.mvc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.util.DBConn;

public class LoginDAO
{
	private Connection conn;
	
	// 데이터베이스 연결 담당 메소드
	public Connection connection()
	{
		try
		{
			conn = DBConn.getConnection();
		}
		catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return conn;
	}
	
	// 로그인 처리 메소드
	public LoginDTO login(String email, String pw)
	{
		LoginDTO result = new LoginDTO();
		
		String sql = "select sid, name, email, pw"
				  + " from tbl_test"
				  + " where email = ? and pw = ?";
		
		try
		{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, email);
			pstmt.setString(2, pw);
			
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next())
			{
				result.setSid(rs.getInt(1));
				result.setName(rs.getString(2));
				result.setEmail(rs.getString(3));
				result.setPw(rs.getString(4));
			}
			
			rs.close();
			pstmt.close();
		}
		catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	// 데이터베이스 연결 종료(해제) 담당 메소드
	public void close()
	{
		try
		{
			DBConn.close();
		}
		catch (Exception e)
		{
			System.out.println(e.toString());
		}
	}
}
