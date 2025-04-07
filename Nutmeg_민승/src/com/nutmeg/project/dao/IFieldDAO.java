package com.nutmeg.project.dao;

import java.util.ArrayList;

import com.nutmeg.project.dto.FieldEnvironmentDTO;
import com.nutmeg.project.dto.FieldTypeDTO;

public interface IFieldDAO
{
	public ArrayList<FieldTypeDTO> fieldTypeList();
	public ArrayList<FieldEnvironmentDTO> fieldEnviromentList();
	
}
