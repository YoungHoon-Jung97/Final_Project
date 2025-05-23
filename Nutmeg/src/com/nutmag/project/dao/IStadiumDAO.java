package com.nutmag.project.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.nutmag.project.dto.FieldEnvironmentDTO;
import com.nutmag.project.dto.FieldRegSearchDTO;
import com.nutmag.project.dto.FieldTypeDTO;
import com.nutmag.project.dto.StadiumHolidayInsertDTO;
import com.nutmag.project.dto.StadiumRegInsertDTO;
import com.nutmag.project.dto.StadiumTimeDTO;

public interface IStadiumDAO
{
	// 경기장 타입 리스트
	public ArrayList<FieldTypeDTO> fieldTypeList();
	
	// 경기장 환경 리스트
	public ArrayList<FieldEnvironmentDTO> fieldEnviromentList();

	// 구장 시간 리스트
	public ArrayList<StadiumTimeDTO> stadiumTimeList();
	
	// 구장 인서트
	public int stadiumInsert(StadiumRegInsertDTO stadium);
	
	// 구장 전체 리스트
	public ArrayList<StadiumRegInsertDTO> stadiumAllList();
	
	// 구장 이름 중복체크
	public int stadiumNameCheck(String stadium_reg_name) throws SQLException;
	
	// 구장 검색 리스트
	public ArrayList<StadiumRegInsertDTO> stadiumSearchList(int user_code_id);
	
	// 전체 구장 갯수
	public int stadiumAllCount();
	
	// 구장 검색 갯수 (유저가 만든 구장 갯수)
	public Integer stadiumSearchCount(int user_code_id);
	
	// 구장 검색 (유저 아이디로)
	public ArrayList<StadiumRegInsertDTO> stadiumSearchId(int stadium_reg_id);
	
	// 구장 업데이트
	public int stadiumUpdate(StadiumRegInsertDTO stadium);
	
	// 구장 휴무 인서트
	public int stadiumHolidayInsert(StadiumHolidayInsertDTO holidayDTO);
	
	// 구장 휴무 타입 리스트
	public ArrayList<StadiumHolidayInsertDTO> stadiumHolidayTypeList();
	
	// 구장 휴무 리스트 (유저 코드로 찾기)
	public ArrayList<StadiumHolidayInsertDTO> stadiumHolidaySearchList(int user_code_id);
	
	// 구장 휴무일 삭제
	public int stadiumHolidayDelete(int stadium_holiday_id);
	
}