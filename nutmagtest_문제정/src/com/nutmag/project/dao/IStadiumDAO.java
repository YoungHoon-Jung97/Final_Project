package com.nutmag.project.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.nutmag.project.dto.FieldEnvironmentDTO;
import com.nutmag.project.dto.FieldTypeDTO;
import com.nutmag.project.dto.StadiumRegInsertDTO;
import com.nutmag.project.dto.StadiumTimeDTO;

public interface IStadiumDAO
{
	public ArrayList<FieldTypeDTO> fieldTypeList();
	public ArrayList<FieldEnvironmentDTO> fieldEnviromentList();
	public ArrayList<StadiumTimeDTO> stadiumTimeList();
	public int stadiumInsert(StadiumRegInsertDTO stadium);
	public ArrayList<StadiumRegInsertDTO> stadiumAllList();
	public int stadiumNameCheck(String stadium_reg_name) throws SQLException;
	public ArrayList<StadiumRegInsertDTO> stadiumSearchList(int user_code_id);
	public int stadiumAllCount();
	public Integer stadiumSearchCount(int user_code_id);
	public ArrayList<StadiumRegInsertDTO> stadiumSearchId(int stadium_reg_id);
}
