package com.nutmag.project.dto;

import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public class FieldRegInsertDTO
{
	private int field_reg_id, field_size_id
			  , stadium_reg_id, field_reg_price,field_reg_garo,field_reg_sero,field_type_id
			  , field_environment_id;
	
	private String field_reg_name, field_reg_at, field_size_capacity, field_image
	,field_reg_notice,field_reg_facilities;
	
	private Map<String, Boolean> facilitiesMap;
	
	private MultipartFile field_reg_image;
	
	
	public int getField_reg_id()
	{
		return field_reg_id;
	}
	public void setField_reg_id(int field_reg_id)
	{
		this.field_reg_id = field_reg_id;
	}
	public int getField_size_id()
	{
		return field_size_id;
	}
	public void setField_size_id(int field_size_id)
	{
		this.field_size_id = field_size_id;
	}
	public int getStadium_reg_id()
	{
		return stadium_reg_id;
	}
	public void setStadium_reg_id(int stadium_reg_id)
	{
		this.stadium_reg_id = stadium_reg_id;
	}
	public int getField_reg_price()
	{
		return field_reg_price;
	}
	public void setField_reg_price(int field_reg_price)
	{
		this.field_reg_price = field_reg_price;
	}
	public int getField_reg_garo()
	{
		return field_reg_garo;
	}
	public void setField_reg_garo(int field_reg_garo)
	{
		this.field_reg_garo = field_reg_garo;
	}
	public int getField_reg_sero()
	{
		return field_reg_sero;
	}
	public void setField_reg_sero(int field_reg_sero)
	{
		this.field_reg_sero = field_reg_sero;
	}
	public int getField_type_id()
	{
		return field_type_id;
	}
	public void setField_type_id(int field_type_id)
	{
		this.field_type_id = field_type_id;
	}
	public int getField_environment_id()
	{
		return field_environment_id;
	}
	public void setField_environment_id(int field_environment_type_id)
	{
		this.field_environment_id = field_environment_type_id;
	}
	public String getField_reg_name()
	{
		return field_reg_name;
	}
	public void setField_reg_name(String field_reg_name)
	{
		this.field_reg_name = field_reg_name;
	}
	public String getField_reg_at()
	{
		return field_reg_at;
	}
	public void setField_reg_at(String field_reg_at)
	{
		this.field_reg_at = field_reg_at;
	}
	public String getField_size_capacity()
	{
		return field_size_capacity;
	}
	public void setField_size_capacity(String field_size_capacity)
	{
		this.field_size_capacity = field_size_capacity;
	}
	
	public MultipartFile getField_reg_image()
	{
		return field_reg_image;
	}
	public void setField_reg_image(MultipartFile field_reg_image)
	{
		this.field_reg_image = field_reg_image;
	}
	public String getField_image()
	{
		return field_image;
	}
	public void setField_image(String field_image)
	{
		this.field_image = field_image;
	}
	public String getField_reg_notice()
	{
		return field_reg_notice;
	}
	public void setField_reg_notice(String field_reg_notice)
	{
		this.field_reg_notice = field_reg_notice;
	}
	public String getField_reg_facilities()
	{
		return field_reg_facilities;
	}
	public void setField_reg_facilities(String field_reg_facilities)
	{
		this.field_reg_facilities = field_reg_facilities;
	}
	public Map<String, Boolean> getFacilitiesMap()
	{
		return facilitiesMap;
	}
	public void setFacilitiesMap(Map<String, Boolean> facilitiesMap)
	{
		this.facilitiesMap = facilitiesMap;
	}

	
}