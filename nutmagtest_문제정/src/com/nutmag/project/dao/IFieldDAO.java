package com.nutmag.project.dao;

import java.util.ArrayList;

import com.nutmag.project.dto.FieldEnvironmentDTO;
import com.nutmag.project.dto.FieldRegInsertDTO;
import com.nutmag.project.dto.FieldTypeDTO;

public interface IFieldDAO
{
	public ArrayList<FieldTypeDTO> fieldTypeList();
	public ArrayList<FieldEnvironmentDTO> fieldEnviromentList();
	public int fieldInsertForm(FieldRegInsertDTO field);
}
