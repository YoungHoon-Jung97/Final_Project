package com.nutmag.project.dao;

import java.util.ArrayList;

import com.nutmag.project.dto.AdminFieldApprDTO;
import com.nutmag.project.dto.FieldEnvironmentDTO;
import com.nutmag.project.dto.FieldRegInsertDTO;
import com.nutmag.project.dto.FieldRegSearchDTO;
import com.nutmag.project.dto.FieldResMainPageDTO;
import com.nutmag.project.dto.FieldTypeDTO;

public interface IFieldDAO
{
	// 경기장 타입
	public ArrayList<FieldTypeDTO> fieldTypeList();
	
	// 경기장 환경
	public ArrayList<FieldEnvironmentDTO> fieldEnviromentList();
	
	// 경기장 인서트 폼
	public int fieldInsertForm(FieldRegInsertDTO field);
	
	// 경기장 인서트
	public int fieldInsert(FieldRegInsertDTO fieldDTO);
	
	// 경기장 전체 리스트 (승인,반려,미승인 전부)
	public ArrayList<FieldRegSearchDTO> fieldAllList();
	
	// 선택된 구장의 경기장 리스트 검색
	public ArrayList<FieldRegSearchDTO> fieldSearchList(int stadium_reg_id);
	
	// 경기장 미승인 리스트
	public ArrayList<FieldRegSearchDTO> fieldBeforeApprList();
	
	// 승인된 경기장 리스트
	public ArrayList<FieldResMainPageDTO> fieldApprOkList();
	
	
}
