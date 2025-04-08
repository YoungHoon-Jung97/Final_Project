package com.nutmag.project.dao;

import java.util.ArrayList;

import com.nutmag.project.dto.FieldEnvironmentDTO;
import com.nutmag.project.dto.FieldRegInsertDTO;
import com.nutmag.project.dto.FieldRegSearchDTO;
import com.nutmag.project.dto.FieldTypeDTO;

public interface IFieldDAO
{
	public ArrayList<FieldTypeDTO> fieldTypeList();
	public ArrayList<FieldEnvironmentDTO> fieldEnviromentList();
	public int fieldInsertForm(FieldRegInsertDTO field);
	public int fieldInsert(FieldRegInsertDTO fieldDTO);
	public ArrayList<FieldRegSearchDTO> fieldSearchList(int stadium_reg_id);
}
